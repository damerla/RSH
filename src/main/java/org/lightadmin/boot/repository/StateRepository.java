package org.lightadmin.boot.repository;

import java.util.List;

import org.lightadmin.boot.domain.State;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface StateRepository extends PagingAndSortingRepository<State, Long> {

	List<State> findByCountryId(Long searchId);

}