package org.team4.airbnb.auth;


import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.IncorrectClaimException;
import io.jsonwebtoken.InvalidClaimException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.MissingClaimException;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import javax.crypto.SecretKey;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;
import org.team4.airbnb.auth.domain.JwtPayload;
import org.team4.airbnb.exception.TokenExpiredException;
import org.team4.airbnb.exception.TokenInValidateException;

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
			.setClaims(claims)
			.setSubject(payload.getSubject())
			.setIssuedAt(payload.getIssuedAt())
			.setExpiration(payload.getExpiration())
			.signWith(key, SignatureAlgorithm.HS256)
			.compact();

		return token;
	}


	public Claims parseJwtToken(String accessToken) {
		SecretKey key = Keys.hmacShaKeyFor(Decoders.BASE64.decode(secretKey));

		return Jwts.parserBuilder()
			.setSigningKey(key)
			.build()
			.parseClaimsJws(accessToken)
			.getBody();
	}

	public Claims validateJwtToken(String accessToken) throws TokenInValidateException, TokenExpiredException {
		SecretKey key = Keys.hmacShaKeyFor(Decoders.BASE64.decode(secretKey));
		Claims body = null;

		long seconds = 3 * 60; //3 minutes

		try {
			body = Jwts.parserBuilder()
				.setAllowedClockSkewSeconds(seconds)
				.requireSubject("team4Airbnb")
				.require("http://org.team4.airbnb", "true")
				.setSigningKey(key)
				.build()
				.parseClaimsJws(accessToken)
				.getBody();
		} catch (MissingClaimException missingClaimException) {
			log.error("**validateJwtToken: MissingClaimException 발생",
				new TokenInValidateException());
			throw new TokenInValidateException();
		} catch (IncorrectClaimException incorrectClaimException) {
			log.error("**validateJwtToken: IncorrectClaimException 발생",
				new TokenInValidateException());
			throw new TokenInValidateException();
		} catch (InvalidClaimException invalidClaimException) {
			log.error("**validateJwtToken: MissingClaimException 발생",
				new TokenInValidateException());
			throw new TokenInValidateException();
		} catch (ExpiredJwtException expiredJwtException) {
			throw new TokenExpiredException();
		}

		return body;
	}
}
