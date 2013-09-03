var main_map;

function initialize_main_map() {
  $("#main-map-canvas").removeClass("hide");

  var mapOptions = {
    center: new google.maps.LatLng(20.6667, -103.3503),
    zoom: 12,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  main_map = new google.maps.Map(document.getElementById("main-map-canvas"), mapOptions);
}

// Resize stuff...
google.maps.event.addDomListener(window, "resize", function() {
	var center = main_map.getCenter();
	google.maps.event.trigger(main_map, "resize");
	main_map.setCenter(center); 
});

$(document).ready(function(){
	initialize_main_map();
});