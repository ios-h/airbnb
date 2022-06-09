package org.team4.airbnb.exception.validation;

import org.springframework.http.HttpStatus;
import org.team4.airbnb.exception.BusinessException;

public abstract class InValidException extends BusinessException {

	@Override
	protected HttpStatus getHttpStatus() {
		return HttpStatus.UNAUTHORIZED;
	}
}
