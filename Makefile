bin 					= ./node_modules/.bin

lastCommit 	 	:= $(shell git rev-parse --short=10 HEAD)
newReleaseMsg := "chore(release): $(lastCommit) by Makefile"

version    		= `$(bin)/lsc -e "require './package.json' .version |> console.log"`

.PHONY: test

default:
	npm i

test: default
	npm test

release: test
	$(bin)/gulp release

	git add -A
	git commit -m $(newReleaseMsg)
	git tag -a $(version) -m $(newReleaseMsg)
	git push
	git push --tags
	npm publish