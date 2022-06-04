package org.team4.airbnb.reservation;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.List;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.junit.jupiter.params.provider.ValueSource;
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

	@ParameterizedTest
	@CsvSource({"1, 0, 1, 1", "1, 0, 10, 2"})
	@DisplayName("customerId로 숙소 정보를 포함한 예약 목록 검색")
	void findAllByCustomerId(Long customerId, int page, int size, int expectedCount) {
		List<Reservation> reservations = reservationRepository
			.findAllByCustomerId(customerId, PageRequest.of(page, size));
		assertThat(reservations).hasSize(expectedCount);
	}
}
