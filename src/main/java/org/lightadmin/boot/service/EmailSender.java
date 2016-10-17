package org.lightadmin.boot.service;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.function.Function;

import javax.inject.Singleton;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;

import com.sparkpost.Client;
import com.sparkpost.exception.SparkPostException;
import com.sparkpost.model.AddressAttributes;
import com.sparkpost.model.RecipientAttributes;
import com.sparkpost.model.TemplateContentAttributes;
import com.sparkpost.model.TransmissionWithRecipientArray;
import com.sparkpost.model.responses.Response;
import com.sparkpost.resources.ResourceTransmissions;
import com.sparkpost.transport.RestConnection;

@Singleton
public class EmailSender {
	private static final Logger logger = LoggerFactory.getLogger(EmailSender.class);

	@Value("${email.dir}")
	private String emailDir;

	private Client client;

	/**
	 * 
	 * @param templateName
	 *            name of the template file. The file should be in
	 *            src/main/resources/emails
	 * @param to
	 *            recipients
	 * @param data
	 *            map of key and value objects to be used in template place
	 *            holders
	 */
	public void sendEmail(String templateName, Map<String, Object> data, String... tos) {
		// FIXME Remove below return statement when we want to send emails
		return;
		// if (client == null) {
		// client = new Client(Constants.EMAIL_KEY);
		// }
		// String content = contentLoder().apply(templateName);
		// String[] split = content.split(Constants.EMAIL_DIVIDER);
		// String subject = split[0].trim();
		// String email = split[1].trim();
		// try {
		// sendEmail(Constants.EMAIL_FROM, tos, subject, email, data);
		// } catch (SparkPostException e) {
		// e.printStackTrace();
		// }
	}

	private Function<String, String> contentLoder() {
		return (fileName) -> {
			String content = "";
			try {
				File file = new File(emailDir, fileName);
				content = IOUtils.toString(new FileInputStream(file), "UTF-8");

			} catch (Exception e) {
				e.printStackTrace();
			}
			return content;
		};
	}

	private void sendEmail(String from, String[] recipients, String subject, String email, Map<String, Object> data)
			throws SparkPostException {
		TransmissionWithRecipientArray transmission = new TransmissionWithRecipientArray();

		// Populate Recipients
		List<RecipientAttributes> recipientArray = new ArrayList<RecipientAttributes>();
		for (String recipient : recipients) {
			RecipientAttributes recipientAttribs = new RecipientAttributes();
			recipientAttribs.setAddress(new AddressAttributes(recipient));
			recipientArray.add(recipientAttribs);
		}
		transmission.setRecipientArray(recipientArray);

		// Populate Substitution Data
		if (data != null) {
			transmission.setSubstitutionData(data);
		}

		// Populate Email Body
		TemplateContentAttributes contentAttributes = new TemplateContentAttributes();
		contentAttributes.setFrom(new AddressAttributes(from));
		contentAttributes.setSubject(subject);
		// contentAttributes.setText("Your Text content here. Dear {{name}},\n
		// Nice to see you!");
		contentAttributes.setHtml(email);
		transmission.setContentAttributes(contentAttributes);

		// Send the Email
		RestConnection connection = new RestConnection(client);
		Response response = ResourceTransmissions.create(connection, 0, transmission);

		logger.debug("Transmission Response: " + response);
	}

}
