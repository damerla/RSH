<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Landing Pages | Recruiter Shack</title>
<%@ include file="common.jsp"%>
</head>
<body class="custom-background">
	<nav class="navbar navbar-static  primary-branding">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="/" style=""><img alt=""
					src="/img/rshLogo.png"> </a>
			</div>
			<ul class="nav navbar-nav navbar-right" id="match-border">
				<sec:authorize access="isAuthenticated()">
					<li><a href="/" class="label-color-font-size">Home</a></li>
				</sec:authorize>
				<li class="dropdown"><a
					class="dropdown-toggle label-color-font-size"
					data-toggle="dropdown" href="#">Company <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="/about">About</a></li>
						<li><a href="/contact">Contact</a></li>
						<li><a href="/faqs">FAQ's</a></li>
					</ul></li>
				<sec:authorize access="isAuthenticated()">
					<li><a href="/recruiter/auth/account"
						class="label-color-font-size">Account</a></li>
				</sec:authorize>
			</ul>
		</div>
	</nav>
	<section class="border" id="unique">
		<div>
			<h1 class="text-align-center">Thanks for Logging In</h1>
			<p class="text-align-center">
				<a class="go-to-account" href="/recruiter/auth/account">Go To
					Account</a>
			</p>
		</div>


		<c:if test="${!recruiter.isUpgraded()}">
			<h2 class="upgrade-now "
				style="text-align: center; font-size: 18px !important;">
				Upgrade to Enterprise Account to Get Access<br>to Premium
				Features
			</h2>
			<hr class="color">
			<p class="text-align-center" id="account-features">
				&#10003; View Unlimited Leads<br> &#10003; Ultimate Search Bar<br>
				&#10003; View Full Lead Information
			</p>
			<form action="/recruiter/auth/payment">
				<input type="hidden" name="type" value="346hjErnhsdafsdu9Judf" /> <input
					type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<input class="um-button enterprise-upgrade"
					value="Upgrade to Enterprise" id="um_account_submit"
					name="um_account_submit" type="submit">
			</form>
		</c:if>
		<c:if test="${!recruiter.isFeatured()}">
			<form action="/recruiter/auth/payment">
				<input type="hidden" name="type" value="346hjE77d45afsdu9Judf" /> <input
					type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<input class="um-button enterprise-upgrade" value="Get featured"
					id="um_account_submit" name="um_account_submit" type="submit">
			</form>
		</c:if>
	</section>
	<footer id="colophon" class="site-footer" role="contentinfo">
		<div class="container">

			<div class="site-info">
				Copyright Recruiter Shack &copy; 2016. All Rights Reserved / <a
					href="/privacy">Privacy</a> / <a href="/terms">Terms</a>
			</div>
			<!-- .site-info -->

			<div class="site-social"></div>
		</div>
	</footer>
</body>
</html>