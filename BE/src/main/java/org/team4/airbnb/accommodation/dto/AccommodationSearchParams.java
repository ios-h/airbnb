package org.team4.airbnb.accommodation.dto;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import org.geolatte.geom.G2D;
import org.geolatte.geom.Point;

@Getter
public class AccommodationSearchParams {

	private final Point<G2D> point;
	private final Double radius;

	@Builder(access = AccessLevel.PACKAGE)
	private AccommodationSearchParams(Point<G2D> point, Double radius) {
		this.point = point;
		this.radius = radius;
	}
}
