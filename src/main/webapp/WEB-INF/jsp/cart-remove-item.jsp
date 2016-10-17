<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cart | Recruiter Shack</title>
<%@ include file="common.jsp"%>
</head>
<body class="custom-background">
	<nav class="navbar navbar-static">
	<div class="container">
		<div class="navbar-header">
			<a class="navbar-brand" href="/" style=""><img alt=""
				src="/img/rshLogo.png"> </a>
		</div>
		<ul class="nav navbar-nav navbar-right" id="match-border">
			<li><a href="/" class="label-color-font-size">Home</a></li>
			<li class="dropdown"><a class="dropdown-toggle label-color-font-size"
				data-toggle="dropdown" href="#">Company <span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="/about">About</a></li>
					<li><a href="/contact">Contact</a></li>
					<li><a href="/faqs">FAQ's</a></li>
				</ul></li>
			<li><a href="/recruiter/auth/account" class="label-color-font-size">Account</a></li>
		</ul>
	</div>
	</nav>
	<div style="padding-left: 95px">
	<div class="border-cart" >
		<p>
			PURCHASE A PREMIUM LEAD removed. <a href="/recruiter/auth/viewCart">Undo?</a>
		</p>
	</div></div>
	<section class="border" id="unique">
	<div>
		<p>Your cart is currently empty.</p>
		<br> <a href="#" class="box-update1 user-home link-line">Return
			To Shop</a>
	</div>
	</section>
	<footer id="colophon" class="site-footer footer-size-unique1"
		role="contentinfo">
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