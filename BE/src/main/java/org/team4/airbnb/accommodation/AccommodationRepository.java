package org.team4.airbnb.accommodation;

import org.springframework.data.jpa.repository.JpaRepository;
import org.team4.airbnb.domain.Accommodation;

public interface AccommodationRepository extends JpaRepository<Accommodation, Long> {

}
