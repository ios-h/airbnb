package org.team4.airbnb.accommodation;

import java.util.Arrays;
import org.team4.airbnb.exception.AccommodationTypeNotFoundException;

public enum AccommodationType {
	HOTEL("일반호텔");

	private final String dbData;

	AccommodationType(String dbData) {
		this.dbData = dbData;
	}

	public static AccommodationType ofDbData(String dbData) {
		return Arrays.stream(AccommodationType.values())
			.filter(type -> type.isEquivalentTo(dbData))
			.findAny()
			.orElseThrow(AccommodationTypeNotFoundException::new);
	}

	public String getDbData() {
		return dbData;
	}

	private boolean isEquivalentTo(String dbData) {
		return this.dbData.equals(dbData);
	}
}
