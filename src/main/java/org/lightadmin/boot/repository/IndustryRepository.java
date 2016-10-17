package org.lightadmin.boot.repository;

import org.lightadmin.boot.domain.Industry;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface IndustryRepository extends PagingAndSortingRepository<Industry, Long> {

}