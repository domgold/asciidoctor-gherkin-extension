/**
 * 
 */
package org.kinimod.asciidoctor.gherkin;

import org.asciidoctor.Asciidoctor;
import org.asciidoctor.extension.RubyExtensionRegistry;
import org.asciidoctor.extension.spi.ExtensionRegistry;

/**
 * Registers the gherkin ruby extension via the registry mechanism provided by Asciidoctor
 * @author Dominik
 * @see ExtensionRegistry
 *
 */
public final class GherkinExtensionRegistry implements ExtensionRegistry {

	/**
	 * Default constructor
	 */
	public GherkinExtensionRegistry() {
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * org.asciidoctor.extension.spi.ExtensionRegistry#register(org.asciidoctor
	 * .Asciidoctor)
	 */
	@Override
	public void register(Asciidoctor asciidoctor) {
		RubyExtensionRegistry rubyExtensionRegistry = asciidoctor
				.rubyExtensionRegistry();
		rubyExtensionRegistry
				.loadClass(
						this.getClass()
								.getResourceAsStream(
										"/com/github/domgold/asciidoctor/extension/gherkin/gherkinblockmacro.rb"))
				.blockMacro("gherkin", "GherkinBlockMacroProcessor");
	}

}
