package org.lightadmin.boot.domain;

import javax.persistence.Lob;
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

public class JobseekerDummy {
	private static final long serialVersionUID = 1L;

	// private String profilePicPath;
	private String firstName;
	private String lastName;
	private String userName;
	private String email;

	@Transient
	private MultipartFile pic;

	@Lob
	private byte[] picData;

	@Transient
	private String picString;

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
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

	public MultipartFile getPic() {
		return pic;
	}

	public void setPic(MultipartFile pic) {
		this.pic = pic;
	}

	public byte[] getPicData() {
		return picData;
	}

	public void setPicData(byte[] picData) {
		this.picData = picData;
	}

	public String getPicString() {
		return picString;
	}

	public void setPicString(String picString) {
		this.picString = picString;
	}

}