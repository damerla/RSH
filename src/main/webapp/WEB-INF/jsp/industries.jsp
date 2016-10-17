* HTML document, UTF-8 Unicode text, with CRLF line terminators
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Industries</title>
<%@ include file="common.jsp"%>
	
</head>
<body>
	<nav class="nav nav-bar navbar-inverse">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="/" style=""><h6 style="color:white"><span class="glyphicon glyphicon-hand-left" style="color:white"></span>&nbsp Back to site</h6> </a>
			</div>
			<ul class="nav navbar-nav navbar-right">
					 <li><a href="#"><span class="glyphicon glyphicon-info-sign"></span>&nbsp Help</a></li>
			</ul>
		</div>
	</nav>
	<div class="container"> 
		<div class="adm-img-spacing col-md-3">
			<img src="/img/rshLogo.png"> </img>
		</div>
		<div class="col-md-9">
			<ul class="col-md-offset-4 button-position-middle">
	        	<button class="btn-lg" type="button"><span class="glyphicon glyphicon-edit"></span><br>Create New </button>
	        	<button class="btn-lg" type="button"><span class="glyphicon glyphicon-inbox"></span><br>Templates</button>
	        	<button class="btn-lg" type="button"><span class="glyphicon glyphicon-export"></span><br>Export Data</button>
	        </ul>
		</div>
	</div>
	<div class="container-fluid">
		<div class="adm-list-group container col-md-2 col-md-offset-1">
			<a href="#" class="list-group-item "><span class="glyphicon glyphicon-dashboard"></span>&nbsp Dashboard</a>
			<a href="#" class="list-group-item active"><span class="glyphicon glyphicon-edit"></span>&nbsp Industries</a>
			<a href="#" class="list-group-item"><span class="glyphicon glyphicon-edit"></span>&nbsp JobSeekers</a>
			<a href="#" class="list-group-item"><span class="glyphicon glyphicon-edit"></span>&nbsp Recruiters</a>
		</div>
		
		
			<div class="page-header col-md-7" id="ad-header-color">
				Industries  
			</div>
			<div class="page-header col-md-7 panel panel-default" id="adm-header-position" style>
				<span class="glyphicon glyphicon-home ">&nbsp<span class="glyphicon glyphicon-menu-right"  style="color:#d9d9d9"></span></span>&nbsp Industries
			</div>
	
	<nav class="nav nav-bar navbar-inverse navbar-fixed-bottom">
		<div class="container">
			<div class="navbar-header">
			<a id="adm-bottom-header-color" href="#">LightAdmin Â© 2014.</a> All rights reserved.
			</div>
		</div>
	</nav>
</body>
</html>
