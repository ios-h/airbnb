package org.team4.airbnb.accommodation;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AccommodationRepository extends JpaRepository<Accommodation, Long> {

	List<Accommodation> findByIdIn(List<Long> accommodationIds);
}
