package org.team4.airbnb.exception;

public class CustomerNotFoundException extends NotFoundException {

	@Override
	protected String getBodyMessage() {
		return "존재하지 않은 회원입니다.";
	}
}
