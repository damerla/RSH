package org.lightadmin.boot;

import static org.springframework.core.Ordered.HIGHEST_PRECEDENCE;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;

import org.apache.log4j.BasicConfigurator;
import org.apache.log4j.Level;
import org.lightadmin.api.config.LightAdmin;
import org.lightadmin.core.config.LightAdminWebApplicationInitializer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.context.embedded.ServletContextInitializer;
import org.springframework.boot.context.web.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;

@Configuration
@ComponentScan
@EnableAutoConfiguration
@Order(HIGHEST_PRECEDENCE)
public class LightAdminBootApplication extends SpringBootServletInitializer {

	private static final Logger logger = LoggerFactory.getLogger(LightAdminBootApplication.class);

	// @Override
	// public void onStartup(ServletContext servletContext) throws
	// ServletException {
	// LightAdmin.configure(servletContext)
	// .basePackage("org.lightadmin.boot.administration")
	// .baseUrl("/admin")
	// .security(false)
	// .backToSiteUrl("http://lightadmin.org");
	//
	// super.onStartup(servletContext);
	// }

	@Bean
	public ServletContextInitializer servletContextInitializer() {
		return new ServletContextInitializer() {
			@Override
			public void onStartup(ServletContext servletContext) throws ServletException {
				LightAdmin.configure(servletContext).basePackage("org.lightadmin.boot.administration").baseUrl("/admin")
						.security(false).backToSiteUrl("/");

				new LightAdminWebApplicationInitializer().onStartup(servletContext);
			}
		};
	}

	public static void main(String[] args) throws Exception {
		BasicConfigurator.configure();
		org.apache.log4j.Logger root = org.apache.log4j.Logger.getRootLogger();
		root.setLevel(Level.INFO);
		SpringApplication.run(LightAdminBootApplication.class, args);
	}

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(LightAdminBootApplication.class);
	}
}