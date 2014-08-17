# Dummy Callback to make sure that the request to picasaweb works
window.dummyCB = ->

sgPicasaService = ($resource, $q, $timeout, AuthenticationService)->
  picasaUrl = 'https://picasaweb.google.com/data/feed/api/user/default'

  meths =
    url: picasaUrl

  meths.getAlbums = ->
    deferred = $q.defer()

    if AuthenticationService.isSignedIn()
      $
      .get meths.url,
        'max-results': 20
        'access_token': AuthenticationService.currentToken().access_token
        'alt': 'json-in-script'
        'callback': 'dummyCB'
      .success (data)->
        re = new RegExp 'dummyCB\((.*)\)', 'g'
        matchedArray = re.exec data
        # Hack Hack Hack
        deferred.resolve eval(matchedArray[1])
      .error ->
        deferred.reject null
    else
      $timeout ->
        deferred.reject null

    deferred.promise;

  meths.getAlbum = (id)->
    deferred = $q.defer()

    if AuthenticationService.isSignedIn()
      $
      .get meths.url + '/albumid/' + id,
        'max-results': 3
        'access_token': AuthenticationService.currentToken().access_token
        'alt': 'json-in-script'
        'callback': 'dummyCB'
      .success (data)->
        re = new RegExp 'dummyCB\((.*)\)', 'g'
        matchedArray = re.exec data
        # Hack Hack Hack
        deferred.resolve eval(matchedArray[1])
      .error ->
        deferred.reject null
    else
      $timeout ->
        deferred.reject null

    deferred.promise;

  meths.postComment = (albumId, photoId, comment)->
    deferred = $q.defer()

    if AuthenticationService.isSignedIn()
      # https://groups.google.com/forum/#!msg/google-picasa-data-api/bHwIXzLAZQ4/UPm6KBbQcuwJ
      commentStructure = "<entry xmlns='http://www.w3.org/2005/Atom'><content>" + escape(comment) + "</content><category scheme=\"http://schemas.google.com/g/2005#kind\" term=\"http://schemas.google.com/photos/2007#comment\"/></entry>"
      $
      .post meths.url + '/albumid/' + albumId + '/photoid/' + photoId,
        'access_token': AuthenticationService.currentToken().access_token
        'alt': 'json-in-script'
        'callback': 'dummyCB'
        'kind': 'comment'
        'entry':
          'content': escape(comment)
          'category':
            'kind': 'comment'
      .success (data)->
        deferred.resolve data
      .error ->
        deferred.reject null
    else
      $timeout ->
        deferred.reject null

    deferred.promise;

  meths

sgPicasaService.$inject = ['$resource', '$q', '$timeout', 'AuthenticationService']

angular
.module 'sgPicasaViewer'
.factory 'SgPicasaService', sgPicasaService
