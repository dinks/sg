AlbumsCtrl = ($scope, SgPicasaService, SgCache)->
  $scope.albums = null

  init= ->
    cachedAlbums = SgCache.get 'albums'
    if cachedAlbums
      $scope.albums = cachedAlbums
    else
      SgPicasaService
      .getAlbums()
      .then (data)->
        $scope.albums = data.feed.entry
        SgCache.put 'albums', data.feed.entry

  init()

AlbumsCtrl.$inject = ['$scope', 'SgPicasaService', 'SgCache']

angular
.module 'sgPicasaViewer'
.controller 'AlbumsCtrl', AlbumsCtrl
