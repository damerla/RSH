package org.lightadmin.boot.repository;

import org.lightadmin.boot.domain.EducationLevel;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface EducationRepository extends PagingAndSortingRepository<EducationLevel, Long>{

}
