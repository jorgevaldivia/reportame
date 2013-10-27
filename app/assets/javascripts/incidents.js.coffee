# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module("Reportame", ["ngResource", "ui.bootstrap"])

app.factory "Incident", ["$resource", ($resource) ->
  $resource("/incidents/:id", {id: "@id"}, {update: {method: "PUT"}, 'query': {method: 'GET', isArray: false}} )
]

@IncidentCtrl = ["$scope", "Incident", ($scope, Incident) ->
  $scope.totalItems       = 0
  $scope.currentPage      = 1
  $scope.maxSize          = 5
  
  $scope.setPage = (pageNo) ->
    $scope.currentPage = pageNo;
    $scope.loadIncidents();
    $.scrollTo("#incidents-section", 600)

  # $scope.incidents = Incident.query( ->
  #   # $scope.createMap()
  #   # $scope.setMarkers()
  # )

  $scope.loadIncidents = ->
    Incident.query({page: $scope.currentPage}, ( (data) ->
      $scope.incidents    = data.records
      $scope.itemsPerPage = data.per_page
      $scope.totalItems   = data.total_entries
    ),
    (data) ->
    )

  $scope.setMarkers = ->
    infowindow = new google.maps.InfoWindow({content: "", maxWidth: 450})

    angular.forEach $scope.incidents, (incident) ->
      marker = new google.maps.Marker({
        position: new google.maps.LatLng(incident.latitude, incident.longitude),
        map: $scope.map,
        title: incident.translated_type
      });

      content_string = "<div class='about-box dark map' id='info-window-content' style='padding-top:3px;'>" +
      '<span class="label label-danger">' + incident.translated_type + '</span><br/>' +
      '<div style="margin-top:5px;">' +
      '<p>' + incident.full_address + '</p>' +
      '<p>' + incident.description + '</p>' +
      '</div>' +
      '</div>'

      google.maps.event.addListener(marker, 'click', ->
         infowindow.setContent content_string
         infowindow.open $scope.map, marker
      );

  $scope.createMap = ->
    $("#main-map-canvas").removeClass("hide");

    mapOptions = {
      center: new google.maps.LatLng(20.6667, -103.3503),
      zoom: 12,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    main_map = new google.maps.Map(document.getElementById("main-map-canvas"), mapOptions);

    google.maps.event.addDomListener(window, "resize", ->
      center = main_map.getCenter();
      google.maps.event.trigger(main_map, "resize");
      main_map.setCenter(center); 
    );

    $scope.map = main_map

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
