assert = require "assert"
{ join } = require "path"
sanitize = require join "..", "lib", "sanitize"
fs = require "fs"

# Create cineteca instance
cineteca = do require join "..", "index"

# Monkey patch instance to use local stubs
cineteca.get = (url, cb) ->
  stub = join __dirname, "stubs", sanitize url
  fs.readFile stub, (err, body) ->
    cb(err, body)

valid_movie = (details) ->
  required_keys = 'id url title time details synopsis img'.split ' '
  for key in required_keys
    assert details[key], 'Movie object missing required key: ' + key
  assert details.url.path, 'Does not have a valid .url path'
  assert details.title.length >= 2, 'Title should be at least two characters long'

describe 'Cineteca', ->

  movies_cache = null

  describe '@movie_urls', ->
    it 'should call callback with a list of valid urls for the movies of the day', (done) ->
      url = cineteca.entry_url + cineteca.today_path
      cineteca.movie_urls url, (err, movies) ->
        movies_cache = movies
        assert Array.isArray movies
        for movie in movies
          assert movie.match(/clv=(\d+)&/gi), 'Path does not include a valid movie id: ' + movie
        done(err, movies)

  describe '@movie_details', ->
    it 'should extract valid movie detail values of a page url', (done) ->
      for movie in movies_cache
        cineteca.movie_details movie, (err, details) ->
          valid_movie details
          done err if err
      done()

  describe '@today', ->
    it 'should get an array of movie like objects after callback', (done) ->
      cineteca.today (err, movies) ->
        assert Array.isArray movies
        valid_movie movie for movie in movies
        done(err, movies)