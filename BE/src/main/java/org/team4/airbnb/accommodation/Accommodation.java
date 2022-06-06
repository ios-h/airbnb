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
import org.team4.airbnb.customer.dto.AccommodationForWishListResponse2;
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

	private List<String> askImagesUrls() {
		return accommodationImages.get(0).offerImagesUrls(accommodationImages);
	}

	//엔티티 to DTO 를 엔티티에서 수행 - 아닌 것 같아서 원복 예정
	public static AccommodationForWishListResponse2 toWishListDto(Accommodation accommodation,
		Long wishId) {
		return AccommodationForWishListResponse2.builder()
			.accommodationId(accommodation.id)
			.name(accommodation.name)
			.price(accommodation.price)
			.imagesUrls(accommodation.askImagesUrls())
			.wishId(wishId)
			.build();
	}

	public boolean isNotNullName(Accommodation accommodation) {
		return !accommodation.name.isEmpty();
	}
}
