package org.kinimod.asciidoctor.gherkin;

import gherkin.parser.Parser;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import org.asciidoctor.ast.AbstractBlock;
import org.asciidoctor.ast.Block;
import org.asciidoctor.extension.BlockProcessor;
import org.asciidoctor.extension.Reader;

public class GherkinBlockProcessor extends BlockProcessor {

	private static Map<String, Object> configs = new HashMap<String, Object>() {
		{
			put("contexts", Arrays.asList(":paragraph", ":literal"));
			put("content_model", ":simple");
		}
	};

	public GherkinBlockProcessor(String name, Map<String, Object> _config) {
		super(name, configs);
	}

	@Override
	public Object process(AbstractBlock parent, Reader reader,
			Map<String, Object> arguments) {
		String blockContent = reader.read();
		String[] lines = convertGherkinToAsciidoc(blockContent);

		Block createBlock = createBlock(parent, "section",
				Arrays.asList(lines), arguments, new HashMap<Object, Object>());
		return createBlock;
	}

	private String[] convertGherkinToAsciidoc(String blockContent) {
		StringBuilder builder = new StringBuilder();
		AsciidocFormatter f = new AsciidocFormatter(builder);
		Parser p = new Parser(f);
		p.parse(blockContent, "feature", 0);
		String out = builder.toString();
		String[] lines = out.split("\\r?\\n");
		return lines;
	}
}
