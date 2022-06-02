package org.team4.airbnb.accommodation;

import java.util.Arrays;
import org.team4.airbnb.exception.CustomException;
import org.team4.airbnb.exception.ErrorCode;

public enum AccommodationType {
	HOTEL("일반 호텔");

	private String dbData;

	AccommodationType(String dbData) {
		this.dbData = dbData;
	}

	public static AccommodationType ofDbData(String dbData) {
		return Arrays.stream(AccommodationType.values())
			.filter(accommodationType -> accommodationType.getDbData().equals(dbData))
			.findAny()
			.orElseThrow(() -> new CustomException(ErrorCode.NO_DATA_FOUND_ACCOMMODATION_TYPE));
	}

	public String getDbData() {
		return dbData;
	}

	public static void main(String[] args) {
		AccommodationType type = AccommodationType.ofDbData("일반 호텔");
		AccommodationType hotel = AccommodationType.HOTEL;
		System.out.println("**type=" + type);
		System.out.println("**hotel=" + hotel);
		System.out.println("type.eq.hotel=" + type.equals(hotel));
	}
}
