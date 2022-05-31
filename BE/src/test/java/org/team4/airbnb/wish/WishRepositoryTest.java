package org.team4.airbnb.wish;


import static org.assertj.core.api.Assertions.*;

import java.util.NoSuchElementException;
import java.util.Optional;
import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;
import org.team4.airbnb.accommodation.AccommodationRepository;
import org.team4.airbnb.customer.CustomerRepository;
import org.team4.airbnb.domain.Accommodation;

@SpringBootTest
@Transactional
class WishRepositoryTest {

	@Autowired
	WishRepository wishRepository;
	@Autowired
	CustomerRepository customerRepository;
    @Autowired
	AccommodationRepository accommodationRepository;

	@Test
	@DisplayName("위시리스트에 특정 숙소 등록하기")
	void addWish() {
		//given
		Wish wish =  new Wish();
//		wish.setId(1L);
		wish.setCustomer(customerRepository.findById(1L).get());
		wish.setAccommodation(accommodationRepository.findById(100L).get());

		//when
		Wish savedWish = wishRepository.save(wish);

		//then
		assertThat(savedWish).isNotNull();
	}
	
	@Test
	@DisplayName("위시리스트에 특정 숙소 삭제하기")
	void deleteWish() {
		//given
		Optional<Wish> wish = wishRepository.findById(1L);

		//when
		wishRepository.delete(wish.get());

		//then
		assertThatExceptionOfType(NoSuchElementException.class)
			.isThrownBy(() -> wishRepository.findById(1L).get());
	}
}