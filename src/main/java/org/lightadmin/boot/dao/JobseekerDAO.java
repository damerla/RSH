package org.lightadmin.boot.dao;

import java.util.List;

import org.lightadmin.boot.domain.Jobseeker;

public interface JobseekerDAO {

	List<Jobseeker> findByDistance(double lat, double lng, double distanceKM, Long industryId);
}
