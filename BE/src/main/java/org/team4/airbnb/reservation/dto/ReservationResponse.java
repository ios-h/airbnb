package org.team4.airbnb.reservation.dto;

import java.util.List;
import lombok.Getter;

@Getter
public class ReservationResponse {

	private final List<ReservationElement> data;

	public ReservationResponse(List<ReservationElement> data) {
		this.data = List.copyOf(data);
	}
}
