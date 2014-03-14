{ parse } = require 'querystring'
{ map, object } = require 'underscore'
{ trim, clean } = require 'underscore.string'
url = require 'url'

get_youtube_id = ($) ->
  $('.botonTrailer')
    .attr('onclick')
    .match(/\/(.{11})(?:\'|\?)/)[1]

table =

  id: (url) ->
    trim parse(url.split("?")[1]).clv

  url: (urlv) ->
    url.parse urlv

  title: ->
    @('.peliculaTitDir').remove()
    clean @('.peliculaTitulo').text()

  time: ->
    clean @('#horarios p:first-of-type span:last-of-type').text()

  details: ->
    trim @('[id=peliculaFicha]').html()

  synopsis: ->
    clean @('[id=peliculaSinopsis] p[style]').text()

  img: ->
    url.parse @('[id=peliculaImagen] img').attr('src')

  youtube: ->
    id = get_youtube_id(this)
    "http://www.youtube.com/watch?v=#{id}" if id

  embed: ->
    id = get_youtube_id(this)
    "http://www.youtube.com/embed/#{id}?autoplay=1" if id

exports.details = ($, url) ->
  object map table, (fn, key) ->
    [key, try fn.call $, url]