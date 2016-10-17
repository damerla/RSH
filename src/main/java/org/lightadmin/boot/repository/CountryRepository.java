package org.lightadmin.boot.repository;

import org.lightadmin.boot.domain.Country;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface CountryRepository extends PagingAndSortingRepository<Country, Long> {

}