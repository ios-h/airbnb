package org.team4.airbnb.customer;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class CustomerController {

	private final CustomerService customerService;

	@GetMapping("/wishlist")
	public void getWishlistByCustomerId(@RequestParam Long customerId) {
		customerService.getWishListByCustomerId(customerId);
	}

}
