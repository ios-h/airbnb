package org.team4.airbnb.exception;

import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
public enum ErrorCode {
	NO_DATA_FOUND_CUSTOMER(HttpStatus.NOT_FOUND, "존재하지 않은 회원입니다."),
	NO_DATA_FOUND_ACCOMMODATION_TYPE(HttpStatus.NOT_FOUND, "존재하지 숙소 타입입니다."),
	NO_DATA_FOUND_RESERVATION(HttpStatus.NOT_FOUND, "존재하지 않는 예약입니다.");

	final HttpStatus status;
	final String message;

	ErrorCode(HttpStatus status, String message) {
		this.status = status;
		this.message = message;
	}
}
