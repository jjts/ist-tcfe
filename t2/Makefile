# ------------------------------------------------------------
# type "make" command in the Linux terminal create report.pdf
#
# type "make clean" to delete all generated files
# ------------------------------------------------------------

all:
	@echo "Please enter number for data generation:"
	@python t2_datagen.py > data.txt
	make -C mat
	make -C sim
	make -C doc
	cp doc/report.pdf .

clean:
	@rm -f *.txt 
	make -C mat clean
	make -C sim clean
	make -C doc clean

.PHONY: all clean


