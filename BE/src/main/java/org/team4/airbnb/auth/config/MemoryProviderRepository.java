package org.team4.airbnb.auth.config;

import java.util.Map;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class MemoryProviderRepository {

	private final Map<String, OauthProvider> providers;

	public OauthProvider findByProviderName(String name) {
		OauthProvider oauthProvider = providers.get(name);
		return oauthProvider;
	}
}
