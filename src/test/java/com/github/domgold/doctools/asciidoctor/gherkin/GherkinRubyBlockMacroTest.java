package com.github.domgold.doctools.asciidoctor.gherkin;

import static org.asciidoctor.OptionsBuilder.options;

import java.io.File;
import java.io.IOException;

import org.asciidoctor.Asciidoctor;
import org.asciidoctor.Options;
import org.asciidoctor.SafeMode;
import org.junit.Test;

public class GherkinRubyBlockMacroTest {

	@Test
	public void test() throws IOException {
		Asciidoctor asciidoctor = Asciidoctor.Factory.create();
		GherkinExtensionRegistry reg = new GherkinExtensionRegistry();
		reg.register(asciidoctor);

		File destinationDir = new File("target/test-output");
		if (!destinationDir.exists() && !destinationDir.mkdirs()) {
			throw new IOException("could not create test-output dir");
		}
		Options options = options().toDir(destinationDir).safe(SafeMode.UNSAFE)
				.get();
		asciidoctor.convertFile(new File(
				"src/test/resources/simple_specs_example.adoc"), options);
		asciidoctor.convertFile(new File(
				"src/test/resources/complex_specs_example.adoc"), options);
	}

}
