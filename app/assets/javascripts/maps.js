function initialize_main_map() {
  $("#main-map-canvas").removeClass("hide");

  var mapOptions = {
    center: new google.maps.LatLng(20.6667, -103.3503),
    zoom: 12,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  main_map = new google.maps.Map(document.getElementById("main-map-canvas"), mapOptions);

  console.log($("[ng-controller=IncidentCtrl]"));
  var myLatlng = new google.maps.LatLng(20.6711852, -103.3628912);
  // var marker = new google.maps.Marker({
  //     position: myLatlng,
  //     map: main_map,
  //     title: 'Hello World!'
  // });
}

// Resize stuff...
// google.maps.event.addDomListener(window, "resize", function() {
// 	var center = main_map.getCenter();
// 	google.maps.event.trigger(main_map, "resize");
// 	main_map.setCenter(center); 
// });

$(document).ready(function(){
	initialize_main_map();
});