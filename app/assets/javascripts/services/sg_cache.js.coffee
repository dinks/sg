cacheFactory = ($cacheFactory)->
  $cacheFactory('sg-cache')

cacheFactory.$inject = ['$cacheFactory']

angular
.module 'sgPicasaViewer'
.factory 'SgCache', cacheFactory
