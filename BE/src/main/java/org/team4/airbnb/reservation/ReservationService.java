package org.team4.airbnb.reservation;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.team4.airbnb.accommodation.AccommodationRepository;
import org.team4.airbnb.exception.CustomException;
import org.team4.airbnb.exception.ErrorCode;
import org.team4.airbnb.reservation.dto.ReservationResponse;

@Service
@Transactional
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

	public void cancel(Long reservationId) {
		Reservation reservation = reservationRepository.findById(reservationId)
			.orElseThrow(() -> new CustomException(ErrorCode.NO_DATA_FOUND_RESERVATION));

		reservationRepository.delete(reservation);
	}
}
