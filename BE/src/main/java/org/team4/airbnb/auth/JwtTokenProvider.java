package org.team4.airbnb.auth;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Header;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

@PropertySource(value = "classpath:jwt.properties", ignoreResourceNotFound = true)
@Component
class JwtTokenProvider {

	@Value("${jwt.secretKey}")
	private String secretKey;

	private final long tokenValidityInMilliseconds = Duration.ofMillis(30).toMillis();

	String createAccessToken(String userId){
		//private claims 생성
		Map<String, Object> claimsAttribute = new HashMap<>();
		claimsAttribute.put("userId",userId);

		Claims claims = Jwts.claims(claimsAttribute);
		return createToken(claims);
	}

	String createRefreshToken(){
		byte[] bytes = new byte[7];
		new Random().nextBytes(bytes);
		String claimSubjectForRefreshToken = new String(bytes, StandardCharsets.UTF_8);
		
		//registered claim : sub 생성
		Claims claims = Jwts.claims().setSubject(claimSubjectForRefreshToken);
		return createToken(claims);
	}

	private String createToken(Claims claims) {
		long currentTime = System.currentTimeMillis();
		Date now = new Date();

		String jwtToken = Jwts.builder()
			.setHeaderParam(Header.TYPE, Header.JWT_TYPE) //Header 셋팅 : 토큰 타입 정보 typ
			//payload - registered claim 셋팅
			.setIssuer("team4")  //iss
			.setIssuedAt(new Date(currentTime)) //iat
			.setExpiration(new Date(now.getTime() + tokenValidityInMilliseconds)) //exp
			//payload - private claim
			.setClaims(claims)
			.signWith(SignatureAlgorithm.HS256, "keySecret") //해싱알고리즘, 시크릿키

			.compact();

		return jwtToken;
	}
}
