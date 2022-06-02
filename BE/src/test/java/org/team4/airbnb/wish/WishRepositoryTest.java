package org.team4.airbnb.wish;


import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatExceptionOfType;

import java.util.NoSuchElementException;
import java.util.Optional;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;
import org.team4.airbnb.accommodation.AccommodationRepository;
import org.team4.airbnb.customer.CustomerRepository;

@SpringBootTest
@Transactional
class WishRepositoryTest {

	@Autowired
	WishRepository wishRepository;
	@Autowired
	CustomerRepository customerRepository;
	@Autowired
	AccommodationRepository accommodationRepository;

	private static final Long customerId = 1L;
	private static final Long accommodationId = 100L;
	private static final Long wishId = 1L;

	@Test
	@DisplayName("위시리스트에 특정 숙소 등록하기")
	void addWish() {
		//given
		Wish wish = new Wish();
		wish.setCustomer(customerRepository.findById(customerId).get());
		wish.setAccommodationId(accommodationId);

		//when
		Wish savedWish = wishRepository.save(wish);

		//then
		assertThat(savedWish).isNotNull();
		assertThat(savedWish.getAccommodationId()).isEqualTo(accommodationId);
	}

	@Test
	@DisplayName("위시리스트에 특정 숙소 삭제하기")
	void deleteWish() {
		//given
		Optional<Wish> wish = wishRepository.findById(wishId);

		//when
		wishRepository.delete(wish.get());

		//then
		assertThatExceptionOfType(NoSuchElementException.class)
			.isThrownBy(() -> wishRepository.findById(wishId).get());
	}
}
