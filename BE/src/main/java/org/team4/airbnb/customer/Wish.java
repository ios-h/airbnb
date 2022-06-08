package org.team4.airbnb.customer;

import java.util.Objects;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.team4.airbnb.customer.dto.WishRequest;
import org.team4.airbnb.domain.BaseCreated;

@Entity
@Builder
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
public class Wish extends BaseCreated {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "wish_id")
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "customer_id")
	private Customer customer;

	private Long accommodationId;

	public static Wish from(Customer customer, WishRequest wishRequest) {
		return Wish.builder()
			.customer(customer)
			.accommodationId(wishRequest.getAccommodationId())
			.build();
	}

	public static Wish from(Customer customer, Long accommodationId) {
		return Wish.builder()
			.customer(customer)
			.accommodationId(accommodationId)
			.build();
	}

	@Override
	public boolean equals(Object o) {
		if (this == o) {
			return true;
		}
		if (o == null || getClass() != o.getClass()) {
			return false;
		}
		Wish wish = (Wish) o;
		return id.equals(wish.id);
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}
}
