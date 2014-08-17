authService = ($q, $timeout, env)->
  current_token = null
  meths = {}

  meths.signIn = ->
    deferred = $q.defer()
    isGapi = typeof(gapi) != 'undefined'
    if isGapi
      gapi.auth.authorize
        cookie_policy: 'single_host_origin',
        client_id: env.clientId,
        scope: 'https://picasaweb.google.com/data/'
      , (response)->
        if response and !response.error
          current_token = gapi.auth.getToken()
          deferred.resolve response
        else
          deferred.reject null
    else
      $timeout ->
        current_token = null
        deferred.reject null
    deferred.promise

  meths.signOut = ->
    deferred = $q.defer()
    isGapi = typeof(gapi) != 'undefined'
    if isGapi
      gapi.auth.signOut()
      $timeout ->
        current_token = null
        deferred.resolve null
    else
      $timeout ->
        current_token = null
        deferred.reject null
    deferred.promise

  meths.isSignedIn = ->
    current_token != null

  meths.currentToken = ->
    current_token

  meths

authService.$inject = ['$q', '$timeout', 'env']

angular
.module 'sgPicasaViewer'
.factory 'AuthenticationService', authService
