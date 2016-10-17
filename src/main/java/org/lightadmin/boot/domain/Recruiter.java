package org.lightadmin.boot.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.Optional;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Transient;
import javax.validation.constraints.Pattern;

import org.aspectj.weaver.patterns.IfPointcut.IfFalsePointcut;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

@Entity
public class Recruiter implements Serializable {
	private static final long serialVersionUID = 1L;

	private static final String EMAIL_PATTERN = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
			+ "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
	private static final String ID_PATTERN = "[0-9]+";
	private static final String STRING_PATTERN = "[a-zA-Z]+";
	private static final String MOBILE_PATTERN = "[0-9]{10}";

	@Id
	@GeneratedValue
	private Long id;
	@Column
	private String firstName;
	@Column
	private String lastName;
	@Column(unique = true)
	@NotEmpty(message = "Company Name should not be empty !")
	private String companyName;
	@Column
	@NotEmpty(message = "Username should not be empty !")
	private String userName;

	@Column(unique = true)
	@Email(message = "Invalid E-mail")
	@NotEmpty(message = "Email should not be empty !")
	private String email;
	private String phone;

	@ManyToOne
	private Industry industry;
	@Column
	// @Pattern(regexp = "((?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{6,20})", message =
	// "Password must contain atleast one digit, one uppercase and one lowercase
	// letter. Should n't be less than 6 characters.")
	private String password;
	@Column
	private boolean active = true;
	private String line1;
	private String line2;

	@ManyToOne
	private Country country;
	@ManyToOne
	private State state;
	@ManyToOne
	private City city;
	@Pattern(regexp = "[0-9]+", message = "Wrong Pincode!")
	private String pinCode;
	// Notification settings
	private boolean emailOnPrivateMessage = true;
	private boolean emailOnBeingFollowed = true;
	private boolean upgraded;
	private boolean featured;
	private String salt;

	// private String logoPath;

	private String stripeToken;
	private String stripeEmail;

	@ManyToMany(cascade = CascadeType.ALL)
	@JoinTable(name = "recruiter_followers", joinColumns = {
			@JoinColumn(name = "recruiter_id") }, inverseJoinColumns = { @JoinColumn(name = "jobseeker_id") })
	private List<Jobseeker> followers = new ArrayList<Jobseeker>();

	@ManyToMany(cascade = CascadeType.ALL)
	@JoinTable(name = "recruiter_purchased", joinColumns = {
			@JoinColumn(name = "recruiter_id") }, inverseJoinColumns = { @JoinColumn(name = "jobseeker_id") })
	private List<Jobseeker> purchased = new ArrayList<Jobseeker>();

	@Transient
	private MultipartFile logo;

	@Lob
	private byte[] logoData;

	@Transient
	private String logoString;

	private double lat;
	private double lng;

	@Transient
	private double distance;

	private String stripeCustomerId;

	private Long featuredUntil;

	private Long enterpriseUntil;

	@Column(columnDefinition = "LONGBLOB")
	private Cart cart;
	
