# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# app = angular.module("Reportame", ["ngResource"])

# app.factory "Image", ["$resource", ($resource) ->
#   $resource("/incidents/:incident_id/images/:id", {incident_id: "@item_id", id: "@id"} )
# ]

# @IncidentIDController = ["$scope", "sharedService", ( $scope, sharedService ) ->
  # $scope.$watch('incident_id', (UID) ->
  #   sharedService.setProjectID($scope.incident_id)
  # )
# ]

# @ImageCtrl = ["$scope", "Image", ($scope, Image) ->
# 	# alert(sharedService.getProjectId())
# ]

# app.factory "Image", ["$resource", ($resource) ->
#   $resource("/images/:id", {id: "@id"}, {update: {method: "PUT"}, 'query': {method: 'GET', isArray: false}} )
# ]

# @ImageCtrl = ["$scope", "Image", ($scope, Image) ->
# ]

@ImageCtrl = ["$scope", "Image", ($scope, Image) ->
	Image.query({incidentId: 121})
]