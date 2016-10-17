package org.lightadmin.boot.domain;

import javax.persistence.Lob;
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

public class RecruiterDummy {
	private static final long serialVersionUID = 1L;

	private String userName;
	private String firstName;
	private String lastName;
	private String email;

	@Transient
	private MultipartFile logo;

	@Lob
	private byte[] logoData;

	@Transient
	private String logoString;

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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
	}

	public String getLogoString() {
		return logoString;
	}

	public void setLogoString(String logoString) {
		this.logoString = logoString;
	}

}
