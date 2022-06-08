package org.team4.airbnb.customer;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertAll;

import java.util.ArrayList;
import java.util.List;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.transaction.annotation.Transactional;
import org.team4.airbnb.accommodation.Accommodation;
import org.team4.airbnb.accommodation.AccommodationRepository;
import org.team4.airbnb.util.EntityCreator;

@DataJpaTest
@Transactional
@Nested
@DisplayName("고객 정보 Repository 에서")
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
class CustomerRepositoryTest {

	@Autowired
	CustomerRepository customerRepository;
	@Autowired
	AccommodationRepository accommodationRepository;
	@Autowired
	WishRepository wishRepository;

	@Test
	@DisplayName("위시리스트만 조회")
	void findById() {
		//given
		List<Wish> wishes = EntityCreator.세개의_Wish_생성_요청(customerRepository,
			accommodationRepository);

		//when
		List<Wish> savedWishes = wishRepository.saveAll(wishes);

		//then
		assertAll(
			() -> assertThat(savedWishes).hasSize(3),
			() -> assertThat(savedWishes).anyMatch(
				savedWish -> savedWish.equals(wishes.get(0)))
		);
	}

	@Test
	@DisplayName("위시리스트와 해당 숙소 조회")
	void findWishAndAccommodationById() {
		//given
		List<Wish> wishes = EntityCreator.세개의_Wish_생성_요청(customerRepository,
			accommodationRepository);

		//when
		List<Wish> savedWishes = wishRepository.saveAll(wishes);

		List<Long> accommodationIds = new ArrayList<>();
		for (Wish wish : savedWishes) {
			accommodationIds.add(wish.getId());
		}

		List<Accommodation> findAccommodations = accommodationRepository.findByIdIn(
			accommodationIds);

		//then
		assertAll(
			() -> assertThat(savedWishes).hasSize(3),
			() -> assertThat(savedWishes).anyMatch(
				savedWish -> savedWish.equals(wishes.get(0))),
			() -> assertThat(findAccommodations).hasSize(3),
			() -> assertThat(findAccommodations).anyMatch(accommodation -> accommodation.isNotNullName(accommodation))
		);
	}
}