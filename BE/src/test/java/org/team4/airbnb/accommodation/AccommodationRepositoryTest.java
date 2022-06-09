package org.team4.airbnb.accommodation;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.List;
import java.util.Set;
import java.util.stream.Stream;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.transaction.annotation.Transactional;

@DataJpaTest
@Transactional
@Nested
@DisplayName("숙소 Repository에서")
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
class AccommodationRepositoryTest {

	@Autowired
	AccommodationRepository accommodationRepository;

	Logger logger = LoggerFactory.getLogger(AccommodationRepositoryTest.class);

	@ParameterizedTest
	@MethodSource("provideSampleIds")
	@DisplayName("숙소 Id 목록으로 사진이 포함된 숙소 목록 검색")
	void findAllWithImagesById(Set<Long> sampleIds) {
		List<Accommodation> accommodations = accommodationRepository
			.findAllWithImagesByIdIn(sampleIds);

		accommodations.forEach(a -> logger.info(a.toString()));

		assertThat(accommodations).hasSize(sampleIds.size());
	}

	private static Stream<Arguments> provideSampleIds() {
		return Stream.of(
			Arguments.of(Set.of(3L, 4L, 5L)),
			Arguments.of(Set.of(1L, 5L, 8L, 10L))
		);
	}
}
