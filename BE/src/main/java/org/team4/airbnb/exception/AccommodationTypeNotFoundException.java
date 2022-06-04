package org.team4.airbnb.exception;

public class AccommodationTypeNotFoundException extends NotFoundException {

	@Override
	protected String getBodyMessage() {
		return "존재하지 숙소 타입입니다.";
	}
}
