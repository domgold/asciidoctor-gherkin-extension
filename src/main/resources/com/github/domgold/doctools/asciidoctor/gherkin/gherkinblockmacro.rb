#A block macro processor converting gherkin feature files to asciidoctor markup
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
    
    if attributes.key?("template-encoding")
    	template_encoding = attributes["template-encoding"]
    elsif doc.attributes.key?("template-encoding")
    	template_encoding = doc.attributes["template-encoding"]
    else
    	template_encoding = "UTF-8"
    end
    
    if doc.attributes.key?('docdir') && attributes.key?('template') && File.exist?(File.expand_path(attributes['template'], doc.attributes['docdir']))
    	template_file = File.open(File.expand_path(attributes['template'], doc.attributes['docdir']), "rb", :encoding => template_encoding)
    	template_content = template_file.read 
    else
    	template_content = com.github.domgold.doctools.asciidoctor.gherkin.MapFormatter.getDefaultTemplate()
    end
    
    erb_template = ERB.new(template_content)
    
    feature_file_name = target
    if doc.attributes.key?('docdir') 
    	feature_file_name = File.expand_path(feature_file_name, doc.attributes['docdir'])
    end
    
    if attributes.key?("encoding")
    	encoding = attributes["encoding"]
    elsif doc.attributes.key?("encoding")
    	encoding = doc.attributes["encoding"]
    else
    	encoding = "UTF-8"
    end
    
    file = File.open(feature_file_name, "rb", :encoding => encoding)
    feature_file_content = file.read
    
    #parse feature and make the result available to the template via binding as 'feature' hash.
    feature = com.github.domgold.doctools.asciidoctor.gherkin.MapFormatter.parse(feature_file_content)
    
    preprocess_feature(feature)
    rendered_template_output = erb_template.result(binding())

    reader.push_include rendered_template_output, target, target, 1, attributes
    nil
  end
    
  def preprocess_feature feature
    if feature.key?('background') 
        preprocess_scenario feature['background']
    end
    if feature.key?('scenarios')
        feature['scenarios'].each do | scenario | 
          preprocess_scenario scenario
        end
    end
  end
    
  def preprocess_scenario scenario
      if scenario.key?('steps')
          preprocess_steplist scenario['steps']
      end
      if scenario.key?('examples')
          preprocess_table_comments scenario['examples']['rows']
      end
  end
    
  def preprocess_steplist steplist
      steplist.each do | step |
        if step.key?('rows')
          preprocess_table_comments step['rows']
        end
      end
  end
    
  def preprocess_table_comments rows
      if rows.length > 0 && rows.first.key?('comments') && rows.first['comments'].length > 0 && rows.first['comments'].first['value'].match(/^#cols=/)
          cols = rows.first['comments'].first['value'][1..-1]
          rows.first['comments'].java_send :remove, [Java::int], 0
          rows.first["cols"] = cols
      end
      rows.each do | row |
        if row.key?('comments') && row['comments'].length > 0 && row['comments'].first['value'].match(/^#cells=/)
            cells = row['comments'].first['value'][7..-1].split(/,/)
            row['cell-styles'] = cells
            row['comments'].java_send :remove, [Java::int], 0
        end
      end
  end    
end