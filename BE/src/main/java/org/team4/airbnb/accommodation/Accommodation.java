package org.team4.airbnb.accommodation;

import java.util.ArrayList;
import java.util.List;
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
import org.team4.airbnb.domain.BaseCreated;
import org.team4.airbnb.domain.Geolocation;

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

	@Embedded
	private Geolocation geolocation;

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

	public boolean isNotNullName(Accommodation accommodation) {
		return !accommodation.name.isEmpty();
	}
}
