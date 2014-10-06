package org.kinimod.asciidoctor.gherkin;

import gherkin.formatter.Formatter;
import gherkin.formatter.model.Background;
import gherkin.formatter.model.Examples;
import gherkin.formatter.model.Feature;
import gherkin.formatter.model.Scenario;
import gherkin.formatter.model.ScenarioOutline;
import gherkin.formatter.model.Step;
import gherkin.parser.Parser;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.IOUtils;

public class MapFormatter implements Formatter {

	public static String getDefaultTemplate() {

		String text = "";
		try {
			text = IOUtils
					.toString(
							MapFormatter.class
									.getResourceAsStream("/com/github/domgold/asciidoctor/extension/gherkin/default_template.erb"),
							"UTF-8");
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
		return text;
	}

	public static Map<String, Object> parse(String fileContent) {
		MapFormatter f = new MapFormatter();
		Parser p = new Parser(f);
		p.parse(fileContent, "feature", 0);
		return f.getFeature();
	}

	private Map<String, Object> currentFeature;
	private Map<String, Object> currentScenario;
	private Map<String, Object> currentStep;
	private Map<String, Object> currentExamples;

	public MapFormatter() {
		super();
	}

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

	@SuppressWarnings("unchecked")
	private void addNew(Map<String, Object> baseMap, String key,
			Map<String, Object> newMap) {
		if (!baseMap.containsKey(key)) {
			baseMap.put(key, new ArrayList<Map<String, Object>>());
		}
		((List<Map<String, Object>>) baseMap.get(key)).add(newMap);
	}

	@Override
	public void eof() {

	}

	public Map<String, Object> getFeature() {
		return currentFeature;
	}

}