package org.team4.airbnb.accommodation;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface AccommodationRepository extends JpaRepository<Accommodation, Long> {

	@Query("select a from Accommodation a join fetch a.accommodationImages where a.id in :accommodationIds")
	List<Accommodation> findAllWithImagesById(Iterable<Long> accommodationIds);
}
