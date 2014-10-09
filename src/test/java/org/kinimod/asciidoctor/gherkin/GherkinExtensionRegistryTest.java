package org.kinimod.asciidoctor.gherkin;

import org.asciidoctor.Asciidoctor;
import org.junit.Test;

public class GherkinExtensionRegistryTest {

	@Test
	public void test() {
		Asciidoctor asciidoctor = Asciidoctor.Factory.create();
		GherkinExtensionRegistry reg = new GherkinExtensionRegistry();
		reg.register(asciidoctor);
	}

}
