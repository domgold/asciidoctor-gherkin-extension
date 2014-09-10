package org.kinimod.asciidoctor.gherkin;

import static org.junit.Assert.*;
import gherkin.formatter.Formatter;
import gherkin.parser.Parser;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
import org.junit.Test;

public class AsciidocFormatterTest {

	@Test
	public void test() throws IOException {
		String content = FileUtils.readFileToString(new File("src/test/resources/simple.feature"));
		StringBuilder builder = new StringBuilder();
		AsciidocFormatter f = new AsciidocFormatter(builder);
		Parser p = new Parser(f);
		p.parse(content, "src/test/resources/simple.feature", 0);
		String out = builder.toString();
		assertNotNull(out);
		File testOutput = new File("target/testoutput");
		if(!testOutput.exists()) {
			testOutput.mkdirs();
		}
		FileUtils.writeStringToFile(new File(testOutput, "test.ad"), out);
	}

}
