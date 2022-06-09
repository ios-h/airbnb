package org.team4.airbnb.exception;

import org.team4.airbnb.exception.validation.InValidException;

public class TokenInValidateException extends InValidException {

	@Override
	protected String getBodyMessage() {
		return "유효하지 않은 토큰입니다";
	}
}
