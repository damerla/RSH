<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>User Account - Recruiter Shack</title>
<%@ include file="common.jsp"%>
<script type="text/javascript">
	function updateSelectOptions(lookupUrl, parentSelectElementId,
			childSelectElementId) {
		concole.log("Getting data with: " + parentElementId);
		if (childSelectElementId === "state") {
			$('#' + 'city').html("<option value='-1'>Other</option>");
		}

		$.getJSON(lookupUrl, {
			searchId : $('#' + parentSelectElementId).val()
		}, function(data) {
			var html = '<option value="-1">Other</option>';
			var len = data.length;
			for (var i = 0; i < len; i++) {
				html += '<option value="' + data[i].id + '">' + data[i].name
						+ '</option>';
			}

			$('#' + childSelectElementId).html(html);
		});
	}
</script>
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
					<li class="dropdown"><a class="dropdown-toggle label-color-font-size"
						data-toggle="dropdown" href="#">Company <span class="caret"></span></a>
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
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container-fluid -->
	</nav>
	<div class="col-md-12" >
		
<div class="container">
<div class="row">
<h4 align="right" style="color: #ff0000">Welcome:
			${pageContext.request.userPrincipal.name}</h4>
	<div class="col-md-4" align="center">
		<!-- http://recruitershack.com/user-account/-->
		<img src="data:image/jpeg;base64,${recruiter.getLogoString()}"
			alt="Logo" width="200" height="200">
		<h4 align="center" class="bottom-links-color">${recruiter.getFirstName()}&nbsp;
			${recruiter.getLastName()}</h4>
		<a href="/recruiter/auth/recruiter-profile"> View profile</a>
		<p></p>
		<ul class="nav nav-pills nav-stacked row side-bar">
			<li role="presentation" class="col-md-12"><a
				href="account"><span
					class="glyphicon glyphicon-user"></span> &nbsp; Account
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
					class="glyphicon glyphicon-chevron-right left"></span></a></li>
			<li role="presentation" class="col-md-12"><a
				href="../changePassword"><span
					class="glyphicon glyphicon-asterisk"></span>&nbsp; Change Password
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
					class="glyphicon glyphicon-chevron-right left"></span></a></li>
			<li role="presentation" class="col-md-12"><a
				href="../notifications"><span
					class="glyphicon glyphicon-envelope"></span>&nbsp; Notifications
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
					class="glyphicon glyphicon-chevron-right left"></span></a></li>
		</ul>
	</div>
	<div class="col-md-8">
		<h3>
			<span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;<b>Account</b>
		</h3>
		<form:form method="POST" commandName="recruiter"
			action="/recruiter/auth/account">
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
			<input type="submit" class="btn btn-lg btn-success"
				value="Update Account" >
			</p>
		</form:form>
		
	</div>
</div>
</div>
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
	</div>
	<!-- .container -->
</body>
</html>