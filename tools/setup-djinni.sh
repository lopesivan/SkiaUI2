#!/usr/bin/env bash
#
# setup-djinni.sh
#
# Migra app/src/main/cpp/native-lib.cpp (JNI manual) para Greeter
# gerado via Djinni. Roda a partir da raiz do projeto Android Studio.
#
set -euo pipefail

# ----------------------------------------
# Configuração
# ----------------------------------------
PROJECT_ROOT="$(pwd)"
APP_ID="com.example.myapplication"
APP_PKG_DIR="com/example/myapplication"
LIB_NAME="myapplication"

CPP_DIR="$PROJECT_ROOT/app/src/main/cpp"
JAVA_DIR="$PROJECT_ROOT/app/src/main/java/$APP_PKG_DIR"
DEPS_DIR="$CPP_DIR/deps"
DJINNI_DIR="$DEPS_DIR/djinni"

IDL_DIR="$CPP_DIR/idl"
GLUE_JNI_DIR="$CPP_DIR/glue-code/jni/generated"
GLUE_CPP_DIR="$CPP_DIR/glue-code/interfaces/generated"
JAVA_GEN_DIR="$JAVA_DIR/gen"

# ----------------------------------------
# 1. Instalar o djinni-generator via Conan 2
# ----------------------------------------
# Disponível para Linux/macOS/Windows no Conan Center. Baixa o binário
# pré-compilado (requer apenas Java/JRE instalado para executar).
DJINNI_CONAN_REF="djinni-generator/1.4.0"

if ! command -v conan >/dev/null 2>&1; then
    echo "ERRO: conan não encontrado no PATH."
    echo "Instale com: pip install --break-system-packages conan"
    exit 1
fi

mkdir -p "$DEPS_DIR/conan-djinni"
cat > "$DEPS_DIR/conan-djinni/conanfile.txt" <<EOF
[tool_requires]
${DJINNI_CONAN_REF}
EOF

conan install "$DEPS_DIR/conan-djinni/conanfile.txt" \
    --output-folder="$DEPS_DIR/conan-djinni" \
    --build=missing

# tool_requires não é copiado para a output-folder; o Conan gera um
# script de ambiente (conanbuild.sh) que injeta o bin/ do pacote no PATH.
CONANBUILD_SH="$DEPS_DIR/conan-djinni/conanbuild.sh"
if [ ! -f "$CONANBUILD_SH" ]; then
    echo "ERRO: $CONANBUILD_SH não foi gerado pelo 'conan install'."
    exit 1
fi

# shellcheck disable=SC1090
set +u
source "$CONANBUILD_SH"
set -u

DJINNI_RUN="$(command -v djinni || true)"

if [ -z "$DJINNI_RUN" ]; then
    # fallback: procurar direto no cache do conan
    DJINNI_RUN="$(find "$HOME/.conan2/p" -type f -name djinni -path '*/bin/*' 2>/dev/null | head -n1)"
    [ -n "$DJINNI_RUN" ] && chmod +x "$DJINNI_RUN"
fi

if [ -z "$DJINNI_RUN" ]; then
    echo "ERRO: binário 'djinni' não encontrado após 'conan install'."
    echo "Rode manualmente: conan install $DEPS_DIR/conan-djinni/conanfile.txt --build=missing"
    echo "E depois: source $CONANBUILD_SH && which djinni"
    exit 1
fi

if ! command -v java >/dev/null 2>&1; then
    echo "ERRO: java não encontrado no PATH. O djinni-generator precisa de um JRE para rodar."
    echo "Instale com: sudo apt install default-jre-headless"
    exit 1
fi

if ! "$DJINNI_RUN" --help >/dev/null 2>&1; then
    echo "ERRO: falha ao executar $DJINNI_RUN."
    exit 1
fi

echo "djinni encontrado em: $DJINNI_RUN"

# support-lib: header-only, clonado à parte (Marshal.cpp, djinni_support.cpp etc.)
SUPPORT_LIB_DIR="$DEPS_DIR/djinni-support-lib"
if [ ! -d "$SUPPORT_LIB_DIR" ]; then
    git clone --depth 1 https://github.com/cross-language-cpp/djinni-support-lib.git "$SUPPORT_LIB_DIR"
fi

# ----------------------------------------
# 2. Criar o IDL
# ----------------------------------------
mkdir -p "$IDL_DIR"

cat > "$IDL_DIR/greeter.djinni" <<'EOF'
Greeter = interface +c {
    static create(): Greeter;
    greet(): string;
}
EOF

echo "IDL criado em $IDL_DIR/greeter.djinni"

