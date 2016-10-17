<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Password Reset</title>
<%@ include file="common.jsp"%>
</head>
<body class="custom-background">
<nav class="nav nav-bar navbar-static" style="background-color: #10ac51;">
<div class="container">
  <div class="navbar-header">
    <a class="navbar-brand" href="/" style=""><img alt=""
      src="/img/whiterecruiterlogo.png"> </a>
  </div>
  <ul class="nav navbar-nav navbar-right" id="match-border">
    <li class="dropdown"><a id="whiteColor-dropDown" class="dropdown-toggle label-color-font-size"
      data-toggle="dropdown" href="#">Company <span class="caret"></span></a>
      <ul class="dropdown-menu">
        <li style="float: center"><a href="/about">About</a></li>
        <li style="float: center"><a href="/contact">Contact</a></li>
        <li style="float: center"><a href="/faqs">FAQ's</a></li>
      </ul></li>
      <sec:authorize access="isAnonymous()">
		<li><a href="/login" class="dropbtn">Login</a></li>
	</sec:authorize>
	<sec:authorize access="isAuthenticated()">
		<li><a href="javascript:formSubmit()" class="label-color-font-size">Logout</a></li>
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
	<div class="col-md-8">
		<div class="password-reset-div1" id="unique">
			<h4>To reset your password, please enter your email address or username below</h4>
			<div class="form-group">
			<input  type="text"
				class="form-control input-lg  col-md-4" id="email"
				placeholder="Enter your username or email" name='username'/> 
			</div>
	     	<div>
	        	<button type="submit" class="btn btn-success btn-lg btn-block">Reset My Password</button>
	    	</div>
		</div>
	</div>
	<div class="col-md-4" id="reset-sidebar">
		<div class="row">
			<div class="password-reset-div2" id="unique">
				<form class="form-search" method="get" id="s" action="/">
				    <div class="input-append">
				        <input type="text" id="search-bar" class="input-lg search-query" name="s" placeholder="Search" value="">
				        <button type="submit" class="add-on"><i class="glyphicon glyphicon-search" style="font-size: 20px;"></i></button>
				    </div>
				</form>
			</div>
		</div>
		<div class="row">
			<div class="password-reset-div3" id="unique">
				<div>
					<h3 ><br>Archives</h3>
					<hr color="green">
					<ul class="points">
						<li><a href="http://recruitershack.com/2016/02/">February 2016</a></li>
						<!-- Need to implement "Archives" properly. -->
					</ul>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="password-reset-div4" id="unique">
				<div></br>
				<h3>Meta</h3>
				<hr></hr>
						<ul class="points"><li><a href="#" data-toggle="modal" data-target="#registerModal">Register</a></li>
						<li><a href="#" data-toggle="modal" data-target="#loginModal" >Login</a><li></ul>
						<div id="registerModal" class="modal fade" role="dialog">
							<div class="modal-dialog">
								<div class="modal-content">
								<h4 align="center"><b>Register</b></h4>
									<div class="row">
										<div class=" col-md-8 col-md-offset-1 ">
										<p>USERNAME</p>
										<input class="inputdefault" type="text">
										</div>
										<div class=" col-md-8  col-md-offset-1 "><br>
										<p>E-Mail</p>
										<input class="inputdefault"  type="email">
										</div>
									</div>
										<div class="container">
											<h5 id="reset-info" style="color:#3a7ec2;">   A PASSWORD TO BE E-MAILED TO YOU.</h5>
												<div class="col-md-8 col-md-offset-2">
													<button class="btn btn-info btn-xs">Register</button>
													<button class="btn btn-info btn-xs">Login</button>
												</div>
										</div>
											<div id="down-lnk">
											<a > LOG IN</a>|<a>LOST YOUR PASSWORD?</a>
											</div>
								</div>
							</div>
						</div> 
						<div id="loginModal" class="modal fade" role="dialog">  
							<div class="modal-dialog">
								<div class="modal-content">
								<h4 align="center"><b>Login</b></h4>
									<div class="row">
										<div class=" col-md-8 col-md-offset-1 ">
										<p>USERNAME</p>
										<input class="inputdefault" type="text">
										</div>
										<div class=" col-md-8  col-md-offset-1 "><br>
										<p>Password</p>
										<input class="inputdefault"  type="password">
										</div>
										
									</div>
										<div class="container">
												<div class="col-md-8 col-md-offset-2"><br>
													<button class="btn btn-info btn-xs">Login</button>
													<button class="btn btn-info btn-xs">Cancel</button>
												</div>
										</div>
											<div id="down-lnk1">
											<a > LOG IN</a>|<a>LOST YOUR PASSWORD?</a>
										</div>
									</div>
								</div>
							</div> 
					<!-- Need to assign proper links to these two. -->
				</div>
			</div>
		</div>
	</div>	
	</div>
</div>
<br>
<br>
<br>
<footer id="colophon" class="site-footer" role="contentinfo">
<div class="container">

	<div class="site-info">
		Copyright Recruiter Shack &copy; 2016. All Rights Reserved / <a
			href="/privacy" class="bottom-links-color">Privacy</a> / <a class="bottom-links-color" href="/terms">Terms</a>
	</div>
	<!-- .site-info -->

	<div class="site-social"></div>
</div>
</footer>
</body>
</html>