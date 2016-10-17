package org.lightadmin.boot.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.lightadmin.boot.Constants;
import org.lightadmin.boot.dao.JobseekerDAO;
import org.lightadmin.boot.dao.RecruiterDao;
import org.lightadmin.boot.domain.Country;
import org.lightadmin.boot.domain.Industry;
import org.lightadmin.boot.domain.Jobseeker;
import org.lightadmin.boot.domain.JobseekerDummy;
import org.lightadmin.boot.domain.Recruiter;
import org.lightadmin.boot.domain.RecruiterDummy;
import org.lightadmin.boot.domain.User;
import org.lightadmin.boot.domain.UserRole;
import org.lightadmin.boot.repository.CityRepository;
import org.lightadmin.boot.repository.CountryRepository;
import org.lightadmin.boot.repository.EducationRepository;
import org.lightadmin.boot.repository.IndustryRepository;
import org.lightadmin.boot.repository.InternalMessageRepository;
import org.lightadmin.boot.repository.JobseekerRepository;
import org.lightadmin.boot.repository.RecruiterRepository;
import org.lightadmin.boot.repository.SeniorityRepository;
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
public class JobseekerController {

	private static final Logger logger = LoggerFactory.getLogger(JobseekerController.class);

	private static final String ROLE = "ROLE_JOBSEEKER";

	@Autowired
	private IndustryRepository industryRepository;

	@Autowired
	private CountryRepository countryRepository;

	@Autowired
	private StateRepository stateRepository;

	@Autowired
	private CityRepository cityRepository;

	@Autowired
	private JobseekerRepository jobseekerRepository;

	@Autowired
	private RecruiterRepository recruiterRepository;

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private UserRoleRepository userRoleRepository;

	@Autowired
	private SeniorityRepository seniorityRepository;

	@Autowired
	private EducationRepository educationRepository;

	@Autowired
	private GeoLocationUpdater geoLocationUpdater;

	@Autowired
	private RecruiterDao recruiterDao;

	@Autowired
	private InternalMessageRepository internalMessageRepository;

	@Autowired
	private JobseekerDAO jobseekerDao;

	@RequestMapping("/jobseeker/how-it-works")
	public String jshowitworks() {
		return "applicant-how-it-works";
	}

	@RequestMapping("/jobseeker/home")
	public String jobseekerhome() {
		return "jobseekerhome";
	}

	@RequestMapping(value = "/jobseeker/register", method = RequestMethod.GET)
	public String jobseekerRegister(ModelMap map) {
		Iterable<Industry> industries = industryRepository.findAll();
		Iterable<Country> countries = countryRepository.findAll();
		map.addAttribute("industries", industries);
		map.addAttribute("countries", countries);
		map.addAttribute("jobseeker", new Jobseeker());
		return "jobseeker-register";
	}

	@RequestMapping(value = "/jobseeker/register", method = RequestMethod.POST)
	public String recruiterregister(@Valid Jobseeker jobseeker, BindingResult result, ModelMap map) {
		PasswordEncoder encoder = new BCryptPasswordEncoder();
		Jobseeker findByuserName = jobseekerRepository.findByuserName(jobseeker.getUserName());
		if (findByuserName != null) {
			ObjectError error = new ObjectError("userName", "An account already exists for this username.");
			result.addError(error);
		}
		Jobseeker recByEmail = jobseekerRepository.findByemail(jobseeker.getEmail());
		if (recByEmail != null) {
			ObjectError error = new ObjectError("email", "An account already exists for this email.");
			result.addError(error);
		}
		if (result.hasErrors() || (recByEmail != null) || (findByuserName != null)) {
			map.addAttribute("industries", industryRepository.findAll());
			map.addAttribute("countries", countryRepository.findAll());
			map.addAttribute("states", stateRepository.findAll());
			map.addAttribute("cities", cityRepository.findAll());
			return "jobseeker-register";
		} else {
			try {
				MultipartFile multipartFile = jobseeker.getPic();
				if (multipartFile != null) {
					// do whatever you want with the file
					jobseeker.setPicData(multipartFile.getBytes());
				}

				multipartFile = jobseeker.getResume();
				if (multipartFile != null) {
					// do whatever you want with the file
					jobseeker.setResumeData(multipartFile.getBytes());
					jobseeker.setResumeFileName(multipartFile.getOriginalFilename());
				}

				String hashpw = encoder.encode(jobseeker.getPassword());
				jobseeker.setSalt(null);
				jobseeker.setPassword(hashpw);

				User user = new User(jobseeker.getUserName(), jobseeker.getPassword(), true);
				UserRole userRole = new UserRole(user, ROLE);
				userRepository.save(user);
				userRoleRepository.save(userRole);
				jobseekerRepository.save(jobseeker);
				geoLocationUpdater.updateGeoLocationAsync(jobseeker);
				return "redirect:/login?signup";
			} catch (IOException e) {
				e.printStackTrace();
				map.addAttribute("industries", industryRepository.findAll());
				map.addAttribute("countries", countryRepository.findAll());
				map.addAttribute("states", stateRepository.findAll());
				map.addAttribute("cities", cityRepository.findAll());
				ObjectError error = new ObjectError("jobseeker",
						"Something gone wrong, try again. If error persists cantact support.");
				result.addError(error);
				return "jobseeker-register";

			}
		}
	}

