package org.team4.airbnb.auth.domain;

import java.util.Date;
import java.util.Map;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor
public class JwtPayload {

	//registered claim
	@Builder.Default
	private final String subject = "team4Airbnb";
	private final Date issuedAt;
	private final Date expiration;

	//public claim
	@Builder.Default
	private final String publicClaim = "http://org.team4.airbnb";

	//private claim
	private final Map<String, Object> privateClaim;

	public static JwtPayload of(Date issuedAt, Date expiration,	Map<String, Object> privateClaim){

		return JwtPayload.builder()
			.issuedAt(issuedAt)
			.expiration(expiration)
			.privateClaim(privateClaim)
			.build();
	}
}
