@LandingCtrl = ["$scope", "$http", "$location", ($scope, $http, $location) ->
  $scope.loaded = true

  $scope.message = "Hello from angular!"
]