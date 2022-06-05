package org.team4.airbnb.wish;

import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.team4.airbnb.wish.dto.WishRequest;
import org.team4.airbnb.wish.dto.WishResponse;

@RestController
@RequiredArgsConstructor
public class WishController {

	private final WishService wishService;

	@PostMapping("/wishlist")
	public ResponseEntity<WishResponse> addWishList(@RequestBody WishRequest wishRequest) {
		WishResponse response = wishService.addWishList(wishRequest);

		return ResponseEntity.status(HttpStatus.CREATED).body(response);
	}

	@DeleteMapping("/wishlist")
	public ResponseEntity<WishResponse> deleteWishList(@RequestBody WishRequest wishRequest) {
		WishResponse response = wishService.deleteWishList(wishRequest);

		return ResponseEntity.noContent().build();
	}
}
