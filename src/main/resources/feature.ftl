= ${name?trim}
:numbered: 

<#if description??>
${description}
</#if>

<#if background??>
== ${background.keyword?trim} ${background.name?trim}

<#if background.steps??>
<#list background.steps as step>
* *${step.keyword?trim}* ${step.name?trim}
</#list>
</#if>
</#if>

<#if scenarios??>
== Scénarii

<#list scenarios as scenario>
=== ${scenario.keyword?trim} ${scenario.name?trim}

<#if description??>
${description}
</#if>

<#if scenario.steps??>
<#list scenario.steps as step>
* *${step.keyword?trim}* ${step.name?trim}
</#list>
</#if>

<#if scenario.examples??>

==== ${scenario.examples.keyword?trim} ${scenario.examples.name?trim}

|====
<#list scenario.examples.rows as row>
<#list row.cells as cell>| ${cell?trim}</#list><#if row_index == 0>

</#if>
</#list>
|====

</#if>

</#list>
</#if>
