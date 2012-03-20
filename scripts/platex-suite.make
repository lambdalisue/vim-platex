# vim: set ft=make
#############################################################
#                                                           #
# Makefile for LaTeX. Used for the following compiling flow #
#                                                           #
# Author: Alisue <lambdalisue@hashnote.net>                 #
#                                                           #
#############################################################

# Main file without extension
# You can pass like `$ FILE=index make` or write here.
#FILE=index

# Application definitions
ifndef TEX
TEX=platex
endif
ifndef BIBTEX
BIBTEX=bibtex
endif
ifndef DVIPDF
DVIPDF=dvipdfmx
endif

# ---------------------------------------------------------------------
.SUFFIXES: .tex .dvi .aux .log .toc .lof .lot .pdf .ps .bbl .bib .blg

all:    pdf clean
pdf:    $(FILE).pdf
dvi:    $(FILE).dvi
bbl:    $(FILE).bbl

$(FILE).pdf:    $(FILE).dvi
$(FILE).dvi:    $(FILE).tex $(FILE).bbl
$(FILE).bbl:    $(FILE).bib
$(FILE).bib:    $(FILE).aux
$(FILE).aux:    $(FILE).tex

.dvi.pdf:
	$(DVIPDF) $<
.bib.bbl:
	$(TEX) $*; $(BIBTEX) $*; $(TEX) $*
.tex.dvi:
	$(TEX) $<
	(while egrep "may have changed" $*.log; do $(TEX) $<; done)
.tex.aux:
	$(TEX) $<


clean:
	rm -rf *~
	rm -rf *.aux *.bbl *.blg *.log $(FILE).lof $(FILE).lot $(FILE).toc $(FILE).out

clean_all: clean
	rm -rf $(FILE).dvi $(FILE).pdf

help:
	@echo "\nUsage: make [<target>]"
	@echo " - all:   execute 'pdf'"
	@echo " - pdf:   make pdf file"
	@echo " - dvi:   make dvi file"
	@echo " - bib:   make bbl file"
	@echo " - clean: remove all temp files"

# ---------------------------------------------------------------------
