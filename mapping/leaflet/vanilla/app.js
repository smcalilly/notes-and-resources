// code from https://leafletjs.com/examples/quick-start/

let mymap = L.map('mapid').setView([34.256933, -88.703613], 13);

L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}', {
    attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
    maxZoom: 18,
    id: 'mapbox/streets-v11',
    tileSize: 512,
    zoomOffset: -1,
    accessToken: 'cyalater'
}).addTo(mymap);

var popup = L.popup()
    .setLatLng([34.27, -88.69])
    .setContent("Greetings from Forlorn, Mississippi.")
    .openOn(mymap);

let circle = L.circle([34.27, -88.69], {
    color: 'red',
    fillColor: '#f03',
    fillOpacity: 0.5,
    radius: 500
}).addTo(mymap)

let polygon = L.polygon([
    [34.26, -88.71],
    [34.20, -88.57],
    [34.22, -88.75]
]).addTo(mymap);

// marker.bindPopup("<b>Hello world!</b><br>I am a popup.").openPopup()
circle.bindPopup('I am a circle.')
polygon.bindPopup("I am a polygon.")

var popup = L.popup();

function onMapClick(e) {
    popup
        .setLatLng(e.latlng)
        .setContent("You clicked the map at " + e.latlng.toString())
        .openOn(mymap);
}

mymap.on('click', onMapClick);


// i tried making a form but on my first attempt
// the map reloads whenever the form submits...
function moveLocations(event) {
    console.log(event)
    // popup
    //  .setLatLng
}

let formInput = document.getElementById('coordinate-input');
console.log(formInput)
formInput.addEventListener('submit', moveLocations)
