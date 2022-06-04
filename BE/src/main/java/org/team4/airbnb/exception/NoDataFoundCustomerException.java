package org.team4.airbnb.exception;

import org.springframework.http.HttpStatus;

public class NoDataFoundCustomerException extends BusinessException{

	@Override
	protected HttpStatus getHttpStatus() {
		return HttpStatus.NOT_FOUND;
	}

	@Override
	protected String getBodyMessage() {
		return "존재하지 않은 회원입니다.";
	}
}
