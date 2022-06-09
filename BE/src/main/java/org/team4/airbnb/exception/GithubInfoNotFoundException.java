package org.team4.airbnb.exception;

public class GithubInfoNotFoundException extends NotFoundException{

	@Override
	protected String getBodyMessage() {
		return "github 회원정보를 가져올 수 없습니다.";
	}
}
