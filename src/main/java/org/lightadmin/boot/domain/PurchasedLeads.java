package org.lightadmin.boot.domain;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Table;

@Table
public class PurchasedLeads implements Serializable {
	/**
	 *
	 */
	private static final long serialVersionUID = 1L;

	private Recruiter recruiter;
	private Jobseeker jobseeker;
	private Timestamp purchasedAt;
	private Timestamp expiresAt;

	public Recruiter getRecruiter() {
		return recruiter;
	}

	public void setRecruiter(Recruiter recruiter) {
		this.recruiter = recruiter;
	}

	public Jobseeker getJobseeker() {
		return jobseeker;
	}

	public void setJobseeker(Jobseeker jobseeker) {
		this.jobseeker = jobseeker;
	}

	public Timestamp getPurchasedAt() {
		return purchasedAt;
	}

	public void setPurchasedAt(Timestamp purchasedAt) {
		this.purchasedAt = purchasedAt;
	}

	public Timestamp getExpiresAt() {
		return expiresAt;
	}

	public void setExpiresAt(Timestamp expiresAt) {
		this.expiresAt = expiresAt;
	}

}
