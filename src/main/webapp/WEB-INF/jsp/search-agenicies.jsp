<%@page contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<title>Listing Archive - Recruiter Shack</title>
<link rel="stylesheet" href="/css/map.css">
<%@ include file="common.jsp"%>
</head>
<body class="custom-background hide-scrollBar">
	<nav class="navbar navbar-static" style="background-color: #10ac51">
		<div class="container">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
					aria-expanded="false">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="/jobseeker/home" style=""> <img alt=""
					src="/img/whiterecruiterlogo.png"></a>
			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-right" id="match-border">
					<li class="dropdown label-color-font-size"><a id="whiteColor-dropDown"
						class="dropdown-toggle" data-toggle="dropdown" href="#">Company
							<span class="caret"></span>
					</a>
						<ul class="dropdown-menu">
							<li><a href="/about">About</a></li>
							<li><a href="/contact">Contact</a></li>
							<li><a href="/faqs">FAQ's</a></li>
						</ul></li>
					<sec:authorize access="isAnonymous()">
						<li><a href="/login" class="label-color-font-size">Login</a></li>
					</sec:authorize>
					<sec:authorize access="isAuthenticated()">
						<li><a href="javascript:formSubmit()" class="label-color-font-size">Logout</a></li>
						<form action="/logout" method="post" id="logoutForm">
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
						</form>
					</sec:authorize>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container-fluid -->
	</nav>
	<div class='container-fluid'>
		<div id="demo"></div>
		<div class="row">
			<div class="col-md-5">
				<div id='job_listings-map'></div>
			</div>
			<div class="col-md-7">
				<div class="row">
					<div class="col-md-6 input-md">
						<input id='pac-input' class="top-boxes form-control"
							placeholder="Location" value="" type="text">
					</div>
					<div class="col-md-6">
						<select id='search-type' class="top-boxes">
							<option value="-1">All Categories</option>
							<c:forEach items="${industries}" var="ind">
								<option value="${ind.getId()}">${ind.getName()}</option>
							</c:forEach>
						</select>
					</div>
					<div class="col-md-12">
						<div class="row">
							<div class="col-md-3">
								<input id="dist_check" class="center" type="checkbox"
									checked="checked"> Radius: <span id='range-display'>100</span>
								KM
							</div>
							<div class="col-md-9">
								<input id='search-range' class="range-slider__range"
									type="range" value="100" min="5" max="500" onchange="update" />
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<button type="button" class="btn btn-default col-md-11"
						id="Ubutton-spacing" onclick="updateSearch()" style="margin-left:20px;">Update</button>
				</div>
				<div class="col-md-12">
					<div id="result-count"></div>
					<ul id="listings" class="featured"></ul>
				</div>
			</div>
		</div>
	</div>
	<footer>
		<div class="container">
			<div class="site-info col-md-12 col-md-offset-6">
				Copyright Recruiter Shack &copy;  2016. All Rights Reserved / <a
					class="bottom-links-color" href="/privacy">Privacy</a> / <a
					class="bottom-links-color" href="/terms">Terms</a>
			</div>
			<!-- .site-info -->
		</div>
	</footer>


	<div id="map"></div>
	<script id="agency" type="text/x-handlebars-template">
      {{#recs}}
        <li>
			<div class="agency">
				<a href="/recruiter/recruiter-public-profile?id={{userName}}"><h3 class="agency-title">{{title}}</h3></a>
				<img src="data:image/jpeg;base64,{{logo}}" alt="Logo" width="200" />
				<div class="distance">{{dist}} KM</div>
			</div>
		</li>
      {{/recs}}
	</script>
	<script>
		$('#search-range').on('input', function() {
			$('#range-display').text($(this).val());
		});
		// This example adds a search box to a map, using the Google Place Autocomplete
		// feature. People can enter geographical searches. The search box will return a
		// pick list containing a mix of places and predicted search terms.

		// This example requires the Places library. Include the libraries=places
		// parameter when you first load the API. For example:
		// <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places">
		var lat = -33.9;
		var lng = 151.2;
		var map;
		function init() {
			if (navigator.geolocation) {
				navigator.geolocation.getCurrentPosition(function(position) {
					lat = position.coords.latitude;
					lng = position.coords.longitude;
					initAutocomplete();
				}, function(error) {
					initAutocomplete();
				});
			} else {
				initAutocomplete();
			}
		}

		function initAutocomplete() {
			map = new google.maps.Map(document
					.getElementById('job_listings-map'), {
				center : {
					lat : lat,
					lng : lng
				},
				zoom : 10,
				mapTypeId : google.maps.MapTypeId.ROADMAP
			});

			// Create the search box and link it to the UI element.
			var input = document.getElementById('pac-input');
			var searchBox = new google.maps.places.SearchBox(input);
			map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

			// Bias the SearchBox results towards current map's viewport.
			map.addListener('bounds_changed', function() {
				searchBox.setBounds(map.getBounds());
			});

			var markers = [];
			// Listen for the event fired when the user selects a prediction and retrieve
			// more details for that place.
			searchBox.addListener('places_changed', function() {
				var places = searchBox.getPlaces();

				if (places.length == 0) {
					return;
				}

				// Clear out the old markers.
				markers.forEach(function(marker) {
					marker.setMap(null);
				});
				markers = [];

				// For each place, get the icon, name and location.
				var bounds = new google.maps.LatLngBounds();
				var place = places[0];
				var icon = {
					url : place.icon,
					size : new google.maps.Size(71, 71),
					origin : new google.maps.Point(0, 0),
					anchor : new google.maps.Point(17, 34),
					scaledSize : new google.maps.Size(25, 25)
				};

				// Create a marker for each place.
				markers.push(new google.maps.Marker({
					map : map,
					icon : icon,
					title : place.name,
					position : place.geometry.location
				}));

				if (place.geometry.viewport) {
					// Only geocodes have viewport.
					bounds.union(place.geometry.viewport);
				} else {
					bounds.extend(place.geometry.location);
				}
				map.fitBounds(bounds);
				lat = place.geometry.location.lat();
				lng = place.geometry.location.lng();
				updateSearch();
			});
			updateSearch();
		}

		function updateSearch() {
			var idst = -1;
			var ind = $('#search-type').val();
			if ($('#dist_check').prop('checked')) {
				idst = $('#search-range').val();
			}
			searchAgencies("/jobseeker/bydistance", idst, ind);
		}

		function searchAgencies(lookupUrl, dist, ind) {

			$.getJSON(lookupUrl, {
				lat : lat,
				lng : lng,
				dist : dist,
				ind : ind
			}, function(data) {
				var len = data.length;
				var recs = [];
				for (var i = 0; i < len; i++) {
					recs.push({
						id : i + 1,
						title : data[i].companyName,
						lat : data[i].lat,
						lng : data[i].lng,
						logo : data[i].logoString,
						dist : data[i].distance,
						userName : data[i].userName
					});
				}
				setMarkers(map, recs);
				setDivs(recs);
			});
		}

		function setDivs(recs) {
			 var source   = $("#agency").html();
			 var template = Handlebars.compile(source);
			 var data = {recs: recs};
			 $("#listings").html(template(data));
			 $("#result-count").html(recs.length+" Results Found");
		}

		var recMarkers = [];
		function setMarkers(map, recs) {
			//Clear old markers
			recMarkers.forEach(function(marker) {
				marker.setMap(null);
			});
			recMarkers = [];
			// Adds markers to the map.

			// Marker sizes are expressed as a Size of X,Y where the origin of the image
			// (0,0) is located in the top left of the image.

			// Origins, anchor positions and coordinates of the marker increase in the X
			// direction to the right and in the Y direction down.
			var image = {
				url : 'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png',
				// This marker is 20 pixels wide by 32 pixels high.
				size : new google.maps.Size(20, 32),
				// The origin for this image is (0, 0).
				origin : new google.maps.Point(0, 0),
				// The anchor for this image is the base of the flagpole at (0, 32).
				anchor : new google.maps.Point(0, 32)
			};
			// Shapes define the clickable region of the icon. The type defines an HTML
			// <area> element 'poly' which traces out a polygon as a series of X,Y points.
			// The final coordinate closes the poly by connecting to the first coordinate.
			var shape = {
				coords : [ 1, 1, 1, 20, 18, 20, 18, 1 ],
				type : 'poly'
			};
			var bounds = new google.maps.LatLngBounds();
			for (var i = 0; i < recs.length; i++) {
				var rec = recs[i];
				var marker = new google.maps.Marker({
					position : {
						lat : rec.lat,
						lng : rec.lng
					},
					map : map,
					//icon: image,
					//shape: shape,
					animation : google.maps.Animation.DROP,
					title : rec.title,
					zIndex : rec.id
				});
				recMarkers.push(marker);
				bounds.extend(new google.maps.LatLng({lat: rec.lat, lng: rec.lng}));
				if(recs.length>0){
					map.fitBounds(bounds);
				}
			}
		}
	</script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=${key}&libraries=places&callback=init"
		async defer></script>
</body>
</html>