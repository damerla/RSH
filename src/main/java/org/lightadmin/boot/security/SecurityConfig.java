package org.lightadmin.boot.security;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.util.matcher.RegexRequestMatcher;
import org.springframework.security.web.util.matcher.RequestMatcher;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	private static final Logger logger = LoggerFactory.getLogger(SecurityConfig.class);

	@Autowired
	@Qualifier("userDetailsService")
	UserDetailsService userDetailsService;

	@Autowired
	RSHAuthenticationSuccessHandler successHandler;

	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder());
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		// http.csrf().disable().requireCsrfProtectionMatcher(getCSFRMatcher());
		http.authorizeRequests().antMatchers("/admin/**").access("hasRole('ROLE_ADMIN')").and().formLogin()
				.loginPage("/login").loginProcessingUrl("/j_spring_security_check").successHandler(successHandler)
				.failureUrl("/login?error").usernameParameter("username").passwordParameter("password").and().logout()
				.logoutSuccessUrl("/login?logout").and().exceptionHandling().accessDeniedPage("/403").and().csrf()
				.disable();

		http.authorizeRequests().antMatchers("/recruiter/auth/**").access("hasRole('ROLE_RECRUITER')").and().formLogin()
				.loginPage("/login").loginProcessingUrl("/j_spring_security_check").failureUrl("/login?error")
				.usernameParameter("username").passwordParameter("password").and().logout()
				.logoutSuccessUrl("/login?logout").and().exceptionHandling().accessDeniedPage("/403").and().csrf()
				.disable();

		http.authorizeRequests().antMatchers("/jobseeker/auth/**").access("hasRole('ROLE_JOBSEEKER')").and().formLogin()
				.loginPage("/login").loginProcessingUrl("/j_spring_security_check").failureUrl("/login?error")
				.usernameParameter("username").passwordParameter("password").and().logout()
				.logoutSuccessUrl("/login?logout").and().exceptionHandling().accessDeniedPage("/403").and().csrf()
				.disable();

	}

	private RequestMatcher getCSFRMatcher() {
		return new RequestMatcher() {
			String allow = "recruiter/api";
			private RegexRequestMatcher apiMatcher = new RegexRequestMatcher("/v[0-9]*/.*", null);

			@Override
			public boolean matches(HttpServletRequest request) {
				String requestURI = request.getRequestURI();
				// No CSRF due to allowedMethod
				if (requestURI.contains(allow)) {
					logger.info("Skipping CSRF: " + requestURI);
					return false;
				}

				// CSRF for everything else that is not an API call or an
				// allowedMethod
				return true;
			}
		};
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		PasswordEncoder encoder = new BCryptPasswordEncoder();
		return encoder;
	}

	// @Autowired
	// public void configureGlobal(AuthenticationManagerBuilder auth) throws
	// Exception {
	// auth.inMemoryAuthentication().withUser("mkyong").password("123456").roles("USER");
	// auth.inMemoryAuthentication().withUser("admin").password("123456").roles("ADMIN");
	// auth.inMemoryAuthentication().withUser("dba").password("123456").roles("DBA");
	// }
	//
	// @Override
	// protected void configure(HttpSecurity http) throws Exception {
	//
	// http.authorizeRequests().antMatchers("/admin/**").access("hasRole('ROLE_ADMIN')").antMatchers("/dba/**")
	// .access("hasRole('ROLE_ADMIN') or
	// hasRole('ROLE_DBA')").and().formLogin();
	//
	// }
}