package org.team4.airbnb.reservation;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import org.team4.airbnb.reservation.dto.ReservationElement;
import org.team4.airbnb.reservation.dto.ReservationResponse;

public class Reservations {

	private final List<Reservation> elements;

	public Reservations(List<Reservation> elements) {
		this.elements = elements;
	}

	public Set<Long> getAccommodationIds() {
		return elements.stream()
			.map(Reservation::getAccommodationId)
			.collect(Collectors.toSet());
	}

	public ReservationResponse toReservationResponse() {
		return new ReservationResponse(elements.stream()
			.map(ReservationElement::new)
			.collect(Collectors.toList()));
	}
}
