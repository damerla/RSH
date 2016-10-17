<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>${pageContext.request.userPrincipal.name}|RecruiterShack</title>
<%@ include file="common.jsp"%>

<script type="text/javascript">
	function updateSelectOptions(lookupUrl, parentSelectElementId,
			childSelectElementId) {

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
					<li><a href="auth/account" class="label-color-font-size">Account</a></li>
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

		</div>
	</div>
	<br>

	<div class="col-md-10 col-md-offset-1">
		<form:form method="POST" commandName="jobseeker"
			action="/jobseeker/auth/jobseeker-profile-edit" enctype="multipart/form-data">

			<form:errors path="*" cssClass="errorblock" element="div" />
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />

			<%-- <p>Company Name</p>
				<form:input path="companyName" class="input-lg form-control" id="companyName"/> <br> --%>
			<p class="label-color-font-size">First Name</p>
			<form:input path="firstName" class="input-lg form-control"
				id="firstName" />
			<form:errors path="firstName" cssClass="error" />
			<br>
			<p class="label-color-font-size">Last Name</p>
			<form:input path="lastName" class="input-lg form-control"
				id="lastName" />
			<br>
			<p class="label-color-font-size">
				<span class="glyphicon glyphicon-envelope" style="font-size: 18px"></span>&nbsp;&nbsp;E-mail
				Address
			</p>
			<form:input path="email" class="input-lg form-control" readonly="true" id="address" />
			<form:errors path="email" cssClass="error" />
			<br>
			<p class="label-color-font-size">
				<span class="glyphicon glyphicon-user" style="font-size: 18px"></span>&nbsp;
				Username
			</p>
			<form:input path="userName" class="input-lg form-control"
				id="userName" readonly="true" />
			<br>
			<p class="label-color-font-size">
				<span class="glyphicon glyphicon-phone-alt"></span>Phone Number
			</p>
			<form:input path="phone" class="input-lg form-control" id="phone" />
			<p class="label-color-font-size">Profile Picture</p>
			<form:input type="file" path="pic" id="pic" accept="image/*" />
			<br>
			<p class="label-color-font-size">Line1</p>
			<form:input path="line1" class="input-lg form-control"
				id="line1_address" />
			<br>
			<p class="label-color-font-size">Line2</p>
			<form:input path="line2" class="input-lg form-control"
				id="line2_address" />
			<br>
			<p class="label-color-font-size">Country</p>
			<form:select path="country" id="country"
				class="input-lg form-control"
				onchange="updateSelectOptions('/lookupStatesWithinCountry', 'country', 'state')">
				<form:option value="-1">Other</form:option>
				<c:forEach items="${countries}" var="ind">
					<c:choose>
						<c:when test="${recruiter.getCountry().getId()==ind.getId()}">
							<form:option selected="selected" value="${ind.getId()}">${ind.getName()}</form:option>
						</c:when>
						<c:otherwise>
							<form:option value="${ind.getId()}">${ind.getName()}</form:option>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</form:select>
			<br>
			<p class="label-color-font-size">State</p>
			<form:select path="state" id="state" class="input-lg form-control"
				onchange="updateSelectOptions('/lookupCitiesWithinState', 'state', 'city')">
				<c:forEach items="${states}" var="ind">
					<c:choose>
						<c:when test="${recruiter.getState().getId()==ind.getId()}">
							<form:option selected="selected" value="${ind.getId()}">${ind.getName()}</form:option>
						</c:when>
						<c:otherwise>
							<form:option value="${ind.getId()}">${ind.getName()}</form:option>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<form:option value="-1">Other</form:option>
			</form:select>
			<br>
			<p class="label-color-font-size">City</p>
			<form:select path="city" id="city" class="input-lg form-control">
				<c:forEach items="${cities}" var="ind">
					<c:choose>
						<c:when test="${recruiter.getCity().getId()==ind.getId()}">
							<form:option selected="selected" value="${ind.getId()}">${ind.getName()}</form:option>
						</c:when>
						<c:otherwise>
							<form:option value="${ind.getId()}">${ind.getName()}</form:option>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<form:option value="-1">Other</form:option>
			</form:select>
			<br>
			<p class="label-color-font-size">Zip</p>
			<form:input path="pinCode" class="input-lg form-control" id="pinCode" />
			<br>
			<p>
				<span class="fa fa-industry" style="font-size: 20px"><strong
					class="label-color-font-size"> Industry </strong></span>
			</p>
			<form:select path="industry" class="input-lg form-control">
				<c:forEach items="${industries}" var="ind">
					<c:choose>
						<c:when test="${recruiter.getIndustry().getId()==ind.getId()}">
							<form:option selected="selected" value="${ind.getId()}">${ind.getName()}</form:option>
						</c:when>
						<c:otherwise>
							<form:option value="${ind.getId()}">${ind.getName()}</form:option>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</form:select>
			<br>
			<p class="label-color-font-size">
				<span class="glyphicon glyphicon-file" style="font-size: 20px"></span>
				Resume
			</p>
			<form:input type="file" path="resume" id="resume" accept="file/*" />
			<br>

			<div class="container">
				<div class="col-md-3">
					<p>
						<span class="glyphicon glyphicon-align-justify"></span>Biography
					</p>
					<form:textarea id="biography-textarea" path="bio"
						placeholder="Enter bit about yourself..."></form:textarea>
				</div>
			</div>
			<div class="container">
				<div class="col-md-3 ">
					<p class="label-color-font-size">Seniority</p>
					<form:select path="seniority" class="input-lg form-control">
						<c:forEach items="${seniorities}" var="seni">
							<c:choose>
								<c:when test="${jobseeker.getSeniority().getId()==seni.getId()}">
									<form:option selected="selected" value="${seni.getId()}">${seni.getName()}</form:option>
								</c:when>
								<c:otherwise>
									<form:option value="${seni.getId()}">${seni.getName()}</form:option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</form:select>
				</div>
			</div>
			<div class="container">
				<div class="col-md-3">
					<p class="label-color-font-size">Education level</p>
					<form:select path="education" class="input-lg form-control">
						<c:forEach items="${educations}" var="education">
							<c:choose>
								<c:when test="${jobseekers.getEducation().getId()==education.getId()}">
									<form:option selected="selected" value="${education.getId()}">${education.getName()}</form:option>
								</c:when>
								<c:otherwise>
									<form:option value="${education.getId()}">${education.getName()}</form:option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</form:select>
				</div>
			</div>
			<div class="container">
				<div class="col-md-3  ">
					<button type="submit" class="btn btn-info btn-lg col-md-12">Update
						Profile</button>
				</div>
				<div class="col-md-3">
					<button type="button" class="btn btn-default btn-lg col-md-12"
						onclick="location.href='/jobseeker/jobseeker-profile'">Cancel</button>
				</div>
			</div>
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