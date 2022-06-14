package org.team4.airbnb.exception;

import org.springframework.http.HttpStatus;

public abstract class InvalidException extends BusinessException {

	@Override
	protected HttpStatus getHttpStatus() {
		return HttpStatus.UNAUTHORIZED;
	}
}
