cheerio = require 'cheerio'
request = require 'request'
async = require 'async'
{ waterfall } = async
{ map } = require 'underscore'
{ details } = require './extract'

entry_url = 'http://www.cinetecanacional.net/'
today_url = 'controlador.php?opcion=carteleraDia'

get = (url, cb) ->
  opts =
    uri: entry_url + url
    encoding: 'binary'
  request opts, cb

movie_urls = (url, cb) ->
  urls = []
  get url, (err, res, body) ->
    $ = cheerio.load body
    cb null, map $('[id=botonVer]'), (btn) ->
      $(btn).attr('onclick').split('\'')[1]

movie_details = (url, cb) ->
  get url, (err, res, body) ->
    $ = cheerio.load body
    cb null, details $, url

module.exports =

  today: (cb) ->
    waterfall [
      (cb) -> movie_urls today_url, cb,
      (urls, cb) -> async.map urls, movie_details, cb
    ], cb
