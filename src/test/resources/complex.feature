# language: en
Feature: A complex feature
  This is the feature description.
  
  Use asciidoctor markup as it pleases you.
    
  [source,java]
  ----
  String test = "Hello, Asciidoctor.";
  ----
  
  * list content
  * list content2
  *** nested list content.
  
  WARNING: admonition.
  
  include::included_doc.adoc[]
  
  .A table with title
  |====
  | A | B 
  
  | 1 | 2
  |====

  Background: Background
    Given a simple step.

  Scenario Outline: Scenario title
    
    The Scenario description comes here.
    
    [NOTE] 
    ====
    Lists with \* get interpreted as steps.
    So if you want a list, use `-` or escape the star.
     
    -----
    \*
    -----
    ====

    Given a simple outline step with a doc string :
      """
      doc string
      2 *lines*
      """
    When I have a step with a *table*
      | a | b |
      | c | d |
    And I render the asciidoctor content to html
    Then the parameters should NOT get processed.
      | img                    |
      | *<parameter_name>*.png |
    And the file "*<parameter_name>*.png" everything is fine.

    Examples: 
      | parameter_name | parameter_value |
      | _actorWidth_   | 25              |
      | actorHeight    | 30              |
