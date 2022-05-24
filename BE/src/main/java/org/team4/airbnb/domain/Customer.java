package org.team4.airbnb.domain;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Customer {

    @Id
    @GeneratedValue
    @Column(name = "customer_id")
    private Long id;

    private String userId;

    @OneToMany(mappedBy = "customer")
    private List<Reservation> reservations = new ArrayList<>();

}
