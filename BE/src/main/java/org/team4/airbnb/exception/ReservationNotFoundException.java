package org.team4.airbnb.exception;

import org.springframework.http.HttpStatus;

public class ReservationNotFoundException extends BusinessException {

	@Override
	protected HttpStatus getHttpStatus() {
		return HttpStatus.NOT_FOUND;
	}

	@Override
	protected String getBodyMessage() {
		return "존재하지 않는 예약입니다";
	}
}
