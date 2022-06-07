package org.team4.airbnb.accommodation;

import java.util.List;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.team4.airbnb.accommodation.dto.AccommodationSearchParams;

public interface AccommodationRepository extends JpaRepository<Accommodation, Long> {

	@Query("select distinct a from Accommodation a "
		+ "left join fetch a.accommodationImages "
		+ "where a.id in :accommodationIds "
		+ "order by a.id asc")
	List<Accommodation> findAllWithImagesByIdIn(
		@Param("accommodationIds") Iterable<Long> accommodationIds);

	@Query(value = "select a.* from accommodation as a "
		+ "where st_distance_sphere(a.location, :#{#searchParams.point}) "
		+ "<= :#{#searchParams.radius}",
		nativeQuery = true)
	List<Long> findIdsBySearchParams(AccommodationSearchParams searchParams);

	List<Accommodation> findByIdIn(List<Long> accommodationIds);

	Accommodation findFirstBy();

	List<Accommodation> findTop3ByOrderById();
}
