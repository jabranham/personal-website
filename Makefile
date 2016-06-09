all:
	bundle exec jekyll serve

clean:
	rm -r _site/

test:
	script/cibuild
