package org.team4.airbnb.customer;

import javax.persistence.*;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.team4.airbnb.domain.Accommodation;
import org.team4.airbnb.domain.BaseCreated;

@Entity
@NoArgsConstructor(access = AccessLevel.PUBLIC)
@Getter
public class Wish extends BaseCreated {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "wish_id")
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "customer_id")
	private Customer customer;

	@OneToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "accommodation_id")
	private Accommodation accommodation;
}
