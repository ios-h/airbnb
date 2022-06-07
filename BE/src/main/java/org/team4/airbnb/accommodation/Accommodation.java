package org.team4.airbnb.accommodation;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import javax.persistence.Column;
import javax.persistence.Convert;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
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

	@OneToMany(mappedBy = "accommodation", fetch = FetchType.LAZY)
	@OrderBy("imageSeq asc")
	private List<AccommodationImage> accommodationImages = new ArrayList<>();

	public List<String> askImagesUrls() {
		return accommodationImages.get(0).offerImagesUrls(accommodationImages);
	}

	public List<String> getImageUrls() {
		return accommodationImages.stream()
			.map(AccommodationImage::getUrl)
			.collect(Collectors.toList());
	}

	public boolean isNotNullName(Accommodation accommodation) {
		return !accommodation.name.isEmpty();
	}
}
