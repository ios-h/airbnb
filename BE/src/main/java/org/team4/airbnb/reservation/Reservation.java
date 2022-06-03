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
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.ToString;
import org.hibernate.annotations.DynamicUpdate;
import org.team4.airbnb.accommodation.Accommodation;
import org.team4.airbnb.customer.Customer;
import org.team4.airbnb.domain.BaseCreated;

@Entity
@Getter
@ToString
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@DynamicUpdate
public class Reservation extends BaseCreated {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "reservation_id")
	private Long id;

	private LocalDate checkInDate;

	private LocalDate checkOutDate;

	private Integer numberOfGuest;

	private Integer numberOfInfant;

	@Embedded
	private Invoice invoice;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "accommodation_id")
	@ToString.Exclude
	private Accommodation accommodation;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "customer_id")
	@ToString.Exclude
	private Customer customer;

	@Builder
	private Reservation(@NonNull LocalDate checkInDate, @NonNull LocalDate checkOutDate,
		@NonNull Integer numberOfGuest, @NonNull Integer numberOfInfant, @NonNull Invoice invoice,
		@NonNull Accommodation accommodation, @NonNull Customer customer) {
		this.checkInDate = checkInDate;
		this.checkOutDate = checkOutDate;
		this.numberOfGuest = numberOfGuest;
		this.numberOfInfant = numberOfInfant;
		this.invoice = invoice;
		this.accommodation = accommodation;
		this.customer = customer;
	}

	public int getInvoiceTotal() {
		return invoice.getTotal();
	}
}
