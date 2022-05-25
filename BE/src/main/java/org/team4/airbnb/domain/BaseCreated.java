package org.team4.airbnb.domain;

import java.time.LocalDateTime;
import javax.persistence.MappedSuperclass;

@MappedSuperclass
public class BaseCreated {

	private LocalDateTime createdDate;

}
