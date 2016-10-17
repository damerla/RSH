<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Privacy - Recruiter Shack</title>
<%@ include file="common.jsp"%>
</head>
<body id="no-hor-scrollbar" class="custom-background">
	<nav class="navbar navbar-static navbar-fixed-top"
		style="background-color: #10ac51">
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
				<a class="navbar-brand" href="index" style=""> <img alt=""
					src="/img/whiterecruiterlogo.png"></a>
			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-right" id="match-border">
					<li class="dropdown"><a id="whiteColor-dropDown"
						class="dropdown-toggle label-color-font-size" data-toggle="dropdown" href="#">Company
							<span class="caret"></span>
					</a>
						<ul class="dropdown-menu">
							<li><a href="/about">About</a></li>
							<li><a href="/contact">Contact</a></li>
							<li><a href="/faqs">FAQ's</a></li>
						</ul></li>
					<sec:authorize access="isAnonymous()">
						<li><a href="/login" class="label-color-font-size">Login</a></li>
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
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container-fluid -->
	</nav>
	<div class="container border-privacyPg" id="unique">
		<div class="row">
			<div class="col-md-6 col-md-offset-4 text-heading">
				<h1>Our Privacy Policy</h1>
			</div>
		</div>
		<div class="row body-text-size">
			<div class="col-md-12">
				<p>Lorem ipsum dolor sit amet, ne vim porro inani aliquid. Ea
					vitae vivendum duo, in per aperiri aliquid reformidans. No accumsan
					recteque mediocritatem eam. Pri vocibus corpora incorrupte no, sumo
					salutatus sit at. Impedit nominavi accommodare no eum, vidit
					luptatum nec an.</p>
			</div>
			<div class="col-md-12">
				<p>Te mel disputando comprehensam, choro eirmod inermis id has,
					ne mazim neglegentur usu. Probo simul epicurei has cu, nec ei reque
					facer inciderint. Unum debitis theophrastus sit ei, exerci nostro
					splendide ne sea, no quo case veri. Ei ius ullum solet nusquam, per
					te dico debitis, pri in dico delicata.</p>
			</div>
			<div class="col-md-12">
				<p>Pericula repudiare moderatius mei ne. Ut mei volutpat
					partiendo principes. Est at dolor omnes laoreet, suas minimum mei
					ea. Usu eirmod interesset te, sed ei utinam timeam quaerendum. Vim
					lorem harum qualisque id, ex integre conceptam appellantur usu.</p>
			</div>
			<div class="col-md-12">
				<p>Semper blandit intellegat sed at, vix vidisse eligendi in. Ea
					movet equidem nam. Vel et probo dictas ponderum, eam in etiam
					nostrum. An pri cibo illud iisque, at dicat noster eos.</p>
			</div>
			<div class="col-md-12">
				<p>Eam no hinc exerci pericula. Mea at aperiam democritum
					intellegebat. Soleat partem efficiantur vis ex, in vel petentium
					disputando. Purto inimicus omittantur nam in. Quod iuvaret at per,
					facete inermis volutpat ad his, ne possit nusquam omittantur pro.</p>
			</div>
		</div>
	</div>
	<footer id="colophon" class="site-footer" role="contentinfo">
		<div class="container">

			<div class="site-info">
				Copyright Recruiter Shack &copy;  2016. All Rights Reserved / <a
					href="/privacy">Privacy</a> / <a href="/terms">Terms</a>
			</div>
			<!-- .site-info -->

			<div class="site-social"></div>
		</div>
	</footer>
</body>
</html>