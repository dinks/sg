safeApply = ($rootScope)->
  $rootScope.$safeApply = ($scope, fn) ->
    fn = fn or ->
    if $scope.$$phase
      fn()
    else
      $scope.$apply fn

safeApply.$inject = ['$rootScope']

angular
.module 'sgPicasaViewer'
.run safeApply
