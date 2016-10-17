package org.lightadmin.boot.repository;

import org.lightadmin.boot.domain.Cart;
import org.lightadmin.boot.domain.User;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface CartRepository extends PagingAndSortingRepository<Cart, Long> {

	Cart findByid(Long searchId);

}