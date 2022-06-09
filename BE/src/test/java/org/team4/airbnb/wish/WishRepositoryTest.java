package org.team4.airbnb.wish;


import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatExceptionOfType;
import static org.junit.jupiter.api.Assertions.assertAll;

import java.util.NoSuchElementException;
import javax.persistence.EntityManager;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.transaction.annotation.Transactional;
import org.team4.airbnb.accommodation.AccommodationRepository;
import org.team4.airbnb.customer.CustomerRepository;
import org.team4.airbnb.customer.Wish;
import org.team4.airbnb.customer.WishRepository;
import org.team4.airbnb.util.EntityCreator;

@DataJpaTest
@Transactional
@Nested
@DisplayName("위시 Repository에서")
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
class WishRepositoryTest {

	@Autowired
	private WishRepository wishRepository;
	@Autowired
	private AccommodationRepository accommodationRepository;
	@Autowired
	private CustomerRepository customerRepository;

	@Autowired
	EntityManager entityManager;

	@Test
	@DisplayName("위시리스트 등록하기")
	void addWish() {
		//given
		Wish wish = EntityCreator.한개의_Wish_생성_요청(customerRepository, accommodationRepository);

		//when
		Wish savedWish = wishRepository.save(wish);

		//then
		assertAll(
			() -> assertThat(savedWish.getAccommodationId()).isEqualTo(wish.getAccommodationId()),
			() -> assertThat(savedWish).isEqualTo(wish)
		);
	}

	@Test
	@DisplayName("위시리스트 삭제하기 - wishId로 위시리스트 목록화면에서 삭제")
	void deleteWishInWishList() {
		//given
		Wish wish = wishRepository.findFirstBy();

		//when
		wishRepository.delete(wish);

		//then
		assertThatExceptionOfType(NoSuchElementException.class)
			.isThrownBy(() -> wishRepository.findById(wish.getId()).get());
	}

	@Test
	@DisplayName("위시리스트 삭제하기 - 숙소 검색화면에서 삭제")
	void deleteWishInSearchList() {
		//given
		Wish wish = wishRepository.findFirstBy();

		//when
		wishRepository.deleteByCustomerIdAndAccommodationId(wish.getCustomer().getId(),
			wish.getAccommodationId());
		entityManager.flush();

		//then
		assertThatExceptionOfType(NoSuchElementException.class)
			.isThrownBy(() -> wishRepository.findById(wish.getId()).get());
	}
}
