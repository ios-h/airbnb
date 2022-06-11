package org.team4.airbnb.auth;


import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Encoders;
import io.jsonwebtoken.security.Keys;
import javax.crypto.SecretKey;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;
import org.team4.airbnb.auth.domain.JwtPayload;
import org.team4.airbnb.exception.TokenInValidateException;

@PropertySource(value = "classpath:jwt.properties", ignoreResourceNotFound = true)
@Component
public class JwtTokenProvider {

	@Value("${jwt.secretKey}")
	private String secretKey;


	public String createToken(JwtPayload payload) {
		SecretKey key = Keys.secretKeyFor(SignatureAlgorithm.HS256);
		Encoders.BASE64.encode(key.getEncoded());
		Claims claims = Jwts.claims(payload.getPrivateClaim());

		String token = Jwts.builder()
			.setSubject(payload.getSubject())
			.setIssuedAt(payload.getIssuedAt())
			.setExpiration(payload.getExpiration())
			.setClaims(claims)
			.signWith(key)
			.compact();

		return token;
	}

//	public Claims parseJwtToken(String token) {
//		String encodeSecretKey = Base64.getEncoder().encodeToString(secretKey.getBytes());
//
//		Claims claims = Jwts.parser()
//			.setSigningKey(encodeSecretKey)
//			.parseClaimsJws(token)
//			.getBody();
//
//		return claims;
//	}

	public String getAccessTokenFromHeader(String header) {
		validateHeader(header);
		String token = extractToken(header);

		return token;
	}

	private void validateHeader(String header) {
		if (header == null || !header.startsWith("Bearer ")) {
			throw new TokenInValidateException();
		}
	}

	private String extractToken(String authorizationHeader) {
		return authorizationHeader.substring("Bearer ".length());
	}

//	public void validateJwtToken(String accessToken) {
//		String encodeSecretKey = Base64.getEncoder().encodeToString(secretKey.getBytes());
//		Jws<Claims> claimsJws = Jwts.parser()
//			.setSigningKey(encodeSecretKey)
//			.parseClaimsJws(accessToken);
//
//		Claims body = claimsJws.getBody();
//		JwsHeader jwsHeader = claimsJws.getHeader();
//		String jwsSignature = claimsJws.getSignature();
//
//		JwsHeader header = claimsJws.getHeader();
//		String signature = claimsJws.getSignature();
//
//		System.out.println(body);
//		body.getExpiration();
//		body.getIssuedAt();
//	}
}
