package org.team4.airbnb.auth.config;

import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@RequiredArgsConstructor
@Configuration
@EnableConfigurationProperties(OauthProperties.class)
public class OauthConfig {

	private final OauthProperties properties;

	@Bean
	public MemoryProviderRepository memoryProviderRepository() {
		Map<String, OauthProvider> providers = OauthAdapter.getOauthProviders(properties);
		return new MemoryProviderRepository(providers);
	}
}
