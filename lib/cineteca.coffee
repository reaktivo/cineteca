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


day_urls = (cb) ->
  days = [];
  get entry + today, (err, res, body) ->
    $ = cheerio.load body;
    cb null, map $("div#mas_fechas p a"), (a) ->
      "&" + $(a).attr('href').split('&')[1]



# movie_urls()
# movie_urls() loads the initial showtimes
# for the day page, it then passes control
# to movie_details() to extract information
# about individual movies.
#
# @param <String> url: Starting point to load
# @param <Function> callback: Function to call
#        when finished
movie_urls = (url, cb, day) ->
  urls = []
  get entry + url, (err, res, body) ->
    
    $ = cheerio.load body
    cb null, ( map $('[id=botonVer]'), (btn) ->
      "/" + $(btn).attr('onclick').split('\'')[1] + "#" + day), day

# movie_details()
# movie_details() loads the passed movie url
# and extracts it's details, including title,
# trailer url, synopsis, etc.
#
# @param <String> url: The movie url to load
# @param <Function> callback: Function to call
#        when finished
movie_details = (url, cb) ->
  data = url.split("#")
  uri = data[0]
  day = data[1]
  get entry + uri, (err, res, body) ->
    $ = cheerio.load body
    cb null, details $, uri, day

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

  get_movies_by_day: (cb, day) ->
    waterfall [
      (cb) -> movie_urls today + day, cb, day
      (urls, day, cb) -> async.map urls, movie_details, cb
      (movies, cb) -> cb null, compact movies
    ], cb

  get_days: (cb) ->
    waterfall [
      (cb) -> day_urls cb
    ], cb











