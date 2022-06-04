package org.team4.airbnb.wish;

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
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.team4.airbnb.customer.Customer;
import org.team4.airbnb.domain.BaseCreated;

@Entity
@NoArgsConstructor(access = AccessLevel.PUBLIC)
@Setter
public class Wish extends BaseCreated {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "wish_id")
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "customer_id")
	private Customer customer;

	private Long accommodationId;

	public Long getId() {
		return id;
	}

	public Long getAccommodationId() {
		return accommodationId;
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
