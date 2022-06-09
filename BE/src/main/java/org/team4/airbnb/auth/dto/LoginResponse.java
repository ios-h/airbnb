package org.team4.airbnb.auth.dto;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
@AllArgsConstructor(access = AccessLevel.PRIVATE)
public class LoginResponse {

	private String accessToken;
	private String freshToken;
	private String tokenType;

	public static LoginResponse of(String accessToken, String freshToken, String tokenType) {
		return LoginResponse.builder()
			.accessToken(accessToken)
			.freshToken(freshToken)
			.tokenType(tokenType)
			.build();
	}

}
