PDFS=calltree.pdf bbs_netpar_solve.pdf tree.pdf discrete.pdf discrete_a.pdf discrete_b.pdf  discrete_c.pdf discrete_d.pdf timestep_flow.pdf dataStorage.pdf
all: ${PDFS}

calltree.pdf: calltree.dot
	dot -Tpdf -o calltree.pdf calltree.dot

bbs_netpar_solve.pdf: bbs_netpar_solve.dot
	dot -Tpdf -o bbs_netpar_solve.pdf bbs_netpar_solve.dot

tree.pdf: tree.dot
	dot -Tpdf -o tree.pdf tree.dot

discrete.pdf: discrete.dot
	dot -Tpdf -o discrete.pdf discrete.dot

discrete_a.pdf: discrete_a.dot
	dot -Tpdf -o discrete_a.pdf discrete_a.dot

discrete_b.pdf: discrete_b.dot
	dot -Tpdf -o discrete_b.pdf discrete_b.dot

discrete_c.pdf: discrete_c.dot
	dot -Tpdf -o discrete_c.pdf discrete_c.dot

discrete_d.pdf: discrete_d.dot
	dot -Tpdf -o discrete_d.pdf discrete_d.dot

timestep_flow.pdf: timestep_flow.tex
	pdflatex timestep_flow.tex

dataStorage.pdf: dataStorage.tex
	pdflatex dataStorage.tex

clean:
	rm -f ${PDFS}
	rm -f *.dvi
	rm -f *.aux
	rm -f *.log
