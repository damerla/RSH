<%@ taglib prefix="sec"
  uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>User Account</title>
<%@ include file="common.jsp"%>
</head>
<body>
	<nav class="navbar navbar-static">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="/" style=""><img alt=""
					src="../img/rshLogo.png"> </a>
			</div>
			<br>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="home" class="label-color-font-size">Home</a></li>
				<li class="dropdown"><a class="dropdown-toggle label-color-font-size"
					data-toggle="dropdown" href="#">Company <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li style="float: center"><a href="/about">About</a></li>
						<li style="float: center"><a href="/contact">Contact</a></li>
						<li style="float: center"><a href="/faqs">FAQ's</a></li>
					</ul></li>
				<li><a href="home" class="label-color-font-size">Log Out</a></li>
			</ul>
		</div>
	</nav>
	<div class="container">
	<div class="row">
	<div class="col-md-4" align="center">
		<!-- http://recruitershack.com/user-account/-->
		<img src="data:image/jpeg;base64,${jobseeker.getPicString()}"
			alt="Logo" width="200" height="200">
		<!-- http://recruitershack.com/user-account/-->
		<h4 align="center">${pageContext.request.userPrincipal.name}</h4>
		<sec:authorize access="hasRole('ROLE_RECRUITER')">
		<a href="auth/recruiter-profile"> View profile</a>
		</sec:authorize>
		<sec:authorize access="hasRole('ROLE_JOBSEEKER')">
		<a href="jobseeker-profile"> View profile</a>
		</sec:authorize>
		<p></p>
		<ul class="nav nav-pills nav-stacked side-bar">
			<li role="presentation"><a href="auth/account"><span
					class="glyphicon glyphicon-user"></span> &nbsp; Account
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
					class="glyphicon glyphicon-chevron-right left"></span></a></li>
			<li role="presentation"><a href="changePassword"><span
					class="glyphicon glyphicon-asterisk"></span>&nbsp; Change Password
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
					class="glyphicon glyphicon-chevron-right left"></span></a></li>
			<li role="presentation"><a href="notifications"><span
					class="glyphicon glyphicon-envelope"></span>&nbsp; Notifications
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
					class="glyphicon glyphicon-chevron-right left"></span></a></li>
		</ul>
	</div>
	<div class="col-md-5">
			<h3><span class="glyphicon glyphicon-asterisk"></span><b>Change Password</b></h3>
			<h4>Current Password </h4><input class="input-lg form-control" type="text"
				name="currentPassword"><h4>New Password</h4>
				 <input class="input-lg form-control" type="text" name="newPasword">
			<h4>Confirm Password </h4><input
				class="input-lg form-control" type="text" name="confirmPassword"> 
				<p></p>
					<input type="submit" class="btn btn-lg btn-success" value="Update Account">
				
	</div>
	</div></div>
	<br>
	<footer class="site-footer container" role="contentinfo" >
	<div class="container">

		<div id="footer-bottom" class="row">

			<div class="col-md-10">
				Copyright Recruiter Shack &copy;  2016. All Rights Reserved / <a
					class="bottom-links" href="/privacy">Privacy</a> / <a
					class="bottom-links" href="/terms">Terms</a> / <br>Designed by
				8Second Designs
			</div>
			<div>
				<ul class="btn-social-icons col-md-2">
					<li class="btn-social-icon fa fa-facebook-square"
						style="font-size: 28px; color: green"><a
						href="https://www.facebook.com/login.php" class="icon"> <span></span>
					</a></li>
					<li class="btn-social-icon fa fa-twitter"
						style="font-size: 28px; color: green"><a
						href="https://twitter.com/login" class="icon"> <span></span>
					</a></li>
					<li class="btn-social-icon fa fa-google-plus"
						style="font-size: 28px; color: green"><a
						href="https://plus.google.com/" class="icon"> <span></span>
					</a></li>
					<li class="btn-social-icon fa fa-rss"
						style="font-size: 28px; color: green"><a
						href="https://http://recruitershack.com/feed/" class="icon"> <span></span>
					</a></li>
				</ul>
			</div>
		</div>
	</div>
	<!-- .container -->
</footer>
</body>
</html>