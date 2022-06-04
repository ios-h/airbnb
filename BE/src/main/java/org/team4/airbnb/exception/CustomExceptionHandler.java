package org.team4.airbnb.exception;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class CustomExceptionHandler {

	@ExceptionHandler(CustomException.class)
	public ResponseEntity<Object> handleCustomException(CustomException exception) {
		return ResponseEntity.status(exception.getErrorCode().getStatus())
			.body(exception.getErrorCode());
	}

	@ExceptionHandler(BusinessException.class)
	public ResponseEntity<Object> handleBusinessException(BusinessException exception) {
		return ResponseEntity.status(exception.getHttpStatus())
			.body(exception.getBodyMessage());
	}
}
