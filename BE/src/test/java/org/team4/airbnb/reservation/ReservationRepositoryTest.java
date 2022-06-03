package org.team4.airbnb.reservation;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.List;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.PageRequest;
import org.springframework.transaction.annotation.Transactional;

@SpringBootTest
@Transactional
@Nested
@DisplayName("예약 Repository에서")
class ReservationRepositoryTest {

	@Autowired
	ReservationRepository reservationRepository;

	@Test
	@DisplayName("customerId로 숙소 정보를 포함한 예약 목록 검색")
	void findAllByCustomerId() {
		List<Reservation> reservations = reservationRepository
			.findAllByCustomerId(1L, PageRequest.of(0, 1));
		assertThat(reservations).hasSize(1);
	}
}
