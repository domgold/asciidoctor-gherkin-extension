package org.kinimod.asciidoctor.gherkin.template;

import java.io.IOException;
import java.util.Map;

import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public class TemplateProcessor {

	private Configuration freemarkerConfiguration;

	public TemplateProcessor() {

	}

	public String process(String templateName, Map<String, Object> args) throws IOException {
		Template template = this.getFreemarkerConfiguration().getTemplate(
				templateName);
		try {
		return FreeMarkerTemplateUtils
				.processTemplateIntoString(template, args);
		} catch(TemplateException ex) {
			throw new RuntimeException(ex);
		} catch(IOException ex) {
			throw new RuntimeException(ex);
		}
	}

	public Configuration getFreemarkerConfiguration() {
		return freemarkerConfiguration;
	}

	public void setFreemarkerConfiguration(Configuration freemarkerConfiguration) {
		this.freemarkerConfiguration = freemarkerConfiguration;
	}
}
