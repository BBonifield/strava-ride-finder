// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var HeatMap = function(){
  var data_points, point_array, map, heatmap;

  var mapOptions = {
    zoom: 9,
    center: new google.maps.LatLng(40.014978,-105.270545),
    mapTypeId: google.maps.MapTypeId.TERRAIN
  };

  map = new google.maps.Map(document.getElementById('map_canvas'),
      mapOptions);

  point_array = new google.maps.MVCArray(taxiData);

  heatmap = new google.maps.visualization.HeatmapLayer({
    data: point_array
  });

  heatmap.setMap(map);
}
