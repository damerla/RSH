package org.lightadmin.boot.web;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.javatuples.Quartet;
import org.lightadmin.boot.Constants;
import org.lightadmin.boot.domain.Cart;
import org.lightadmin.boot.domain.Industry;
import org.lightadmin.boot.domain.Jobseeker;
import org.lightadmin.boot.domain.Recruiter;
import org.lightadmin.boot.repository.CartRepository;
import org.lightadmin.boot.repository.IndustryRepository;
import org.lightadmin.boot.repository.JobseekerRepository;
import org.lightadmin.boot.repository.RecruiterRepository;
import org.lightadmin.boot.security.RSHAuthenticationSuccessHandler;
import org.lightadmin.boot.service.EmailSender;
import org.lightadmin.boot.vo.PayementData;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.JsonSyntaxException;
import com.stripe.Stripe;
import com.stripe.exception.APIConnectionException;
import com.stripe.exception.APIException;
import com.stripe.exception.AuthenticationException;
import com.stripe.exception.CardException;
import com.stripe.exception.InvalidRequestException;
import com.stripe.model.Charge;
import com.stripe.model.Customer;
import com.stripe.model.Event;
import com.stripe.model.Invoice;
import com.stripe.model.Subscription;
import com.stripe.net.APIResource;

@Controller
public class PaymentController {
	private static final Logger logger = LoggerFactory.getLogger(PaymentController.class);

	@Autowired
	private RecruiterRepository recruiterRepository;

	@Autowired
	private EmailSender emailSender;

	@Autowired
	private IndustryRepository industryRepository;

	@Autowired
	private JobseekerRepository jobseekerRepository;

	@Autowired
	private CartRepository cartRepository;

	@RequestMapping(value = "/recruiter/api/webhook", method = RequestMethod.POST)
	public String webhook(HttpServletRequest request, HttpServletResponse response) {
		// Retrieve the request's body and parse it as JSON
		try {
			Event event = APIResource.GSON.fromJson(IOUtils.toString(request.getInputStream(), "UTF-8"), Event.class);
			if ("invoice.payment_failed".equals(event.getType())) {
				Invoice invoice = (Invoice) event.getData().getObject();
				String customer = invoice.getCustomer();
				String subscription = invoice.getSubscription();
				updateSubscriptionFailed(customer, subscription);
			}
			if ("invoice.payment_succeeded".equals(event.getType())) {
				Invoice invoice = (Invoice) event.getData().getObject();
				String customer = invoice.getCustomer();
				String subscription = invoice.getSubscription();
				updateSubscriptionSucceeded(customer, subscription);
			}
			logger.info("EVENT ########@########\n" + event.toString());
			// TODO update the subscriptions

		} catch (JsonSyntaxException | IOException e) {
			e.printStackTrace();
		}

		response.setStatus(200);
		return "";
	}

	private void updateSubscriptionSucceeded(String customer, String subscription) {
		// Send email to admin and customer. And extend the date
		Stripe.apiKey = Constants.STRIPE_SERVER_KEY;
		try {
			Subscription sub = Subscription.retrieve(subscription);
			if (Constants.STRIPE_PLAN_ENTERPRISE.equals(sub.getPlan().getId())) {
				notifyAndUpdateEnterpriseRenewed(customer, sub);
			}
			if (Constants.STRIPE_PLAN_FEATURED.equals(sub.getPlan().getId())) {
				notifyAndUpdateFeaturedRenewed(customer, sub);
			}
		} catch (AuthenticationException | InvalidRequestException | APIConnectionException | CardException
				| APIException e) {
			logger.error("Retreiving subcription failed: " + subscription);
		}

	}

