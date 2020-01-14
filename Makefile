.PHONY: examples

CC = xelatex
EXAMPLES_DIR = output
RESUME_DIR = examples/resume
CV_DIR = cv
RESUME_SRCS = $(shell find $(RESUME_DIR) -name '*.tex')
 
all:
	make clean
	make cv.pdf

cv.pdf: $ cv.tex 
	$(CC) $<


clean:
	rm $(CV_DIR).pdf

show:
	okular cv.pdf
