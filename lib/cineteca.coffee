cheerio = require 'cheerio'
request = require 'request'
async = require 'async'
{ waterfall } = async
{ map, compact } = require 'underscore'
{ details } = require './extract'

entry = 'http://www.cinetecanacional.net'
today = '/controlador.php?opcion=carteleraDia'

get = (uri, cb) ->
  request { uri, encoding: 'binary' }, (err, res, body) ->
    if res and res.statusCode
      unless 200 <= res.statusCode < 300 or res.statusCode is 304
        err = new Error "Response status code was #{res.statusCode} successful"
    return cb err if err
    cb err, res, body

# movie_urls()
# movie_urls() loads the initial showtimes
# for the day page, it then passes control
# to movie_details() to extract information
# about individual movies.
#
# @param <String> url: Starting point to load
# @param <Function> callback: Function to call
#        when finished
movie_urls = (url, cb) ->
  urls = []
  get entry + url, (err, res, body) ->
    $ = cheerio.load body
    cb null, map $('[id=botonVer]'), (btn) ->
      "/" + $(btn).attr('onclick').split('\'')[1]

# movie_details()
# movie_details() loads the passed movie url
# and extracts it's details, including title,
# trailer url, synopsis, etc.
#
# @param <String> url: The movie url to load
# @param <Function> callback: Function to call
#        when finished
movie_details = (url, cb) ->
  url = entry + url
  get url, (err, res, body) ->
    $ = cheerio.load body
    cb null, details $, url

# Public API
module.exports =

  # Keep a copy of Cineteca Nacional's url
  prefix: entry

  # today(fn) starts the scraping process
  # to get the movie listings for the day
  # The callback is called with an array of
  # movie listings for the day when complete.
  #
  # @param callback
  today: (cb) ->
    waterfall [
      (cb) -> movie_urls today, cb
      (urls, cb) -> async.map urls, movie_details, cb
      (movies, cb) -> cb null, compact movies
    ], cb
