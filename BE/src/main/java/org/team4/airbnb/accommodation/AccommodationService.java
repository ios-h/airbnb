package org.team4.airbnb.accommodation;

import java.util.List;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.team4.airbnb.accommodation.dto.AccommodationSearchElement;
import org.team4.airbnb.accommodation.dto.AccommodationSearchParams;
import org.team4.airbnb.accommodation.dto.AccommodationSearchRequest;
import org.team4.airbnb.accommodation.dto.AccommodationSearchResponse;

@Service
@RequiredArgsConstructor
public class AccommodationService {

	private final AccommodationRepository accommodationRepository;

	@Transactional(readOnly = true)
	public AccommodationSearchResponse search(AccommodationSearchRequest searchRequest) {
		AccommodationSearchParams searchParams = searchRequest.toSearchParams();

		List<Long> accommodationIds = searchForIds(searchParams);

		List<AccommodationSearchElement> elements = accommodationRepository
			.findAllWithImagesByIdIn(accommodationIds)
			.stream()
			.map(AccommodationSearchElement::from)
			.collect(Collectors.toList());

		return new AccommodationSearchResponse(elements);
	}

	private List<Long> searchForIds(AccommodationSearchParams searchParams) {
		return accommodationRepository.findIdsBySearchParams(searchParams);
	}
}