	private void notifyAndUpdateFeaturedRenewed(String customer, Subscription sub) {
		Recruiter rec = recruiterRepository.findBystripeCustomerId(customer);
		rec.setFeatured(true);
		rec.setFeaturedUntil(sub.getCurrentPeriodEnd());

		Map<String, Object> adminData = new HashMap<>();
		adminData.put("name", "Admin");
		emailSender.sendEmail(Constants.EMAIL_T_A_FEATURED_RENEWED, adminData, Constants.ADMIN_EMAIL);

		HashMap<String, Object> data = new HashMap<>();
		data.put("name", rec.getFirstName());
		emailSender.sendEmail(Constants.EMAIL_T_C_FEATURED_RENEWED, data, rec.getEmail(), rec.getStripeEmail());
	}

	private void notifyAndUpdateEnterpriseRenewed(String customer, Subscription sub) {
		Recruiter rec = recruiterRepository.findBystripeCustomerId(customer);
		rec.setUpgraded(true);
		rec.setEnterpriseUntil(sub.getCurrentPeriodEnd());

		Map<String, Object> adminData = new HashMap<>();
		adminData.put("name", "Admin");
		emailSender.sendEmail(Constants.EMAIL_T_A_UPGRADED_RENEWED, adminData, Constants.ADMIN_EMAIL);

		HashMap<String, Object> data = new HashMap<>();
		data.put("name", rec.getFirstName());
		emailSender.sendEmail(Constants.EMAIL_T_C_UPGRADED_RENEWED, data, rec.getEmail(), rec.getStripeEmail());
	}

	private void updateSubscriptionFailed(String customer, String subscription) {
		// Send email to admin and customer. And extend the date
		Stripe.apiKey = Constants.STRIPE_SERVER_KEY;
		try {
			Subscription sub = Subscription.retrieve(subscription);
			if (Constants.STRIPE_PLAN_ENTERPRISE.equals(sub.getPlan().getId())) {
				notifyAndUpdateEnterpriseFailed(customer, sub);
			}
			if (Constants.STRIPE_PLAN_FEATURED.equals(sub.getPlan().getId())) {
				notifyAndUpdateFeaturedFailed(customer, sub);
			}
		} catch (AuthenticationException | InvalidRequestException | APIConnectionException | CardException
				| APIException e) {
			logger.error("Retreiving subcription failed: " + subscription);
		}

	}

	private void notifyAndUpdateFeaturedFailed(String customer, Subscription sub) {
		Recruiter rec = recruiterRepository.findBystripeCustomerId(customer);
		rec.setFeatured(false);

		Map<String, Object> adminData = new HashMap<>();
		adminData.put("name", "Admin");
		emailSender.sendEmail(Constants.EMAIL_T_A_FEATURED_FAILED, adminData, Constants.ADMIN_EMAIL);

		HashMap<String, Object> data = new HashMap<>();
		data.put("name", rec.getFirstName());
		emailSender.sendEmail(Constants.EMAIL_T_C_FEATURED_FAILED, data, rec.getEmail(), rec.getStripeEmail());
	}

	private void notifyAndUpdateEnterpriseFailed(String customer, Subscription sub) {
		Recruiter rec = recruiterRepository.findBystripeCustomerId(customer);
		rec.setUpgraded(false);

		Map<String, Object> adminData = new HashMap<>();
		adminData.put("name", "Admin");
		emailSender.sendEmail(Constants.EMAIL_T_A_UPGRADED_FAILED, adminData, Constants.ADMIN_EMAIL);

		HashMap<String, Object> data = new HashMap<>();
		data.put("name", rec.getFirstName());
		emailSender.sendEmail(Constants.EMAIL_T_C_UPGRADED_FAILED, data, rec.getEmail(), rec.getStripeEmail());
	}