# ----------------------------------------
# 3. Rodar o Djinni
# ----------------------------------------
mkdir -p "$GLUE_JNI_DIR" "$GLUE_CPP_DIR" "$JAVA_GEN_DIR"

"$DJINNI_RUN" \
    --java-out "$JAVA_GEN_DIR" \
    --java-package "${APP_ID}.generated" \
    --jni-out "$GLUE_JNI_DIR" \
    --ident-jni-class NativeFooBar \
    --ident-jni-file NativeFooBar \
    --cpp-out "$GLUE_CPP_DIR" \
    --cpp-namespace generated \
    --idl "$IDL_DIR/greeter.djinni"

echo "Código gerado pelo djinni em:"
echo "  $JAVA_GEN_DIR"
echo "  $GLUE_JNI_DIR"
echo "  $GLUE_CPP_DIR"

if [ ! -f "$GLUE_JNI_DIR/NativeGreeter.cpp" ]; then
    echo "ERRO: $GLUE_JNI_DIR/NativeGreeter.cpp não foi gerado."
    echo "Conteúdo real de $GLUE_JNI_DIR:"
    ls -la "$GLUE_JNI_DIR" || true
    exit 1
fi

# ----------------------------------------
# 4. Implementação C++ (GreeterImpl.cpp)
# ----------------------------------------
cat > "$CPP_DIR/GreeterImpl.cpp" <<'EOF'
#include "Greeter.hpp"

class GreeterImpl : public generated::Greeter
{
public:
    std::string greet() override
    {
        return "Hello from C++";
    }
};

std::shared_ptr<generated::Greeter> generated::Greeter::create()
{
    return std::make_shared<GreeterImpl>();
}
EOF

echo "Criado $CPP_DIR/GreeterImpl.cpp"

# ----------------------------------------
# 5. native-lib.cpp antigo (removido, sem uso)
# ----------------------------------------
if [ -f "$CPP_DIR/native-lib.cpp" ]; then
    rm -f "$CPP_DIR/native-lib.cpp"
    echo "Removido $CPP_DIR/native-lib.cpp (substituído pelo GreeterImpl.cpp)"
fi

# ----------------------------------------
# 6. CMakeLists.txt
# ----------------------------------------
cat > "$CPP_DIR/CMakeLists.txt" <<EOF
cmake_minimum_required(VERSION 3.22.1)

set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_STANDARD 17)

project("${LIB_NAME}")

file(GLOB_RECURSE DJINNI_SUPPORT_SRC
    deps/djinni-support-lib/djinni/jni/*.cpp)

add_library(
    \${CMAKE_PROJECT_NAME} SHARED
    GreeterImpl.cpp
    glue-code/jni/generated/NativeGreeter.cpp
    \${DJINNI_SUPPORT_SRC})

target_include_directories(
    \${CMAKE_PROJECT_NAME} PRIVATE
    glue-code/interfaces/generated
    deps/djinni-support-lib)

target_link_libraries(
    \${CMAKE_PROJECT_NAME}
    android log)
EOF

echo "Atualizado $CPP_DIR/CMakeLists.txt"

# ----------------------------------------
# 7. MainActivity.java
# ----------------------------------------
mkdir -p "$JAVA_DIR"

cat > "$JAVA_DIR/MainActivity.java" <<EOF
package ${APP_ID};

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.widget.TextView;

import ${APP_ID}.databinding.ActivityMainBinding;
import ${APP_ID}.generated.Greeter;

public class MainActivity extends AppCompatActivity
{
    static
    {
        System.loadLibrary("${LIB_NAME}");
    }

    private ActivityMainBinding binding;
    private Greeter mGreeter;

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);

        binding = ActivityMainBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        mGreeter = Greeter.create();

        TextView tv = binding.sampleText;
        tv.setText(mGreeter.greet());
    }
}
EOF

echo "Atualizado $JAVA_DIR/MainActivity.java"

# ----------------------------------------
# Resumo
# ----------------------------------------
cat <<EOF

Concluído.

Estrutura resultante:
  $CPP_DIR/idl/greeter.djinni
  $CPP_DIR/GreeterImpl.cpp
  $CPP_DIR/glue-code/jni/generated/NativeGreeter.cpp   (gerado)
  $CPP_DIR/glue-code/interfaces/generated/greeter.hpp  (gerado)
  $JAVA_GEN_DIR/Greeter.java                           (gerado)
  $JAVA_DIR/MainActivity.java                          (atualizado)
  $CPP_DIR/CMakeLists.txt                              (atualizado)

Para adicionar novos métodos: edite $CPP_DIR/idl/greeter.djinni
e rode este script novamente para regenerar o glue code.

Binário do djinni em: $DJINNI_RUN
Support-lib em:       $SUPPORT_LIB_DIR
EOF
