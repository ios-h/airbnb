package org.team4.airbnb.auth;

import io.jsonwebtoken.Header;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.Collections;
import java.util.Date;
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

	public LoginResponse processLogin(String provider, String authCode) {
		OauthProvider oauthProvider = memoryProviderRepository.findByProviderName(provider);

		//1. access token 얻어오기
		OauthTokenResponse tokenResponse = getAccessTokenFromOauth(authCode, oauthProvider);

		//2. 유저 정보 얻어오기
		UserProfile userProfile = getUserInfoFromOauth(provider, oauthProvider,
			tokenResponse);
		String userIdViaUserProfile = userProfile.getUserId();

		if (userIdViaUserProfile == null) {
			new GithubInfoNotFoundException();
		}

		//3. DB에 유저 정보 저장 (최초 로그인 시 1번)
		Customer customer = Customer.of(userIdViaUserProfile);
		//기존 db에 사용자 있는지 확인 후, 없다면 DB에 유저 정보 저장 후 로그인처리
		Customer findCustomer = customerRepository.findByUserId(userIdViaUserProfile)
			.orElse(null);

		if(findCustomer == null) {
			customer = customerRepository.save(customer);
		}

		//4. JWT 토큰 생성 후 전달
		String jwtToken = makeJwtToken(userIdViaUserProfile);

		return null;
	}

	private String makeJwtToken(String userId){
		long currentTime = System.currentTimeMillis();
		Date now = new Date();

		String jwtToken = Jwts.builder()
			.setHeaderParam(Header.TYPE, Header.JWT_TYPE) //Header 셋팅 : 토큰 타입 정보 typ
			//payload - registered claim 셋팅
			.setIssuer("team4")  //iss
			.setIssuedAt(new Date(currentTime)) //iat
			.setExpiration(new Date(now.getTime() + Duration.ofMillis(30).toMillis())) //exp
			//payload - private claim
			.claim("userId",userId)
			.signWith(SignatureAlgorithm.HS256, "keySecret") //해싱알고리즘, 시크릿키
			.compact();

			return jwtToken;
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
