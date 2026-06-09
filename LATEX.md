# LaTeX setup

Notes on the LaTeX toolchain that ships with this dotfiles repo, and the conventions I follow when writing new documents.

## Engine

I compile everything with **xelatex**. This is set in `top_level/latexmkrc`, which aliases both `$pdflatex` and `$xelatex` to `xelatex --shell-escape` so that any tool invoking `latexmk` ends up on the same engine.

The reason I'm on xelatex (and not pdflatex, which is faster) is that my books embed Python and Julia code with Greek-letter variables, and rendering those needs a Unicode-aware monospace font — pdflatex can't do that cleanly.

## Standard preamble

The font setup that's in place across my books and reference letters:

```latex
\usepackage{fontspec}
\usepackage[xcharter]{newtxmath}
\setmainfont{XCharter}
\setmonofont{DejaVu Sans Mono}[Scale=MatchLowercase]
```

- **XCharter** for body text, paired with `newtxmath`'s xcharter option so that math glyphs match the prose.
- **DejaVu Sans Mono** for code listings — it's Unicode-complete, so `α`, `β`, `θ` etc. inside Python/Julia snippets render correctly.

Both fonts resolve cleanly without any extra setup, but for two different reasons:

- XCharter has an `XCharter.fontspec` definition file in TeX Live, which fontspec finds via kpathsea. fontconfig isn't involved.
- DejaVu Sans Mono is a real Ubuntu system font (`fonts-dejavu-mono`), found via fontconfig.

The canonical version of this preamble lives at `~/gh_synced/books/dp_books/book-dp1/book/preamble.tex` (lines 14–18).

## Avoid: `mathpazo` under xelatex

`\usepackage{mathpazo}` registers Palatino under the legacy OT1 encoding only. xelatex uses Unicode (TU) encoding, so when the document asks for `TU/ppl/b/n` (Palatino bold) it's undefined and **silently falls back to the regular weight** — every `\textbf{...}` renders as plain text with no error. I lost a couple of hours to this on a reference letter in May 2026.

If I ever want a Palatino look under xelatex, the right call is `\setmainfont{TeX Gyre Pagella}` via fontspec — but see the section below about fontconfig.

## Avoid: `\mathbb` with digits (indicator functions)

The legacy blackboard-bold math alphabets — the ones supplied by `newtxmath` and `amssymb` — contain **letters only**. Writing `\mathbb{1}` for an indicator function doesn't error: the digit indexes an unrelated glyph in the same font and renders as ⊮ ("does not force"), with a completely clean log. Caught this in the adps_pospace paper in June 2026; standalone figure files using `amssymb` had the identical bug.

The portable fix is the `dsfont` package, which supplies double-struck digits via its own math alphabet and works under both pdflatex and xelatex:

```latex
\usepackage{dsfont}
\newcommand{\1}{\mathds{1}}   % indicator function
```

`dsfont` coexists fine with `newtxmath` (unlike `amssymb` and `bbm`, which must not be loaded alongside it).

**Exception:** under `unicode-math` with STIX Two Math (the book-dp2 / literature-review setup), `\mathbb{1}` is fine — that font has genuine double-struck digits and unicode-math maps them correctly. The trap is specific to the 8-bit math alphabets.

Same failure family as the mathpazo trap above: wrong output, clean log. A warning-free compile doesn't guarantee correct glyphs — when in doubt, spot-check the PDF (visually or via `pdftotext`).

## Defensive fix: register TeX Live fonts with fontconfig

Most TeX Live fonts that lack a `.fontspec` definition file (the TeX Gyre family, STIX, etc.) need fontconfig registration to be findable by xelatex on Linux. The standard preamble above doesn't depend on this, but it's a useful one-time fix so the toolchain doesn't surprise me later.

`install.sh` Phase 6b (`register_texlive_fonts`) handles it: it symlinks `$(kpsewhich --var-value TEXMFSYSVAR)/fonts/conf/texlive-fontconfig.conf` into `/etc/fonts/conf.d/` and rebuilds the font cache. Idempotent.

If at some point `\setmainfont{TeX Gyre Pagella}` fails with "font cannot be found", that step never ran — re-invoke `install.sh`, or do the symlink + `sudo fc-cache -fsv` by hand.

## Compiling

- **Normal builds:** `latexmk file.tex`. This handles biber, makeindex, and re-runs automatically and uses the engine set in `latexmkrc`.
- **One-shot:** `xelatex --shell-escape file.tex`. The `--shell-escape` is required because `minted` (used in the books for code highlighting) shells out to Pygments.
