DIR = $(shell basename $(shell pwd))

.PHONY: default
default: root.pdf

.PHONY: all
all: root.dvi root.ps root.pdf

.PHONY: root.dvi
root.dvi: *.tex
	latex root
	bibtex root
	latex root
	latex root

root.ps: root.dvi
	dvips -o root.ps root.dvi

root.pdf: *.tex
	pdflatex root
	bibtex root
	pdflatex root
	pdflatex root

.PHONY: dist
dist: root.pdf
	cp root.pdf ppdp2022.pdf

.PHONY: print
print: root.dvi
	dvips -P${PRINTER} root.dvi

.PHONY: view
view: root.dvi
	xdvi root.dvi

.PHONY: clean
clean:
	rm -f root.dvi root.ps root.pdf
	rm -f *.aux *.out *.log *.bbl *.blg

%.pdf : %.eps
	epstopdf $*.eps > $*.pdf
