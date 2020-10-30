header = '<head><link rel="stylesheet" href="/exercises/style.css"></head> <div class="footer"><img class='logo'  src='https://www.csc.fi/documents/10180/152246/CSC-logo.png' alt='CSC'/></div>'

all: index exercises

index: index.html
index.html: README.md
	echo $(header) > index.html
	markdown_py README.md >>index.html

exercises:
	find . -name readme.md -exec dirname {} \; | while read p; do echo $(header) > $${p}/index.html; markdown_py $${p}/readme.md >> $${p}/index.html; done
