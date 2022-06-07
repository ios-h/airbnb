package org.team4.airbnb.accommodation.dto;

import javax.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.geolatte.geom.G2D;
import org.geolatte.geom.Geometries;
import org.geolatte.geom.Point;
import org.geolatte.geom.crs.CoordinateReferenceSystems;

@Getter
@Setter
public class AccommodationSearchRequest {

	@NotNull
	private Double longitude;
	@NotNull
	private Double latitude;
	private Double radius = 500D;

	public AccommodationSearchParams toSearchParams() {
		Point<G2D> point = Geometries.mkPoint(new G2D(longitude, latitude),
			CoordinateReferenceSystems.WGS84);

		return AccommodationSearchParams.builder()
			.point(point)
			.radius(radius)
			.build();
	}
}
