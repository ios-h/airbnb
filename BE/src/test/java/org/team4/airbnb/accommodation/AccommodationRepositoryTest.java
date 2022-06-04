package org.team4.airbnb.accommodation;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.List;
import java.util.Set;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

@SpringBootTest
@Transactional
@Nested
@DisplayName("숙소 Repository에서")
class AccommodationRepositoryTest {

	private static final Set<Long> SAMPLE_IDS = Set.of(3L, 4L, 5L);

	@Autowired
	AccommodationRepository accommodationRepository;

	Logger logger = LoggerFactory.getLogger(AccommodationRepositoryTest.class);

	@Test
	@DisplayName("숙소 Id 목록으로 사진이 포함된 숙소 목록 검색")
	void findAllWithImagesById() {
		List<Accommodation> accommodations = accommodationRepository
			.findAllWithImagesByIdIn(SAMPLE_IDS);

		accommodations.forEach(a -> logger.info(a.toString()));

		assertThat(accommodations).hasSize(SAMPLE_IDS.size());
	}
}
