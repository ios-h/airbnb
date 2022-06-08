package org.team4.airbnb.auth;

import java.nio.charset.StandardCharsets;
import java.util.Collections;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.reactive.function.client.WebClient;
import org.team4.airbnb.auth.config.MemoryProviderRepository;
import org.team4.airbnb.auth.config.OauthProvider;
import org.team4.airbnb.auth.dto.OauthTokenResponse;
import org.team4.airbnb.auth.dto.UserProfile;

@RequiredArgsConstructor
@Service
public class OAuthService {

	private final MemoryProviderRepository memoryProviderRepository;

	/*Todo
				1. authcode를 통해 OAuth서버에서 access token 얻어오기
				2. access token을 통해 유저 정보 얻어오기
				3. 유저 DB에 저장
	*/
	public LoginResponse processLogin(String provider, String authCode) {
		OauthProvider oauthProvider = memoryProviderRepository.findByProviderName(provider);

		//1. access token 얻어오기
		OauthTokenResponse tokenResponse = getAccessTokenFromOauth(authCode, oauthProvider);

		//2. 유저 정보 얻어오기
		UserProfile userProfile = getUserInfoFromOauth(provider, oauthProvider,
			tokenResponse);

		//3. DB에 유저 정보 저장 (최초 로그인 시 1번)

		return null;
	}


	private OauthTokenResponse getAccessTokenFromOauth(String authCode, OauthProvider oauthProvider) {
		OauthTokenResponse oauthTokenResponse = WebClient.create()
			.post()
			.uri(oauthProvider.getTokenUrl())
			.headers(httpHeaders -> {
				httpHeaders.setBasicAuth(oauthProvider.getClientId(),
					oauthProvider.getClientSecret());
				httpHeaders.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
				httpHeaders.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
				httpHeaders.setAcceptCharset((Collections.singletonList(StandardCharsets.UTF_8)));
			})
			.bodyValue(makeBodyForTokenRequest(authCode, oauthProvider))
			.retrieve()
			.bodyToMono(OauthTokenResponse.class)
			.block();

		return oauthTokenResponse;
	}

	private MultiValueMap<String, String> makeBodyForTokenRequest(String authCode,
		OauthProvider oauthProvider) {
		MultiValueMap<String, String> formData = new LinkedMultiValueMap<>();
		formData.add("client_id", oauthProvider.getClientId());
		formData.add("client_secret", oauthProvider.getClientSecret());
		formData.add("code", authCode);
		formData.add("grant_type", "authorization_code");
		formData.add("redirect_uri", oauthProvider.getRedirectUrl()); //다시 controller들어올텐데..

		return formData;
	}


	private UserProfile getUserInfoFromOauth(String provider, OauthProvider oauthProvider,
		OauthTokenResponse tokenResponse) {
		Map<String, Object> userInfo = requestToOauthServer(oauthProvider, tokenResponse);
		UserProfile userProfile = UserProfile.from(userInfo, provider);

		return userProfile;
	}

	private Map<String, Object> requestToOauthServer(OauthProvider oauthProvider,
		OauthTokenResponse tokenResponse) {

		Map<String, Object> userInfoResponse = WebClient.create()
			.get()
			.uri(oauthProvider.getUserInfoUrl())
			.headers(httpHeaders -> httpHeaders.setBearerAuth(tokenResponse.getAccessToken()))
			.retrieve()
			.bodyToMono(new ParameterizedTypeReference<Map<String, Object>>() {
			})
			.block();

		return userInfoResponse;
	}
}
