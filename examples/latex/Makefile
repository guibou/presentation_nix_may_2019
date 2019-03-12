all: doc.pdf

doc.pdf: doc.tex graph.png
	pdflatex doc.tex
	pdflatex doc.tex
	pdflatex doc.tex

graph.png: graph.dot
	dot -Tpng graph.dot > graph.png
