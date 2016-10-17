package org.lightadmin.boot.repository;

import org.lightadmin.boot.domain.InternalMessage;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface InternalMessageRepository
		extends PagingAndSortingRepository<InternalMessage, Long>, CrudRepository<InternalMessage, Long> {

}
