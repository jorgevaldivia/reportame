# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module("Reportame", ["ngResource", "ui.bootstrap", "table.extensions", "map.pins"])

app.factory "Incident", ["$resource", ($resource) ->
  $resource("/incidents/:id", {id: "@id"}, {update: {method: "PUT"}, 'query': {method: 'GET', isArray: false}} )
]

app.factory "Image", ["$resource", ($resource) ->
  $resource("/incidents/:incidentId/images/:id", {incidentId: "@incidentId", id: "@id"} )
]

@IncidentCtrl = ["$scope", "Incident", ($scope, Incident) ->
  $scope.totalItems       = 0
  $scope.currentPage      = 1
  $scope.maxSize          = 5
  $scope.incidentTypes    = []
  $scope.incidentType     = ""
  $scope.searchText       = ""
  $scope.from             = "list"

  $scope.setPage = (pageNo) ->
    $scope.currentPage = pageNo;
    $scope.loadIncidents();
    $.scrollTo("#incidents-section", 600)

  $scope.loadIncidents = ->
    Incident.query({page: $scope.currentPage, incident_type: $scope.incidentType, q: $scope.searchText}, ( (data) ->
      $scope.incidents      = data.records
      $scope.itemsPerPage   = data.per_page
      $scope.totalItems     = data.total_entries
      if $scope.incidentTypes.length == 0
        $scope.incidentTypes  = data.types
    ),
    (data) ->
    )

  $scope.loadIncidents()
]

app.factory "IncidentType", ["$resource", ($resource) ->
  $resource("/incident_types/:id", {id: "@id"}, {update: {method: "PUT"}})
]

@IncidentTypeCtrl = ["$scope", "IncidentType", ($scope, IncidentType) ->
  $scope.incident_types = IncidentType.query()
]


getLocation = ->
  if (navigator.geolocation)
    navigator.geolocation.getCurrentPosition(showPosition);

showPosition = (position) ->
  $("#incident_latitude").val(position.coords.latitude);
  $("#incident_longitude").val(position.coords.longitude);

$(document).ready( ->
  entry_tabs();
  $("#gps-link").click( ->
    if !$("#incident_latitude").val() && !$("#incident_longitude").val()
      getLocation()
  )

  if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) )
    $("#gps-link").trigger("click");
);

entry_tabs = ->
  $("#entry-tab a").click((e) ->
    tab       = $(this);
    li        = tab.parent();
    content   = $(tab.attr("href"));

    e.preventDefault();
    $("#entry-tab li").removeClass("active");
    li.addClass("active");
    content.parent().find(".tab-pane").removeClass("active");
    content.addClass("active");
  );
