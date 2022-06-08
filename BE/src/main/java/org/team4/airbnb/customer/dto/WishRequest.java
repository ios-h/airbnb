package org.team4.airbnb.customer.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@NoArgsConstructor
@Getter
@Setter
public class WishRequest {

	private Long customerId;

	private Long accommodationId;

}
