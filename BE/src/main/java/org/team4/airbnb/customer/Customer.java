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
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.team4.airbnb.wish.Wish;

@Entity
@NoArgsConstructor
@Setter
public class Customer {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "customer_id")
	private Long id;

	private String userId;

	@OneToMany(mappedBy = "customer", fetch = FetchType.LAZY)
	List<Wish> wishes = new ArrayList<>();

	public List<Long> askAccommodationIdsOfWishes(){
		List<Long> accommodationIds = new ArrayList<>();
		for (Wish wish : wishes) {
			accommodationIds.add(wish.getAccommodationId());
		}
		return accommodationIds;
	}

	public List<Long> askWishIdsOfWishes(){
		return wishes.stream()
			.map(Wish::getId)
			.collect(Collectors.toList());
	}

	@Override
	public String toString() {
		return "Customer{" +
			"id=" + id +
			", userId='" + userId + '\'' +
			'}';
	}
}
