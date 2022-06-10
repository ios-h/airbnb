package org.team4.airbnb.accommodation.dto;

import java.util.List;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.team4.airbnb.accommodation.Accommodation;

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
	private final Integer maxGuest;
	private final Integer numberOfRoom;
	private final Integer numberOfBed;
	private final Integer numberOfBathroom;
	private final List<String> imageUrls;

	public static AccommodationSearchElement from(Accommodation accommodation) {
		return builder()
			.id(accommodation.getId())
			.name(accommodation.getName())
			.price(accommodation.getPrice())
			.longitude(accommodation.getLongitude())
			.latitude(accommodation.getLatitude())
			.address(accommodation.getAddress())
			.type(accommodation.getType().getDbData())
			.hostName(accommodation.getHostName())
			.description(accommodation.getDescription())
			.maxGuest(accommodation.getRoomFeature().getMaxGuest())
			.numberOfRoom(accommodation.getRoomFeature().getNumberOfRoom())
			.numberOfBed(accommodation.getRoomFeature().getNumberOfBed())
			.numberOfBathroom(accommodation.getRoomFeature().getNumberOfBathroom())
			.imageUrls(accommodation.getImageUrls())
			.build();
	}
}
