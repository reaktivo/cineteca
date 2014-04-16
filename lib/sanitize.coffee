cineteca = do require './cineteca'

module.exports = (url) ->
  url = url
    .replace cineteca.entry_url, ''
    .replace 'controlador', ''
    .replace 'Dia', ''
    .replace 'detallePelicula.php?clv=', ''
    .replace '/php/', ''
    .replace '.php?', ''
    .replace 'opcion=', ''
    .replace /\&Tit=.+$/gi, ''
    .toLowerCase()
  url + '.html'