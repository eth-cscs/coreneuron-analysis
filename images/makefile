all: calltree.pdf bbs_netpar_solve.pdf

calltree.pdf: calltree.dot
	dot -Tpdf -o calltree.pdf calltree.dot

bbs_netpar_solve.pdf: bbs_netpar_solve.dot
	dot -Tpdf -o bbs_netpar_solve.pdf bbs_netpar_solve.dot

clean:
	rm -f *.pdf
