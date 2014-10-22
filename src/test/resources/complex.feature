# language: en
Feature: A complex feature
  This is the feature description.
  
  In the feature's description, you can use asciidoctor markup as it pleases you.
    
  [source,java]
  ----
  String test = "Hello, Asciidoctor.";
  ----
  
  * list content
  * list content2
  ** nested list content.
  
  WARNING: admonition.
  
  include::included_doc.adoc[]
  
  .A table with title
  |====
  | A | B 
  
  | 1 | 2
  |====

  Background: Background
    Given a complex background step with table with header
      #cols=".<2,.^5,^.>3",options="header"
      #cells=h,h,h
      | Header Cell 1            | Header Cell 2          | Header Cell 3 |
      #cells=,m,
      | Cell 1 Row 1             | Cell 2 Row 1 monospace | Cell 3 Row 1  |
      | Cell 1 Row 2 with *bold* | Cell 2 Row 2           | Cell 3 Row 2  |

  Scenario Outline: 1st scenario title
    
    The scenario description comes here.
    
    [NOTE] 
    ====
    Lists with \* get interpreted as steps.
    So if you want a list, use `-` or escape the star.
     
    -----
    \*
    -----
    ====
    
    - dash list in scenario description
    - the second list item
    
    \* escaped star list
    \* second list item

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
      #cols="2,2,^4"
      | parameter_name | parameter_value | 3rd colonne double width |
      | _actorWidth_   | 25              | A                        |
      | actorHeight    | 30              | B                        |

  Scenario: 2nd scenario title
    Given a short scenario
    Then it's really short.
