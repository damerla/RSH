<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>${recruiter.getFirstName()}&nbsp;${recruiter.getLastName()}|
	Recruiter Shack</title>
<%@ include file="common.jsp"%>
<script type="text/javascript">
	function follow(userName) {
		$.post("/jobseeker/auth/follow", {
			userName : userName,
		}).done(fs);
	}

	function unfollow(userName) {
		$.post("/jobseeker/auth/unfollow", {
			userName : userName,
		}).done(ufs);
	}
	
	function ufs(data) {
		if (data === "Success") {
			$("#unfollow").hide();
			$("#follow").show();
		}
	}
	
	function fs(data) {
		if (data === "Success") {
			$("#follow").hide();
			$("#unfollow").show();
		}
	}
</script>
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
				<a class="navbar-brand" href="/" style=""> <img alt=""
					src="/img/rshLogo.png"></a>
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
					<li><a href="/recruiter/auth/account"
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
		<div class="col-md-6 col-md-offset-4">
			<figure>
				<img src="data:image/png;base64,${recruiter.getLogoString()}"
					height="190" width="220" alt="">
				<h3>${recruiter.getCompanyName()}</h3>
				<h4>${recruiter.getCity().getName().trim()}<c:if
						test="${recruiter.getCity().getName()!=null && !recruiter.getCity().getName().isEmpty()}">,</c:if>
					${recruiter.getState().getName()}
				</h4>
				<h4>${recruiter.getIndustry().getName()}</h4>
			</figure>
			<sec:authorize var="isJS" access="hasRole('ROLE_JOBSEEKER')">
			</sec:authorize>
			<c:choose>
				<c:when test="${isJS}">
					<input class="btn-primary btn-lg" type="button" name="#"
						id="follow" value="Follow"
						onClick="follow('${recruiter.getUserName()}')" />
					<input class="btn-primary btn-lg" type="button" name="#"
						id="unfollow" value="Unfollow"
						onClick="unfollow('${recruiter.getUserName()}')" hidden="true" />
				</c:when>
				<c:otherwise>
					<div>Login as applicant to connect with this recruiter</div>
				</c:otherwise>
			</c:choose>

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
			</div>
		</div>
		<!-- .container -->
	</footer>
</body>
</html>