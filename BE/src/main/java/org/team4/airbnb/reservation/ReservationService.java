package org.team4.airbnb.reservation;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.team4.airbnb.accommodation.Accommodation;
import org.team4.airbnb.accommodation.AccommodationRepository;

@Service
@RequiredArgsConstructor
public class ReservationService {

	private ReservationRepository reservationRepository;
	private AccommodationRepository accommodationRepository;

	public void findAllByCustomerId(Long customerId) {
		List<Reservation> reservations = reservationRepository.findAllByCustomerId(customerId);

		Set<Long> accommodationIds = reservations.stream()
			.map(r -> r.getAccommodation().getId())
			.collect(Collectors.toSet());

		List<Accommodation> accommodations = accommodationRepository.findAllWithImagesById(accommodationIds);

	}
}
