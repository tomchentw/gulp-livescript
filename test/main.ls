"use strict";
/**
 * __template__gist__: https://gist.github.com/tomchentw/0dc24c30955c1a6c94d4#file-test__index-js
 */
require! {
  fs
  "gulp-util": gutil
  "gulp-sourcemaps": sourcemaps
}
const gulp-livescript = require if process.env.TRAVIS then "../" else "../src"

(...) <-! describe "gulp-livescript"
require("mocha-jshint")(["./lib/"])
require("mocha-jscs")(["./lib/"])

it "should compile livescript file to javascript" !(done) ->
  const ls = gulp-livescript!
  const fakeFile = new gutil.File do
      base: "test/fixtures"
      cwd: "test/fixtures"
      path: "test/fixtures/file.ls"
      contents: fs.readFileSync "test/fixtures/file.ls"

  ls.once "data" !(expectedFile) ->
    expectedFile.should.exist
    expectedFile.path.should.exist
    expectedFile.contents.should.exist
    String expectedFile.contents .should.equal fs.readFileSync("test/fixtures/expected.js", "utf8")
    done!

  ls.write fakeFile

it "should compile livescript with bare option to javascript" !(done) ->
  const ls = gulp-livescript bare: true
  const fakeFile = new gutil.File do
      base: "test/fixtures"
      cwd: "test/fixtures"
      path: "test/fixtures/file.ls"
      contents: fs.readFileSync "test/fixtures/file.ls"

  ls.once "data" !(expectedFile) ->
    expectedFile.should.exist
    expectedFile.path.should.exist
    expectedFile.contents.should.exist
    String expectedFile.contents .should.equal fs.readFileSync("test/fixtures/bare-expected.js", "utf8")
    done!

  ls.write fakeFile

it "should compile livescript json files" !(done) ->
  const ls = gulp-livescript {+json}
  const fakeFile = new gutil.File do
      base: "test/fixtures"
      cwd: "test/fixtures"
      path: "test/fixtures/file.ls"
      contents: fs.readFileSync "test/fixtures/package.ls"

  ls.once "data" !(expectedFile) ->
    expectedFile.should.exist
    expectedFile.path.should.exist
    expectedFile.contents.should.exist
    String expectedFile.contents .should.equal fs.readFileSync("test/fixtures/json-expected.json", "utf8")
    done!

  ls.write fakeFile

it "should compile livescript json files when extname is .json.ls" !(done) ->
  const ls = gulp-livescript!
  const fakeFile = new gutil.File do
      base: "test/fixtures"
      cwd: "test/fixtures"
      path: "test/fixtures/file.json.ls"
      contents: fs.readFileSync "test/fixtures/package.ls"

  ls.once "data" !(expectedFile) ->
    expectedFile.should.exist
    expectedFile.path.should.equal "test/fixtures/file.json"
    expectedFile.contents.should.exist
    String expectedFile.contents .should.equal fs.readFileSync("test/fixtures/json-expected.json", "utf8")
    done!

  ls.write fakeFile

it "should emit error when livescript compilation fails" !(done) ->
  const ls = gulp-livescript bare: true
  const fakeFile = new gutil.File do
      base: "test/fixtures"
      cwd: "test/fixtures"
      path: "test/fixtures/illegal.ls"
      contents: fs.readFileSync "test/fixtures/illegal.ls"

  ls.once "error" !(error) ->
    error.should.exist
    error.message.should.exist
    error.message.should.equal "Parse error on line 1: Unexpected 'ID'\nat test/fixtures/illegal.js"
    done!

  ls.write fakeFile

it "should emit error with streaming files" !(done) ->
  const ls = gulp-livescript bare: true
  const fakeFile = new gutil.File do
      base: "test/fixtures"
      cwd: "test/fixtures"
      path: "test/fixtures/illegal.ls"
      contents: fs.createReadStream "test/fixtures/file.ls"

  ls.once "error" !(error) ->
    error.should.exist
    error.message.should.exist
    error.message.should.equal "Streaming not supported"
    done!

  ls.write fakeFile

it "should compile livescript file with source map" !(done) ->
  const ls = gulp-livescript!
  const fakeFile = new gutil.File do
      base: "test/fixtures"
      cwd: "test/fixtures"
      path: "test/fixtures/file.ls"
      contents: fs.readFileSync "test/fixtures/file.ls"

  stream = sourcemaps.init!
  stream.write fakeFile
  stream.pipe ls
    .once 'data' !(expectedFile) ->
      mappings = JSON.parse fs.readFileSync("test/fixtures/expected.js.map", "utf8") .mappings
      expectedFile.should.exist
      expectedFile.path.should.exist
      expectedFile.contents.should.exist
      expectedFile.sourceMap.mappings.should.equal mappings
      done!

