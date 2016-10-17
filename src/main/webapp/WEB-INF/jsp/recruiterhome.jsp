<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Recruiter Shack | Connecting Recruiting Agencies
	Applicants Everyday - Recruiter Shack</title>
<%@ include file="common.jsp"%>
<link rel="stylesheet" href="/css/common.css">
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
				<a class="navbar-brand" href="/" style=""><img alt=""
					src="/img/rshLogo.png"> </a>
			</div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="match-border">
                
			<ul class="nav navbar-nav navbar-right">
                    <li class="hidden">
                        <a href="#page-top"></a>
                    </li>
				<li class="dropdown"><a class="dropdown-toggle label-color-font-size"
					data-toggle="dropdown" href="#">Company <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="/about">About</a></li>
						<li><a href="/contact">Contact</a></li>
						<li><a href="/faqs">FAQ's</a></li>
					</ul></li>
				<sec:authorize access="isAnonymous()">
					<li><a href="/login" class="label-color-font-size">Login</a></li>
					<li><a href="/recruiter/register" class="label-color-font-size">Register</a></li>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
					<li><a href="/recruiter/auth/account" class="label-color-font-size">Account</a></li>
					<form action="/logout" method="post" id="logoutForm">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />
					</form>
				</sec:authorize>
			</ul>
		</div>
		</div>
	</nav>
		<div class="background-image-recruiter  text-color rercuiter_padding" id="rHomeBg-padding">
			<div class="container">
			<h1 id="font-size-h1">
				Find and <span
					style="background: linear-gradient(#0b5f2e, #16b529); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Recruit
					Fast</span>
			</h1>
			<p id="font-size-p">The Quickest Way to Connect with Quality
				Applicants</p>
			<div class="container">
				<div class="row">
					<div>
						<a class="link-line user-home" href="/recruiter/register">Apply
							Now</a> <a class="link-line user-home" href="/recruiter/how-it-works">How
							it Works</a>
					</div>
				</div>
			</div>
			</div>
		</div>
	<div class="row background1-jobseeker">
		<div
			class="col-md-6 count1 floating-box1-recruiter box-c-p text-color"
			align="center">
			<h2>
				<span id='count1'> 77</span>%
			</h2>
			<h4>LEAD-TO-HIRE RATIO</h4>
		</div>
		<div class="col-md-6 floating-box1-recruiter1 box-c-p text-color"
			align="center">
			<h2>
				<span id='count1'>924</span>
			</h2>
			<h4>LEADS GENERATED PER DAY</h4>
		</div>
	</div>
	<div id="background-featured-recruiter">
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-2 floating-box-jobseeker text-color" align="center">
				<img alt="" src="/img/fashion.png" height="60" width="60"></img>
				<h4>HIGH QUALITY LEADS</h4>
				<p>An essent oporteat deterruisset ius, quo an nulla dicit
					adipiscing.</p>
			</div>
			<div class="col-md-2 floating-box-jobseeker text-color" align="center">
				<img alt="" src="/img/business1.png" height="60" width="60"></img>
				<h4>LASER SHARP CRITERIA</h4>
				<p>An essent oporteat deterruisset ius, quo an nulla dicit
					adipiscing.</p>
			</div>
			<div class="col-md-2 floating-box-jobseeker text-color" align="center">
				<img alt="" src="/img/interface.png" height="60" width="60"></img>
				<h4>DIRECT CHAT FEATURE</h4>
				<p>An essent oporteat deterruisset ius, quo an nulla dicit
					adipiscing.</p>
			</div>
			<div class="col-md-2 floating-box-jobseeker text-color" align="center">
				<img alt="" src="/img/security.png" height="60" width="60"></img>
				<h4>COMPLETE CONFIDENTIALITY</h4>
				<p>An essent oporteat deterruisset ius, quo an nulla dicit
					adipiscing.</p>
			</div>
			<div class="col-md-2"></div>
		</div>
	</div>
	<footer id="colophon" class="site-footer" role="contentinfo">
		<div class="container">

			<div class="site-info">
				Copyright Recruiter Shack &copy;  2016. All Rights Reserved / <a
					href="/privacy">Privacy</a> / <a href="/terms">Terms</a>
			</div>
			<!-- .site-info -->

			<div class="site-social"></div>
		</div>
	</footer>
</body>
</html>