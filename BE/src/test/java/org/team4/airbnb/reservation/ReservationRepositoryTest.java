package org.team4.airbnb.reservation;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.List;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

@SpringBootTest
@Transactional
class ReservationRepositoryTest {

	@Autowired
	ReservationRepository reservationRepository;

	@Test
	@DisplayName("customerId로 reservation 목록 검색")
	void findAllByCustomerId() {
		List<Reservation> reservations = reservationRepository.findAllByCustomerId(2L);

		assertThat(reservations).hasSize(2);
	}
}