	@RequestMapping(value = "/recruiter/api/upgrade")
	public String upgrade(HttpServletRequest req) {
		String stripeToken = req.getParameter("stripeToken");
		String stripeEmail = req.getParameter("stripeEmail");
		Recruiter recruiter = getRecruiter(req);

		try {

			Stripe.apiKey = Constants.STRIPE_SERVER_KEY;

			if (!recruiter.isUpgraded()) {
				String customerid = recruiter.getStripeCustomerId();
				if (customerid != null) {
					if (stripeToken != null) {
						// Old Customer
						recruiter.setStripeToken(stripeToken);
						recruiter.setStripeEmail(stripeEmail);
						Map<String, Object> customerParams = new HashMap<String, Object>();
						customerParams.put("source", stripeToken);
						customerParams.put("email", recruiter.getEmail());
						Customer customer = Customer.retrieve(customerid);
						customer.update(customerParams);
					}
				} else {
					// New Customer
					Map<String, Object> customerParams = new HashMap<String, Object>();
					customerParams.put("source", stripeToken);
					customerParams.put("email", recruiter.getEmail());

					Customer customer = Customer.create(customerParams);
					customerid = customer.getId();

					// Save the additional data
					recruiter.setStripeCustomerId(customer.getId());
					recruiter.setStripeToken(stripeToken);
					recruiter.setStripeEmail(stripeEmail);
				}
				logger.info("Upgrading: " + recruiter.getUserName() + " Stripe customerid: " + customerid);
				Map<String, Object> subscriptionParams = new HashMap<String, Object>();
				subscriptionParams.put("customer", customerid);
				subscriptionParams.put("plan", Constants.STRIPE_PLAN_ENTERPRISE);
				Subscription sub = Subscription.create(subscriptionParams);

				recruiter.setEnterpriseUntil(sub.getCurrentPeriodEnd());
				recruiter.setUpgraded(true);
				recruiterRepository.save(recruiter);
				// notifyNewEnterpriseSubcription(recruiter);
			}

		} catch (AuthenticationException | InvalidRequestException | APIConnectionException | CardException
				| APIException e) {
			e.printStackTrace();
			// Payment failed
			req.setAttribute("error", "Payement Failed Please try again");
			return "payment";
		}

		return "redirect:/recruiter/auth/search-applicants";
	}

	private void notifyNewEnterpriseSubcription(Recruiter recruiter) {
		Map<String, Object> adminData = new HashMap<>();
		adminData.put("name", "Admin");
		emailSender.sendEmail(Constants.EMAIL_T_A_ENTERPRISE_SUBSCRIPTION, adminData, Constants.ADMIN_EMAIL);

		HashMap<String, Object> data = new HashMap<>();
		data.put("name", recruiter.getFirstName());
		emailSender.sendEmail(Constants.EMAIL_T_C_ENTERPRISE_SUBSCRIPTION, data, recruiter.getEmail(),
				recruiter.getStripeEmail());

	}

	@RequestMapping(value = "/recruiter/api/feature")
	public String feature(HttpServletRequest req) {
		String stripeToken = req.getParameter("stripeToken");
		String stripeEmail = req.getParameter("stripeEmail");
		Recruiter recruiter = getRecruiter(req);

		try {

			Stripe.apiKey = Constants.STRIPE_SERVER_KEY;

			if (!recruiter.isFeatured()) {
				String customerid = recruiter.getStripeCustomerId();
				if (customerid != null) {
					if ((stripeToken != null)) {
						// Old Customer
						recruiter.setStripeToken(stripeToken);
						recruiter.setStripeEmail(stripeEmail);
						Map<String, Object> customerParams = new HashMap<String, Object>();
						customerParams.put("source", stripeToken);
						customerParams.put("email", recruiter.getEmail());
						Customer customer = Customer.retrieve(customerid);
						customer.update(customerParams);
					}
				} else {
					// New Customer
					Map<String, Object> customerParams = new HashMap<String, Object>();
					customerParams.put("source", stripeToken);
					customerParams.put("email", recruiter.getEmail());

					Customer customer = Customer.create(customerParams);
					customerid = customer.getId();

					// Save the additional data
					recruiter.setStripeCustomerId(customer.getId());
					recruiter.setStripeToken(stripeToken);
					recruiter.setStripeEmail(stripeEmail);
				}
				logger.info("Featuring: " + recruiter.getUserName() + " Stripe customerid: " + customerid);
				Map<String, Object> subscriptionParams = new HashMap<String, Object>();
				subscriptionParams.put("customer", customerid);
				subscriptionParams.put("plan", Constants.STRIPE_PLAN_FEATURED);
				Subscription sub = Subscription.create(subscriptionParams);

				recruiter.setFeaturedUntil(sub.getCurrentPeriodEnd());
				recruiter.setFeatured(true);
				recruiterRepository.save(recruiter);
				// notifyNewFeaturedSubcription(recruiter);
			}

		} catch (AuthenticationException | InvalidRequestException | APIConnectionException | CardException
				| APIException e) {
			e.printStackTrace();
			// Payment failed
			req.setAttribute("error", "Payement Failed Please try again");
			return "payment";
		}

		return "redirect:/featuredRecruiters";
	}

