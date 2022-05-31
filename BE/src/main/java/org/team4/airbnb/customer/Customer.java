package org.team4.airbnb.customer;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;
import lombok.NoArgsConstructor;

@Entity
@NoArgsConstructor
public class Customer {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "customer_id")
	private Long id;

	private String userId;

	@OneToMany(mappedBy = "customer")
	List<Wish> wishes = new ArrayList<>();
}
