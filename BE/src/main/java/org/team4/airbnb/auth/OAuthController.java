package org.team4.airbnb.auth;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.team4.airbnb.auth.dto.LoginResponse;

@RequiredArgsConstructor
@RestController
public class OAuthController {

	private final OAuthService oAuthService;

	@GetMapping("/login/oauth2/github")
	public ResponseEntity<LoginResponse> processGitHubLogin(@RequestParam String code){
		String provider = "github";
		LoginResponse loginResponse = oAuthService.processLogin(provider, code);

		return ResponseEntity.ok().body(loginResponse);
	}
}
