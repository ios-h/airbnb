package org.team4.airbnb.accommodation;

import javax.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.team4.airbnb.accommodation.dto.AccommodationSearchRequest;
import org.team4.airbnb.accommodation.dto.AccommodationSearchResponse;

@RestController
@RequiredArgsConstructor
@RequestMapping("api/accommodations")
public class AccommodationController {

	private final AccommodationService accommodationService;

	@GetMapping
	public ResponseEntity<AccommodationSearchResponse> searchFrom
		(@Valid AccommodationSearchRequest searchRequest, Pageable pageable) {

		return ResponseEntity.ok(accommodationService.search(searchRequest, pageable));
	}
}
