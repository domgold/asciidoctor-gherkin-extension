require 'asciidoctor'
require 'asciidoctor/extensions'
require 'erb'
require 'java'

class GherkinBlockMacroProcessor < Asciidoctor::Extensions::BlockMacroProcessor
  use_dsl
	
  named :gherkin
  name_positional_attributes 'template'

  def process parent, target, attributes
    doc = parent.document
    reader = parent.document.reader
    
    if doc.attributes.key?('docdir') && attributes.key?('template') && File.exist?(File.expand_path(attributes['template'], doc.attributes['docdir']))
    	template_file = File.open(File.expand_path(attributes['template'], doc.attributes['docdir']), "rb")
    	template_content = template_file.read 
    else
    	template_content = org.kinimod.asciidoctor.gherkin.MapFormatter.getDefaultTemplate()
    end
    
    erb_template = ERB.new(template_content)
    
    feature_file_name = target
    if doc.attributes.key?('docdir') 
    	feature_file_name = File.expand_path(feature_file_name, doc.attributes['docdir'])
    end
        
    file = File.open(feature_file_name, "rb")
    feature_file_content = file.read
    
    #parse feature and make the result available to the template via binding as 'feature' hash.
    feature = org.kinimod.asciidoctor.gherkin.MapFormatter.parse(feature_file_content)
    
    rendered_template_output = erb_template.result(binding())
	
    reader.push_include rendered_template_output, target, target, 1, attributes
	
    nil
  end

end