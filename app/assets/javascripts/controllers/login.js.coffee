LoginCtrl = ($rootScope, $scope, $location, AuthenticationService) ->
  changeLocation = (url, force)->
    $location.path(url).replace()
    mainScope = $rootScope || angular.element('div.ng-scope').scope();
    if force or !$rootScope.$$phase
      $rootScope.$apply()

  init = ->

  $scope.login = ->
    AuthenticationService
    .signIn()
    .then (response)->
      changeLocation('/albums')
    .catch ->
      console.log 'error', response

  init()

LoginCtrl.$inject = ['$rootScope', '$scope', '$location', 'AuthenticationService']

angular
.module 'sgPicasaViewer'
.controller 'LoginCtrl', LoginCtrl
