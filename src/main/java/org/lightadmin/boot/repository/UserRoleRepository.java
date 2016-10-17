package org.lightadmin.boot.repository;

import org.lightadmin.boot.domain.User;
import org.lightadmin.boot.domain.UserRole;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface UserRoleRepository extends PagingAndSortingRepository<UserRole, String> {

	User findByUser(String searchId);

}