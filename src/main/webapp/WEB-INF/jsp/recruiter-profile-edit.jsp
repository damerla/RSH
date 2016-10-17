<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>${recruiter.getFirstName()}&nbsp;${recruiter.getLastName()}|RecruiterShack</title>
<%@ include file="common.jsp"%>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<script src="/js/cropper.js"></script>
<script src="/js/docs.js"></script>
<script src="/js/upload.js"></script>
<link href="/css/cropper.css" rel="stylesheet">
<link href="/css/uploadpic.css" rel="stylesheet">
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
					<li><a href="../account" class="label-color-font-size">Account</a></li>
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
	<div class="container" id="rProfileEdit-topPort"  align="center">
		<div>
			<div class="col-md-offset-10">
			<a href="#" class="col"> <span class="glyphicon glyphicon-ok"
				style="font-size: 25px;"></span></a>
		</div>

			<ul class="nav navbar-nav" style="width:200px;">
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#"><span
						class="glyphicon glyphicon-camera"
						style="font-size: 45px;"></span> <img src="data:image/jpeg;base64,${recruiter.getLogoString()} "
				height="200" width="200" alt=""></a>
					<ul class="dropdown-menu">
						<li><a id="upload_link">Upload</a></li>
						<li><a href="#">Remove</a></li>
						<li><a href="#">Cancel</a></li>
					</ul></li>
			</ul>
			<div class="container" align="center">
		<h3>${recruiter.getFirstName()}&nbsp;${recruiter.getLastName()}</h3>
	</div>
		</div>
		
	</div>
	
<div class="container docs-overview" id="upload_dialog">
            <div >
                <div class="container-fluid eg-container" id="basic-example">
                    <div class="eg-main">
                        <div class="">
                            <div class="eg-wrapper">
                                <img class="cropper" src="data:image/jpeg;base64,${recruiter.getLogoString()}" alt="Picture">
                            </div>
                        </div>
                    </div>

                    <div class="clearfix">
                        <div class="col-xs-12">
                            <div class="eg-button">
                                <button class="btn btn-warning" id="reset" type="button">Reset</button>
                                <button class="btn btn-info" id="zoomIn" type="button">Zoom In</button>
                                <button class="btn btn-info" id="zoomOut" type="button">Zoom Out</button>
                                <button class="btn btn-info" id="rotateLeft" type="button">Rotate Left</button>
                                <button class="btn btn-info" id="rotateRight" type="button">Rotate Right</button>
                                <label class="btn btn-primary" for="inputImage" title="Upload image file">
                                    <input class="hide" id="inputImage" name="file" accept="image/*" type="file">
                                    <span data-original-title="Import image with FileReader" class="docs-tooltip" data-toggle="tooltip" title="">
                                        <span class="glyphicon glyphicon-upload"></span>Browse
                                    </span>
                                </label>
                                <button class="btn btn-primary" id="getDataURL" onclick="setCrop();" type="button">Preview</button>
                                <div class="col-md-12">
                                    <div id="err"></div>
                                </div>
                            </div>

                            <div class="row eg-output">
                                <div class="col-md-6">
                                    <form action="Upload" method="POST" onsubmit="return validate();">
                                        <textarea name="image_file" style="display: none;"class="form-control" id="dataURL" rows="10"></textarea>
                                        <input class="btn btn-success" type="submit" value="Save Image">
                                    </form>
                                </div>
                                <div class="col-md-6">
                                    <div id="showDataURL"></div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="hidden-print docs-sidebar" role="complementary">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
	<div class="container row">
		<form:form method="POST" commandName="recruiter"
			action="/recruiter/auth/profile/edit" enctype="multipart/form-data">
			<form:errors path="*" cssClass="errorblock" element="div" />
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
				<p class="label-color-font-size">
					<span class="fa fa-building"></span> Company Name
				</p>
				<form:input path="companyName" class="input-lg form-control" id="companyName" />
				<br>
				<p class="label-color-font-size">First Name</p>
				<form:input path="firstName" class="input-lg form-control" id="firstName" />
				<br>
				<p class="label-color-font-size">Last Name</p>
				<form:input path="lastName" class="input-lg form-control" id="lastName" />
				<br>
				<p class="label-color-font-size">
					<span class="glyphicon glyphicon-envelope" style="font-size: 18px"></span>&nbsp;&nbsp;E-mail
					Address
				</p>
				<form:input path="email" class="input-lg form-control" id="address" />
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
				<form:input path="pinCode" class="input-lg form-control"
					id="pinCode" />
				<br>
				<p class="label-color-font-size">
					<span class="fa fa-industry"></span> Industry
				</p>
				<form:select path="industry" class="input-lg form-control">
					<c:forEach items="${industries}" var="ind">
						<form:option value="${ind.getId()}">${ind.getName()}</form:option>
					</c:forEach>
				</form:select>
			<button type="submit" class="box-update user-home" onclick="location.href='/recruiter/auth/profile/edit'">Update
				Profile</button>
			<button type="button" class="box-update" id="user-home"
				onclick="location.href='/'">Cancel</button>
		</form:form>
	</div>
	<br>
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