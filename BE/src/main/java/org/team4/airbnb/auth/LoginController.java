package org.team4.airbnb.auth;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.view.RedirectView;

@Controller
public class LoginController {

	@GetMapping("/login")
	public RedirectView requestGithubLoginUrl(){
		String githubLoginUrl = "https://github.com/login/oauth/authorize?client_id=941c51754821fc586dd4&scope=read:user";
		return new RedirectView(githubLoginUrl);
	}
}
