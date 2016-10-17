<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>${pageContext.request.userPrincipal.name} | RecruiterShack</title>
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

		<img src="data:image/jpeg;base64,${jobseeker.getPicString()}"
			height="200" width="200" alt="">
		<div>
			<div class="container">
				<div class="col-md-3 col-md-offset-3">
					<h3>${pageContext.request.userPrincipal.name}</h3>
				</div>
				<div class="col-md-offset-12">
					<a href="#" class="col"> <span class="glyphicon glyphicon-ok"
						style="font-size: 25px;"></span></a>
				</div>

			</div>

			<div class="col-md-3 col-md-offset-3">
				<textarea id="jobseeker-textarea"
					placeholder="Tell us a bit about yourself..."></textarea>
			</div>
		</div>
	</div>
	<br>
	<div class="col-md-10  col-md-offset-1">
		<ul class="nav nav-tabs ">
			<li><a href="#">CONNECTIONS </a></li>
			<li><a href="#">CONNECTED</a></li>
		</ul>
	</div>
	<br>
	<br>

	<div class="col-md-10 col-md-offset-1">
		<br> <br>
		<form:form method="POST" commandName="jobseeker"
			action="/jobseeker/register">
			<form:errors path="*" cssClass="errorblock" element="div" />
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
			<div class="container">
				<div class="col-md-3 col-md-offset-2">
					<p class="label-color-font-size">
						<span class="glyphicon glyphicon-user" style="font-size: 18px"></span>&nbsp;
						Username
					</p>
					<form:input path="userName" class="input-lg form-control"
						id="userName" />
				</div>
				<div class="col-md-3">
					<p class="label-color-font-size">First Name</p>
					<form:input class="input-lg form-control" id="firstName"
						path="firstName" type="text" />
				</div>
			</div>
			<br>
			<div class="container">
				<div class="col-md-3 col-md-offset-2">
					<p class="label-color-font-size">Last Name</p>
					<form:input class="input-lg form-control" id="lastName"
						path="lastName" type="text" />
				</div>
				<div class="col-md-3">
					<p class="label-color-font-size">Account Type</p>
					<form:select path="industry" class="input-lg form-control">
						<c:forEach items="${industries}" var="ind">
							<form:option value="${ind.getId()}">${ind.getName()}</form:option>
						</c:forEach>
					</form:select>
				</div>


			</div>
			<br>
			<div class="container">
				<div class="col-md-3 col-md-offset-2">
					<p class="label-color-font-size">
						<span class="glyphicon glyphicon-envelope" style="font-size: 18px"></span>&nbsp;&nbsp;E-mail
						Address
					</p>
					<form:input path="email" class="input-lg form-control" id="address" />
				</div>
				<div class="col-md-3">
					<p class="label-color-font-size">
						<span class="glyphicon glyphicon-file" style="font-size: 20px"></span>Resume
						&nbsp;&nbsp;<span class="glyphicon glyphicon-question-sign"
							style="font-size: 15px; color: green"></span>
					</p>
					<form:input id="resume" path="resumeFileName" type="file"
						accept="file/*" />
				</div>
			</div>
			<br>
			<div class="container">
				<div class="col-md-3 col-md-offset-2">
					<p class="label-color-font-size">
						<span class="glyphicon glyphicon-earphone"></span>&nbsp; Phone
						Number
					</p>
					<form:input id="phone" path="phone" class="input-lg form-control"
						type="text" />
				</div>
				<div class="col-md-3">
					<p class="label-color-font-size">
						City of Residence &nbsp;&nbsp;<span
							class="glyphicon glyphicon-question-sign"
							style="font-size: 15px; color: green"></span>
					</p>
					<form:input path="city" class="input-lg form-control " id="city" name="" type="text" />
				</div>
			</div>
			<br>

			<div class="container">
				<div class="col-md-3 col-md-offset-2">
					<p class="label-color-font-size">Seniority</p>
					<form:select path="seniority" class="input-lg form-control">
						<c:forEach items="${seniorities}" var="seni">
							<form:option value="${seni.getId()}">${seni.getName()}</form:option>
						</c:forEach>
					</form:select>
				</div>
				<div class="col-md-3">
					<p class="label-color-font-size">Education level</p>
					<form:select path="education" class="input-lg form-control">
						<c:forEach items="${educations}" var="education">
							<form:option value="${education.getId()}">${education.getName()}</form:option>
						</c:forEach>
					</form:select>
				</div>
			</div>
			<br>
			<div class="container">
				<div class="col-md-3 col-md-offset-2">
					<p class="label-color-font-size">Employment Status</p>
					<form:input path="status" class="input-lg form-control" id="status" />
				</div>
				<div class="col-md-3">
					<p class="label-color-font-size">Current Position Held</p>
					<form:input  path="currentPositionHeld" class="input-lg form-control" id="currentPositionHeld" name="" type="text"/>
				</div>
			</div>
			<br>
			<div class="container">
				<div class="col-md-3 col-md-offset-2">
					<p class="label-color-font-size">Start Working</p>
					<form:input path="startWorkingDate" class="input-lg form-control"
						id="startWorkingDate" />
				</div>
				<div class="col-md-3">
					<p class="label-color-font-size">Experience</p>
					<form:input path="experienceInTheIndustry"
						class="input-lg form-control" id="experienceInTheIndustry" />
				</div>
			</div>
			<br>
			<div class="container">
				<div class="col-md-3 col-md-offset-2">
					<p class="label-color-font-size">Line1</p>
					<form:input path="line1" class="input-lg form-control"
						id="line1_address" />
				</div>
				<div class=" col-md-3">
					<p class="label-color-font-size">Line2</p>
					<form:input path="line2" class="input-lg form-control"
						id="line2_address" />
				</div>
			</div>
			<br>
			<div class="container">
				<div class="col-md-3 col-md-offset-2">
					<p class="label-color-font-size">Country</p>
					<form:select path="country" id="country"
						class="input-lg form-control"
						onchange="updateSelectOptions('/lookupStatesWithinCountry', 'country', 'state')">
						<form:option value="-1">Other</form:option>
						<c:forEach items="${countries}" var="ind">
							<form:option value="${ind.getId()}">${ind.getName()}</form:option>
						</c:forEach>
					</form:select>
				</div>
				<div class=" col-md-3">
					<p class="label-color-font-size">State</p>
					<form:select path="state" id="state" class="input-lg form-control"
						onchange="updateSelectOptions('/lookupCitiesWithinState', 'state', 'city')">
					</form:select>
				</div>
			</div>
			<br>
			<div class="container">
				<div class="col-md-3 col-md-offset-2">
					<p class="label-color-font-size">City</p>
					<form:select path="city" id="city" class="input-lg form-control" />
				</div>
				<div class="col-md-3">
					<p class="label-color-font-size">Zip</p>
					<form:input path="pinCode" class="input-lg form-control"
						id="pinCode" />
				</div>
			</div>
		</form:form>
	</div>
	<br>
	<div class="container">
		<div class="col-md-4 col-md-offset-2">
			<p>
				<span class="glyphicon glyphicon-align-justify"></span> Biography
			</p>
			<textarea id="biography-textarea"
				placeholder="Enter bit about yourself..."></textarea>
		</div>
	</div>
	<br>
	<br>

	<div class="container">
		<div class="col-md-3 col-md-offset-2">
			<button type="submit" class="btn btn-info btn-lg col-md-12">Update
				Profile</button>
		</div>
		<div class="col-md-3">
			<button type="button" class="btn btn-default btn-lg col-md-12"
				onclick="location.href='/jobseeker/jobseeker-profile'">Cancel</button>
		</div>
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