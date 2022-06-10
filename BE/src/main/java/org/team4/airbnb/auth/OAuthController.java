package org.team4.airbnb.auth;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
public class OAuthController {

	private final OAuthService oAuthService;

	@GetMapping("/login/oauth2/github")
	public ResponseEntity<LoginResponse> processGigHubLogin(@RequestParam String code){
		String provider = "github";
		LoginResponse loginResponse = oAuthService.processLogin(provider, code);
		System.out.println();
		return ResponseEntity.ok().body(loginResponse);
	}
}
