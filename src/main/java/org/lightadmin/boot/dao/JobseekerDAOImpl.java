package org.lightadmin.boot.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.inject.Singleton;
import javax.sql.DataSource;

import org.lightadmin.boot.domain.Jobseeker;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

@Singleton
public class JobseekerDAOImpl implements JobseekerDAO {
	private static final Logger logger = LoggerFactory.getLogger(JobseekerDAOImpl.class);

	private JdbcTemplate jdbcTemplate;

	@Autowired
	public void setDataSource(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	// Implement the DAO methods using jdbcTemplate

	@Override
	public List<Jobseeker> findByDistance(double lat, double lng, double distanceKM, Long industryId) {
		StringBuffer sb = new StringBuffer();
		sb.append(
				"SELECT user_name,lat,lng,id,user_name,first_name,last_name, pic_data, 3956 * 2 * ASIN(SQRT(POWER(SIN((");
		sb.append(lat);
		sb.append(" - abs(dest.lat)) * pi()/180 / 2), 2) + COS(");
		sb.append(lat);
		sb.append(" * pi()/180 ) * COS(abs(dest.lat) * pi()/180) *  POWER(SIN((");
		sb.append(lng);
		sb.append(" - dest.lng) * pi()/180 / 2), 2) )) as distance  FROM Jobseeker dest");
		if (industryId != null && industryId != -1) {
			sb.append(" where industry_id=");
			sb.append(industryId);
		}
		if (distanceKM > 0) {
			sb.append(" having distance < ");
			sb.append(distanceKM);
		}
		sb.append(" ORDER BY distance");
		List<Jobseeker> users = this.jdbcTemplate.query(sb.toString(), new RowMapper<Jobseeker>() {
			public Jobseeker mapRow(ResultSet rs, int rowNum) throws SQLException {
				Jobseeker user = new Jobseeker();
				user.setId(rs.getLong("id"));
				user.setUserName(rs.getString("user_name"));
				user.setFirstName(rs.getString("first_name"));
				user.setLastName(rs.getString("last_name"));
				byte[] code = rs.getBytes("pic_data");
				user.setPicData(code);
				user.initPicString();
				logger.info("Distance: " + rs.getDouble("distance"));
				user.setDistance(rs.getDouble("distance"));
				user.setLat(rs.getDouble("lat"));
				user.setLng(rs.getDouble("lng"));
				return user;
			}
		});
		return users;
	}
}