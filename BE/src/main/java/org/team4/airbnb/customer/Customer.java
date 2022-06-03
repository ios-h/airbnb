package org.team4.airbnb.customer;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;
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
}
