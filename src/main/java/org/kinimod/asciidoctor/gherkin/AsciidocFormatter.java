package org.kinimod.asciidoctor.gherkin;

import gherkin.formatter.Formatter;
import gherkin.formatter.model.Background;
import gherkin.formatter.model.Examples;
import gherkin.formatter.model.Feature;
import gherkin.formatter.model.Scenario;
import gherkin.formatter.model.ScenarioOutline;
import gherkin.formatter.model.Step;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.kinimod.asciidoctor.gherkin.template.TemplateProcessor;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class AsciidocFormatter implements Formatter {

	private TemplateProcessor templateProcessor;

	public AsciidocFormatter(StringBuilder builder) {
		this.builder = builder;
		ClassPathXmlApplicationContext applicationContext = null;
		try {
			applicationContext = new ClassPathXmlApplicationContext();

			applicationContext.setConfigLocation("classpath:/beans.xml");
			applicationContext.refresh();
			this.templateProcessor = applicationContext
					.getBean(TemplateProcessor.class);

		} finally {
			if (applicationContext != null) {
				applicationContext.close();
			}
		}
	}

	private StringBuilder builder;

	private Map<String, Object> currentFeature;

	private Map<String, Object> currentScenario;

	private Map<String, Object> currentStep;

	private Map<String, Object> currentExamples;

	@Override
	public void background(Background arg0) {
		currentScenario = arg0.toMap();
		currentFeature.put("background", currentScenario);
	}

	@Override
	public void close() {
	}

	@Override
	public void done() {
	}

	@Override
	public void endOfScenarioLifeCycle(Scenario arg0) {
	}

	@Override
	public void eof() {
		try {
			String content = templateProcessor.process("feature.ftl",
					currentFeature);
			builder.append(content);
		} catch (IOException e) {
			throw new RuntimeException(e);
		}

	}

	@Override
	public void examples(Examples arg0) {
		currentExamples = arg0.toMap();
		currentScenario.put("examples", currentExamples);
	}

	@Override
	public void feature(Feature arg0) {
		currentFeature = arg0.toMap();
	}

	@Override
	public void scenario(Scenario arg0) {
		currentScenario = arg0.toMap();
		addNew(currentFeature, "scenarios", currentScenario);
	}

	@Override
	public void scenarioOutline(ScenarioOutline arg0) {
		currentScenario = arg0.toMap();
		addNew(currentFeature, "scenarios", currentScenario);
	}

	@Override
	public void startOfScenarioLifeCycle(Scenario arg0) {
	}

	@Override
	public void step(Step arg0) {
		currentStep = arg0.toMap();
		addNew(currentScenario, "steps", currentStep);
	}

	@Override
	public void syntaxError(String arg0, String arg1, List<String> arg2,
			String arg3, Integer arg4) {
	}

	@Override
	public void uri(String arg0) {
	}

	private void addNew(Map<String, Object> baseMap, String key,
			Map<String, Object> newMap) {
		if (!baseMap.containsKey(key)) {
			baseMap.put(key, new ArrayList<Map<String, Object>>());
		}
		((List<Map<String, Object>>) baseMap.get(key)).add(newMap);
	}

}