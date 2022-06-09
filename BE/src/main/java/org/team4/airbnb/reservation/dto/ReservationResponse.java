package org.team4.airbnb.reservation.dto;

import java.util.List;
import java.util.stream.Collectors;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.team4.airbnb.reservation.Reservation;

@RequiredArgsConstructor
@Getter
public class ReservationResponse {

	private final List<ReservationElement> data;

	public static ReservationResponse from(List<Reservation> reservations) {
		return new ReservationResponse(reservations.stream()
			.map(ReservationElement::new)
			.collect(Collectors.toList()));
	}
}
