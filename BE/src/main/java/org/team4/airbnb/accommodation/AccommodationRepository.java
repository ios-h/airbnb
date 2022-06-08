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
		+ "left outer join reservation as r on a.accommodation_id = r.accommodation_id "
		+ "where st_distance_sphere(a.location, :#{#searchParams.point}) "
		+ "<= :#{#searchParams.radius} "
		+ "and ifnull(a.price >= :#{#searchParams.minPrice}, true) "
		+ "and ifnull(a.price <= :#{#searchParams.maxPrice}, true) "
		+ "and ifnull(r.check_out_date <= :#{#searchParams.checkInDate} "
		+ "or r.check_in_date > :#{#searchParams.checkOutDate}, true)",
		nativeQuery = true)
	List<Long> findIdsBySearchParams(AccommodationSearchParams searchParams, Pageable pageable);

	List<Accommodation> findByIdIn(List<Long> accommodationIds);

	Accommodation findFirstBy();

	List<Accommodation> findTop3ByOrderById();
}
