#!/usr/bin/env bash
set -euo pipefail
# bug com codificacao do texto
# corrigndo letra que nao esteja no formato utf8
if (($# == 0)); then
    echo "Uso: $0 arquivo [arquivo ...]" >&2
    exit 1
fi

for source_path in "$@"; do
    if [[ ! -f "$source_path" ]]; then
        echo "Ignorando: não é arquivo: $source_path" >&2
        continue
    fi

    fixed_path="${source_path}.fixed"
    backup_path="${source_path}.bak"

    if ! iconv -f UTF-8 -t WINDOWS-1252 "$source_path" |
        iconv -f UTF-8 -t UTF-8 >"$fixed_path"; then
        rm -f "$fixed_path"
        echo "Falhou, arquivo original preservado: $source_path" >&2
        continue
    fi

    if cmp -s "$source_path" "$fixed_path"; then
        rm -f "$fixed_path"
        echo "Sem alteração: $source_path"
        continue
    fi

    cp -p "$source_path" "$backup_path"
    mv "$fixed_path" "$source_path"
    echo "Corrigido: $source_path (backup: $backup_path)"
done
