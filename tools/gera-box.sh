#!/usr/bin/env bash

# Uso: gera-box.sh LARGURA ALTURA NUMERO [ARQUIVO_SAIDA]
#
# Gera um PNG de LARGURA x ALTURA pixels com um retângulo preenchendo o
# canvas e o NUMERO centralizado dentro dele, com fonte proporcional ao
# tamanho do retângulo.
#
# Exemplos:
#   gera-box.sh 200 200 4
#   gera-box.sh 640 320 42 saida/box42.png

# if [ $# -lt 3 ]; then
#     echo "Uso: $0 LARGURA ALTURA NUMERO [ARQUIVO_SAIDA]" >&2
#     exit 1
# fi
if [ $# -lt 3 ]; then
    echo "Nenhum argumento completo — usando valores padrão (${largura}x${altura}, número ${numero})." >&2
fi

largura="${1:-200}"
altura="${2:-200}"
numero="${3:-0}"
saida="${4:-box_${largura}x${altura}_${numero}.png}"

# largura="$1"
# altura="$2"
# numero="$3"
# saida="${4:-box_${largura}x${altura}_${numero}.png}"

# Paleta (mesmo estilo do generate-images.sh)
cor_fundo='#dbeafe'
cor_borda='#2563eb'
cor_texto='#1e3a8a'

mkdir -p "$(dirname "${saida}")"

# Fonte proporcional: ~60% do menor lado do retângulo.
lado_menor=$((largura < altura ? largura : altura))
tamanho_fonte=$((lado_menor * 60 / 100))

# Espessura da borda proporcional, com mínimo de 2px.
borda=$((lado_menor / 40))
[ "${borda}" -lt 2 ] && borda=2

convert -size "${largura}x${altura}" xc:"${cor_fundo}" \
    -fill none -stroke "${cor_borda}" -strokewidth "${borda}" \
    -draw "rectangle 0,0 $((largura - 1)),$((altura - 1))" \
    -gravity center \
    -fill "${cor_texto}" -stroke none \
    -font DejaVu-Sans-Bold -pointsize "${tamanho_fonte}" \
    -annotate +0+0 "${numero}" \
    "${saida}"

echo "Imagem gerada em: ${saida}"
