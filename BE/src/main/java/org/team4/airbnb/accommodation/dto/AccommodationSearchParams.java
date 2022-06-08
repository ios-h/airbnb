package org.team4.airbnb.accommodation.dto;

import java.time.LocalDate;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import org.geolatte.geom.G2D;
import org.geolatte.geom.Point;

@Getter
public class AccommodationSearchParams {

	private final Point<G2D> point;
	private final Double radius;
	private final LocalDate checkInDate;
	private final LocalDate checkOutDate;

	@Builder(access = AccessLevel.PACKAGE)
	private AccommodationSearchParams(Point<G2D> point, Double radius, LocalDate checkInDate,
		LocalDate checkOutDate) {
		this.point = point;
		this.radius = radius;
		this.checkInDate = checkInDate;
		this.checkOutDate = checkOutDate;
	}
}
