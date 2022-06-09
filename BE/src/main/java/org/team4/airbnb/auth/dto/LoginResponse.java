package org.team4.airbnb.auth.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LoginResponse {

	private String accessToken;
	private String freshToken;
	private String tokenType;

}
