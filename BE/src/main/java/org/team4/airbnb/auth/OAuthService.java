package org.team4.airbnb.auth;

import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import lombok.RequiredArgsConstructor;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.reactive.function.client.WebClient;
import org.team4.airbnb.auth.config.MemoryProviderRepository;
import org.team4.airbnb.auth.config.OauthProvider;
import org.team4.airbnb.auth.domain.JwtPayload;
import org.team4.airbnb.auth.dto.LoginResponse;
import org.team4.airbnb.auth.dto.OauthTokenResponse;
import org.team4.airbnb.auth.dto.UserProfile;
import org.team4.airbnb.customer.Customer;
import org.team4.airbnb.customer.CustomerRepository;
import org.team4.airbnb.exception.GithubInfoNotFoundException;

@RequiredArgsConstructor
@Service
public class OAuthService {

	private final MemoryProviderRepository memoryProviderRepository;
	private final CustomerRepository customerRepository;
	private final JwtTokenProvider jwtTokenProvider;

	private final String TOKEN_TYPE = "Bearer";
	private final long VALID_TIME_ACCESS_TOKEN = Duration.ofMillis(300).toMillis();
	private final long VALID_TIME_REFRESH_TOKEN = Duration.ofMillis(600).toMillis();

	private final Random random = new Random();

	@Transactional
	public LoginResponse processLogin(String provider, String authCode) {
		OauthProvider oauthProvider = memoryProviderRepository.findByProviderName(provider);

		String userId = processOauth(provider, authCode, oauthProvider);
		checkIsAndSignUpMember(userId);
		LoginResponse response = createJwtTokenAndMakeResponse(userId);

		return response;
	}

	/**
	 * JWT token을 생성하고, 로그인 응답 DTO 객체를 생성한다.
	 *
	 * @param userId
	 * @return 로그인 응답 DTO
	 */
	private LoginResponse createJwtTokenAndMakeResponse(String userId) {
		Date issuedAt = new Date(System.currentTimeMillis());
		Map<String, Object> privateClaim = new HashMap<>();
		privateClaim.put("userid", userId);
		privateClaim.put("role", "customer");

		String accessToken = jwtTokenProvider.createToken(makePayloadForAccessToken(privateClaim, issuedAt));
		String refreshToken = jwtTokenProvider.createToken(makePayloadForRefreshToken(privateClaim, issuedAt));

		return LoginResponse.of(accessToken, refreshToken, TOKEN_TYPE);
	}

	private JwtPayload makePayloadForAccessToken(Map<String, Object> privateClaim, Date issuedAt) {
		Date expiration = new Date(System.currentTimeMillis() + VALID_TIME_ACCESS_TOKEN);
		return JwtPayload.of(issuedAt, expiration, privateClaim);
	}

	private JwtPayload makePayloadForRefreshToken(Map<String, Object> privateClaim, Date issuedAt) {
		Date expiration = new Date(System.currentTimeMillis() + VALID_TIME_REFRESH_TOKEN);

		byte[] bytes = new byte[7];
		random.nextBytes(bytes);
		privateClaim.put("refresh", new String(bytes, StandardCharsets.UTF_8));

		return JwtPayload.of(issuedAt, expiration, privateClaim);
	}

	/**
	 * 회원 DB에 해당 회원정보 없을 경우, 가입 처리 가입 처리는, 최초 로그인 시 1번 수행된다.
	 *
	 * @param userId
	 */
	private void checkIsAndSignUpMember(String userId) {
		customerRepository.findByUserId(userId)
			.ifPresentOrElse(customer -> {
				},
				() -> customerRepository.save(Customer.of(userId)));
	}

	/**
	 * github 인증서버와 인증 처리를 하고, 사용자 정보를 가져온다. 서드파티에서 제공하는 사용자 정보중, userId 정보만 사용하기 때문에 userId를 반환한다.
	 *
	 * @param provider
	 * @param authCode
	 * @param oauthProvider
	 * @return userId
	 */
	private String processOauth(String provider, String authCode, OauthProvider oauthProvider) {
		//1. OAuth access token 얻어오기
		OauthTokenResponse tokenResponse = getAccessTokenFromOauth(authCode, oauthProvider);

		//2. OAuth 유저 정보 얻어오기
		UserProfile userProfile = getUserInfoFromOauth(provider, oauthProvider,
			tokenResponse);
		String userId = userProfile.getUserId();

		if (userId == null) {
			new GithubInfoNotFoundException();
		}
		return userId;
	}

	private OauthTokenResponse getAccessTokenFromOauth(String authCode,
		OauthProvider oauthProvider) {
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
