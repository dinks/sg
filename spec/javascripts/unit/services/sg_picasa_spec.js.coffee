//= require spec_helper

describe 'SgPicasaService', ->
  $SgPicasaService        = null
  $AuthenticationService  = null
  $server                 = null

  beforeEach module('sgPicasaViewer')

  before ->
    $server = sinon.fakeServer.create()

    $server
    .respondWith 'GET',
    '/test', [
      200,
      'Content-Type': 'application/json',
      'dummyCB([])'
    ]

  after ->
    $server.restore()

  beforeEach inject ['SgPicasaService', 'AuthenticationService', (SgPicasaService, AuthenticationService)->
    $SgPicasaService        = SgPicasaService
    $AuthenticationService  = AuthenticationService

    authStub = sinon.stub().returns true
    AuthenticationService.isSignedIn = once authStub

    tokenStub = sinon.stub().returns { currentToken: 'test' }
    AuthenticationService.currentToken = once authStub

    SgPicasaService.picasaUrl = '/test'
  ]

  it 'should get photos', ->

    callback = sinon.spy()

    $SgPicasaService
    .getAlbums()
    .then (data)->

    $server.respond()

    sinon.assert.calledOnce callback

