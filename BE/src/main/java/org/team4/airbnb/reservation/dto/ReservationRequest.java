package org.team4.airbnb.reservation.dto;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import lombok.Getter;
import lombok.ToString;
import org.team4.airbnb.accommodation.Accommodation;
import org.team4.airbnb.customer.Customer;
import org.team4.airbnb.reservation.Invoice;
import org.team4.airbnb.reservation.Reservation;

@Getter
@ToString
public class ReservationRequest {

	private LocalDate checkInDate;
	private LocalDate checkOutDate;
	private Integer numberOfGuest;
	private Integer numberOfInfant;

	private Long customerId;
	private Long accommodationId;

	public Integer getLengthOfStay() {
		return Math.toIntExact(ChronoUnit.DAYS.between(checkInDate, checkOutDate));
	}

	public Reservation toReservation(Accommodation accommodation,
		Customer customer) {
		return Reservation.builder()
			.checkInDate(checkInDate)
			.checkOutDate(checkOutDate)
			.numberOfGuest(numberOfGuest)
			.numberOfInfant(numberOfInfant)
			.invoice(Invoice.calculate(accommodation.getPrice(), getLengthOfStay()))
			.accommodation(accommodation)
			.customer(customer)
			.build();
	}
}
