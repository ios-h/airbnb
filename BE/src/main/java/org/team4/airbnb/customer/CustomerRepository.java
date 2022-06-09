package org.team4.airbnb.customer;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CustomerRepository extends JpaRepository<Customer, Long> {

	Customer findFirstBy();

	Optional<Customer> findByUserId(String userId);
}
