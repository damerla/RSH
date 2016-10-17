package org.lightadmin.boot.domain;

import java.io.Serializable;
import java.util.List;
import java.util.Optional;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;

@Entity
public class Cart implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue
	private Long id;

	@ManyToMany(cascade = CascadeType.ALL,fetch=FetchType.EAGER)
	@JoinTable(name = "cart_jobseeker", joinColumns = {
			@JoinColumn(name = "cart_id") }, inverseJoinColumns = { @JoinColumn(name = "jobseeker_id") })
	private List<Jobseeker> jobseekers;

	public List<Jobseeker> getJobseekers() {
		return jobseekers;
	}

	public void setJobseekers(List<Jobseeker> jobseekers) {
		this.jobseekers = jobseekers;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public void addItem(Jobseeker jobseeker) {

		Optional<Jobseeker> findFirst = jobseekers.stream().filter(j -> j.getId() == jobseeker.getId()).findFirst();
		if (!findFirst.isPresent()) {
			jobseekers.add(jobseeker);
		}
	}
	
	public void removeItem(Jobseeker jobseeker) {
		Optional<Jobseeker> findFirst = jobseekers.stream().filter(j -> j.getId() == jobseeker.getId()).findFirst();
		if (findFirst.isPresent()) {
			jobseekers.remove(findFirst.get());
		}
	}

}
