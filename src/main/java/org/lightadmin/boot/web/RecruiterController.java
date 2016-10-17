package org.lightadmin.boot.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.lightadmin.boot.domain.Cart;
import org.lightadmin.boot.domain.Country;
import org.lightadmin.boot.domain.Industry;
import org.lightadmin.boot.domain.Jobseeker;
import org.lightadmin.boot.domain.Recruiter;
import org.lightadmin.boot.domain.RecruiterDummy;
import org.lightadmin.boot.domain.User;
import org.lightadmin.boot.domain.UserRole;
import org.lightadmin.boot.repository.CartRepository;
import org.lightadmin.boot.repository.CityRepository;
import org.lightadmin.boot.repository.CountryRepository;
import org.lightadmin.boot.repository.IndustryRepository;
import org.lightadmin.boot.repository.InternalMessageRepository;
import org.lightadmin.boot.repository.JobseekerRepository;
import org.lightadmin.boot.repository.RecruiterRepository;
import org.lightadmin.boot.repository.StateRepository;
import org.lightadmin.boot.repository.UserRepository;
import org.lightadmin.boot.repository.UserRoleRepository;
import org.lightadmin.boot.security.RSHAuthenticationSuccessHandler;
import org.lightadmin.boot.service.GeoLocationUpdater;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class RecruiterController {
	private static final Logger logger = LoggerFactory.getLogger(RecruiterController.class);

	private static final String ROLE_REC = "ROLE_RECRUITER";

	@Autowired
	private IndustryRepository industryRepository;

	@Autowired
	private CountryRepository countryRepository;
	@Autowired
	private StateRepository stateRepository;

	@Autowired
	private CityRepository cityRepository;

	@Autowired
	private RecruiterRepository recruiterRepository;

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private JobseekerRepository jobseekerRepository;

	@Autowired
	private UserRoleRepository userRoleRepository;

	@Autowired
	private GeoLocationUpdater geoLocationUpdater;

	@Autowired
	private InternalMessageRepository internalMessageRepository;

	@Autowired
	private CartRepository cartRepository;

	@RequestMapping("/recruiter/home")
	public String recruiterhome() {
		return "recruiterhome";
	}

	@RequestMapping("/recruiter/auth/viewcart")
	public String viewCart(HttpServletRequest req, ModelMap map) {
		Recruiter rec = getRecruiter(req);
		Cart cart = rec.getCart();
		if (cart == null) {
			cart = new Cart();
			cartRepository.save(cart);
			rec.setCart(cart);
			recruiterRepository.save(rec);
		} else {
			cart = cartRepository.findByid(cart.getId());
		}
		map.put("cart", cart);
		return "viewCart";
	}

	@RequestMapping("/recruiter/cart-remove-item")
	public String cartRemoveItem() {
		return "cart-remove-item";
	}

	@RequestMapping("/recruiter/auth/buy-leads")
	public String buyLeads(HttpServletRequest req) {
		Recruiter recruiter = getRecruiter(req);
		Recruiter fresh = recruiterRepository.findByuserName(recruiter.getUserName());
		req.setAttribute("jobseekers", fresh.getFollowers());
		Cart cart = fresh.getCart();
		if (cart == null) {
			cart = new Cart();
			cart.setJobseekers(new ArrayList<Jobseeker>());
			cartRepository.save(cart);
			fresh.setCart(cart);
			recruiterRepository.save(fresh);
		} else {
			cart = cartRepository.findByid(fresh.getCart().getId());
		}
		req.setAttribute("incart", cart.getJobseekers().stream().map(j -> j.getId()).collect(Collectors.toList()));
		return "buy-leads";
	}

	private Recruiter getRecruiter(HttpServletRequest req) {
		return (Recruiter) req.getSession().getAttribute(RSHAuthenticationSuccessHandler.USER);
	}

	@RequestMapping("/featuredRecruiters")
	public String featuredRecruiters(ModelMap map) {
		Iterable<Recruiter> recruiters = recruiterRepository.findByFeatured(true);
		recruiters.forEach(r -> r.initLogoString());
		map.addAttribute("recruiters", recruiters);
		return "featuredRecruiters";
	}

	@RequestMapping("/recruiter/auth/landing")
	public String recruiterLanding(ModelMap map, HttpServletRequest req) {
		map.addAttribute("recruiter", getRecruiter(req));
		return "landing-page";
	}

	@RequestMapping(value = "/recruiter/auth/profile/edit", method = RequestMethod.GET)
	public String recruiterProfileEdit(ModelMap map, HttpServletRequest request) {
		// recruiter.initLogoString();
		map.addAttribute("recruiter", getRecruiter(request));
		map.put("countries", countryRepository.findAll());
		map.put("industries", industryRepository.findAll());
		return "recruiter-profile-edit";
	}

	@RequestMapping(value = "/recruiter/auth/profile/edit", method = RequestMethod.POST)
	public String recruiterProfileEditPost(@Valid Recruiter recruiter, BindingResult result, ModelMap map) {
		// recruiter.initLogoString();
		if (result.hasErrors()) {
			map.put("countries", countryRepository.findAll());
			map.put("industries", industryRepository.findAll());
			return "recruiter-profile-edit";
		} else {
			try {
				Recruiter updateRec = recruiterRepository.findByemail(recruiter.getEmail());
				updateRec.initLogoString();
				MultipartFile multipartFile = recruiter.getLogo();
				if (multipartFile != null) {
					// do whatever you want with the file
					if (multipartFile.getBytes().length > 0) {
						updateRec.setLogoData(multipartFile.getBytes());
					}
				}
				updateRec(updateRec, recruiter);
				recruiterRepository.save(updateRec);
				geoLocationUpdater.updateGeoLocationAsync(updateRec);
				return "recruiter-profile-edit";
			} catch (IOException e) {
				e.printStackTrace();
				map.put("countries", countryRepository.findAll());
				map.put("industries", industryRepository.findAll());
				ObjectError error = new ObjectError("recruiter",
						"Something gone wrong, try again. If error persists cantact support.");
				result.addError(error);
				return "recruiter-profile-edit";
			}
		}
	}

	private void updateRec(Recruiter updateRec, Recruiter recruiter) {
		updateRec.setFirstName(recruiter.getFirstName());
		updateRec.setLastName(recruiter.getLastName());
		updateRec.setCompanyName(recruiter.getCompanyName());
		updateRec.setEmail(recruiter.getEmail());
		updateRec.setPhone(recruiter.getPhone());
		updateRec.setIndustry(recruiter.getIndustry());
		updateRec.setActive(recruiter.isActive());
		updateRec.setLine1(recruiter.getLine1());
		updateRec.setLine2(recruiter.getLine2());
		updateRec.setCountry(recruiter.getCountry());
		updateRec.setState(recruiter.getState());
		updateRec.setCity(recruiter.getCity());
		updateRec.setPinCode(recruiter.getPinCode());
		updateRec.setEmailOnPrivateMessage(recruiter.isEmailOnPrivateMessage());
		updateRec.setEmailOnBeingFollowed(recruiter.isEmailOnBeingFollowed());
		updateRec.setUpgraded(recruiter.isUpgraded());
		updateRec.setFeatured(recruiter.isFeatured());
		updateRec.setStripeToken(recruiter.getStripeToken());
		updateRec.setStripeEmail(recruiter.getStripeEmail());
		updateRec.setLogo(recruiter.getLogo());
		updateRec.setLogoData(recruiter.getLogoData());
		updateRec.setLogoString(recruiter.getLogoString());
		updateRec.setDistance(recruiter.getDistance());
		updateRec.setStripeCustomerId(recruiter.getStripeCustomerId());
		updateRec.setFeaturedUntil(recruiter.getFeaturedUntil());
		updateRec.setEnterpriseUntil(recruiter.getEnterpriseUntil());
		updateRec.setCart(recruiter.getCart());
	}

	@RequestMapping(value = "/recruiter/auth/account", method = RequestMethod.GET)
	public String recruiterAccount(ModelMap map, HttpServletRequest req) {
		Recruiter recruiter = getRecruiter(req);
		RecruiterDummy recruiterDemo = new RecruiterDummy();
		recruiterDemo.setFirstName(recruiter.getFirstName());
		recruiterDemo.setLastName(recruiter.getLastName());
		recruiterDemo.setEmail(recruiter.getEmail());
		recruiterDemo.setUserName(recruiter.getUserName());
		map.addAttribute("recruiter", recruiterDemo);
		map.put("countries", countryRepository.findAll());
		map.put("industries", industryRepository.findAll());
		return "recruiter-account";
	}

	@RequestMapping(value = "/recruiter/auth/account", method = RequestMethod.POST)
	public String recruiterAccountPost(@Valid RecruiterDummy recruiter, BindingResult result, ModelMap map,
			HttpServletRequest req) {
		Recruiter old = getRecruiter(req);
		recruiter.setUserName(old.getUserName());
		map.put("recruiter", recruiter);
		if (result.hasErrors()) {
			map.put("countries", countryRepository.findAll());
			map.put("industries", industryRepository.findAll());
			return "recruiter-account";
		} else {
			try {
				Recruiter updateRec = recruiterRepository.findByemail(recruiter.getEmail());
				updateRec.initLogoString();
				MultipartFile multipartFile = recruiter.getLogo();
				if (multipartFile != null) {
					// do whatever you want with the file
					if (multipartFile.getBytes().length > 0) {
						updateRec.setLogoData(multipartFile.getBytes());
					}
				}
				updateRecAcc(updateRec, recruiter);
				recruiterRepository.save(updateRec);
				geoLocationUpdater.updateGeoLocationAsync(updateRec);
				return "recruiter-account";
			} catch (IOException e) {
				e.printStackTrace();
				map.put("countries", countryRepository.findAll());
				map.put("industries", industryRepository.findAll());
				ObjectError error = new ObjectError("recruiter",
						"Something gone wrong, try again. If error persists cantact support.");
				result.addError(error);
				return "recruiter-account";
			}
		}
	}

	private void updateRecAcc(Recruiter updateRec, RecruiterDummy recruiter) {
		updateRec.setFirstName(recruiter.getFirstName());
		updateRec.setLastName(recruiter.getLastName());
		updateRec.setEmail(recruiter.getEmail());
	}

	@RequestMapping(value = "/recruiter/register", method = RequestMethod.GET)
	public String recruiterregister(ModelMap map) {
		Iterable<Industry> industries = industryRepository.findAll();
		Iterable<Country> countries = countryRepository.findAll();
		map.addAttribute("industries", industries);
		map.addAttribute("countries", countries);
		map.addAttribute("recruiter", new Recruiter());
		return "recruiter-register";
	}

	@RequestMapping(value = "/recruiter/register", method = RequestMethod.POST)
	public String recruiterregister(@Valid Recruiter recruiter, BindingResult result, ModelMap map) {
		PasswordEncoder encoder = new BCryptPasswordEncoder();
		Recruiter findByuserName = recruiterRepository.findByuserName(recruiter.getUserName());
		if (findByuserName != null) {
			ObjectError error = new ObjectError("userName", "An account already exists for this username.");
			result.addError(error);
		}
		Recruiter recByEmail = recruiterRepository.findByemail(recruiter.getEmail());
		if (recByEmail != null) {
			ObjectError error = new ObjectError("email", "An account already exists for this email.");
			result.addError(error);
		}
		if (result.hasErrors() || (recByEmail != null) || (findByuserName != null)) {
			map.addAttribute("industries", industryRepository.findAll());
			map.addAttribute("countries", countryRepository.findAll());
			map.addAttribute("states", stateRepository.findAll());
			map.addAttribute("cities", cityRepository.findAll());
			return "recruiter-register";
		} else {
			try {
				MultipartFile multipartFile = recruiter.getLogo();
				if (multipartFile != null) {
					// do whatever you want with the file
					recruiter.setLogoData(multipartFile.getBytes());
				}
				String hashpw = encoder.encode(recruiter.getPassword());
				recruiter.setSalt(null);
				recruiter.setPassword(hashpw);

				User user = new User(recruiter.getUserName(), recruiter.getPassword(), true);
				UserRole userRole = new UserRole(user, ROLE_REC);
				userRepository.save(user);
				userRoleRepository.save(userRole);
				recruiterRepository.save(recruiter);
				geoLocationUpdater.updateGeoLocationAsync(recruiter);
				return "redirect:/login?signup";
			} catch (Exception e) {
				e.printStackTrace();
				map.addAttribute("industries", industryRepository.findAll());
				map.addAttribute("countries", countryRepository.findAll());
				map.addAttribute("states", stateRepository.findAll());
				map.addAttribute("cities", cityRepository.findAll());
				ObjectError error = new ObjectError("recruiter",
						"Something gone wrong, try again. If error persists cantact support.");
				result.addError(error);
				return "recruiter-register";
			}
		}
	}

	@RequestMapping("/recruiter/how-it-works")
	public String recruiterHowitworks() {
		return "recruiter-how-it-works";
	}

	@RequestMapping("/recruiter/auth/recruiter-profile")
	public String recruiterProfilePage(HttpServletRequest req, ModelMap map,
			@RequestParam(value = "id", required = false) Long id) {
		Recruiter recruiter;
		if (id != null && id > 0) {
			recruiter = recruiterRepository.findByid(id);
		} else {
			recruiter = getRecruiter(req);
		}
		recruiter.initLogoString();
		map.addAttribute("recruiter", recruiter);
		return "recruiter-profile";
	}

	@RequestMapping("/recruiter/recruiter-public-profile")
	public String recruiterAnanumousProfilePage(HttpServletRequest req, ModelMap map,
			@RequestParam(value = "id", required = false) String userName) {
		map.addAttribute("recruiter", new Recruiter());
		if (userName != null && !userName.isEmpty()) {
			Recruiter recruiter = recruiterRepository.findByuserName(userName);
			recruiter.initLogoString();
			map.addAttribute("recruiter", recruiter);
		}
		return "recruiter-public-profile";
	}

	@RequestMapping("/recruiter/passwordReset")
	public String passwordReset() {
		return "passwordReset";
	}

	@RequestMapping("/recruiter/changePassword")
	public String changePassword() {
		return "change-password";
	}

	@RequestMapping(" /recruiter/notifications")
	public String notifications() {
		return "notifications";
	}

	@RequestMapping("/recriter/user-profile-editprofile")
	public String userProfileEditprofile() {
		return "user-profile-editprofile";
	}

	@ResponseBody
	@RequestMapping("/recruiter/geocode")
	public String geoCode(HttpServletRequest req) {
		Recruiter recruiter = getRecruiter(req);
		geoLocationUpdater.updateGeoLocationAsync(recruiter);
		return "Requsted for processing. Will run in background!";
	}

	@ResponseBody
	@RequestMapping(value = "/recruiter/auth/add", method = RequestMethod.POST)
	public String follow(@RequestParam(value = "id", required = true) Long id, HttpServletRequest req) {
		Recruiter rec = getRecruiter(req);
		Cart cart = rec.getCart();
		if (cart == null) {
			cart = new Cart();
			cartRepository.save(cart);
			rec.setCart(cart);
			recruiterRepository.save(rec);
		} else {
			cart = cartRepository.findByid(cart.getId());
		}
		Jobseeker js = jobseekerRepository.findByid(id);
		cart.addItem(js);
		cartRepository.save(cart);
		return "Success";
	}

	@ResponseBody
	@RequestMapping(value = "/recruiter/auth/remove", method = RequestMethod.POST)
	public String unfollow(@RequestParam(value = "id", required = true) Long id, HttpServletRequest req) {
		Recruiter rec = getRecruiter(req);
		Cart cart = rec.getCart();
		cart = cartRepository.findByid(cart.getId());
		Jobseeker js = jobseekerRepository.findByid(id);
		cart.removeItem(js);
		cartRepository.save(cart);
		return "Success";
	}

	@ResponseBody
	@RequestMapping("/recruiter/auth/upload")
	public String uploadLogo(HttpServletRequest req) {
		Recruiter recruiter = getRecruiter(req);
		// TODO read the logo from request and set here
		byte[] logoImage = null;
		recruiter.setLogoData(logoImage);
		recruiterRepository.save(recruiter);
		return "success";
	}

}