package org.team4.airbnb.customer;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;
import org.team4.airbnb.accommodation.Accommodation;
import org.team4.airbnb.accommodation.AccommodationRepository;
import org.team4.airbnb.wish.Wish;

@SpringBootTest
@Transactional
@Nested
@DisplayName("고객 정보 Repository 에서")
class CustomerRepositoryTest {

	@Autowired
	CustomerRepository customerRepository;
	@Autowired
	AccommodationRepository accommodationRepository;

	@Test
	@DisplayName("위시리스트만 조회")
	void findById() {
		//when
		Optional<Customer> findCustomer = customerRepository.findById(1L);
		List<Wish> wishes = findCustomer.get().getWishes();

		//then
		assertThat(findCustomer).isNotEmpty();
		assertThat(wishes).hasSize(3).anyMatch(wish -> wish.getCustomer().getId() == 1);
	}

	@Test
	@DisplayName("위시리스트와 해당 숙소 조회")
	void findWishAndAccommodationById() {
		//when
		Optional<Customer> findCustomer = customerRepository.findById(1L);
		List<Wish> wishes = findCustomer.get().getWishes();

		List<Long> accommodationIds = new ArrayList<>();
		for (Wish wish : wishes) {
			accommodationIds.add(wish.getId());
		}

		List<Accommodation> findAccommodations = accommodationRepository.findByIdIn(
			accommodationIds);

		//then
		assertThat(findCustomer).isNotEmpty();
		assertThat(wishes).hasSize(3).anyMatch(wish -> wish.getCustomer().getId() == 1);
		assertThat(findAccommodations).hasSize(3).anyMatch(Objects::nonNull);
	}
}