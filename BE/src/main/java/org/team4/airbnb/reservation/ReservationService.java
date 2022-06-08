package org.team4.airbnb.reservation;

import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
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
import org.team4.airbnb.reservation.dto.ReservationRequest;
import org.team4.airbnb.reservation.dto.ReservationResponse;

@Service
@RequiredArgsConstructor
public class ReservationService {

	private final ReservationRepository reservationRepository;
	private final AccommodationRepository accommodationRepository;
	private final CustomerRepository customerRepository;

	@Transactional
	public void make(ReservationRequest reservationRequest) {
		Customer customer = customerRepository.findById(reservationRequest.getCustomerId())
			.orElseThrow(CustomerNotFoundException::new);

		Accommodation accommodation = accommodationRepository
			.findById((reservationRequest.getAccommodationId()))
			.orElseThrow(AccommodationNotFoundException::new);

		Integer lengthOfStay = Math.toIntExact(
			ChronoUnit.DAYS.between(reservationRequest.getCheckInDate(),
				reservationRequest.getCheckOutDate()));

		Invoice invoice = Invoice.calculate(accommodation.getPrice(), lengthOfStay);

		Reservation reservation = Reservation.builder()
			.checkInDate(reservationRequest.getCheckInDate())
			.checkOutDate(reservationRequest.getCheckOutDate())
			.numberOfGuest(reservationRequest.getNumberOfGuest())
			.numberOfInfant(reservationRequest.getNumberOfInfant())
			.invoice(invoice)
			.accommodation(accommodation)
			.customer(customer)
			.build();

		reservationRepository.save(reservation);
	}

	@Transactional(readOnly = true)
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
			.orElseThrow(ReservationNotFoundException::new);

		reservationRepository.delete(reservation);
	}
}
