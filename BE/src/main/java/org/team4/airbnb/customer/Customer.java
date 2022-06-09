package org.team4.airbnb.customer;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;
import org.team4.airbnb.domain.BaseCreated;


@Entity
@Builder
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Customer extends BaseCreated {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "customer_id")
	private Long id;

	private String userId;

	@Builder.Default
	@OneToMany(mappedBy = "customer", fetch = FetchType.LAZY)
	List<Wish> wishes = new ArrayList<>();

	public static Customer of(String userId) {
		return Customer.builder()
			.userId(userId)
			.build();
	}

	public List<Long> askAccommodationIdsOfWishes() {
		List<Long> accommodationIds = new ArrayList<>();
		for (Wish wish : wishes) {
			accommodationIds.add(wish.getAccommodationId());
		}
		return accommodationIds;
	}

	public List<Long> askWishIdsOfWishes() {
		return wishes.stream()
			.map(Wish::getId)
			.collect(Collectors.toList());
	}

	public Long getId() {
		return id;
	}

	@Override
	public String toString() {
		return "Customer{" +
			"id=" + id +
			", userId='" + userId + '\'' +
			'}';
	}
}