	@RequestMapping(value = "/jobseeker/auth/account", method = RequestMethod.GET)
	public String jobseekerAccount(ModelMap map, HttpServletRequest request) {
		Jobseeker jobseeker = getJobseeker(request);
		JobseekerDummy jobseekerDummy = new JobseekerDummy();
		jobseekerDummy.setFirstName(jobseeker.getFirstName());
		jobseekerDummy.setLastName(jobseeker.getLastName());
		jobseekerDummy.setEmail(jobseeker.getEmail());
		jobseekerDummy.setUserName(jobseeker.getUserName());
		map.addAttribute("jobseeker", jobseekerDummy);
		map.put("countries", countryRepository.findAll());
		map.put("industries", industryRepository.findAll());
		return "jobseeker-account";
	}

	@RequestMapping(value = "/jobseeker/auth/account", method = RequestMethod.POST)
	public String jobseekerAccountPost(@Valid JobseekerDummy jobseeker, BindingResult result, ModelMap map ,HttpServletRequest req) {
		Jobseeker old = getJobseeker(req);
		jobseeker.setUserName(old.getUserName());
		map.put("jobseeker", jobseeker);
		if (result.hasErrors()) {
			map.put("countries", countryRepository.findAll());
			map.put("industries", industryRepository.findAll());
			return "jobseeker-account";
		} else {
			try {
				Jobseeker updateJS = jobseekerRepository.findByemail(jobseeker.getEmail());
				updateJS.initPicString();
				MultipartFile multipartFile = jobseeker.getPic();
				if (multipartFile != null) {
					// do whatever you want with the file
					if (multipartFile.getBytes().length > 0) {
						updateJS.setPicData(multipartFile.getBytes());
					}
				}
				updateRecAcc(updateJS, jobseeker);
				jobseekerRepository.save(updateJS);
				geoLocationUpdater.updateGeoLocationAsync(updateJS);
				return "jobseeker-account";
			} catch (IOException e) {
				e.printStackTrace();
				map.put("countries", countryRepository.findAll());
				map.put("industries", industryRepository.findAll());
				ObjectError error = new ObjectError("recruiter",
						"Something gone wrong, try again. If error persists cantact support.");
				result.addError(error);
				return "jobseeker-account";
			}
		}
	}
	
	private void updateRecAcc(Jobseeker updateJS, JobseekerDummy jobseeker) {
		updateJS.setFirstName(jobseeker.getFirstName());
		updateJS.setLastName(jobseeker.getLastName());
		updateJS.setEmail(jobseeker.getEmail());
	}

	@RequestMapping("/jobseeker/search-agenicies")
	public String searchAgenicies(ModelMap map) {
		Iterable<Industry> industries = industryRepository.findAll();
		map.addAttribute("industries", industries);
		map.addAttribute("key", Constants.GOOGLE_MAP_BROWSER_KEY);
		return "search-agenicies";
	}

