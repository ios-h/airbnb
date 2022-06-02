package org.team4.airbnb.reservation;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.team4.airbnb.accommodation.AccommodationRepository;
import org.team4.airbnb.reservation.dto.ReservationResponse;

@Service
@RequiredArgsConstructor
public class ReservationService {

	private final ReservationRepository reservationRepository;
	private final AccommodationRepository accommodationRepository;

	public ReservationResponse findAllByCustomerId(Long customerId, Pageable pageable) {

		List<Reservation> reservations = reservationRepository
			.findAllByCustomerId(customerId, pageable);

		Set<Long> accommodationIds = reservations.stream()
			.map(r -> r.getAccommodation().getId())
			.collect(Collectors.toSet());

		accommodationRepository.findAllWithImagesByIdIn(accommodationIds);

		return ReservationResponse.from(reservations);
	}
}
