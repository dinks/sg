angular
.module 'sgPicasaViewer'
.directive 'onEsc', ->
  link: (scope, elm, attr) ->
    elm.bind 'keydown', (e)->
      if( e.keyCode == 27 )
        scope.$apply attr.onEsc

angular
.module 'sgPicasaViewer'
.directive 'onEnter', ->
  link: (scope, elm, attr) ->
    elm.bind 'keydown', (e) ->
      if( e.keyCode == 13 )
        scope.$apply attr.onEnter

angular
.module 'sgPicasaViewer'
.directive 'onTab', ->
  link: (scope, elm, attr) ->
    elm.bind 'keydown', (e) ->
      if( e.keyCode == 9 )
        e.preventDefault()
        scope.$apply attr.onTab
