package org.team4.airbnb.accommodation;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface AccommodationRepository extends JpaRepository<Accommodation, Long> {

	@Query("select distinct a from Accommodation a "
		+ "left join fetch a.accommodationImages "
		+ "where a.id in :accommodationIds")
	List<Accommodation> findAllWithImagesByIdIn(
		@Param("accommodationIds") Iterable<Long> accommodationIds);

	List<Accommodation> findByIdIn(List<Long> accommodationIds);

	Accommodation findFirstBy();

	List<Accommodation> findTop3ByOrderById();
}
