meta = (provider) ->
  m = document.getElementsByTagName 'meta'
  for i in m
    provider.defaults.headers.common['X-CSRF-Token'] = i.content if i.name == 'csrf-token'

meta.$inject = ['$httpProvider']

angular
.module 'sgPicasaViewer'
.config meta
