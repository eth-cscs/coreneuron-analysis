IMAGES=images/*.pdf
TEXFILES=report.tex timestep_impl.tex appendix_*.tex benchmarking.tex overview.tex maths.tex

report.pdf : $(TEXFILES) $(IMAGES)
	pdflatex --shell-escape report

force : report.pdf
	pdflatex --shell-escape report

open : report.pdf
	open report.pdf

clean:
	rm -f report.pdf
	rm -f *.aux
	rm -f *.log

