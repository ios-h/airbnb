package org.team4.airbnb.accommodation.dto;

import java.time.LocalDate;
import javax.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.geolatte.geom.G2D;
import org.geolatte.geom.Geometries;
import org.geolatte.geom.Point;
import org.geolatte.geom.crs.CoordinateReferenceSystems;
import org.springframework.format.annotation.DateTimeFormat;

@Getter
@Setter
public class AccommodationSearchRequest {

	private static final Double DEFAULT_RADIUS = 1_000D;
	private static final Integer DEFAULT_LENGTH_OF_STAY = 7;

	@NotNull
	private Double longitude;
	@NotNull
	private Double latitude;
	private Double radius = DEFAULT_RADIUS;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate checkInDate = LocalDate.now();
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate checkOutDate = LocalDate.now().plusDays(DEFAULT_LENGTH_OF_STAY);
	private Integer minPrice;
	private Integer maxPrice;
	private Integer numberOfGuest;

	public AccommodationSearchParams toSearchParams() {
		Point<G2D> point = Geometries.mkPoint(new G2D(longitude, latitude),
			CoordinateReferenceSystems.WGS84);

		return AccommodationSearchParams.builder()
			.point(point)
			.radius(radius)
			.checkInDate(checkInDate)
			.checkOutDate(checkOutDate)
			.minPrice(minPrice)
			.maxPrice(maxPrice)
			.numberOfGuest(numberOfGuest)
			.build();
	}
}
