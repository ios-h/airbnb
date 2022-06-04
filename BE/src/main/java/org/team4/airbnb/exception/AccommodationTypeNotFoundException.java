package org.team4.airbnb.exception;

import org.springframework.http.HttpStatus;

public class AccommodationTypeNotFoundException extends BusinessException {

	@Override
	protected HttpStatus getHttpStatus() {
		return HttpStatus.NOT_FOUND;
	}

	@Override
	protected String getBodyMessage() {
		return "존재하지 숙소 타입입니다.";
	}
}
