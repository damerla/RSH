package org.lightadmin.boot.security;

import java.io.IOException;
import java.time.Instant;
import java.util.Collection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.lightadmin.boot.domain.Jobseeker;
import org.lightadmin.boot.domain.Recruiter;
import org.lightadmin.boot.repository.JobseekerRepository;
import org.lightadmin.boot.repository.RecruiterRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

public class RSHAuthenticationSuccessHandler implements AuthenticationSuccessHandler {
	public static final String USER_TYPE = "USER_RECRUITER";

	public static final int TYPE_RECRUITER = 1;
	public static final int TYPE_JOBSEEKER = 2;
	public static final int TYPE_ADMIN = 3;

	public static final String USER = "USER";

	protected Log logger = LogFactory.getLog(this.getClass());

	@Autowired
	private RecruiterRepository recruiterRepository;

	@Autowired
	private JobseekerRepository jobseekerRepository;

	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException {
		handle(request, response, authentication);
		clearAuthenticationAttributes(request);
	}

	protected void handle(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException {
		String targetUrl = determineTargetUrl(authentication, request);

		if (response.isCommitted()) {
			logger.debug("Response has already been committed. Unable to redirect to " + targetUrl);
			return;
		}

		redirectStrategy.sendRedirect(request, response, targetUrl);
	}

	/**
	 * Builds the target URL according to the logic defined in the main class
	 * Javadoc.
	 * 
	 * @param request
	 */
	protected String determineTargetUrl(Authentication authentication, HttpServletRequest request) {
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String name = user.getUsername();
		Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
		for (GrantedAuthority grantedAuthority : authorities) {
			if (grantedAuthority.getAuthority().equals("ROLE_RECRUITER")) {
				Recruiter recruiter = recruiterRepository.findByuserName(name);
				recruiter.initLogoString();
				request.getSession().setAttribute(USER_TYPE, TYPE_RECRUITER);
				request.getSession().setAttribute(USER, recruiter);
				updateSubscriptionStatuses(recruiter);
				return "/recruiter/auth/landing";
			} else if (grantedAuthority.getAuthority().equals("ROLE_ADMIN")) {
				request.getSession().setAttribute(USER_TYPE, TYPE_ADMIN);
				return "/admin";
			} else if (grantedAuthority.getAuthority().equals("ROLE_JOBSEEKER")) {
				Jobseeker jobseeker = jobseekerRepository.findByuserName(name);
				jobseeker.initPicString();
				request.getSession().setAttribute(USER_TYPE, TYPE_JOBSEEKER);
				request.getSession().setAttribute(USER, jobseeker);
				return "/jobseeker/auth/account";
			}
		}
		return "/";

	}

	private void updateSubscriptionStatuses(Recruiter recruiter) {
		long now = Instant.now().getEpochSecond();
		if (recruiter.isUpgraded()) {
			if (recruiter.getEnterpriseUntil() != null) {
				if (now > recruiter.getEnterpriseUntil()) {
					recruiter.setUpgraded(false);
					recruiterRepository.save(recruiter);
				}
			}
		}

		if (recruiter.isFeatured()) {
			if (recruiter.getFeaturedUntil() != null) {
				if (now > recruiter.getFeaturedUntil()) {
					recruiter.setFeatured(false);
					recruiterRepository.save(recruiter);
				}
			}
		}
	}

	protected void clearAuthenticationAttributes(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		if (session == null) {
			return;
		}
		session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
	}

	public void setRedirectStrategy(RedirectStrategy redirectStrategy) {
		this.redirectStrategy = redirectStrategy;
	}

	protected RedirectStrategy getRedirectStrategy() {
		return redirectStrategy;
	}
}