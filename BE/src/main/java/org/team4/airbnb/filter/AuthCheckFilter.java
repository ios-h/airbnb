package org.team4.airbnb.filter;

import java.io.IOException;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.web.filter.OncePerRequestFilter;
import org.team4.airbnb.auth.JwtTokenProvider;
import org.team4.airbnb.exception.TokenInValidateException;

@Slf4j
@RequiredArgsConstructor
@WebFilter(urlPatterns = {"/api/wishlist/*", "/api/reservations/*"})
public class AuthCheckFilter extends OncePerRequestFilter {

	private final JwtTokenProvider jwtTokenProvider;

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
		FilterChain filterChain) throws ServletException, IOException {
		String header = request.getHeader(HttpHeaders.AUTHORIZATION);

		validateHeader(header);
		String accessToken = header.substring("Bearer ".length());

		jwtTokenProvider.validateJwtToken(accessToken);
//		Claims claims = jwtTokenProvider.parseJwtToken(accessToken);

		filterChain.doFilter(request, response);
	}

	private void validateHeader(String header) {
		if (header == null || !header.startsWith("Bearer ")) {
			throw new TokenInValidateException();
		}
	}
}
