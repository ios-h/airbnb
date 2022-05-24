package org.team4.airbnb.domain;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
public class Reservation {

    @Id
    @GeneratedValue
    @Column(name = "reservation_id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "customer_id")
    private Customer customer;

    @ManyToOne
    @JoinColumn(name = "accommodation_id")
    private Accommodation accommodation;

    private LocalDate checkInDate;

    private LocalDate checkOutDate;

    private int numberOfGuest;

    private int numberOfInfant;

    @Embedded
    private Invoice invoice;
}
