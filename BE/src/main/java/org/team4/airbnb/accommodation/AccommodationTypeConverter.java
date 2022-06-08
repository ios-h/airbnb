package org.team4.airbnb.accommodation;

import javax.persistence.AttributeConverter;

public class AccommodationTypeConverter implements AttributeConverter<AccommodationType, String> {


	@Override
	public String convertToDatabaseColumn(AccommodationType attribute) {
		return attribute.getDbData();
	}

	@Override
	public AccommodationType convertToEntityAttribute(String dbData) {
		return AccommodationType.ofDbData(dbData);
	}
}
