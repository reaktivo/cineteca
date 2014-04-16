cheerio = require 'cheerio'
request = require 'request'
async = require 'async'
{ waterfall } = async
{ map, compact } = require 'underscore'
details = require './details'


module.exports = ({entry, today} = {}) ->

  @entry_url = entry or 'http://www.cinetecanacional.net'
  @today_path = today or '/controlador.php?opcion=carteleraDia'

  @get = (url, cb) ->
    request { url, encoding: 'binary' }, (err, res, body) ->
      if res and res.statusCode
        unless 200 <= res.statusCode < 300 or res.statusCode is 304
          err = new Error "Response status code was #{res.statusCode} successful"
      cb err, body

  # movie_urls()
  # movie_urls() loads the initial showtimes
  # for the day page, it then passes control
  # to movie_details() to extract information
  # about individual movies.
  #
  # @param <String> url: Starting point to load
  # @param <Function> callback: Function to call
  #        when finished
  @movie_urls = (url, cb) =>
    urls = []
    @get url, (err, body) ->
      return cb err if err
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
  @movie_details = (url, cb) =>
    url = @entry_url + url
    @get url, (err, body) ->
      return cb err if err
      $ = cheerio.load body
      cb null, details $, url

  # today(fn) starts the scraping process
  # to get the movie listings for the day
  # The callback is called with an array of
  # movie listings for the day when complete.
  #
  # @param callback
  @today = (cb) =>
    waterfall [
      (cb) => @movie_urls @entry_url + @today_path, cb
      (urls, cb) => async.map urls, @movie_details, cb
      (movies, cb) => cb null, compact movies
    ], cb

  this
