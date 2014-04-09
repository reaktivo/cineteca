require('coffee-script/register');
module.exports = require('./lib/cineteca.coffee')

/*
var print_all = function(err, movies) {
    for (j in movies){
      console.log(movies[j].title)
    }
  }

cineteca.get_days( function(err, days) {
    for (i in days){
      cineteca.get_movies_by_day( print_all , days[i] )
    }
  })
*/