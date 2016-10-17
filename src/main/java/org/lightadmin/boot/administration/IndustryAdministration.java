package org.lightadmin.boot.administration;

import org.lightadmin.api.config.AdministrationConfiguration;
import org.lightadmin.api.config.builder.EntityMetadataConfigurationUnitBuilder;
import org.lightadmin.api.config.builder.FieldSetConfigurationUnitBuilder;
import org.lightadmin.api.config.builder.PersistentFieldSetConfigurationUnitBuilder;
import org.lightadmin.api.config.unit.EntityMetadataConfigurationUnit;
import org.lightadmin.api.config.unit.FieldSetConfigurationUnit;
import org.lightadmin.api.config.utils.FieldValueRenderer;
import org.lightadmin.boot.domain.Industry;

public class IndustryAdministration extends AdministrationConfiguration<Industry> {

	@Override
	public EntityMetadataConfigurationUnit configuration(EntityMetadataConfigurationUnitBuilder configurationBuilder) {
		return configurationBuilder.nameField("name").singularName("Industry").pluralName("Industries").build();
	}

	@Override
	public FieldSetConfigurationUnit listView(FieldSetConfigurationUnitBuilder fragmentBuilder) {
		return fragmentBuilder.field("name").caption("Name").build();
	}

	@Override
	public FieldSetConfigurationUnit formView(PersistentFieldSetConfigurationUnitBuilder fragmentBuilder) {
		return fragmentBuilder.field("name").caption("Name").build();
	}

	private static FieldValueRenderer<Industry> idRenderer() {
		return new FieldValueRenderer<Industry>() {
			private static final long serialVersionUID = 1L;

			@Override
			public String apply(Industry industry) {
				return String.format("\u00A3 %s", industry.getId());
			}
		};
	}

}