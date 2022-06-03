package org.team4.airbnb.accommodation;

import static org.assertj.core.api.Assertions.*;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

@SpringBootTest
@Transactional
class AccommodationRepositoryTest {

	@Autowired
	AccommodationRepository accommodationRepository;

	@Test
	@DisplayName("accommodationId 목록으로 accommodation 검색")
	void findAllWithImagesById() {
		Set<Long> ids = new HashSet<>();
		ids.add(4L);
		ids.add(5L);
		List<Accommodation> accommodations = accommodationRepository.findAllWithImagesById(ids);

		assertThat(accommodations).hasSize(2);
	}
}
