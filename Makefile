
HTML_FILES := $(patsubst %.Rmd, %.html ,$(wildcard *.Rmd)) \
              $(patsubst %.md, %.html ,$(wildcard *.md))

all: html


html: $(HTML_FILES)

%.html: %.Rmd
#	R --version
#	R -q -e "installed.packages()"
#	R --slave -e "set.seed(100); library(\"rmarkdown\", lib.loc = \"/home/michaelt/Software/R-3.0.2/library\"); render('$<');"
	R --slave -e "set.seed(100); .libPaths(c( .libPaths(), \"/home/michaelt/Software/R-3.0.2/library\")); rmarkdown::render('$<')"
#	R --slave -e "set.seed(100); rmarkdown::render('$<')"

%.html: %.md
#	R --slave -e "set.seed(100); rmarkdown::render('$<')"
	R --slave -e "set.seed(100); .libPaths(c( .libPaths(), \"/home/michaelt/Software/R-3.0.2/library\")); rmarkdown::render('$<')"

.PHONY: clean
clean:
	$(RM) $(HTML_FILES)

