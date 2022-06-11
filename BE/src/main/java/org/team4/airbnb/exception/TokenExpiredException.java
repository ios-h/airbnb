package org.team4.airbnb.exception;

import org.springframework.http.HttpStatus;

public class TokenExpiredException extends BusinessException {

	@Override
	protected HttpStatus getHttpStatus() {
		return HttpStatus.UNAUTHORIZED;
	}

	@Override
	protected String getBodyMessage() {
		return "인증이 만료되었습니다.";
	}
}
