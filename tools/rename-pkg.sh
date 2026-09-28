#!/usr/bin/env bash
set -euo pipefail

OLD_PKG="com.example.myapplication"
NEW_PKG="br.eng.ivanlopes.exemplo"
OLD_PATH="com/example/myapplication"
NEW_PATH="br/eng/ivanlopes/exemplo"

echo "==> Movendo diretorios"
for base in \
    "app/src/main/java" \
    "app/src/main/kotlin" \
    "app/src/androidTest/kotlin" \
    "app/src/test/kotlin"; do
    if [[ -d "$base/$OLD_PATH" ]]; then
        mkdir -p "$base/$(dirname "$NEW_PATH")"
        mv "$base/$OLD_PATH" "$base/$NEW_PATH"
        echo "   movido: $base/$OLD_PATH -> $base/$NEW_PATH"
    fi
done

echo "==> Removendo diretorios vazios"
find app/src -type d -empty -delete

echo "==> Reescrevendo package/import em arquivos .kt e .java"
grep -rl --include='*.kt' --include='*.java' "$OLD_PKG" app/src |
    xargs -r sed -i "s/\b${OLD_PKG//./\\.}\b/${NEW_PKG}/g"

echo "==> Reescrevendo build.gradle(.kts)"
for f in app/build.gradle app/build.gradle.kts; do
    [[ -f "$f" ]] || continue
    sed -i \
        -e "s/namespace = \"$OLD_PKG\"/namespace = \"$NEW_PKG\"/" \
        -e "s/namespace \"$OLD_PKG\"/namespace \"$NEW_PKG\"/" \
        -e "s/applicationId = \"$OLD_PKG\"/applicationId = \"$NEW_PKG\"/" \
        -e "s/applicationId \"$OLD_PKG\"/applicationId \"$NEW_PKG\"/" \
        "$f"
done

echo "==> Reescrevendo AndroidManifest.xml"
grep -rl "$OLD_PKG" app/src/main/AndroidManifest.xml 2>/dev/null |
    xargs -r sed -i "s/\b${OLD_PKG//./\\.}\b/${NEW_PKG}/g"

echo "==> Pronto."

exit 0
