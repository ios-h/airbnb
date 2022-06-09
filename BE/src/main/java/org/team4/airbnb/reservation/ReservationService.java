package org.team4.airbnb.reservation;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.team4.airbnb.accommodation.Accommodation;
import org.team4.airbnb.accommodation.AccommodationRepository;
import org.team4.airbnb.customer.Customer;
import org.team4.airbnb.customer.CustomerRepository;
import org.team4.airbnb.exception.AccommodationNotFoundException;
import org.team4.airbnb.exception.CustomerNotFoundException;
import org.team4.airbnb.exception.ReservationNotFoundException;
import org.team4.airbnb.reservation.dto.ReservationElement;
import org.team4.airbnb.reservation.dto.ReservationRequest;
import org.team4.airbnb.reservation.dto.ReservationResponse;

@Service
@RequiredArgsConstructor
public class ReservationService {

	private final ReservationRepository reservationRepository;
	private final AccommodationRepository accommodationRepository;
	private final CustomerRepository customerRepository;

	@Transactional
	public ReservationElement make(ReservationRequest reservationRequest) {
		Customer customer = retrieveCustomer(reservationRequest.getCustomerId());

		Accommodation accommodation = retrieveAccommodation(
			reservationRequest.getAccommodationId());

		Reservation reservation = reservationRequest.toReservation(accommodation,
			customer);

		reservation = reservationRepository.save(reservation);

		return new ReservationElement(reservation);
	}

	@Transactional(readOnly = true)
	public ReservationResponse findAllByCustomerId(Long customerId, Pageable pageable) {
		Reservations reservations = new Reservations(reservationRepository
			.findAllByCustomerId(customerId, pageable));

		accommodationRepository.findAllWithImagesByIdIn(reservations.getAccommodationIds());

		return reservations.toReservationResponse();
	}

	@Transactional
	public void cancel(Long reservationId) {
		Reservation reservation = reservationRepository.findById(reservationId)
			.orElseThrow(ReservationNotFoundException::new);

		reservationRepository.delete(reservation);
	}

	private Accommodation retrieveAccommodation(Long accommodationId) {
		return accommodationRepository
			.findById(accommodationId)
			.orElseThrow(AccommodationNotFoundException::new);
	}

	private Customer retrieveCustomer(Long customerId) {
		return customerRepository.findById(customerId)
			.orElseThrow(CustomerNotFoundException::new);
	}
}
