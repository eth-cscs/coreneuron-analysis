report.pdf : $(TEXFILES)
	pdflatex report

force : report.pdf
	pdflatex report

open : report.pdf
	evince report.pdf
#	open report.pdf

clean:
	rm report.pdf
	rm report.aux
	rm report.log

