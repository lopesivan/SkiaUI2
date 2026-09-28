#!/usr/bin/env bash
set -euo pipefail

base="app/src/main/cpp/third_party/AndroidLaTeXMath/libtex/src/main/jni/tex/src"

python3 - "$base" <<'PY'
from pathlib import Path
import sys

base = Path(sys.argv[1])

cpp = base / "atom/atom_basic.cpp"
hdr = base / "atom/atom.h"

def replace_once(path, old, new):
    text = path.read_text(encoding="utf-8")

    count = text.count(old)
    if count != 1:
        raise SystemExit(
            f"{path}: esperado 1 trecho, encontrados {count}"
        )

    path.write_text(
        text.replace(old, new, 1),
        encoding="utf-8"
    )

# 1. Corrige acesso fora do vector.
replace_once(
    cpp,
    """if (pos > _elements.size())""",
    """if (pos >= _elements.size())"""
)

# 2. Elimina &(*shared_ptr), que é UB quando o ponteiro é null.
replace_once(
    cpp,
    """change2Ord(&(*atom), &(*_previousAtom), &(*nextAtom));""",
    """change2Ord(atom.get(), _previousAtom.get(), nextAtom.get());"""
)

# 3. Atom é uma classe polimórfica: destrutor deve ser virtual.
replace_once(
    hdr,
    """    virtual sptr<Atom> clone() const = 0;""",
    """    virtual sptr<Atom> clone() const = 0;

    virtual ~Atom() = default;"""
)

print("Correções aplicadas.")
PY
