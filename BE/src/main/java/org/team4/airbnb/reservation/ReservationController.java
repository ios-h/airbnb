package org.team4.airbnb.reservation;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.team4.airbnb.reservation.dto.ReservationRequest;
import org.team4.airbnb.reservation.dto.ReservationResponse;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/reservations")
public class ReservationController {

	private final ReservationService reservationService;

	@PostMapping
	public ResponseEntity<Object> make(@RequestBody ReservationRequest reservationRequest) {
		reservationService.make(reservationRequest);
		return ResponseEntity.ok().build();
	}

	@GetMapping
	public ReservationResponse allByCustomerId(@RequestParam("customerId") Long customerId, Pageable pageable) {
		return reservationService.findAllByCustomerId(customerId, pageable);
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<Object> cancel(@PathVariable("id") Long reservationId) {
		reservationService.cancel(reservationId);
		return ResponseEntity.ok().build();
	}
}