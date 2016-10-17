package org.lightadmin.boot.administration;

import org.lightadmin.api.config.AdministrationConfiguration;
import org.lightadmin.api.config.builder.EntityMetadataConfigurationUnitBuilder;
import org.lightadmin.api.config.builder.FieldSetConfigurationUnitBuilder;
import org.lightadmin.api.config.builder.FiltersConfigurationUnitBuilder;
import org.lightadmin.api.config.unit.EntityMetadataConfigurationUnit;
import org.lightadmin.api.config.unit.FieldSetConfigurationUnit;
import org.lightadmin.api.config.unit.FiltersConfigurationUnit;
import org.lightadmin.boot.domain.Jobseeker;

public class JobseekerAdministration extends AdministrationConfiguration<Jobseeker> {

	@Override
	public EntityMetadataConfigurationUnit configuration(EntityMetadataConfigurationUnitBuilder configurationBuilder) {
		return configurationBuilder.nameField("firstname").singularName("Jobseeker").pluralName("Jobseekers").build();
	}

	public FieldSetConfigurationUnit listView(FieldSetConfigurationUnitBuilder fragmentBuilder) {
		return fragmentBuilder.field("firstName").caption("First Name").field("lastName").caption("Last Name")
				.field("active").caption("Active?").build();
	}

	// public FieldSetConfigurationUnit
	// quickView(FieldSetConfigurationUnitBuilder fragmentBuilder) {
	// return fragmentBuilder.field("firstName").caption("First
	// Name").field("lastName").caption("Last Name")
	// .field("active").caption("Active?").build();
	// }
	//
	// public FieldSetConfigurationUnit showView(final
	// FieldSetConfigurationUnitBuilder fragmentBuilder) {
	// return fragmentBuilder.field("firstName").caption("First
	// Name").field("lastName").caption("Last Name")
	// .field("active").caption("Active?").build();
	// }
	//
	// public FieldSetConfigurationUnit formView(final
	// PersistentFieldSetConfigurationUnitBuilder fragmentBuilder) {
	// return fragmentBuilder.field("firstName").caption("First
	// Name").field("lastName").caption("Last Name")
	// .field("active").caption("Active?").build();
	// }

	public FiltersConfigurationUnit filters(final FiltersConfigurationUnitBuilder filterBuilder) {
		return filterBuilder.filter("Name", "firstName").filter("Active?", "active").build();
	}
}