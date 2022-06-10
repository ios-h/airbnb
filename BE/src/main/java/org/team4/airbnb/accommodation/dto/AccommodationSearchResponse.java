package org.team4.airbnb.accommodation.dto;

import java.util.List;
import lombok.Getter;

@Getter
public class AccommodationSearchResponse {

	private final List<AccommodationSearchElement> data;

	public AccommodationSearchResponse(List<AccommodationSearchElement> data) {
		this.data = data;
	}
}
