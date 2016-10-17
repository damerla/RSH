package org.lightadmin.boot.dao;

import java.util.List;

import org.lightadmin.boot.domain.Recruiter;

public interface RecruiterDao {

	List<Recruiter> findByDistance(double lat, double lng, double distanceKM, Long industryId);
}
