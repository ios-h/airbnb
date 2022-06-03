package org.team4.airbnb.customer;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.team4.airbnb.wish.Wish;

@Entity
@NoArgsConstructor
@Getter
public class Customer {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "customer_id")
	private Long id;

	private String userId;

	@OneToMany(mappedBy = "customer", fetch = FetchType.LAZY)
	List<Wish> wishes = new ArrayList<>();

	@Override
	public String toString() {
		return "Customer{" +
			"id=" + id +
			", userId='" + userId + '\'' +
			'}';
	}
}
