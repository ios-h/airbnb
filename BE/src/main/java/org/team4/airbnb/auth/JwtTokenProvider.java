package org.team4.airbnb.auth;


import io.jsonwebtoken.Claims;
import io.jsonwebtoken.IncorrectClaimException;
import io.jsonwebtoken.InvalidClaimException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.MissingClaimException;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import java.util.Date;
import javax.crypto.SecretKey;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;
import org.team4.airbnb.auth.domain.JwtPayload;
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
			.setSubject(payload.getSubject())
			.setIssuedAt(payload.getIssuedAt())
			.setExpiration(payload.getExpiration())
			.setClaims(claims)
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

	public Claims validateJwtToken(String accessToken) throws TokenInValidateException{
		SecretKey key = Keys.hmacShaKeyFor(Decoders.BASE64.decode(secretKey));
		Claims body = null;

		try {
			body = Jwts.parserBuilder()
				.requireSubject("team4Airbnb")
				.require("http://org.team4.airbnb", "true")
				.requireExpiration(new Date(System.currentTimeMillis()))
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
		}

		return body;
	}
}
