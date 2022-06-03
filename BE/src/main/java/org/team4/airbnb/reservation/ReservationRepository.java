package org.team4.airbnb.reservation;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface ReservationRepository extends JpaRepository<Reservation, Long> {

	@Query("select r from Reservation r join fetch r.accommodation where r.customer.id = :customerId")
	List<Reservation> findAllByCustomerId(Long customerId);
}
