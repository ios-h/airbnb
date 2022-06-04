package org.team4.airbnb.accommodation;

import java.util.Arrays;
import org.team4.airbnb.exception.AccommodationTypeNotFoundException;
import org.team4.airbnb.exception.CustomException;
import org.team4.airbnb.exception.ErrorCode;

public enum AccommodationType {
	HOTEL("일반호텔");

	private String dbData;

	AccommodationType(String dbData) {
		this.dbData = dbData;
	}

	public static AccommodationType ofDbData(String dbData) {
		return Arrays.stream(AccommodationType.values())
			.filter(accommodationType -> accommodationType.getDbData().equals(dbData))
			.findAny()
			.orElseThrow(AccommodationTypeNotFoundException::new);
	}

	public String getDbData() {
		return dbData;
	}
}
