package org.team4.airbnb.exception;

public class WishNotFoundException extends NotFoundException{

	@Override
	protected String getBodyMessage() {
		return "해당하는 위시리스트가 없습니다.";
	}
}
