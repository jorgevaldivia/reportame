# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module("Reportame", ["ngResource"])

app.factory "Incident", ["$resource", ($resource) ->
  $resource("/incidents/:id", {id: "@id"}, {update: {method: "PUT"}})
]

@IncidentCtrl = ["$scope", "Incident", ($scope, Incident) ->

  $scope.incidents = Incident.query( ->
    $scope.createMap()
    $scope.setMarkers()
  )

  $scope.setMarkers = ->
    angular.forEach $scope.incidents, (incident) ->
      marker = new google.maps.Marker({
        position: new google.maps.LatLng(incident.latitude, incident.longitude),
        map: $scope.map,
        title: incident.incident_type
      });
      
      
  $scope.createMap = ->
    $("#main-map-canvas").removeClass("hide");

    mapOptions = {
      center: new google.maps.LatLng(20.6667, -103.3503),
      zoom: 12,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    main_map = new google.maps.Map(document.getElementById("main-map-canvas"), mapOptions);
    $scope.map = main_map
]