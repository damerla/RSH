package org.lightadmin.boot.repository;

import org.lightadmin.boot.domain.Jobseeker;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface PurchasedLeadsRepository extends PagingAndSortingRepository<Jobseeker, Long>, CrudRepository<Jobseeker, Long> {

}
