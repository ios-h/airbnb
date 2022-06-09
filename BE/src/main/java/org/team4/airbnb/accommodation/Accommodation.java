package org.team4.airbnb.accommodation;

import java.util.List;
import javax.persistence.Column;
import javax.persistence.Convert;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.geolatte.geom.G2D;
import org.geolatte.geom.Point;
import org.team4.airbnb.domain.BaseCreated;

@Entity
@NoArgsConstructor
@Getter
@ToString
public class Accommodation extends BaseCreated {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "accommodation_id")
	private Long id;

	private String name;

	private Integer price;

	private Point<G2D> location;

	private String address;

	@Convert(converter = AccommodationTypeConverter.class)
	@Column(name = "accommodation_type")
	private AccommodationType type;

	private String hostName;

	private String description;

	@Embedded
	private RoomFeature roomFeature;

	@Embedded
	private AccommodationImages accommodationImages;

	public List<String> getImageUrls() {
		return accommodationImages.getUrls();
	}

	public boolean isNotNullName(Accommodation accommodation) {
		return !accommodation.name.isEmpty();
	}

	public Double getLongitude() {
		return location.getPosition().getLon();
	}

	public Double getLatitude() {
		return location.getPosition().getLat();
	}
}
