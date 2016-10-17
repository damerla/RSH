<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>User Account - Recruiter Shack</title>
<%@ include file="common.jsp"%>
<script>
	function formSubmit() {
		document.getElementById("logoutForm").submit();
	}
</script>
</head>
<body>
	<form action="/logout" method="post" id="logoutForm">
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" />
	</form>
	<nav class="navbar navbar-static">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="/jobseeker/home" style=""><img alt=""
					src="/img/rshLogo.png"> </a>
			</div>
			<ul class="nav navbar-nav navbar-right" id="match-border">
				<li><a href="/" class="label-color-font-size">Home</a></li>
				<li class="dropdown"><a
					class="dropdown-toggle label-color-font-size"
					data-toggle="dropdown" href="#">Company <span class="caret"></span>
				</a>
					<ul class="dropdown-menu">
						<li><a href="/about">About</a></li>
						<li><a href="/contact">Contact</a></li>
						<li><a href="/faqs">FAQ's</a></li>
					</ul></li>

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
	<div class="container">
	<div class="row">
	<h4 align="right" style="color: #ff0000">Welcome:
			${pageContext.request.userPrincipal.name}</h4>
	<div class="col-md-4" align="center">
		<img src="data:image/jpeg;base64,${jobseeker.getPicString()}"
			alt="Logo" width="200" height="200">
		<!-- http://recruitershack.com/user-account/-->
		<h4 align="center" class="bottom-links-color">${pageContext.request.userPrincipal.name}</h4>
		<p align="center">
			<a href="/jobseeker/jobseeker-profile" class="bottom-links-color">
				View profile</a>
		</p>
		<br>
		<ul class="nav nav-pills nav-stacked side-bar">
			<li role="presentation"><a href="account"><span
					class="glyphicon glyphicon-user"></span> &nbsp; Account
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
					class="glyphicon glyphicon-chevron-right left"></span></a></li>
			<li role="presentation"><a href="../changePassword"><span
					class="glyphicon glyphicon-asterisk"></span>&nbsp; Change Password
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
					class="glyphicon glyphicon-chevron-right left"></span></a></li>
			<li role="presentation"><a href="../notifications"><span
					class="glyphicon glyphicon-envelope"></span>&nbsp; Notifications
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
					class="glyphicon glyphicon-chevron-right left"></span></a></li>
		</ul>
	</div>
	<div class="col-md-7">
		<h3>
			<span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;<b>Account</b>
		</h3>
		<form:form method="POST" commandName="jobseeker"
			action="/jobseeker/auth/account">
			<form:errors path="*" cssClass="errorblock" element="div" />
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
			<p class="label-color-font-size">Username:</p>
			<form:input path="userName" class="input-lg form-control"
				id="userName" disabled="true" />
			<br>
			<p class="label-color-font-size">First Name:</p>
			<form:input path="firstName" class="input-lg form-control"
				id="firstName" />
			<form:errors path="firstName" cssClass="error" />
			<br>
			<p class="label-color-font-size">Last Name:</p>
			<form:input path="lastName" class="input-lg form-control"
				id="lastName" />
			<br>
			<p class="label-color-font-size">Email Address:</p>
			<form:errors path="email" cssClass="errorblock" />
			<form:input path="email" class="input-lg form-control" id="address" />
			<br>
			<p>
			<input type="submit" class="btn btn-success btn-lg"
				value="Update Account">
		</p>
		</form:form>
		
	</div>
</div></div>
	<div class="container" style="margin-top: 20px">
		<div class="col-md-9">
			Copyright Recruiter Shack &copy;  2016. All Rights Reserved / <a
				class="bottom-links-color" href="/privacy">Privacy</a> / <a
				class="bottom-links-color" href="/terms">Terms</a> / <br>Designed
			by 8Second Designs
		</div>
		<div class="col-md-3">
			<ul class="btn-social-icons">
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
	<!-- .container -->
</body>
</html>