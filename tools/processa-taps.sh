#!/usr/bin/env bash
set -euo pipefail

adb_args=""
[ -n "${ADB_DEVICE:-}" ] && adb_args="-s $ADB_DEVICE"

mapfile -t lines <"${1:-/dev/stdin}"

for linha in "${lines[@]}"; do
    [ -z "$linha" ] && continue
    [[ "$linha" =~ ^\[ ]] || continue

    # 1. isola coords
    coords="${linha%% *}"

    # 2. x1
    : "${coords#\[}" # -> "17,182][703,274]"
    : "${_%%]*}"     # -> "17,182"
    x1="${_%,*}"     # -> "17"

    # 2. y1
    : "${coords#\[}" # -> "17,182][703,274]"
    : "${_%%]*}"     # -> "17,182"
    y1="${_#*,}"     # -> "182"

    # 3. x2
    : "${coords#*]}" # -> "[703,274]"
    : "${_#\[}"      # -> "703,274]"
    : "${_%]}"       # -> "703,274"
    x2="${_%,*}"     # -> "703"

    # 3. y2
    : "${coords#*]}" # -> "[703,274]"
    : "${_#\[}"      # -> "703,274]"
    : "${_%]}"       # -> "703,274"
    y2="${_#*,}"     # -> "274"

    # 4. tipo
    : "${linha#* }"                # -> " EditText Pesquisar apps"
    : "${_#"${_%%[![:space:]]*}"}" # -> "EditText Pesquisar apps"
    : "${_%% *}"                   # -> "EditText"
    tipo="$_"

    # 4. nome
    : "${linha#* }"                # -> " EditText Pesquisar apps"
    : "${_#"${_%%[![:space:]]*}"}" # -> "EditText Pesquisar apps"
    : "${_#"${_%%[[:space:]]*}"}"  # -> " Pesquisar apps"
    : "${_#"${_%%[![:space:]]*}"}" # -> "Pesquisar apps"
    nome="$_"

    # 5. centro
    x_centro=$(((x1 + x2) / 2))
    y_centro=$(((y1 + y2) / 2))

    # 6. exibe
    if [ -n "${ADB_DEVICE:-}" ]; then
        cmd="adb -s $ADB_DEVICE shell input tap $x_centro $y_centro"
    else
        cmd="adb shell input tap $x_centro $y_centro"
    fi

    printf "%-50s : %s\n" "$nome" "$cmd"

done
