package org.team4.airbnb.wish;

import org.springframework.data.jpa.repository.JpaRepository;

public interface WishRepository extends JpaRepository<Wish, Long> {

	Wish findFirstBy();

	void deleteByCustomerIdAndAccommodationId(Long customerId, Long accommodationId);
}
