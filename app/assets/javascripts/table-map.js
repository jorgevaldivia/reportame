angular.module("map.extensions", ["map.pins"]);
angular.module('map.pins', [])

.controller('TableMapController', ['$scope', '$attrs', '$parse', '$interpolate', function ($scope, $attrs, $parse, $interpolate) {
  var self = this;

  this.init = function() {
    $scope.$parent.$watch($parse($attrs.incidents), function(value) {
      if(value){
        $scope.incidents = value
        $scope.createMap();
        $scope.setMarkers();
      }
    });
  }

  $scope.setMarkers = function() {
    var infowindow;
    infowindow = new google.maps.InfoWindow({
      content: "",
      maxWidth: 450
    });
    return angular.forEach($scope.incidents, function(incident) {
      var content_string, marker;
      marker = new google.maps.Marker({
        position: new google.maps.LatLng(incident.latitude, incident.longitude),
        map: $scope.map,
        title: incident.translated_type
      });
      content_string = "<div class='about-box dark map' id='info-window-content' style='padding-top:3px;'>" + 
        '<span class="label label-danger">' + incident.translated_type + '</span><br/>' + 
        '<div style="margin-top:5px;">' + '<p>' + incident.full_address + '</p>' + 
        '<p>' + incident.description + '</p>' + '</div>' + '</div>';
      return google.maps.event.addListener(marker, 'click', function() {
        infowindow.setContent(content_string);
        return infowindow.open($scope.map, marker);
      });
    });
  };

  $scope.createMap = function() {
    var main_map, mapOptions;
    $("#main-map-canvas").removeClass("hide");
    mapOptions = {
      center: new google.maps.LatLng(20.6667, -103.3503),
      zoom: 12,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    main_map = new google.maps.Map(document.getElementById("main-map-canvas"), mapOptions);
    google.maps.event.addDomListener(window, "resize", function() {
      var center;
      center = main_map.getCenter();
      google.maps.event.trigger(main_map, "resize");
      return main_map.setCenter(center);
    });
    return $scope.map = main_map;
  };

  
}])

.constant('tableMapConfig', {
})

.directive('tableMap', ['$parse', 'tableMapConfig', function($parse, config) {
  return {
    restrict: 'EA',
    scope: {
      incidents: '=',
    },
    controller: 'TableMapController',
    templateUrl: '/assets/tables/map.html',
    replace: true,
    link: function(scope, element, attrs, tableMapCtrl) {
      tableMapCtrl.init();
    }
  }
}]);