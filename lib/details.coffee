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
    clean @('.peliculaTitulo').first().text()

  time: ->
    clean @('#horarios p:first-of-type span:last-of-type').text()

  details: ->
    trim @('[id=peliculaFicha]').html()

  synopsis: ->
    $ = this
    el = $('[id=peliculaSinopsis]')
    $('p', el).removeAttr('style')
    el.html()

  img: ->
    url.parse @('[id=peliculaImagen] img').attr('src')

  youtube: ->
    id = get_youtube_id(this)
    "http://www.youtube.com/watch?v=#{id}&iv_load_policy=3" if id

  embed: ->
    id = get_youtube_id(this)
    "http://www.youtube.com/embed/#{id}?autoplay=1&iv_load_policy=3" if id

module.exports = ($, url) ->
  movie = object map table, (fn, key) ->
    [key, try fn.call $, url]
  if movie.id then movie else null