	private void notifyNewFeaturedSubcription(Recruiter recruiter) {

		Map<String, Object> adminData = new HashMap<>();
		adminData.put("name", "Admin");
		emailSender.sendEmail(Constants.EMAIL_T_A_FEATURED_SUBSCRIPTION, adminData, Constants.ADMIN_EMAIL);

		HashMap<String, Object> data = new HashMap<>();
		data.put("name", recruiter.getFirstName());
		emailSender.sendEmail(Constants.EMAIL_T_C_FEATURED_SUBSCRIPTION, data, recruiter.getEmail(),
				recruiter.getStripeEmail());

	}

	@RequestMapping("/recruiter/auth/search-applicants")
	public String seachApplicant(HttpServletRequest req, ModelMap map) {
		Recruiter recruiter = getRecruiter(req);
		Iterable<Industry> industries = industryRepository.findAll();
		map.addAttribute("industries", industries);
		map.addAttribute("key", Constants.GOOGLE_MAP_BROWSER_KEY);
		if (!recruiter.isUpgraded()) {
			return "redirect:/recruiter/auth/landing";
		}
		return "search-applicants";
	}

	@RequestMapping(value = "/recruiter/api/buy-leads")
	public String buyleadsComplete(HttpServletRequest req) {
		String stripeToken = req.getParameter("stripeToken");
		String stripeEmail = req.getParameter("stripeEmail");
		Recruiter recruiter = getRecruiter(req);

		try {

			Stripe.apiKey = Constants.STRIPE_SERVER_KEY;

			String customerid = recruiter.getStripeCustomerId();
			if (customerid != null) {
				if ((stripeToken != null)) {
					// Old Customer
					recruiter.setStripeToken(stripeToken);
					recruiter.setStripeEmail(stripeEmail);
					Map<String, Object> customerParams = new HashMap<String, Object>();
					customerParams.put("source", stripeToken);
					customerParams.put("email", recruiter.getEmail());
					Customer customer = Customer.retrieve(customerid);
					customer.update(customerParams);
				}
			} else {
				// New Customer
				Map<String, Object> customerParams = new HashMap<String, Object>();
				customerParams.put("source", stripeToken);
				customerParams.put("email", recruiter.getEmail());

				Customer customer = Customer.create(customerParams);
				customerid = customer.getId();

				// Save the additional data
				recruiter.setStripeCustomerId(customer.getId());
				recruiter.setStripeToken(stripeToken);
				recruiter.setStripeEmail(stripeEmail);
			}
			logger.info("Featuring: " + recruiter.getUserName() + " Stripe customerid: " + customerid);

			Recruiter fresh = recruiterRepository.findByuserName(recruiter.getUserName());
			req.setAttribute("jobseekers", fresh.getFollowers());
			Cart cart = cartRepository.findByid(fresh.getCart().getId());

			Map<String, Object> chargeMap = new HashMap<String, Object>();
			chargeMap.put("amount", cart.getJobseekers().size() * 5000);
			chargeMap.put("currency", "usd");
			chargeMap.put("customer", customerid);
			Charge create = Charge.create(chargeMap);
			logger.info(create.toString());
			// TODO give access to contacts for 30 days
			// notifyNewFeaturedSubcription(recruiter);

		} catch (AuthenticationException | InvalidRequestException | APIConnectionException | CardException
				| APIException e) {
			e.printStackTrace();
			// Payment failed
			req.setAttribute("error", "Payement Failed Please try again");
			return "payment";
		}

		return "redirect:/featuredRecruiters";
	}

