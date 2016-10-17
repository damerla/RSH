package org.lightadmin.boot.repository;

import java.util.List;

import org.lightadmin.boot.domain.City;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface CityRepository extends PagingAndSortingRepository<City, Long> {

	List<City> findByStateId(Long searchId);

}