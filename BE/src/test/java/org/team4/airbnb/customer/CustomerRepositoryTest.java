package org.team4.airbnb.customer;

import static org.assertj.core.api.Assertions.*;

import java.util.List;
import java.util.Optional;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;
import org.team4.airbnb.wish.Wish;

@SpringBootTest
@Transactional
class CustomerRepositoryTest {

	@Autowired
	CustomerRepository customerRepository;

	@Test
	@DisplayName("customerId로 위시리스트 조회하기")
	void findById() {
		//when
		Optional<Customer> findCustomer = customerRepository.findById(1L);
		List<Wish> wishes = findCustomer.get().getWishes();

		//then
		assertThat(findCustomer).isNotEmpty();
		assertThat(wishes).hasSize(3).anyMatch(wish -> wish.getCustomer().getId() == 1);
	}
}