	@ResponseBody
	@RequestMapping("/jobseeker/bydistance")
	public List<Recruiter> findRecruiterByDistance(HttpServletRequest req,
			@RequestParam(value = "lat", required = true) Double lat,
			@RequestParam(value = "lng", required = true) Double lng,
			@RequestParam(value = "dist", required = true) Double distance,
			@RequestParam(value = "ind", required = true) Long ind) {
		List<Recruiter> findByDistance = recruiterDao.findByDistance(lat, lng, distance, ind);
		logger.info("Size: " + findByDistance.size());
		return findByDistance;
	}

	@ResponseBody
	@RequestMapping("/recruiter/bydistance")
	public List<Jobseeker> findJobseekerByDistance(HttpServletRequest req,
			@RequestParam(value = "lat", required = true) Double lat,
			@RequestParam(value = "lng", required = true) Double lng,
			@RequestParam(value = "dist", required = true) Double distance,
			@RequestParam(value = "ind", required = true) Long ind) {
		List<Jobseeker> findByDistance = jobseekerDao.findByDistance(lat, lng, distance, ind);
		logger.info("Size: " + findByDistance.size());
		return findByDistance;
	}

	@RequestMapping("/jobseeker/changePassword")
	public String changePassword() {
		return "change-password";
	}

	@RequestMapping("/jobseeker/notifications")
	public String notifications() {
		return "notifications";
	}
	
	@ResponseBody
	@RequestMapping(value = "/jobseeker/auth/follow" , method = RequestMethod.POST)
	public String follow(@RequestParam(value = "userName", required = true) String userName, HttpServletRequest req ) {
		Jobseeker jobseeker = getJobseeker(req);
		Recruiter rec = recruiterRepository.findByuserName(userName);
		rec.addFollower(jobseeker);
		recruiterRepository.save(rec);
		return "Success";
	}
	
	@ResponseBody
	@RequestMapping(value = "/jobseeker/auth/unfollow" , method = RequestMethod.POST)
	public String unfollow(@RequestParam(value = "userName", required = true) String userName, HttpServletRequest req ) {
		Jobseeker jobseeker = getJobseeker(req);
		Recruiter rec = recruiterRepository.findByuserName(userName);
		rec.removeFollower(jobseeker);
		recruiterRepository.save(rec);
		return "Success";
	}

	@RequestMapping(value = "/jobseeker/auth/jobseeker-profile-edit", method = RequestMethod.GET)
	public String jobseekerProfileEdit(ModelMap map, HttpServletRequest req) {
		map.put("jobseeker", getJobseeker(req));
		map.put("countries", countryRepository.findAll());
		map.put("industries", industryRepository.findAll());
		map.put("seniorities", seniorityRepository.findAll());
		map.put("educations", educationRepository.findAll());
		return "jobseeker-profile-edit";
	}

	@RequestMapping(value = "/jobseeker/auth/jobseeker-profile-edit", method = RequestMethod.POST)
	public String jobseekerProfileEditPost(@Valid Jobseeker jobseeker, BindingResult result, ModelMap map) {
		map.addAttribute("jobseeker",jobseeker);
		if (result.hasErrors()) {
			map.put("countries", countryRepository.findAll());
			map.put("industries", industryRepository.findAll());
			map.put("seniorities", seniorityRepository.findAll());
			map.put("educations", educationRepository.findAll());
			return "jobseeker-profile-edit";
		} else {
			try {
				Jobseeker updateJS = jobseekerRepository.findByemail(jobseeker.getEmail());
				updateJS.initPicString();
				MultipartFile multipartFile = jobseeker.getPic();
				if (multipartFile != null) {
					// do whatever you want with the file
					if (multipartFile.getBytes().length > 0) {
						updateJS.setPicData(multipartFile.getBytes());
					}
				}

				multipartFile = jobseeker.getResume();
				if (multipartFile != null) {
					// do whatever you want with the file
					if (multipartFile.getBytes().length > 0) {
						updateJS.setResumeData(multipartFile.getBytes());
					}
					updateJS.setResumeFileName(multipartFile.getOriginalFilename());
				}
				updateJS(updateJS, jobseeker);
				jobseekerRepository.save(updateJS);
				geoLocationUpdater.updateGeoLocationAsync(updateJS);
				map.put("countries", countryRepository.findAll());
				map.put("industries", industryRepository.findAll());
				map.put("seniorities", seniorityRepository.findAll());
				map.put("educations", educationRepository.findAll());
				return "jobseeker-profile-edit";
			} catch (IOException e) {
				e.printStackTrace();
				map.put("countries", countryRepository.findAll());
				map.put("industries", industryRepository.findAll());
				map.put("seniorities", seniorityRepository.findAll());
				map.put("educations", educationRepository.findAll());
				ObjectError error = new ObjectError("jobseeker",
						"Something gone wrong, try again. If error persists cantact support.");
				result.addError(error);
				return "jobseeker-profile-edit";

			}
		}
	}

