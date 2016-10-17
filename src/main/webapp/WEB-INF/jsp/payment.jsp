<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Enter your payement details</title>
<%@ include file="common.jsp"%>
</head>
<body>
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
				<a class="navbar-brand" href="/" style=""> <img alt=""
					src="/img/rshLogo.png"></a>
			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-right" id="match-border">
					<li><a href="/" class="label-color-font-size">Home</a></li>
					<li class="dropdown"><a class="dropdown-toggle label-color-font-size"
						data-toggle="dropdown" href="#">Company <span
							class="glyphicon glyphicon-menu-down"></span></a>
						<ul class="dropdown-menu">
							<li><a href="/about">About</a></li>
							<li><a href="/contact">Contact</a></li>
							<li><a href="/faqs">FAQ's</a></li>
						</ul></li>
					<li><a href="account" class="label-color-font-size">Account</a></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container-fluid -->
	</nav>
<div class="container">
	<label Class="error">${error}</label>
	<h3>${pd.title}</h3>
	<h4>${pd.pricing}</h4>
	<ul>
		<c:forEach items="${pd.advs}" var="adv">
			<li>${adv}</li>
		</c:forEach>
	</ul>
	<button id="referer" onclick="location.href='${pd.referer}'" class="btn btn-success">Cancel</button>
	<form action="${pd.postUrl}" method="POST">

		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" />
		<c:choose>
			<c:when test="${have_card}">
				<input class="btn btn-success" type="submit" value="Charge My Card" />
			</c:when>
			<c:otherwise>
				<script src="https://checkout.stripe.com/checkout.js"
					class="stripe-button" data-key="pk_test_enNYAiVqyoAC5WD0mvcyBlal"
					data-amount="15000" data-name="Recruitershack"
					data-image="/img/rshLogo.png" data-locale="auto"
					data-label="Pay Now!">
					
				</script>
			</c:otherwise>
		</c:choose>
	</form>
</div>
<footer class="site-footer" role="contentinfo">
		<div class="container">
			<div id="footer-bottom" class="row">
				<div class="col-md-10">
					Copyright Recruiter Shack &copy; 2016. All Rights Reserved / <a
						class="bottom-links-color" href="/privacy">Privacy</a> / <a
						class="bottom-links-color" href="/terms">Terms</a> / <br>Designed
					by 8Second Designs
				</div>
				<div>
					<ul class="btn-social-icons col-md-2">
						<li class="btn-social-icon fa fa-facebook-square"
							style="font-size: 36px; color: green"><a
							href="https://www.facebook.com/login.php" class="icon"> <span></span>
						</a></li>
						<li class="btn-social-icon fa fa-twitter"
							style="font-size: 36px; color: green"><a
							href="https://twitter.com/login" class="icon"> <span></span>
						</a></li>
						<li class="btn-social-icon fa fa-google-plus"
							style="font-size: 36px; color: green"><a
							href="https://plus.google.com/" class="icon"> <span></span>
						</a></li>
					</ul>
				</div>
				<div></div>
			</div>
		</div>
		<!-- .container -->

	</footer>
</body>
</html>