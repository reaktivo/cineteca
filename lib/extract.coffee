{ parse } = require 'querystring'
{ map, object } = require 'underscore'
{ trim, clean } = require 'underscore.string'
url = require 'url'

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

  trailer: ->
    embed = @('.botonTrailer')
      .attr('onclick')
      .match(/iframe\:\'(.+?)\'/)[1]
    embed.replace 'embed/', 'watch?v=' if embed

exports.details = ($, url) ->
  object map table, (fn, key) ->
    [key, try fn.call $, url]