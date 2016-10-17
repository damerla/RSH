<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Login Form</title>
<%@ include file="common.jsp"%>
</head>
<body id="no-scrollbar">
	<nav class="navbar">
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
						<li><a href="/login" class="label-color-font-size active">Login</a></li>
						<li><a href="/recruiter/register" class="label-color-font-size">Register</a></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container-fluid -->
	</nav>
	<div id="contact_page">
		<div class="container">
		<div class="row">
			<div class="row">
				<div class="col-md-3"></div>
				<div class="col-md-6">
				<div class="row">
				<div class="col-md-4">
					<button   class="btn btn-facebook  fa fa-facebook-square btn-lg "
						style="font-size: 15px;" onclick="location.href='https://www.facebook.com/login.php?skip_api_login=1&api_key=777547872378369&signed_next=1&next=https%3A%2F%2Fwww.facebook.com%2Fv2.5%2Fdialog%2Foauth%3Fredirect_uri%3Dhttp%253A%252F%252Frecruitershack.com%252Fr%252Flogin%252F%253Fprovider%253Dfacebook%26state%3D29c1d1f5e9f5e242f7d3d3572e67d731%26scope%3Dpublic_profile%252Cemail%26response_type%3Dcode%26client_id%3D777547872378369%26ret%3Dlogin%26sdk%3Dphp-sdk-5.1.2%26logger_id%3Dba3aa106-dc0a-4097-933c-daf7d5918dc4&cancel_url=http%3A%2F%2Frecruitershack.com%2Fr%2Flogin%2F%3Fprovider%3Dfacebook%26error%3Daccess_denied%26error_code%3D200%26error_description%3DPermissions%2Berror%26error_reason%3Duser_denied%26state%3D29c1d1f5e9f5e242f7d3d3572e67d731%23_%3D_&display=page&locale=en_GB&logger_id=ba3aa106-dc0a-4097-933c-daf7d5918dc4'">
						<i class="icon-facebook"></i> | Sign in with Facebook
					</button>
				</div>
				<div class="col-md-6">
					<button class="btn btn-linkedin fa fa-linkedin btn-lg"
						style="font-size: 15px;" onclick="location.href='https://www.linkedin.com/uas/oauth/authorize?oauth_token=75--bad615f5-1945-4f95-865f-2748d61ca8a7&state='">
						<i class="icon-linkedin"></i> | Sign in with LinkedIn
					</button>
					<br>
				</div>
				</div>
			<div class="row">
				<p></p>
				<div class="container">
					<c:if test="${not empty error}">
						<div class="error">${error}</div>
					</c:if>
					<c:if test="${not empty msg}">
						<div class="msg">${msg}</div>
					</c:if>
		
					<form name='loginForm'
						action="<c:url value='/j_spring_security_check' />" method='POST'>
		
						<div class="row">
							<div class="form-group col-md-4">
								<label for="email">Username</label>
								<input  type="text"
									class="form-control input-lg" id="email"
									placeholder="Enter Username" name='username'> 
							</div>
						</div>
						<div class="row">
							<div class="form-group col-md-4">
								<label for="pwd">Password</label> <input type="password" class="form-control input-lg" id="pwd"
									placeholder="Enter password" name='password' /> 
						</div>
						</div>
						<div class="row col-md-offset-1">
				          <div class="col-md-2 " >
				            <button type="submit" class="btn btn-success btn-lg btn-block">Log In</button>
				          </div>
				        </div>
				        <br>
						<a href="/recruiter/passwordReset">Forgot Your Password?</a>
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />
		
					</form>
				</div></div>
			</div>
			<div class="col-md-3"></div>
			</div>
		</div>
	</div>
	</div>
	<br><br>
	<footer class="site-footer" role="contentinfo" >
		<div class="container">

			<div id="footer-bottom" class="row">

				<div class="col-md-10">
					Copyright Recruiter Shack &copy;  2016. All Rights Reserved / <a
						class="bottom-links-color" href="/privacy">Privacy</a> / <a
						class="bottom-links-color" href="/terms">Terms</a> / <br>Designed by
					8Second Designs
				</div>
				<div>
					<ul class="btn-social-icons col-md-2">
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
	</footer>
</body>
</html>