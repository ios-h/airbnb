package org.team4.airbnb.reservation;

import java.util.List;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ReservationRepository extends JpaRepository<Reservation, Long> {

	@Query("select r from Reservation r join fetch r.accommodation where r.customer.id = :customerId")
	List<Reservation> findAllByCustomerId(@Param("customerId") Long customerId, Pageable pageable);
}
