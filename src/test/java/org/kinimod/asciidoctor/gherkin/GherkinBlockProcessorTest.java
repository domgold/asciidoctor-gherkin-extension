package org.kinimod.asciidoctor.gherkin;

import static org.junit.Assert.*;
import static org.asciidoctor.OptionsBuilder.*;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
import org.asciidoctor.Asciidoctor;
import org.asciidoctor.Options;
import org.asciidoctor.SafeMode;
import org.junit.BeforeClass;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.TemporaryFolder;

public class GherkinBlockProcessorTest {

	@BeforeClass
	public static void init() {
		File tmpFolder = new File("target/tmptest");
		if(!tmpFolder.exists()) {
			assertTrue(tmpFolder.mkdirs());
		}
	}
	
	@Rule
	public TemporaryFolder testFolder = new TemporaryFolder(new File("target/tmptest"));
	
	@Test
	public void testProcessAbstractBlockReaderMapOfStringObject() throws IOException {
		Asciidoctor asciidoctor = Asciidoctor.Factory.create();
		asciidoctor.javaExtensionRegistry().block("gherkin",
				GherkinBlockProcessor.class);
//		asciidoctor.javaExtensionRegistry().preprocessor(GherkinPreprocessor.class);
		Options options = options().inPlace(false)
				.toFile(new File(new File("target/tmptest"), "rendersample.html"))
				.safe(SafeMode.UNSAFE).get();
		asciidoctor.renderFile(new File("src/test/resources/testfeatureblock.ad"),
				options);
		File renderedFile = new File(testFolder.getRoot(), "rendersample.html");
		assertTrue(renderedFile.exists());
		String html = FileUtils.readFileToString(renderedFile);
		assertTrue(String.format("html must contain '<h1>Test feature</h>', content was :\n%s", html), html.contains("<h1>Test feature</h>"));
	}

}
