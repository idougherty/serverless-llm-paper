MAKE = make

.PHONY: all clean

MAIN = paper

# Add any custom .cls, .bst, or .sty files needed to compile.
# Used only by 'make single'.
STYLE_FILES =

ALL = ${MAIN}.pdf

TEX   := $(shell find . -name '*.tex')
MDTEX := $(shell find . -name '*.md' ! -name 'README.md' | sed 's/.md/.from-md.tex/')
BIB   := $(shell find . -name '*.bib')

all: ${ALL} ${MDTEX}

${MAIN}.pdf: ${TEX} ${BIB} ${MDTEX}
	latexmk -pdf ${MAIN}.tex

EXTS  = *~ *.aux *.backup *.blg *.log *.out *.vtc *.lof *.loa *.lot *.toc *.bbl *.bak *.texshop *.dvi *.fdb_latexmk *.fls
TRASH := $(foreach ext,${EXTS},$(shell find . -name '${ext}'))

%.from-md.tex: %.md
	@echo "[Markdown -> LaTeX]" $<
	@(echo "%%% !!!! AUTO-GENERATED: Do not edit!"; pandoc -f markdown -t latex $<) \
	 | sed -e '/\\tightlist/d' -e '/\\\labelenumi/d' > $@

clean:
	@echo Cleaning  ${EXTS} ${ALL}...
	@latexmk -C -quiet ${MAIN}.tex
	@rm -f ${EXTS} ${TRASH} ${MDTEX}
