cineteca
========

Un módulo Nodejs para extraer horarios de películas en la Cineteca Nacional.

## Para instalar:

    npm install cineteca@latest --save

## Testing

    npm test

## Para usar

    var cineteca = require('cineteca')({
      // defaults:
      entry: 'http://www.cinetecanacional.net',
      today: '/controlador.php?opcion=carteleraDia'
    });

    cineteca.today(function(err, movies) {
      // movies es un array de
      // [{ id: '12578',
      // url:
      //  { href: 'http://www.cinetecanacional.net/php/detallePelicula.php?clv=12578&Tit=Estrenos' },
      // title: 'Balada de un hombre común',
      // time: '22:00 hrs.',
      // details: '<span class="bold">Director:</span>&nbsp;Ethan y Joel Coen.&nbsp;<span class="bold">Gui&oacute;n:</span>&nbsp;Ethan y Joel Coen.&nbsp;<span class="bold">F en C.:</span>&nbsp;Bruno Delbonnel.&nbsp;<span class="bold">Edici&oacute;n:</span>&nbsp;Roderick Jaynes.&nbsp;<span class="bold">Con:</span>&nbsp;Oscar Isaac (Llewyn Davis), Carey Mulligan (Jean), Justin Timberlake (Jim), Ethan Phillips (Mitch Gorfein), Garrett Hedlund (Johnny Five), John Goodman (Roland Turner).&nbsp;<span class="bold">Productor:</span>&nbsp;Ethan y Joel Coen y Scott Rudin.&nbsp;<span class="bold">Clasificaci&oacute;n:</span>&nbsp;B.',
      // synopsis: '\r\n                <p> </p><p>La vida de un joven cantante de folk en el universo de Greenwich Village en 1961. Llewyn Davis est&aacute; en una encrucijada. Con su guitarra a cuestas acurrucado contra el fr&iacute;o de un invierno implacable en Nueva York, el joven lucha por ganarse la vida como m&uacute;sico y hace frente a obst&aacute;culos que parecen insuperables &mdash;comenzando por aquellos creados por &eacute;l mismo&mdash;. Sobrevive gracias a la ayuda de sus amigos o de desconocidos a cambio de peque&ntilde;os trabajos. De los caf&eacute;s del Village a un club desierto de Chicago, sus desventuras lo llevan a una audici&oacute;n para el gigante de la m&uacute;sica Bud Grossman, antes de volver al lugar de donde viene.</p><p></p>\r\n                <p> </p><p><strong>Sitio oficial: <a href="http://www.insidellewyndavis.com/splash">www.insidellewyndavis.com</a></strong></p>\n<p><strong>Facebook: <a href="https://www.facebook.com/CorazonFilms">/CorazonFilms</a></strong></p>\n<p><strong>Twitter: <a href="https://twitter.com/CorazonFilms">@CorazonFilms</a><br></strong></p>\n<p><strong><br></strong></p><p></p>\r\n            ',
      // img:
      //  { path: '/imagenes/img_peliculas/12578-B.jpg',
      //    href: 'http://www.cinetecanacional.net/imagenes/img_peliculas/12578-B.jpg' },
      // youtube: 'http://www.youtube.com/watch?v=ltK0IN2U2hU&iv_load_policy=3',
      // embed: 'http://www.youtube.com/embed/ltK0IN2U2hU?autoplay=1&iv_load_policy=3' }, etc ]
    });
