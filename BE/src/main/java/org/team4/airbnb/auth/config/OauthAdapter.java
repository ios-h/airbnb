package org.team4.airbnb.auth.config;

import java.util.HashMap;
import java.util.Map;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class OauthAdapter {

	public static Map<String, OauthProvider> getOauthProviders(OauthProperties properties) {
		Map<String, OauthProvider> oauthProviders = new HashMap<>();

		properties.getUsers().forEach(
			(vendor, user) -> oauthProviders.put(vendor, OauthProvider.from(user, properties.getProviders()
				.get(vendor))));
		return oauthProviders;
	}

}
