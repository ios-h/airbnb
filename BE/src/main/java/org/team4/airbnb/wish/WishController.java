package org.team4.airbnb.wish;

import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
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
	public ResponseEntity<WishResponse> deleteWishInSearchList(@RequestParam Map<String, String> params) {
		ObjectMapper mapper = new ObjectMapper();
		WishRequest wishRequest = mapper.convertValue(params, WishRequest.class);

		WishResponse response = wishService.deleteWishInSearchList(wishRequest.getCustomerId(), wishRequest.getAccommodationId());

		return ResponseEntity.noContent().build();
	}

	@DeleteMapping("/wishlist/{wishId}")
	public ResponseEntity<WishResponse> deleteWishInWishList(@PathVariable Long wishId, @RequestParam Map<String, String> params) {
		ObjectMapper mapper = new ObjectMapper();
		WishRequest wishRequest = mapper.convertValue(params, WishRequest.class);

		WishResponse response = wishService.deleteWishInWishList(wishId, wishRequest.getCustomerId());

		return ResponseEntity.noContent().build();
	}
}
