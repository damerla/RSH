package org.lightadmin.boot.administration;

import org.lightadmin.api.config.AdministrationConfiguration;
import org.lightadmin.api.config.builder.EntityMetadataConfigurationUnitBuilder;
import org.lightadmin.api.config.builder.FieldSetConfigurationUnitBuilder;
import org.lightadmin.api.config.builder.FiltersConfigurationUnitBuilder;
import org.lightadmin.api.config.unit.EntityMetadataConfigurationUnit;
import org.lightadmin.api.config.unit.FieldSetConfigurationUnit;
import org.lightadmin.api.config.unit.FiltersConfigurationUnit;
import org.lightadmin.boot.domain.Recruiter;

public class RecruiterAdministration extends AdministrationConfiguration<Recruiter> {

	@Override
	public EntityMetadataConfigurationUnit configuration(EntityMetadataConfigurationUnitBuilder configurationBuilder) {
		return configurationBuilder.nameField("firstname").singularName("Recruiter").pluralName("Recruiters").build();
	}

	public FieldSetConfigurationUnit listView(FieldSetConfigurationUnitBuilder fragmentBuilder) {
		return fragmentBuilder.field("firstName").caption("First Name").field("lastName").caption("Last Name")
				.field("active").caption("Active?").field("upgraded").caption("Upgraded?").field("featured")
				.caption("Featured?").build();
	}

	// public FieldSetConfigurationUnit
	// quickView(FieldSetConfigurationUnitBuilder fragmentBuilder) {
	// return fragmentBuilder.field("firstName").caption("First
	// Name").field("lastName").caption("Last Name")
	// .field("active").caption("Active?").field("upgraded").caption("Upgraded?").field("featured")
	// .caption("Featured?").build();
	// }
	//
	// public FieldSetConfigurationUnit showView(final
	// FieldSetConfigurationUnitBuilder fragmentBuilder) {
	// return fragmentBuilder.field("firstName").caption("First
	// Name").field("lastName").caption("Last Name")
	// .field("active").caption("Active?").field("upgraded").caption("Upgraded?").field("featured")
	// .caption("Featured?").build();
	// }
	//
	// public FieldSetConfigurationUnit formView(final
	// PersistentFieldSetConfigurationUnitBuilder fragmentBuilder) {
	// return fragmentBuilder.field("firstName").caption("First
	// Name").field("lastName").caption("Last Name")
	// .field("active").caption("Active?").field("upgraded").caption("Upgraded?").field("featured")
	// .caption("Featured?").build();
	// }

	public FiltersConfigurationUnit filters(final FiltersConfigurationUnitBuilder filterBuilder) {
		return filterBuilder.filter("Name", "firstName").filter("Active?", "active").filter("Featured?", "featured")
				.filter("Upgraded?", "upgraded").build();
	}
}