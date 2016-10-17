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
<title>Cart - Recruiter Shack</title>
<%@ include file="common.jsp"%>
<%--cart caluclation for total Amonut --%>
<script>
	function cal() {
		var price = document.getElementById('unit_price').value;
		var quantity = document.getElementById('qty').value;
		document.getElementById('subtotal').value = ((price) * quantity)
				.toFixed(2);
		document.getElementById('subtotal1').value = ((price) * quantity)
				.toFixed(2);
		document.getElementById('grand_total').value = ((price) * quantity)
				.toFixed(2);
		document.getElementById('updated').innerHTML = "Cart Updated";
	}
</script>
<script type="text/javascript">
	function removeFromCart(id) {
		$.post("/recruiter/auth/remove", {
			id : id,
		}).done(function(data) {
			location.reload();
		});
	}
</script>
</head>
<body class="custom-background">
	<nav class="nav nav-bar navbar-static"
		style="background-color: #10ac51;">
	<div class="container">
		<div class="navbar-header">
			<a class="navbar-brand" href="/" style=""><img alt=""
				src="/img/whiterecruiterlogo.png"> </a>
		</div>
		<ul class="nav navbar-nav navbar-right" id="match-border">
			<li><a href="/" id="whiteColor-dropDown"
				class="label-color-font-size">Home</a></li>
			<li class="dropdown"><a id="whiteColor-dropDown"
				class="dropdown-toggle label-color-font-size" data-toggle="dropdown"
				href="#">Company <span class="glyphicon glyphicon-chevron-down"></span></a>
				<ul class="dropdown-menu">
					<li style="float: center"><a href="/about">About</a></li>
					<li style="float: center"><a href="/contact">Contact</a></li>
					<li style="float: center"><a href="/faqs">FAQ's</a></li>
				</ul></li>
			<li><a href="/recruiter/auth/account" id="whiteColor-dropDown"
				class="label-color-font-size">Account</a></li>
		</ul>
	</div>
	</nav>
	<div>
		<p id="updated" style="color: white"></p>
	</div>
	<div class="container">
		<div class="col-md-12 table-position" id="unique">
			<a href="http://localhost:8090/recruiter/auth/buy-leads">Add more
				leads</a>
			<table class="table-bordered" width="1000" height="100">
				<tr>
					<th>X</th>
					<th>Product</th>
					<th>Price</th>
				</tr>
				<tbody>
					<c:forEach items="${cart.getJobseekers()}" var="j">
						<tr align="center">
							<td><div onClick="removeFromCart('${j.getId()}')"
									title="Remove this item">
									<span class="glyphicon glyphicon-remove"
										style="color: green; font-size: 9px;"></span>
								</div></td>

							<td><div>${j.getFirstName()}</div>
								<div>${j.getCity().getName()}</div>
								<div>${j.getIndustry().getName()}</div>
								<div>${j.getStatus()}</div>
								<div>${j.getExpectedJoiningDate() }</div></td>
							<td>$50.00</td>
						</tr>
					</c:forEach>

				</tbody>
			</table>
			<!-- <div class="floating-box-jobseeker5  ">
				<input class="col-md-3 input-lg" type="text"
					placeholder="Coupon Code" id="enter-coupon"></input>
				<button class="btn-success btn-lg col-md-2">Apply coupon</button>
				<button class="btn-success btn-lg col-md-2 col-md-offset-5"
					onClick="cal()">Update Cart</button>
			</div> -->
			<div class="text-align-center ">
				<c:forEach items="${jobseekers}" var="j">
					<div>${j.getCity().getName()}</div>
					<div>${j.getIndustry().getName()}</div>
					<div>${j.getStatus()}</div>
					<div>${j.getExpectedJoiningDate() }</div>
				</c:forEach>
			</div>
			<div class="container col-md-5 col-md-offset-5">
				<div class="container col-md-12 col-md-offset-6">
					<h4 id="calculation-part">Cart Total</h4>
				</div>
				<div class="container col-md-6 col-md-offset-6">
					<table class="table-bordered" width="400" height="100">
						<tr>
							<td><strong>&nbsp;Subtotal</strong></td>
							<td>${cart.getJobseekers().size()*50}</td>
						</tr>
						<tr>
							<td><strong>&nbsp;Total</strong></td>
							<td><strong>${cart.getJobseekers().size()*50}</strong></td>
						</tr>
					</table>
					<br>
				</div>

				<form action="/recruiter/auth/payment">
					<input type="hidden" name="type" value="346hjdsaewKcdjsdu9Judf" />
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" /> <input
						class="btn-success btn-lg col-md-6 col-md-offset-11"
					id="checkout-button"type="submit">
				</form>

			</div>
		</div>
	</div>
	<br>
	<div class="navbar navbar-default navbar-fixed-bottom"
		role="navigation">
		<footer id="colophon" class="site-footer" role="contentinfo">
		<div class="container" id="bottom-navi">
			<div class="site-info">
				Copyright Recruiter Shack &copy; 2016. All Rights Reserved / <a
					href="/privacy">Privacy</a> / <a href="/terms">Terms</a>
			</div>
			<!-- .site-info -->
			<div class="site-social"></div>
		</div>
		</footer>
	</div>
</body>
</html>