package org.team4.airbnb.auth.config;

import java.util.HashMap;
import java.util.Map;
import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;

@Getter
@ConfigurationProperties(prefix = "oauth")
public class OauthProperties {
	private final Map<String, User> users = new HashMap<>();

	private final Map<String, Provider> providers = new HashMap<>();

	@Getter
	@Setter
	public static class User {
		private String clientId;
		private String clientSecret;
		private String redirectUri;
	}

	@Getter
	@Setter
	public static class Provider {
		private String tokenUri;
		private String userInfoUri;
	}
}
