package org.team4.airbnb.exception;

public class ReservationNotFoundException extends NotFoundException {

	@Override
	protected String getBodyMessage() {
		return "존재하지 않는 예약입니다";
	}
}
