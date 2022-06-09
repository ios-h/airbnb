package org.team4.airbnb.customer;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.team4.airbnb.customer.dto.AccommodationForWishListResponse;

@RestController
@RequiredArgsConstructor
public class CustomerController {

	private final CustomerService customerService;

	@GetMapping("/api/wishlist")
	public ResponseEntity<AccommodationForWishListResponse> getWishlistByCustomerId(@RequestParam Long customerId) {
		AccommodationForWishListResponse bodyResponse = customerService.getWishListByCustomerId(
			customerId);

		return ResponseEntity.ok().body(bodyResponse);
	}

}
