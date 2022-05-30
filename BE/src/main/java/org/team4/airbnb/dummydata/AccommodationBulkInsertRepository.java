package org.team4.airbnb.dummydata;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class AccommodationBulkInsertRepository {

	private final JdbcTemplate jdbcTemplate;

	public void bulkInsertAccommodations(List<AccommodationDummy> list) {
		String sql = "INSERT INTO accommodation "
			+ "(name,  latitude, longitude, address, accommodation_type,  "
			+ "number_of_room, number_of_bed, number_of_bathroom, "
			+ "price, host_name, description, max_guest) "
			+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		jdbcTemplate.batchUpdate(sql, new BatchPreparedStatementSetter() {
			@Override
			public void setValues(PreparedStatement stmt, int idx) throws SQLException {
				AccommodationDummy accommodationDummy = list.get(idx);
				stmt.setString(1, accommodationDummy.getName());
				stmt.setDouble(2, accommodationDummy.getLatitude());
				stmt.setDouble(3, accommodationDummy.getLongitude());
				stmt.setString(4, accommodationDummy.getAddress());
				stmt.setString(5, accommodationDummy.getType());
				stmt.setInt(6, accommodationDummy.getNumberOfRoom());
				stmt.setInt(7, accommodationDummy.getNumberOfBed());
				stmt.setInt(8, accommodationDummy.getNumberOfBathroom());
				stmt.setInt(9, accommodationDummy.getPrice());
				stmt.setString(10, accommodationDummy.getHostName());
				stmt.setString(11, accommodationDummy.getDescription());
				stmt.setInt(12, accommodationDummy.getMaxGuest());

				System.out.println(stmt);
			}

			@Override
			public int getBatchSize() {
				return list.size();
			}
		});
	}


}
