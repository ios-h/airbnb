package org.team4.airbnb.filter;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.jsonwebtoken.Claims;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.web.filter.OncePerRequestFilter;
import org.team4.airbnb.auth.JwtTokenProvider;
import org.team4.airbnb.exception.ErrorResponse;
import org.team4.airbnb.exception.TokenExpiredException;
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

		try {
			validateHeader(header);
			String accessToken = header.substring("Bearer ".length());

			Claims claims = jwtTokenProvider.validateJwtToken(accessToken);

			filterChain.doFilter(request, response);
		} catch (TokenInValidateException inValidateException) {
			ErrorResponse errorResponse = new ErrorResponse(
				new String("invalid token".getBytes(), StandardCharsets.UTF_8));
			response.setStatus(HttpStatus.UNAUTHORIZED.value());
			response.getWriter().write(convertObjectToJson(errorResponse));
		} catch (TokenExpiredException expiredException) {
			ErrorResponse errorResponse = new ErrorResponse(
				new String("authentication is expired".getBytes(), StandardCharsets.UTF_8));
			response.setStatus(HttpStatus.UNAUTHORIZED.value());
			response.getWriter().write(convertObjectToJson(errorResponse));
		}
	}

	private void validateHeader(String header) throws TokenInValidateException {
		if (header == null || !header.startsWith("Bearer ")) {
			throw new TokenInValidateException();
		}
	}

	private String convertObjectToJson(Object object) throws JsonProcessingException {
		if (object == null) {
			return null;
		}
		ObjectMapper mapper = new ObjectMapper();
		return mapper.writeValueAsString(object);
	}
}
