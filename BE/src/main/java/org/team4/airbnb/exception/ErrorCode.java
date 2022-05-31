package org.team4.airbnb.exception;

import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
public enum ErrorCode {
	NO_DATA_FOUND_CUSTOMER(HttpStatus.NOT_FOUND, "존재하지 않은 회원입니다.");

	final HttpStatus status;
	final String message;

	ErrorCode(HttpStatus status, String message) {
		this.status = status;
		this.message = message;
	}
}
