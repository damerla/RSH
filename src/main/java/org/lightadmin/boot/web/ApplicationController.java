package org.lightadmin.boot.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.lightadmin.boot.Constants;
import org.lightadmin.boot.dao.JobseekerDAO;
import org.lightadmin.boot.dao.JobseekerDAOImpl;
import org.lightadmin.boot.dao.RecruiterDao;
import org.lightadmin.boot.dao.RecruiterDaoImpl;
import org.lightadmin.boot.domain.City;
import org.lightadmin.boot.domain.State;
import org.lightadmin.boot.repository.CityRepository;
import org.lightadmin.boot.repository.StateRepository;
import org.lightadmin.boot.service.EmailSender;
import org.lightadmin.boot.service.GeoLocationUpdater;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ApplicationController {

	@Autowired
	private StateRepository stateRepository;

	@Autowired
	private CityRepository cityRepository;

	@Autowired
	private EmailSender emailSender;

	@RequestMapping("/send")
	@ResponseBody
	public String sendEmail() {
		Map<String, Object> map = new HashMap<>();
		map.put("name", "Kisor");
		emailSender.sendEmail(Constants.EMAIL_UPGRADED, map, "kisor.biswal@gmail.com");
		return "Sent";
	}

	@RequestMapping("/")
	public String index() {
		return "index";
	}

	@RequestMapping("/about")
	public String about() {
		return "about";
	}

	@RequestMapping("/contact")
	public String contact() {
		return "contact";
	}

	@RequestMapping("/faqs")
	public String faqs() {
		return "faqs";
	}

	@RequestMapping("/privacy")
	public String privacy() {
		return "privacy";
	}

	@RequestMapping("/terms")
	public String terms() {
		return "terms";
	}

	@RequestMapping("/user/profile/editprofile")
	public String userProfile() {
		return "user-profile-editprofile";
	}

	@RequestMapping("/landing/pagee")
	public String landingpage() {
		return "landing-page";
	}

	@RequestMapping("/jobseeker/profile")
	public String jobseekerProfile() {
		return "jobseeker-profile";
	}

	@RequestMapping("/buy/leads")
	public String buyLeads() {
		return "buy-leads";
	}

	@RequestMapping("/cart/remove/item")
	public String cartRemoveItem() {
		return "cart-remove-item";
	}

	@RequestMapping("/cart/view")
	public String viewCart() {
		return "viewCart";
	}

	@RequestMapping(value = "/lookupStatesWithinCountry", method = RequestMethod.GET)
	@ResponseBody
	public List<State> lookupStatesWithinCountry(@RequestParam(value = "searchId") Long searchId) {

		return stateRepository.findByCountryId(searchId);
	}

	@RequestMapping(value = "/lookupCitiesWithinState", method = RequestMethod.GET)
	@ResponseBody
	public List<City> lookupCitiesWithinState(@RequestParam(value = "searchId") Long searchId) {

		return cityRepository.findByStateId(searchId);
	}

	@Bean
	public GeoLocationUpdater getLocation() {
		return new GeoLocationUpdater();
	}

	@Bean
	public EmailSender gemailSender() {
		return new EmailSender();
	}

	@Bean
	public RecruiterDao recruiterDAO() {
		return new RecruiterDaoImpl();
	}
	
	@Bean
	public JobseekerDAO jobseekerDao() {
		return new JobseekerDAOImpl();
	}
}