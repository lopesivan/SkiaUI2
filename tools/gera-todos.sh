#!/usr/bin/env bash
set -euo pipefail

# Uso: gera-todos.sh [LARGURA] [ALTURA] [DIR_SAIDA]
#
# Chama gera-box.sh uma vez para cada glifo confirmado no cmap da
# DejaVu Sans Bold (ver conversa: símbolos, naipes, clima, setas, etc.),
# gerando um PNG por glifo dentro de DIR_SAIDA.
#
# Exemplos:
#   gera-todos.sh
#   gera-todos.sh 200 200
#   gera-todos.sh 300 300 saida/icones

largura="${1:-200}"
altura="${2:-200}"
dir_saida="${3:-icones}"

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
gera_box="${script_dir}/gera-box.sh"

if [ ! -f "${gera_box}" ]; then
    echo "gera-box.sh não encontrado em ${script_dir}" >&2
    exit 1
fi

mkdir -p "${dir_saida}"

# glifo -> nome de arquivo (slug), na ordem listada na conversa.
glifos=(
    "★:estrela_cheia"      "☆:estrela_vazia"
    "✓:check"              "✔:check_grosso"
    "✗:x"                  "✘:x_grosso"
    "⚠:atencao"
    "♥:coracao"             "♦:ouros"
    "♣:paus"                "♠:espadas"
    "☀:sol"                 "☁:nuvem"
    "☂:guarda_chuva"        "☃:boneco_de_neve"
    "⚡:raio"
    "☕:cafe"                "☎:telefone"
    "✈:aviao"               "⚓:ancora"
    "⚙:engrenagem"          "✂:tesoura"
    "✉:envelope"            "✎:lapis"
    "✏:lapis2"              "⌘:command"
    "☺:carinha_feliz"       "☹:carinha_triste"
    "☯:yin_yang"            "☮:paz"
    "→:seta_direita"        "←:seta_esquerda"
    "↑:seta_cima"           "↓:seta_baixo"
    "↔:seta_dupla"
    "∞:infinito"            "≈:aproximado"
    "≠:diferente"           "±:mais_menos"
    "°:grau"                "µ:micro"
    "©:copyright"           "®:registrado"
    "™:trademark"           "§:paragrafo"
    "¶:pilcrow"             "‰:por_mil"
    "€:euro"                "£:libra"
    "¥:iene"                "¢:centavo"
    "♪:nota_musical"        "♫:notas_musicais"
)

total=${#glifos[@]}
echo "Gerando ${total} imagens (${largura}x${altura}) em ${dir_saida}/ ..."

for par in "${glifos[@]}"; do
    glifo="${par%%:*}"
    nome="${par##*:}"
    bash "${gera_box}" "${largura}" "${altura}" "${glifo}" "${dir_saida}/${nome}.png"
done

echo "Concluído: ${total} imagens em ${dir_saida}/"

