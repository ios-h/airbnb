package org.team4.airbnb.wish;


import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatExceptionOfType;

import java.util.NoSuchElementException;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;
import org.team4.airbnb.accommodation.AccommodationRepository;
import org.team4.airbnb.customer.CustomerRepository;
import org.team4.airbnb.util.EntityCreator;

@SpringBootTest
@Transactional
@Nested
@DisplayName("위시 Repository에서")
class WishRepositoryTest {

	@Autowired
	private WishRepository wishRepository;
	@Autowired
	private AccommodationRepository accommodationRepository;
	@Autowired
	private CustomerRepository customerRepository;


	@Test
	@DisplayName("위시리스트 등록하기")
	void addWish() {
		//given
		Wish wish = EntityCreator.createWish(customerRepository, accommodationRepository);

		//when
		Wish savedWish = wishRepository.save(wish);

		//then
		Assertions.assertAll(
			() -> assertThat(savedWish.getAccommodationId()).isEqualTo(wish.getAccommodationId()),
			() -> assertThat(savedWish.getCustomer()).isEqualTo(wish.getCustomer())
		);
	}

	@Test
	@DisplayName("위시리스트 삭제하기")
	void deleteWish() {
		//given
		Wish wish = wishRepository.findFirstBy();

		//when
		wishRepository.delete(wish);

		//then
		assertThatExceptionOfType(NoSuchElementException.class)
			.isThrownBy(() -> wishRepository.findById(wish.getId()).get());
	}
}
