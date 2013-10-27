# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module("Reportame", ["ngResource", "map.pins"])

app.factory "Incident", ["$resource", ($resource) ->
  $resource("/incidents/:id", {id: "@id"}, {update: {method: "PUT"}, 'query': {method: 'GET', isArray: false}} )
]

@IncidentMapCtrl = ["$scope", "Incident", ($scope, Incident) ->

  $scope.loadIncidents = ->
    Incident.query({map: true}, ( (data) ->
      $scope.incidents      = data.records
    ),
    (data) ->
    )

  $scope.loadIncidents()
]
