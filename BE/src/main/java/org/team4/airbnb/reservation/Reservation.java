package org.team4.airbnb.reservation;

import javax.persistence.*;
import java.time.LocalDate;
import org.team4.airbnb.customer.Customer;
import org.team4.airbnb.domain.Accommodation;
import org.team4.airbnb.domain.BaseCreated;

@Entity
public class Reservation extends BaseCreated {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "reservation_id")
	private Long id;

	private LocalDate checkInDate;

	private LocalDate checkOutDate;

	private int numberOfGuest;

	private int numberOfInfant;

	@Embedded
	private Invoice invoice;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "accommodation_id")
	private Accommodation accommodation;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "customer_id")
	private Customer customer;
}
