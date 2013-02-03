// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var HeatMap = function(){
  var mapOptions = {
    zoom: 9,
    center: new google.maps.LatLng(40.014978,-105.270545),
    mapTypeId: google.maps.MapTypeId.TERRAIN
  };

  var map = new google.maps.Map(
    document.getElementById('map_canvas'),
    mapOptions
  );

  var rows = [
    "39.9529, -105.2308",
    "39.9569, -105.1847",
    "39.9435, -105.5289",
    "39.949, -105.3302",
    "40.0201, -105.3401",
    "40.1874, -105.2951",
    "40.0324, -105.3383",
    "40.0252, -105.2437",
    "40.1073, -105.3323",
    "40.0136, -105.3091"
  ];
  var heatmapData = [];
  for (var i in rows) {
    var row_data = rows[i].split(', ')
    var lat = row_data[0];
    var lng = row_data[1];
    heatmapData.push(new google.maps.LatLng(lat,lng));
  }
  var heatmap = new google.maps.visualization.HeatmapLayer({
    data: heatmapData
  });

  heatmap.setMap(map);
}
