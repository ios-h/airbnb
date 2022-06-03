package org.team4.airbnb.reservation.dto;

import java.time.LocalDate;
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class ReservationRequest {

	private LocalDate checkInDate;
	private LocalDate checkOutDate;
	private Integer numberOfGuest;
	private Integer numberOfInfant;

	private Long customerId;
	private Long accommodationId;
}
