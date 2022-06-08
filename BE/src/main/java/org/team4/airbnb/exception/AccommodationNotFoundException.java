package org.team4.airbnb.exception;

public class AccommodationNotFoundException extends NotFoundException {

	@Override
	protected String getBodyMessage() {
		return "존재하지 않는 숙소입니다";
	}
}
