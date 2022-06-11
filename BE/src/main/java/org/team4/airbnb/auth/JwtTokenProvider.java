package org.team4.airbnb.auth;


import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import javax.crypto.SecretKey;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;
import org.team4.airbnb.auth.domain.JwtPayload;

@Slf4j
@PropertySource(value = "classpath:jwt.properties", ignoreResourceNotFound = true)
@Component
public class JwtTokenProvider {

	@Value("${jwt.secretKey}")
	private String secretKey;

	public String createToken(JwtPayload payload) {
		SecretKey key = Keys.hmacShaKeyFor(Decoders.BASE64.decode(secretKey));

		payload.getPrivateClaim().put(payload.getPublicClaim(), "true");
		Claims claims = Jwts.claims(payload.getPrivateClaim());

		String token = Jwts.builder()
			.setHeaderParam("typ", "JWT")
			.setSubject(payload.getSubject())
			.setIssuedAt(payload.getIssuedAt())
			.setExpiration(payload.getExpiration())
			.setClaims(claims)
			.signWith(key, SignatureAlgorithm.HS256)
			.compact();

		return token;
	}

}