	@RequestMapping("/recruiter/auth/payment")
	public String payment(ModelMap map, HttpServletRequest req,
			@RequestParam(value = "type", required = false) String type) {
		Recruiter recruiter = getRecruiter(req);
		if (recruiter == null) {
			return "redirect:/login";
		}
		Quartet<String, String, String, String[]> quartet = getPostURL(type);
		if (recruiter.getStripeToken() != null) {
			map.addAttribute("have_card", true);
		} else {
			map.addAttribute("have_card", false);
		}
		PayementData data = new PayementData();

		data.setPostUrl((String) quartet.getValue(0));
		data.setTitle((String) quartet.getValue(1));
		data.setPricing((String) quartet.getValue(2));
		data.setAdvs((String[]) quartet.getValue(3));
		data.setReferer(req.getHeader("referer"));
		req.getSession().setAttribute("pd", data);
		return "payment";
	}

	private Quartet<String, String, String, String[]> getPostURL(String type) {
		if ("346hjErnhsdafsdu9Judf".equals(type)) {
			// Enterprise
			return new Quartet<String, String, String, String[]>("/recruiter/api/upgrade", "Upgrade to Enterprise!",
					"$150 per month!",
					new String[] { "View Unlimited Leads", "Ultimate Search Bar", "View Full Lead Information" });
		}
		if ("346hjE77d45afsdu9Judf".equals(type)) {
			// Feature
			return new Quartet<String, String, String, String[]>("/recruiter/api/feature", "Get Featured!",
					"$70 per month!", new String[] { "Get More Visibility", "Be a Trusted Brand", "Get More Leads" });
		}
		if ("346hjdsaewKcdjsdu9Judf".equals(type)) {
			// Checkout of buy lead
			return new Quartet<String, String, String, String[]>("/recruiter/api/buy-leads", "Buy premium leads!",
					"$70 per month!", new String[] { "Full access for 30 days!", "Veiew unlimited no of times!"});
		}
		return null;
	}

	@RequestMapping("/recruiter/auth/jobseeker-profile")
	public String jobseekerProfile(ModelMap map, HttpServletRequest req,
			@RequestParam(value = "id", required = false) String userName) {
		Recruiter recruiter = getRecruiter(req);
		if (!recruiter.isUpgraded()) {
			return "redirect:/recruiter/auth/landing";
		}
		if (userName != null && !userName.isEmpty()) {
			Jobseeker jobseeker = jobseekerRepository.findByuserName(userName);
			jobseeker.initPicString();
			map.addAttribute("jobseeker", jobseeker);
		}

		return "jobseeker-profile";
	}

	@RequestMapping("/recruiter/auth/full-view/jobseeker")
	public String fullViewJobseeker(ModelMap map, HttpServletRequest req,
			@RequestParam(value = "id", required = false) String userName) {
		Recruiter recruiter = getRecruiter(req);
		if (!recruiter.isUpgraded()) {
			return "redirect:/recruiter/auth/landing";
		}
		if (userName != null && !userName.isEmpty()) {
			Jobseeker jobseeker = jobseekerRepository.findByuserName(userName);
			jobseeker.initPicString();
			map.addAttribute("jobseeker", jobseeker);
		}

		return "full-view-jobseeker";
	}

	private Recruiter getRecruiter(HttpServletRequest req) {
		return (Recruiter) req.getSession().getAttribute(RSHAuthenticationSuccessHandler.USER);
	}
}
