package org.team4.airbnb.exception;

import org.springframework.http.HttpStatus;

public class BusinessException extends RuntimeException{

	private HttpStatus httpStatus;
	private String bodyMessage;

	protected HttpStatus getHttpStatus() {
		return httpStatus;
	}

	protected String getBodyMessage() {
		return bodyMessage;
	}
}
