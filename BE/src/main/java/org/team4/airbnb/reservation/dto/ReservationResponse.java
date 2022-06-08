package org.team4.airbnb.reservation.dto;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.team4.airbnb.accommodation.AccommodationImage;
import org.team4.airbnb.reservation.Reservation;

@RequiredArgsConstructor
@Getter
public class ReservationResponse {

	private final List<Element> data;

	@Getter
	private static class Element {

		private final Long id;
		private final LocalDate checkInDate;
		private final LocalDate checkOutDate;
		private final Integer numberOfGuest;
		private final Integer invoiceTotal;

		private final String hostName;
		private final String accommodationType;
		private final List<String> accommodationImages;

		Element(Reservation reservation) {
			this.id = reservation.getId();
			this.checkInDate = reservation.getCheckInDate();
			this.checkOutDate = reservation.getCheckOutDate();
			this.numberOfGuest = reservation.getNumberOfGuest();
			this.invoiceTotal = reservation.getInvoiceTotal();
			this.hostName = reservation.getAccommodation().getHostName();
			this.accommodationType = reservation.getAccommodation().getType().getDbData();
			this.accommodationImages = reservation.getAccommodation().getAccommodationImages()
				.stream()
				.map(AccommodationImage::getUrl)
				.collect(Collectors.toList());
		}
	}

	public static ReservationResponse from(List<Reservation> reservations) {
		return new ReservationResponse(reservations.stream()
			.map(Element::new)
			.collect(Collectors.toList()));
	}
}
