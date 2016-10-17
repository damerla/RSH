package org.lightadmin.boot.repository;

import org.lightadmin.boot.domain.User;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface UserRepository extends PagingAndSortingRepository<User, String> {

	User findByUsername(String searchId);

}