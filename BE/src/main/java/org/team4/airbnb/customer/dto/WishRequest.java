package org.team4.airbnb.customer.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@NoArgsConstructor
@Getter
@Setter
public class WishRequest {

	@JsonProperty("customer_id")
	private Long customerId;

	@JsonProperty("accommodation_id")
	private Long accommodationId;

}
