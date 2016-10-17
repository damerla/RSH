package org.lightadmin.boot.repository;

import java.util.List;

import org.lightadmin.boot.domain.EducationLevel;
import org.lightadmin.boot.domain.Industry;
import org.lightadmin.boot.domain.Jobseeker;
import org.lightadmin.boot.domain.Seniority;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface JobseekerRepository
		extends PagingAndSortingRepository<Jobseeker, Long>, CrudRepository<Jobseeker, Long> {

	Jobseeker findByemail(String email);

	Jobseeker findByuserName(String username);

	List<Jobseeker> findByindustry(Industry industry);

	List<Jobseeker> findBySeniority(Seniority seniority);

	List<Jobseeker> findByEducation(EducationLevel education);

	Jobseeker findByid(Long id);
}