<%@page contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>PURCHASE A PREMIUM LEAD | Recruiter Shack</title>
<%@ include file="common.jsp"%>
<script type="text/javascript">
	function addToCart(id) {
		$.post("/recruiter/auth/add", {
			id : id,
		}).done(function(data) {
			if (data === "Success") {
				$("#add-" + id).hide();
				$("#remove-" + id).show();
			}
		});
	}

	function removeFromCart(id) {
		$.post("/recruiter/auth/remove", {
			id : id,
		}).done(function(data) {
			if (data === "Success") {
				$("#add-" + id).show();
				$("#remove-" + id).hide();
			}
		});
	}
</script>
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
			<li class="dropdown"><a
				class="dropdown-toggle label-color-font-size" data-toggle="dropdown"
				href="#">Company <span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="/about">About</a></li>
					<li><a href="/contact">Contact</a></li>
					<li><a href="/faqs">FAQ's</a></li>
				</ul></li>
			<sec:authorize access="isAnonymous()">
				<li><a href="/recruiter/auth/account"
					class="label-color-font-size">Account</a></li>
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
	<section class="border-buy-lead" id="unique">
	<div class="text-align-center ">
		<a href="http://localhost:8090/recruiter/auth/viewcart">View Cart</a>
		<p>PURCHASE PREMIUM LEADs. $50/LEAD</p>
		<br>
		<ul>
			<c:forEach items="${jobseekers}" var="j">
				<li>
					<div class="lead">
						<div>${j.getIndustry().getName()}</div>
						<div>${j.getCity().getName()}</div>
						<div>${j.getStatus()}</div>
						<div>${j.getExpectedJoiningDate() }</div>
						<div>${j.getExperienceInTheIndustry() }</div>
						<c:choose>
							<c:when test="${incart.contains(j.getId())}">
								<button hidden="true" id="add-${j.getId()}" class="box-lead-chart"
									onClick="addToCart('${j.getId()}')">Add to Cart</button>
								<button id="remove-${j.getId()}" class="box-lead-chart"
									onClick="removeFromCart('${j.getId()}')" >Remove
									from Cart</button>
							</c:when>
							<c:otherwise>
								<button id="add-${j.getId()}" class="box-lead-chart"
									onClick="addToCart('${j.getId()}')">Add to Cart</button>
								<button id="remove-${j.getId()}" class="box-lead-chart"
									onClick="removeFromCart('${j.getId()}')" hidden="true">Remove
									from Cart</button>
							</c:otherwise>

						</c:choose>
					</div>
				</li>
			</c:forEach>
		</ul>
	</div>
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