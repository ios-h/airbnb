package org.team4.airbnb.reservation.dto;

import java.time.LocalDate;
import java.util.List;
import lombok.Getter;
import org.team4.airbnb.reservation.Reservation;

@Getter
public class ReservationElement {

	private final Long id;
	private final LocalDate checkInDate;
	private final LocalDate checkOutDate;
	private final Integer numberOfGuest;
	private final Integer invoiceTotal;

	private final String hostName;
	private final String accommodationType;
	private final List<String> accommodationImages;

	public ReservationElement(Reservation reservation) {
		this.id = reservation.getId();
		this.checkInDate = reservation.getCheckInDate();
		this.checkOutDate = reservation.getCheckOutDate();
		this.numberOfGuest = reservation.getNumberOfGuest();
		this.invoiceTotal = reservation.getInvoiceTotal();
		this.hostName = reservation.getHostName();
		this.accommodationType = reservation.getAccommodationTypeString();
		this.accommodationImages = List.copyOf(reservation.getAccommodationImageUrls());
	}
}
