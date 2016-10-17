<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Recruiter Shack | The Easiest Way To Connect With
	Recruiters - Recruiter Shack</title>
<%@ include file="common.jsp"%>
</head>
<body id="hiding">
	<nav class="navbar navbar-static">
		<div class="container">
			<!-- Brand and toggle get grouped for better mobile display -->
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#match-border">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
			<div class="navbar-header">
				<a class="navbar-brand" href="/jobseeker/home" style=""><img alt=""
					src="/img/rshLogo.png"> </a>
			</div>
			 <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="match-border">
                
			<ul class="nav navbar-nav navbar-right">
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
					<li><a href="/jobseeker/auth/account" class="label-color-font-size">Account</a></li>
					<form action="/logout" method="post" id="logoutForm">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />
					</form>
				</sec:authorize>
			</ul>
			</div>
		</div>
	</nav>
	<div class="background-image-jobseeker et_pb_main_blurb_image">
		<div>
			<h1>Find Your Dream Career</h1>
			<h3>The Easiest Way To Connect With Recruitment Agencies</h3>



			<a class="link-line user-home" href="/jobseeker/search-agenicies">Search
				Agencies</a> <a class="link-line user-home"
				href="/jobseeker/how-it-works">How it Works</a>
		</div>
	</div>

	<div class="background1-jobseeker">

		<div class="col-md-6  floating-box3-jobseeker box-c-p text-color "
			align="center">
			<h2 id='count1'>10,204</h2>
			<h4>JOBS CREATED BY RECRUITER SHACK</h4>
		</div>
		<div class="col-md-6  floating-box1-jobseeker box-c-p text-color"
			align="center">
			<h2>
				<span id='count1'> 5.5</span>%
			</h2>
			<h4>NAATIONAL UNEMPLOYMENT RATE</h4>
		</div>

	</div>

	<div id="background-featured-jobseeker">
		<div class="box-div-jobseeker text-color">
			<h3>Check Out Our Featured Agencies</h3>
			<a class="link-line" class="user-home" href="/featuredRecruiters">View
				Now</a>
		</div>
		<div class="row box-align-jobsecker">
			<div class="col-md-2"></div>
			<div class="col-md-2 floating-box-jobseeker1 text-color " align="center">
				<img alt="cup" src="/img/cup.png" height="60" width="60">
				<h4>TOP RECRUITER AGENCIES</h4>
				<p>An essent oporteat deterruisset ius, quo an nulla dicit
					adipiscing.</p>
			</div>

			<div class="col-md-2 floating-box-jobseeker1 text-color" align="center">
				<img alt="business" src="/img/business-1.png" height="60" width="60">

				<h4>BSET HIRING RATIONS</h4>
				<p>An essent oporteat deterruisset ius, quo an nulla dicit
					adipiscing.</p>
			</div>
			<div class="col-md-2 floating-box-jobseeker1 text-color" align="center">
				<img alt="interface" src="/img/interface.png" height="60" width="60">

				<h4>DIRECT CHAT FEATURE</h4>
				<p>An essent oporteat deterruisset ius, quo an nulla dicit
					adipiscing.</p>
			</div>
			<div class="col-md-2 floating-box-jobseeker1 text-color" align="center">
				<img alt="Security" src="/img/security.png" height="60" width="60">

				<h4>COMPLATE CONFIDENTIALITY</h4>
				<p>An essent oporteat deterruisset ius, quo an nulla dicit
					adipiscing.</p>
			</div>
			<div class="col-md-2"></div>
		</div>
	</div>
	<footer class="site-footer" role="contentinfo" >
		<div class="container">

			<div id="footer-bottom" class="row">

				<div class="col-md-10">
					Copyright Recruiter Shack &copy; 2016. All Rights Reserved /
					<a class="label-color-font-size" href="/privacy">Privacy</a> / <a
						class="label-color-font-size" href="/terms">Terms</a> / <br>Designed
					by <a href="#" class="label-color-font-size">8Second Designs</a>
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