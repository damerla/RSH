<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Login Form</title>
<%@ include file="common.jsp"%>
</head>
<body>
	<nav class="navbar navbar-static">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="/jobseeker/home" style=""><img alt=""
					src="../img/rshLogo.png"> </a>
			</div>
			<ul class="nav navbar-nav navbar-right" id="match-border">
				<li class="dropdown"><a class="dropdown-toggle label-color-font-size"
					data-toggle="dropdown" href="#">Company <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li style="float: center"><a href="/about">About</a></li>
						<li style="float: center"><a href="/contact">Contact</a></li>
						<li style="float: center"><a href="/faqs">FAQ's</a></li>
					</ul></li>
				<sec:authorize access="isAnonymous()">
					<li><a href="/recruiter/register" class="label-color-font-size">Register</a></li>
				</sec:authorize>
			</ul>
		</div>
	</nav>
	<section class="container">
		<div class="login-link" style="border: none;">
			<form action="https://www.facebook.com/login.php"
				style="display: inline-block; float: left;">
				<input class="form button" style="float: left" type="submit"
					value="Facebook">
			</form>
			<form action="https://www.linkedin.com/"
				style="display: inline-block; float: right;">
				<input class="form button" style="float: right;" type="submit"
					value="LinkedIn">
			</form>
		</div>
		<br> <br>
		<div class="login">
			<form method="post" action="/jobseeker/auth">
				<label>User Name or Email:</label> <input type="text"
					name="userName"> <br> <label>Password:</label> <input
					type="password" name="password"><br>
				<p class="remember_me">
					<label> <input type="checkbox" name="remember_me"
						id="remember_me"> Keep me signed in
					</label>
				</p>
				<p class="submit">
					<input type="submit" name="commit" value="Login">
				</p>
				<input type="button" value="Register" onclick="signup" />
			</form>
		</div>
		<div class="login-help">
			<p>
				<a href="passwordReset">Forgot your password?</a>
			</p>
		</div>
	</section>
	<div>
		Copyright Recruiter Shack &copy;  2016. All Rights Reserved / <a
			href="/privacy">Privacy</a> / <a href="/terms">Terms</a>
	</div>
</body>
</html>