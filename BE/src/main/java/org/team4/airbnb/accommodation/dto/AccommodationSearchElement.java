package org.team4.airbnb.accommodation.dto;

import java.util.List;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.team4.airbnb.accommodation.Accommodation;
import org.team4.airbnb.accommodation.RoomFeature;

@Builder(access = AccessLevel.PRIVATE)
@RequiredArgsConstructor(access = AccessLevel.PRIVATE)
@Getter
public class AccommodationSearchElement {

	private final Long id;
	private final String name;
	private final Integer price;
	private final Double longitude;
	private final Double latitude;
	private final String address;
	private final String type;
	private final String hostName;
	private final String description;
	private final RoomFeature roomFeature;
	private final List<String> imageUrls;

	public static AccommodationSearchElement from(Accommodation accommodation) {
		return builder()
			.id(accommodation.getId())
			.name(accommodation.getName())
			.price(accommodation.getPrice())
			.longitude(accommodation.getLocation().getPosition().getLon())
			.latitude(accommodation.getLocation().getPosition().getLat())
			.address(accommodation.getAddress())
			.type(accommodation.getType().getDbData())
			.hostName(accommodation.getHostName())
			.description(accommodation.getDescription())
			.roomFeature(accommodation.getRoomFeature())
			.imageUrls(accommodation.getImageUrls())
			.build();
	}
}
