package org.team4.airbnb.accommodation;

import java.util.List;
import java.util.stream.Collectors;
import org.team4.airbnb.accommodation.dto.AccommodationSearchElement;
import org.team4.airbnb.accommodation.dto.AccommodationSearchResponse;

public class Accommodations {

	private final List<Accommodation> elements;

	public Accommodations(List<Accommodation> elements) {
		this.elements = elements;
	}

	public AccommodationSearchResponse toSearchResponse() {
		return new AccommodationSearchResponse(elements.stream()
			.map(AccommodationSearchElement::from)
			.collect(Collectors.toList()));
	}
}
