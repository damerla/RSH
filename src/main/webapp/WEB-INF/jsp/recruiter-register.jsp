<%@page contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Register Sign Up - Recruiter Shack</title>
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
<body>
	<nav class="navbar main-header ">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="/" style=""><img alt=""
					src="/img/rshLogo.png"> </a>
			</div>
			<ul class="nav navbar-nav navbar-right" id="match-border">
				<li class="dropdown"><a
					class="dropdown-toggle label-color-font-size"
					data-toggle="dropdown" href="#">Company <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="/about">About</a></li>
						<li><a href="/contact">Contact</a></li>
						<li><a href="/faqs">FAQ's</a></li>
					</ul></li>
				<sec:authorize access="isAnonymous()">
					<li><a href="/login" class="label-color-font-size">Login</a></li>
				</sec:authorize>
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
	<section class="container">
		<div id="contact_page">
			<div class="container">
				<div class="row">
					<div class="col-md-3"></div>
					<div class="login col-md-6">
						<div class="row">
							<div class="col-md-3">
								<button class="btn btn-facebook  fa fa-facebook-square btn-lg "
									style="font-size: 21px;"
									onclick="location.href='https://www.facebook.com/login.php?skip_api_login=1&api_key=777547872378369&signed_next=1&next=https%3A%2F%2Fwww.facebook.com%2Fv2.5%2Fdialog%2Foauth%3Fredirect_uri%3Dhttp%253A%252F%252Frecruitershack.com%252Fr%252Flogin%252F%253Fprovider%253Dfacebook%26state%3D29c1d1f5e9f5e242f7d3d3572e67d731%26scope%3Dpublic_profile%252Cemail%26response_type%3Dcode%26client_id%3D777547872378369%26ret%3Dlogin%26sdk%3Dphp-sdk-5.1.2%26logger_id%3Dba3aa106-dc0a-4097-933c-daf7d5918dc4&cancel_url=http%3A%2F%2Frecruitershack.com%2Fr%2Flogin%2F%3Fprovider%3Dfacebook%26error%3Daccess_denied%26error_code%3D200%26error_description%3DPermissions%2Berror%26error_reason%3Duser_denied%26state%3D29c1d1f5e9f5e242f7d3d3572e67d731%23_%3D_&display=page&locale=en_GB&logger_id=ba3aa106-dc0a-4097-933c-daf7d5918dc4'">
									<i class="icon-facebook"></i> | Sign in with Facebook
								</button>
							</div>
							<div class="col-md-3  col-md-offset-3">
								<button class="btn btn-linkedin fa fa-linkedin btn-lg"
									style="font-size: 21px;"
									onclick="location.href='https://www.linkedin.com/uas/oauth/authorize?oauth_token=75--bad615f5-1945-4f95-865f-2748d61ca8a7&state='">
									<i class="icon-linkedin"></i> | Sign in with LinkedIn
								</button>
								<br>
							</div>
						</div>
						<form:form method="POST" commandName="recruiter"
							action="/recruiter/register" enctype="multipart/form-data">
							<form:errors path="*" cssClass="errorblock" element="div" />
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
							<p class="label-color-font-size">
								<span class="fa fa-building" style="font-size: 22px"></span>
								Company Name
							</p>
							<form:input path="companyName" class="input-lg form-control"
								id="companyName" />
							<br>
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
								<span class="glyphicon glyphicon-envelope"
									style="font-size: 18px"></span>&nbsp;&nbsp;E-mail Address
							</p>
							<form:input path="email" class="input-lg form-control"
								id="address" />
							<br>
							<p class="label-color-font-size">
								<span class="glyphicon glyphicon-user" style="font-size: 18px"></span>&nbsp;
								Username
							</p>
							<form:input path="userName" class="input-lg form-control"
								id="userName" />
							<br>
							<p class="label-color-font-size">Line1</p>
							<form:input path="line1" class="input-lg form-control"
								id="line1_address" />
							<br>
							<p class="label-color-font-size">Line2</p>
							<form:input path="line2" class="input-lg form-control"
								id="line2_address" />
							<br>
							<%-- <p>Country</p>
							<form:input path="country"  class="input-lg form-control" id="country"/> <br>
							<p class="label-color-font-size">State</p>
							<form:input path="state" class="input-lg form-control"  id="state"/> <br>
							<p class="label-color-font-size">City</p>
							<form:input path="city" class="input-lg form-control"  id="city"/> <br> --%>
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
							<form:select path="state" id="state"
								class="input-lg form-control"
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
							<form:input path="pinCode" class="input-lg form-control"
								id="pinCode" />
							<br>
							<p class="label-color-font-size">Logo</p>
							<form:input type="file" path="logo" id="logo" accept="image/*" />
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
							<p>
								<span class="fa fa-unlock-alt" style="font-size: 20px">&nbsp;
									<strong class="label-color-font-size"> Password</strong>
								</span>
							</p>
							<form:input type="password" path="password"
								class="input-lg form-control" id="password" />
							<br>
							<div class="row">
								<div class="col-md-6">
									<button type="submit" class="btn btn-success btn-lg btn-block">Register</button>
								</div>
								<div class="col-md-6">
									<input type="button" class="btn btn-default btn-lg btn-block"
										value="Login" onclick="location.href='/login' " />
								</div>
							</div>
						</form:form>
					</div>
				</div>
				<div class="col-md-3"></div>
			</div>
		</div>
		<p></p>
		<br>
	</section>
	<footer>
		<div class="container">
			<div id="footer-bottom" class="row">
				<div class="col-md-10">
					<br> <br> <br> Copyright Recruiter Shack &copy;
					2016. All Rights Reserved / <a class="label-color-font-size"
						href="/privacy">Privacy</a> / <a class="label-color-font-size"
						href="/terms">Terms</a> / <br>Designed by <a href="#"
						class="label-color-font-size">8Second Designs</a>
				</div>
				<div>
					<ul class="btn-social-icons col-md-2">
						<br>
						<br>
						<br>
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
							href="https://http://recruitershack.com/feed/" class="icon">
								<span></span>
						</a></li>
					</ul>
				</div>
			</div>
		</div>
		<!-- .container -->
	</footer>
</body>
</html>