package org.kinimod.asciidoctor.gherkin;

import static org.junit.Assert.*;

import java.io.File;

import static org.asciidoctor.OptionsBuilder.*;

import org.asciidoctor.Asciidoctor;
import org.asciidoctor.Options;
import org.asciidoctor.SafeMode;
import org.asciidoctor.extension.RubyExtensionRegistry;
import org.junit.AfterClass;
import org.junit.Test;

public class GherkinRubyBlockTest {

	@AfterClass
	public static void tearDownAfterClass() throws Exception {
	}

	@Test
	public void test() {
		Asciidoctor asciidoctor = Asciidoctor.Factory.create();
		RubyExtensionRegistry rubyExtensionRegistry = asciidoctor.rubyExtensionRegistry(); 
		rubyExtensionRegistry.loadClass(Class.class.getResourceAsStream("/com/github/domgold/asciidoctor/extension/gherkin/gherkinblock.rb")).includeProcessor("GherkinIncludeProcessor"); 

		File destinationDir = new File("target");
		Options options = options()
		.toDir(destinationDir)
		.safe(SafeMode.UNSAFE).get();
		asciidoctor.convertFile(
				new File("src/test/resources/simple_specs_example.adoc"),
		                options);
		asciidoctor.convertFile(
				new File("src/test/resources/complex_specs_example.adoc"),
		                options);
	}

}