	public Recruiter() {

	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public boolean isFeatured() {
		return featured;
	}

	public void setFeatured(boolean isFeatured) {
		this.featured = isFeatured;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Industry getIndustry() {
		return industry;
	}

	public void setIndustry(Industry industry) {
		this.industry = industry;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public boolean isEmailOnPrivateMessage() {
		return emailOnPrivateMessage;
	}

	public void setEmailOnPrivateMessage(boolean emailOnPrivateMessage) {
		this.emailOnPrivateMessage = emailOnPrivateMessage;
	}

	public boolean isEmailOnBeingFollowed() {
		return emailOnBeingFollowed;
	}

	public void setEmailOnBeingFollowed(boolean emailOnBeingFollowed) {
		this.emailOnBeingFollowed = emailOnBeingFollowed;
	}

	public List<Jobseeker> getFollowers() {
		return followers;
	}

	public void setFollowers(List<Jobseeker> followers) {
		this.followers = followers;
	}

	public void addFollower(Jobseeker jobseeker) {

		Optional<Jobseeker> findFirst = followers.stream().filter(j -> j.getId() == jobseeker.getId()).findFirst();
		if (!findFirst.isPresent()) {
			followers.add(jobseeker);
		}
	}

	public List<Jobseeker> getPurchased() {
		return purchased;
	}

	public void setPurchased(List<Jobseeker> purchased) {
		this.purchased = purchased;
	}

	public void Purchased(Jobseeker jobseeker) {
		purchased.add(jobseeker);
	}

	/*
	 * public String getLogoPath() { return logoPath; }
	 * 
	 * public void setLogoPath(String logoPath) { this.logoPath = logoPath; }
	 */

	public String getLine1() {
		return line1;
	}

	public void setLine1(String line1) {
		this.line1 = line1;
	}

	public String getLine2() {
		return line2;
	}

	public void setLine2(String line2) {
		this.line2 = line2;
	}

	public String getPinCode() {
		return pinCode;
	}

	public void setPinCode(String pinCode) {
		this.pinCode = pinCode;
	}

	public String getSalt() {
		return salt;
	}

	public void setSalt(String salt) {
		this.salt = salt;
	}

	public boolean isUpgraded() {
		return upgraded;
	}

	public void setUpgraded(boolean upgraded) {
		this.upgraded = upgraded;
	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	// public String getLogoPath() {
	// return logoPath;
	// }
	//
	// public void setLogoPath(String logoPath) {
	// this.logoPath = logoPath;
	// }

	public Country getCountry() {
		return country;
	}

	public void setCountry(Country country) {
		this.country = country;
	}

	public State getState() {
		return state;
	}

	public void setState(State state) {
		this.state = state;
	}

	public City getCity() {
		return city;
	}

	public void setCity(City city) {
		this.city = city;
	}

	public String getStripeToken() {
		return stripeToken;
	}

	public void setStripeToken(String stripeToken) {
		this.stripeToken = stripeToken;
	}

	public String getStripeEmail() {
		return stripeEmail;
	}

	public void setStripeEmail(String stripeEmail) {
		this.stripeEmail = stripeEmail;
	}

	public MultipartFile getLogo() {
		return logo;
	}

	public void setLogo(MultipartFile logo) {
		this.logo = logo;
	}

	public byte[] getLogoData() {
		return logoData;
	}

	public void setLogoData(byte[] logoData) {
		this.logoData = logoData;
		initLogoString();
	}

	public String getLogoString() {
		return logoString;
	}

	public String initLogoString() {
		byte[] code = getLogoData();
		if (code != null && code.length > 0) {
			setLogoString(new String(Base64.getEncoder().encode(code)));
		} else {
			setLogoString(
					"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");
		}
		return this.logoString;
	}

	public Long getFeaturedUntil() {
		return featuredUntil;
	}

	public void setLogoString(String logoString) {
		this.logoString = logoString;
	}

	public double getLat() {
		return lat;
	}

	public void setLat(double lat) {
		this.lat = lat;
	}

	public double getLng() {
		return lng;
	}

	public void setLng(double lng) {
		this.lng = lng;
	}

	public double getDistance() {
		return distance;
	}

	public void setDistance(double distance) {
		this.distance = Math.round(distance);
	}

	public String getStripeCustomerId() {
		return stripeCustomerId;
	}

	public void setStripeCustomerId(String id) {
		this.stripeCustomerId = id;

	}

	public void setFeaturedUntil(Long currentPeriodEnd) {
		this.featuredUntil = currentPeriodEnd;
	}

	public void setEnterpriseUntil(Long currentPeriodEnd) {
		this.enterpriseUntil = currentPeriodEnd;

	}

	public Long getEnterpriseUntil() {
		return enterpriseUntil;
	}

	public Cart getCart() {
		return cart;
	}

	public void setCart(Cart cart) {
		this.cart = cart;
	}

	public void removeFollower(Jobseeker jobseeker) {
		Optional<Jobseeker> findFirst = followers.stream().filter(j -> j.getId() == jobseeker.getId()).findFirst();
		if (findFirst.isPresent()) {
			followers.remove(findFirst.get());
		}
	}


}
