package org.team4.airbnb.auth;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.team4.airbnb.auth.config.MemoryProviderRepository;
import org.team4.airbnb.auth.config.OauthProvider;

@SpringBootTest
@DisplayName("MemoryProviderRepository 사용하여")
class OAuthRepositoryUseTest {

	@Autowired
	MemoryProviderRepository memoryProviderRepository;
	
	@Test
	@DisplayName("github OAuth 설정정보 객체 조회")
	void oauthRepositoryGetTest() {
		//when
		OauthProvider oauthProvider = memoryProviderRepository.findByProviderName("github");

		//then
		assertThat(oauthProvider).isNotNull();
	}

}