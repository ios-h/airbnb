package org.team4.airbnb.auth.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class OauthTokenResponse {
	@JsonProperty("access_token")
	private String accessToken;

	private String scope;

	@JsonProperty("token_type")
	private String tokenType;
}
