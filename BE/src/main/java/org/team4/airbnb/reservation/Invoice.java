package org.team4.airbnb.reservation;

import javax.persistence.Embeddable;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Embeddable
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Invoice {

	private static final Float DISCOUNT_RATE = 0.1f;
	private static final Float CLEANING_FEE_RATE = 0.1f;
	private static final Float SERVICE_FEE_RATE = 0.1f;
	private static final Float VAT_RATE = 0.01f;

	private Integer pricePerDay;
	private Integer discount;
	private Integer cleaningFee;
	private Integer serviceFee;
	private Integer vat;
	private Integer total;

	@Builder(access = AccessLevel.PRIVATE)
	private Invoice(@NonNull Integer pricePerDay, @NonNull Integer discount,
		@NonNull Integer cleaningFee, @NonNull Integer serviceFee,
		@NonNull Integer vat, @NonNull Integer total) {
		this.pricePerDay = pricePerDay;
		this.discount = discount;
		this.cleaningFee = cleaningFee;
		this.serviceFee = serviceFee;
		this.vat = vat;
		this.total = total;
	}

	public static Invoice calculate(Integer pricePerDay, Integer lengthOfStay) {
		Integer basePrice = pricePerDay * lengthOfStay;
		Integer discount = Math.round(basePrice * DISCOUNT_RATE);
		Integer cleaningFee = Math.round(basePrice * CLEANING_FEE_RATE);
		Integer serviceFee = Math.round(basePrice * SERVICE_FEE_RATE);
		Integer vat = Math.round(basePrice * VAT_RATE);
		Integer total = basePrice - discount + cleaningFee + serviceFee + vat;

		return Invoice.builder()
			.pricePerDay(pricePerDay)
			.discount(discount)
			.cleaningFee(cleaningFee)
			.serviceFee(serviceFee)
			.vat(vat)
			.total(total)
			.build();
	}
}
