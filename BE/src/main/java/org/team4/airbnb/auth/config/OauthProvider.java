package org.team4.airbnb.auth.config;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import org.team4.airbnb.auth.config.OauthProperties.Provider;
import org.team4.airbnb.auth.config.OauthProperties.User;

@Getter
@Builder
@AllArgsConstructor
public class OauthProvider {

	private final String clientId;
	private final String clientSecret;
	private final String redirectUrl;
	private final String tokenUrl;
	private final String userInfoUrl;

	public static OauthProvider from(User user, Provider provider) {
		return OauthProvider.builder()
			.clientId(user.getClientId())
			.clientSecret(user.getClientSecret())
			.redirectUrl(user.getRedirectUri())
			.tokenUrl(provider.getTokenUri())
			.userInfoUrl(provider.getUserInfoUri())
			.build();
	}
}
