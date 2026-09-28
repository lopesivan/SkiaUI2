#!/usr/bin/env python3
"""
Lê a saída de `make ls`, filtra linhas com `adb ... input tap`,
apresenta seletor interativo e executa o tap selecionad3.

Uso:
    make ls | ./tap-select.py
    ./tap-select.py < <(make ls)
"""

import curses
import re
import subprocess
import sys
import os

ARROW = "▶ "
NORMAL = "  "
HEADER = " 👆 Selecione o item para tap  (↑↓/jk · Enter · ESC/q sair · digitar filtra)"
TAP_RE = re.compile(r"^(.+?)\s*:\s+(adb\s+.*input\s+tap\s+\d+\s+\d+)\s*$")


def parse_items(lines: list[str]) -> list[tuple[str, str]]:
    """Retorna lista de (label, comando_adb)."""
    items = []
    for line in lines:
        m = TAP_RE.match(line)
        if m:
            label = m.group(1).strip()
            cmd = m.group(2).strip()
            items.append((label, cmd))
    return items


def selector(stdscr, items: list[tuple[str, str]]) -> tuple[str, str] | None:
    curses.curs_set(0)
    curses.use_default_colors()
    curses.start_color()

    curses.init_pair(1, curses.COLOR_BLACK,
                     curses.COLOR_CYAN)   # header/footer
    curses.init_pair(2, curses.COLOR_CYAN,   -
                     1)                   # selecionado
    curses.init_pair(3, curses.COLOR_WHITE,  -1)                   # normal
    curses.init_pair(4, curses.COLOR_YELLOW, -1)                   # filtro
    curses.init_pair(5, curses.COLOR_BLACK,  curses.COLOR_YELLOW)  # contador
    curses.init_pair(6, curses.COLOR_GREEN,  -
                     1)                   # cmd preview

    query = ""
    cursor = 0
    filtered = items[:]

    while True:
        stdscr.erase()
        h, w = stdscr.getmaxyx()

        # Header
        stdscr.attron(curses.color_pair(1) | curses.A_BOLD)
        stdscr.addstr(0, 0, HEADER[:w - 1].ljust(w - 1))
        stdscr.attroff(curses.color_pair(1) | curses.A_BOLD)

        # Filtro
        filter_line = f" / {query}_"
        stdscr.attron(curses.color_pair(4) | curses.A_BOLD)
        stdscr.addstr(1, 0, filter_line[:w - 1])
        stdscr.attroff(curses.color_pair(4) | curses.A_BOLD)

        # Contador
        count = f" {len(filtered)}/{len(items)} "
        if w - len(count) > 1:
            stdscr.attron(curses.color_pair(5))
            stdscr.addstr(1, w - len(count) - 1, count)
            stdscr.attroff(curses.color_pair(5))

        # Lista
        list_h = h - 4
        scroll = max(0, cursor - list_h + 1)
        visible = filtered[scroll: scroll + list_h]

        for i, (label, _cmd) in enumerate(visible):
            real_i = scroll + i
            row = i + 2
            is_sel = real_i == cursor
            prefix = ARROW if is_sel else NORMAL
            line = f"{prefix}{label}"[:w - 1]

            if is_sel:
                stdscr.attron(curses.color_pair(2) | curses.A_BOLD)
                stdscr.addstr(row, 0, line.ljust(min(len(line) + 2, w - 1)))
                stdscr.attroff(curses.color_pair(2) | curses.A_BOLD)
            else:
                stdscr.attron(curses.color_pair(3))
                stdscr.addstr(row, 0, line)
                stdscr.attroff(curses.color_pair(3))

        # Rodapé — mostra o comando que será executado
        if filtered and cursor < len(filtered):
            _, cmd = filtered[cursor]
            preview = f"  $ {cmd}"
            stdscr.attron(curses.color_pair(6))
            try:
                stdscr.addstr(h - 1, 0, preview[:w - 1])
            except curses.error:
                pass
            stdscr.attroff(curses.color_pair(6))

        stdscr.refresh()

        key = stdscr.getch()

        if key in (curses.KEY_UP, ord("k")):
            cursor = max(0, cursor - 1)

        elif key in (curses.KEY_DOWN, ord("j")):
            cursor = min(len(filtered) - 1, cursor + 1)

        elif key == curses.KEY_PPAGE:
            cursor = max(0, cursor - list_h)

        elif key == curses.KEY_NPAGE:
            cursor = min(len(filtered) - 1, cursor + list_h)

        elif key in (10, 13, curses.KEY_ENTER):
            return filtered[cursor] if filtered else None

        elif key in (27, ord("q")):
            return None

        elif key in (curses.KEY_BACKSPACE, 127, 8):
            query = query[:-1]
            filtered = [(l, c) for l, c in items if query.lower() in l.lower()]
            cursor = 0

        elif 32 <= key <= 126:
            query += chr(key)
            filtered = [(l, c) for l, c in items if query.lower() in l.lower()]
            cursor = 0


def main() -> None:
    raw = sys.stdin.read().splitlines()
    items = parse_items(raw)

    if not items:
        print("Nenhum item com 'input tap' encontrado na entrada.", file=sys.stderr)
        sys.exit(1)

    tty = os.open("/dev/tty", os.O_RDWR)

    os.dup2(tty, 0)  # stdin real do terminal
    os.dup2(tty, 1)  # stdout real do terminal
    os.dup2(tty, 2)  # stderr real do terminal

    result = curses.wrapper(selector, items)

    if not result:
        sys.exit(0)

    label, cmd = result
    print(f"\n▶  {label}")
    print(f"   $ {cmd}\n")
    subprocess.run(cmd, shell=True)


if __name__ == "__main__":
    main()
