package org.team4.airbnb.accommodation;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.team4.airbnb.accommodation.dto.AccommodationSearchParams;
import org.team4.airbnb.accommodation.dto.AccommodationSearchRequest;
import org.team4.airbnb.accommodation.dto.AccommodationSearchResponse;

@Service
@RequiredArgsConstructor
public class AccommodationService {

	private final AccommodationRepository accommodationRepository;

	@Transactional(readOnly = true)
	public AccommodationSearchResponse search(AccommodationSearchRequest searchRequest,
		Pageable pageable) {
		AccommodationSearchParams searchParams = searchRequest.toSearchParams();

		List<Long> accommodationIds = searchForIds(searchParams, pageable);

		Accommodations accommodations = new Accommodations(accommodationRepository
			.findAllWithImagesByIdIn(accommodationIds));

		return accommodations.toSearchResponse();
	}

	private List<Long> searchForIds(AccommodationSearchParams searchParams, Pageable pageable) {
		return accommodationRepository.findIdsBySearchParams(searchParams, pageable);
	}
}
