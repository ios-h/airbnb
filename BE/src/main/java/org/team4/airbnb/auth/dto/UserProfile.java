package org.team4.airbnb.auth.dto;

import java.util.Map;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor(access = AccessLevel.PRIVATE)
public class UserProfile {

	private final String oauthId;
	private final String email;

	public static UserProfile from(Map<String, Object> userInfo, String provider) {
		UserProfile userProfile = null;

		if(provider == "github") {
			userProfile = UserProfile.builder()
				.oauthId(String.valueOf(userInfo.get("id")))
				.email(String.valueOf(userInfo.get("email")))
				.build();
		}

		return userProfile;
	}

}
