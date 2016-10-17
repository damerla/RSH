<%@page contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Featured Recruiters</title>
<%@ include file="common.jsp"%>
<!--[if lt IE 9]><script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
<style>
</style>
</head>
<body>
	<nav class="navbar navbar-static">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="/jobseeker/home" style=""><img alt=""
					src="/img/rshLogo.png"> </a>
			</div>
			<ul class="nav navbar-nav navbar-right" id="match-border">
				<li class="dropdown"><a
					class="dropdown-toggle label-color-font-size"
					data-toggle="dropdown" href="#">Company <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li style="float: center"><a href="/about">About</a></li>
						<li style="float: center"><a href="/contact">Contact</a></li>
						<li style="float: center"><a href="/faqs">FAQ's</a></li>
					</ul></li>
				<sec:authorize access="isAnonymous()">
					<li><a href="/login" class="label-color-font-size">Login</a></li>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
					<li><a href="javascript:formSubmit()"
						class="label-color-font-size">Logout</a></li>
					<form action="/logout" method="post" id="logoutForm">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />
					</form>
				</sec:authorize>
			</ul>
		</div>
	</nav>
	<div class="row">
		<div class="container col-md-10 col-md-offset-1">
			<h2 id="body-heading">Featured Recruiters</h2>
		</div>
	</div>
	<div class="container">
		<div class="row text-center">
			<div>
				<c:forEach items="${recruiters}" var="recruiter">
					<ul class="featured">
						<li >
							<%-- <h3>${recruiter.getFirstName()}</h3> --%> <a
							href="/recruiter/recruiter-public-profile?id=${recruiter.getUserName()}"><h3>${recruiter.getCompanyName()}</h3></a>
							<img src="data:image/jpeg;base64,${recruiter.getLogoString()}"
							width="200px"></img>
							<h4>${recruiter.getIndustry().getName()}</h4>
						</li>
					</ul>
				</c:forEach>
			</div>
		</div>
	</div>
	<footer class="site-footer" role="contentinfo">
		<div class="container">

			<div id="footer-bottom" class="row">

				<div class="col-md-10">
					Copyright Recruiter Shack Â&copy; 2016. All Rights Reserved / <a
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
							href="https://http://recruitershack.com/feed/" class="icon">
								<span></span>
						</a></li>
					</ul>
				</div>
			</div>
		</div>
		<!-- .container -->
	</footer>
</body>
</html>