	private void updateJS(Jobseeker updateJS, Jobseeker jobseeker ) {
		updateJS.setFirstName(jobseeker.getFirstName());
		updateJS.setLastName(jobseeker.getLastName());
		updateJS.setEmail(jobseeker.getEmail());
		updateJS.setCity(jobseeker.getCity());
		updateJS.setCountry(jobseeker.getCountry());
		updateJS.setEducation(jobseeker.getEducation());
		updateJS.setPhone(jobseeker.getPhone());
		updateJS.setDistance(jobseeker.getDistance());
		updateJS.setStartWorkingDate(jobseeker.getStartWorkingDate());
		updateJS.setIndustry(jobseeker.getIndustry());
		updateJS.setLine1(jobseeker.getLine1());
		updateJS.setLine2(jobseeker.getLine2());
		updateJS.setState(jobseeker.getState());
		updateJS.setPinCode(jobseeker.getPinCode());
		updateJS.setStatus(jobseeker.getStatus());
		updateJS.setExpectedJoiningDate(jobseeker.getExpectedJoiningDate());
		updateJS.setExperienceInTheIndustry(jobseeker.getExperienceInTheIndustry());
		updateJS.setSeniority(jobseeker.getSeniority());
		updateJS.setEducation(jobseeker.getEducation());
		updateJS.setCurrentPositionHeld(jobseeker.getCurrentPositionHeld());
		updateJS.setPic(jobseeker.getPic());
		updateJS.setPicData(jobseeker.getPicData());
		updateJS.setPicString(jobseeker.getPicString());
		updateJS.setResume(jobseeker.getResume());
		updateJS.setResumeData(jobseeker.getResumeData());
		updateJS.setResumeFileName(jobseeker.getResumeFileName());
		updateJS.setBio(jobseeker.getBio());
		updateJS.setActive(jobseeker.isActive());
		updateJS.setEmailOnBeingFollowed(jobseeker.isEmailOnBeingFollowed());
		updateJS.setEmailOnPrivateMessage(jobseeker.isEmailOnPrivateMessage());
	}

	@RequestMapping("/jobseeker/jobseeker-profile")
	public String jobseekerProfile(ModelMap map, HttpServletRequest req) {
		map.put("jobseeker", getJobseeker(req));
		return "jobseeker-profile";
	}

	private Jobseeker getJobseeker(HttpServletRequest req) {
		return (Jobseeker) req.getSession().getAttribute(RSHAuthenticationSuccessHandler.USER);
	}

	@ResponseBody
	@RequestMapping("/jobseeker/geocode")
	public String geoCode(HttpServletRequest req) {
		Jobseeker recruiter = getJobseeker(req);
		geoLocationUpdater.updateGeoLocationAsync(recruiter);
		return "Requsted for processing. Will run in background!";
	}

	@ResponseBody
	@RequestMapping("/jobseeker/auth/upload")
	public String uploadLogo(HttpServletRequest req) {
		Jobseeker jobseeker = getJobseeker(req);
		// TODO read the logo from request and set here
		byte[] logoImage = null;
		jobseeker.setPicData(logoImage);
		jobseekerRepository.save(jobseeker);
		return "success";
	}

}