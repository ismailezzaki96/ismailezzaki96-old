.PHONY: examples

CC = xelatex
EXAMPLES_DIR = output
RESUME_DIR = examples/resume
CV_DIR = cv
RESUME_SRCS = $(shell find $(RESUME_DIR) -name '*.tex')
 
all:
	make clean
	make cv.pdf
	make coverletter.pdf

cv.pdf: $ cv.tex 
	$(CC) $<

	
coverletter.pdf: $ motivation_letter.tex 
	$(CC) $<

clean:
	rm -rf cv.pdf
	rm -rf motivation_letter.pdf

show:
	okular cv.pdf
