package org.team4.airbnb.auth.domain;

import java.util.Date;
import java.util.Map;
import lombok.AllArgsConstructor;
import lombok.Builder;

@Builder
@AllArgsConstructor
public class JwtPayload {

	//registered claim
	private final String subject = "team4Airbnb";
	private final Date issuedAt;
	private final Date expiration;

	//public claim
	private final String publicClaim = "http://org.team4.airbnb";

	//private claim
	private final Map<String, String> privateClaim;

	public static JwtPayload of(Date issuedAt, Date expiration,	Map<String, String> privateClaim){

		return JwtPayload.builder()
			.issuedAt(issuedAt)
			.expiration(expiration)
			.privateClaim(privateClaim)
			.build();
	}
}
