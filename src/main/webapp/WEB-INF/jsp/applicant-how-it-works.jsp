<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>How It Works? - Recruiter Shack</title>
<%@ include file="common.jsp"%>
</head>
<body id="no-scrollbar">
	<nav class="navbar navbar-static">
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
					src="/img/rshLogo.png"></a>
			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-right" id="match-border">
					<li class="dropdown"><a class="dropdown-toggle label-color-font-size"
						data-toggle="dropdown" href="#">Company <span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="/about">About</a></li>
							<li><a href="/contact">Contact</a></li>
							<li><a href="/faqs">FAQ's</a></li>
						</ul></li>
					<sec:authorize access="isAnonymous()">
						<li><a href="/login" class="label-color-font-size">Login</a></li>
						<li><a href="/jobseeker/register" class="label-color-font-size">Register</a></li>
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
	<div id="custom-background"
		class="et_pb_main_blurb_image image-padding ">
		<h1 class="text-on-image-h1">How it Works</h1>
		<h4 class="text-on-image-h4">The Easiest Way to Get Your Dream
			Job</h4>
	</div>
	<div id="body-text">
		<div class="row">
			<div class="container col-md-8 col-md-offset-2">
				<p>Recruiter Shack is an advanced employment platform, which
					allows users to easily connect with top recruitment agencies with
					just a click of a button! With our system, you will no longer have
					to scour the internet for job ads, hoping and wondering if youâ€™ll
					get the job. Our system will link you up with recruiters based on
					your experience, skill set, and location.</p>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="container-fluid col-md-8 col-md-offset-2">
			<div class="col-md-4">
				<div class="floating-box" align="center">
					<img alt="cCustom" src="/img/custom.png" height="50" width="50">

					<h4 class="color-h4">Sign Up for a Custom User Profile</h4>
				</div>
			</div>
			<div class="col-md-4">
				<div class="floating-box" align="center">
					<img alt="social" src="/img/office.png" height="50" width="50">
					<h4 class="color-h4">Display your Application to Top Agencies</h4>
				</div>
			</div>
			<div class="col-md-4">
				<div class="floating-box" align="center">
					<img alt="tool" src="/img/people.png" height="50" width="60">

					<h4 class="color-h4">Get the Dream Job That You've Always
						Wanted</h4>
				</div>
			</div>
		</div>
	</div>
	<br>
	<br>
	<br>
	<br>
	<footer class="page-wrap" role="contentinfo">
		<div class="container">

			<div id="footer-bottom" class="row">

				<div class="col-md-10">
					Copyright Recruiter Shack Â&copy;  2016. All Rights Reserved / <a
						class="bottom-links-color" href="/privacy">Privacy</a> / <a
						class="bottom-links-color" href="/terms">Terms</a> / <br>Designed
					by 8Second Designs
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