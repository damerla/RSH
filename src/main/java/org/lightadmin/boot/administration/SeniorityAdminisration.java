package org.lightadmin.boot.administration;

import org.lightadmin.api.config.AdministrationConfiguration;
import org.lightadmin.api.config.builder.EntityMetadataConfigurationUnitBuilder;
import org.lightadmin.api.config.builder.FieldSetConfigurationUnitBuilder;
import org.lightadmin.api.config.builder.PersistentFieldSetConfigurationUnitBuilder;
import org.lightadmin.api.config.unit.EntityMetadataConfigurationUnit;
import org.lightadmin.api.config.unit.FieldSetConfigurationUnit;
import org.lightadmin.api.config.utils.FieldValueRenderer;
import org.lightadmin.boot.domain.Seniority;

public class SeniorityAdminisration extends AdministrationConfiguration<Seniority> {

	@Override
	public EntityMetadataConfigurationUnit configuration(EntityMetadataConfigurationUnitBuilder configurationBuilder) {
		return configurationBuilder.nameField("name").singularName("Seniority").pluralName("Seniorities").build();
	}

	@Override
	public FieldSetConfigurationUnit listView(FieldSetConfigurationUnitBuilder fragmentBuilder) {
		return fragmentBuilder.field("name").caption("Name").build();
	}

	@Override
	public FieldSetConfigurationUnit formView(PersistentFieldSetConfigurationUnitBuilder fragmentBuilder) {
		return fragmentBuilder.field("name").caption("Name").build();
	}

	private static FieldValueRenderer<Seniority> idRenderer() {
		return new FieldValueRenderer<Seniority>() {
			private static final long serialVersionUID = 1L;

			@Override
			public String apply(Seniority seniority) {
				return String.format("\u00A3 %s", seniority.getId());
			}
		};
	}

}