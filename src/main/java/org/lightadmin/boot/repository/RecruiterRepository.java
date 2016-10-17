package org.lightadmin.boot.repository;

import java.util.List;

import org.lightadmin.boot.domain.Recruiter;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface RecruiterRepository
		extends PagingAndSortingRepository<Recruiter, Long>, CrudRepository<Recruiter, Long> {

	List<Recruiter> findByFeatured(boolean featured);

	Recruiter findByuserName(String username);

	Recruiter findByid(Long recId);

	Recruiter findByemail(String email);

	Recruiter findBystripeCustomerId(String customer);
}