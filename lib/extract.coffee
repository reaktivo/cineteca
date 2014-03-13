{ parse } = require 'querystring'
{ map, object } = require 'underscore'
{ trim, clean } = require 'underscore.string'

table =

  id: (url) ->
    trim parse(url.split("?")[1]).clv
  url: (url) -> 'http://www.cinetecanacional.net/' + url
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
    trim @('[id=peliculaImagen] img').attr('src')
  trailer: ->
    @('.botonTrailer')
      .attr('onclick')
      .match(/iframe\:\'(.+?)\'/)[1]

exports.details = ($, url) ->
  object map table, (fn, key) -> [key, try fn.call $, url]