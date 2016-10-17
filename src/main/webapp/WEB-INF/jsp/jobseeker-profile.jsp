<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>${pageContext.request.userPrincipal.name}| RecruiterShack</title>
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
				<a class="navbar-brand" href="/jobseeker/home" style=""> <img
					alt="" src="/img/rshLogo.png"></a>
			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-right" id="match-border">
					<li><a href="/" class="label-color-font-size">Home</a></li>
					<li class="dropdown"><a
						class="dropdown-toggle label-color-font-size"
						data-toggle="dropdown" href="#">Company <span
							class="glyphicon glyphicon-menu-down"></span></a>
						<ul class="dropdown-menu">
							<li><a href="/about">About</a></li>
							<li><a href="/contact">Contact</a></li>
							<li><a href="/faqs">FAQ's</a></li>
						</ul></li>
					<li><a href="/jobseeker/auth/account"
						class="label-color-font-size">Account</a></li>
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
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container-fluid -->
	</nav>
	<div class="container">
		<div class="col-md-11" align="center">
			<figure>
				<img src="data:image/jpeg;base64,${jobseeker.getPicString()}"
					height="190" width="220" alt="">
				<h3>${pageContext.request.userPrincipal.name}</h3>
			</figure>
		</div>
		<ul class="nav navbar-nav navbar-right ">
			<li class="dropdown"><a class="dropdown-toggle"
				data-toggle="dropdown"
				style="font-size: 36px; color: green; text-decoration: none"
				href="#"><span class="glyphicon glyphicon-cog"></span></a>
				<ul class="dropdown-menu">
					<li class="text-align-center"><a
						href="/jobseeker/auth/jobseeker-profile-edit">Edit Profile</a></li>
					<li class="text-align-center"><a
						href="/jobseeker/auth/account">My Account</a></li>
					<li class="text-align-center"><a
						href="javascript:formSubmit()">Log out</a></li>
					<li class="text-align-center" role="separator" class="divider"><a
						href="#"></a></li>
					<li class="text-align-center"><a
						href="/jobseeker/jobseeker-profile">Cancel</a></li>
				</ul></li>
		</ul>
	</div>
	<div class="container">
		<ul class="nav nav-tabs">
			<li><a href="#">CONNECTIONS </a></li>
			<li><a href="#">CONNECTED</a></li>
		</ul>
	</div>
	<br>
	<div class="container col-md-offset-4">
		<form:form method="POST" commandName="jobseeker"
			action="/jobseeker/register">
			<form:errors path="*" cssClass="errorblock" element="div" />
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />

			<p class="label-color-font-size">First Name</p>
			<form:input path="firstName" class="data-border-align" id="firstName"
				readonly="true" />
			<br>
			<p class="label-color-font-size">Last Name</p>
			<form:input path="lastName" class="data-border-align" id="lastName"
				readonly="true" />
			<br>
			<p class="label-color-font-size">
				<span class="glyphicon glyphicon-earphone"></span>&nbsp;&nbsp;Phone
				Number
			</p>
			<form:input path="phone" class="data-border-align" id="phone"
				readonly="true" />
			<br>
			<p class="label-color-font-size">Email Address</p>
			<form:input path="email" class="data-border-align" id="address"
				readonly="true" />
			<br>

			<p class="label-color-font-size">Employment Status</p>
			<form:input path="status" class="data-border-align" id="status"
				readonly="true" />
			<br>

			<p class="label-color-font-size">Start Working</p>
			<form:input path="startWorkingDate" class="data-border-align"
				id="startWorkingDate" readonly="true" />
			<br>

			<p class="label-color-font-size">Experience</p>
			<form:input path="experienceInTheIndustry" class="data-border-align"
				id="experienceInTheIndustry" readonly="true" />
			<br>

			<p class="label-color-font-size">Resume</p>

			<a href="file:/// ${jobseeker.getResume()}"
				onclick="_gaq.push([ 'Download', 'Download 2.3.2']); "> <form:input
					class="data-border-align" type="url" path="resume" id="resumePath"
					value="Resume Download" readonly="true" />
			</a>
		</form:form>
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