#!/usr/bin/env bash
set -euo pipefail

out_dir="${1:-app/src/main/res/drawable-nodpi}"
mkdir -p "${out_dir}"

# 1. Boas-vindas — composição azul, porta de entrada e caminho.
convert -size 1000x520 xc:'#dbeafe' \
    -fill '#bfdbfe' -stroke none \
    -draw 'circle 160,110 300,110 circle 850,390 1030,390' \
    -fill '#ffffff' -stroke '#2563eb' -strokewidth 8 \
    -draw 'roundrectangle 350,80 650,440 32,32' \
    -fill '#2563eb' -stroke none \
    -draw 'roundrectangle 410,145 590,440 12,12 circle 550,292 561,292' \
    -fill '#60a5fa' \
    -draw 'polygon 120,455 360,330 640,330 900,455' \
    "${out_dir}/theme_welcome.png"

# 2. Relatórios — gráfico de barras e curva de tendência.
convert -size 1000x520 xc:'#d1fae5' \
    -stroke '#065f46' -strokewidth 5 -fill none \
    -draw 'line 120,410 900,410 line 120,90 120,410' \
    -fill '#34d399' -stroke none \
    -draw 'roundrectangle 190,280 290,410 12,12 roundrectangle 350,210 450,410 12,12 roundrectangle 510,245 610,410 12,12 roundrectangle 670,135 770,410 12,12' \
    -stroke '#047857' -strokewidth 9 -fill none \
    -draw "path 'M 175,270 C 300,250 350,165 455,205 C 565,245 655,115 820,105'" \
    "${out_dir}/theme_reports.png"

# 3. Configurações — controles deslizantes.
convert -size 1000x520 xc:'#fef3c7' \
    -stroke '#d97706' -strokewidth 12 -fill none \
    -draw 'line 170,145 830,145 line 170,260 830,260 line 170,375 830,375' \
    -fill '#ffffff' -stroke '#b45309' -strokewidth 8 \
    -draw 'circle 350,145 385,145 circle 650,260 685,260 circle 460,375 495,375' \
    -fill '#f59e0b' -stroke none \
    -draw 'circle 350,145 365,145 circle 650,260 665,260 circle 460,375 475,375' \
    "${out_dir}/theme_settings.png"

# 4. Sobre — nós conectados representando Android, JNI e Yoga.
convert -size 1000x520 xc:'#ede9fe' \
    -stroke '#7c3aed' -strokewidth 8 -fill none \
    -draw 'line 500,260 255,135 line 500,260 745,135 line 500,260 255,390 line 500,260 745,390' \
    -fill '#ffffff' -stroke '#6d28d9' -strokewidth 7 \
    -draw 'circle 500,260 575,260 circle 255,135 315,135 circle 745,135 805,135 circle 255,390 315,390 circle 745,390 805,390' \
    -fill '#8b5cf6' -stroke none \
    -draw 'circle 500,260 525,260 circle 255,135 275,135 circle 745,135 765,135 circle 255,390 275,390 circle 745,390 765,390' \
    "${out_dir}/theme_about.png"

echo "Imagens geradas em: ${out_dir}"
