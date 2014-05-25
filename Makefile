bin           = ./node_modules/.bin
requireLS     = --require LiveScript

lastCommit    = $(shell git rev-parse --short=10 HEAD)
newCommitMsg  = "chore(release): $(lastCommit) by Makefile"

getVersion    = `ruby -r 'json' -e "puts JSON.parse(File.read('package.json'))['version']"`

.PHONY: test

default:
	npm i

test: default
	npm test

release: test
	$(bin)/gulp release $(requireLS) --type=$(TYPE)

	git add -A
	git commit -m $(newCommitMsg)
	git tag -a $(getVersion) -m $(newCommitMsg)
	git push
	git push --tags
	npm publish