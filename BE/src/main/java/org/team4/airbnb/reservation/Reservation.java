package org.team4.airbnb.reservation;

import java.time.LocalDate;
import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import lombok.Getter;
import org.team4.airbnb.accommodation.Accommodation;
import org.team4.airbnb.customer.Customer;
import org.team4.airbnb.domain.BaseCreated;

@Entity
@Getter
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

	public int getInvoiceTotal() {
		return invoice.getTotal();
	}
}
