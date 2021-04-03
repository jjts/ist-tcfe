FILES = t2_1.net t2_2.net 

all: ngspice.log prep3 sim4
	$(eval NGSFIGS=$(shell grep _FIG $< | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	$(foreach i, $(NGSFIGPS), ps2pdf $i;)
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)

ngspice.log: $(FILES) 
	for f in $^; do ngspice -b $$f -o test.log; cat test.log >> $@;done
	@rm test.log

prep3: prep3.m
	octave $< >> ngspice_data_3.txt
	ngspice -b t2_3.net -o test.log
	cat test.log >> ngspice.log
	@rm test.log

sim4:
	ngspice -b t2_4.net -o test.log
	cat test.log >> ngspice.log
	@rm test.log

clean:
	@rm -f ngspice.log *.txt *.log *.tex *.pdf *.ps *~

.PHONY: all clean
