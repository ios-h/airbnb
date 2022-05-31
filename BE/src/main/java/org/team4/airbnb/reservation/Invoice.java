package org.team4.airbnb.reservation;

import javax.persistence.Embeddable;
import lombok.Getter;

@Embeddable
@Getter
public class Invoice {

	private int pricePerDay;
	private int total;
	private int discount;
	private int cleaningFee;
	private int serviceFee;
	private int vat;

}
