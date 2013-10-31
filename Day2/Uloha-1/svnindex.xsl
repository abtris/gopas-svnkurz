<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>svnindex.xsl</title>
<style type="text/css">
.enscript-comment { font-style: italic; color: rgb(178,34,34); }
.enscript-function-name { font-weight: bold; color: rgb(0,0,255); }
.enscript-variable-name { font-weight: bold; color: rgb(184,134,11); }
.enscript-keyword { font-weight: bold; color: rgb(160,32,240); }
.enscript-reference { font-weight: bold; color: rgb(95,158,160); }
.enscript-string { font-weight: bold; color: rgb(188,143,143); }
.enscript-builtin { font-weight: bold; color: rgb(218,112,214); }
.enscript-type { font-weight: bold; color: rgb(34,139,34); }
.enscript-highlight { text-decoration: underline; color: 0; }
</style>
</head>
<body id="top">
<h1 style="margin:8px;" id="f1">svnindex.xsl&nbsp;&nbsp;&nbsp;<span style="font-weight: normal; font-size: 0.5em;">[<a href="?txt">plain text</a>]</span></h1>
<hr/>
<div></div>
<pre>
&lt;?xml version=&quot;1.0&quot;?&gt;

&lt;!-- A sample XML transformation style sheet for displaying the Subversion
  directory listing that is generated by mod_dav_svn when the &quot;SVNIndexXSLT&quot;
  directive is used. --&gt;
&lt;xsl:stylesheet xmlns:xsl=&quot;<a href="http://www.w3.org/1999/XSL/Transform">http://www.w3.org/1999/XSL/Transform</a>&quot; version=&quot;1.0&quot;&gt;

  &lt;xsl:output method=&quot;html&quot;/&gt;

  &lt;xsl:template match=&quot;*&quot;/&gt;

  &lt;xsl:template match=&quot;svn&quot;&gt;
    &lt;html&gt;
      &lt;head&gt;
        &lt;title&gt;
          &lt;xsl:if test=&quot;string-length(index/@name) != 0&quot;&gt;
            &lt;xsl:value-of select=&quot;index/@name&quot;/&gt;
            &lt;xsl:text&gt;: &lt;/xsl:text&gt;
          &lt;/xsl:if&gt;
          &lt;xsl:value-of select=&quot;index/@path&quot;/&gt;
        &lt;/title&gt;
        &lt;link rel=&quot;stylesheet&quot; type=&quot;text/css&quot; href=&quot;/svnindex.css&quot;/&gt;
      &lt;/head&gt;
      &lt;body&gt;
        &lt;div class=&quot;svn&quot;&gt;
          &lt;xsl:apply-templates/&gt;
        &lt;/div&gt;
        &lt;div class=&quot;footer&quot;&gt;
          &lt;xsl:text&gt;Powered by &lt;/xsl:text&gt;
          &lt;xsl:element name=&quot;a&quot;&gt;
            &lt;xsl:attribute name=&quot;href&quot;&gt;
              &lt;xsl:value-of select=&quot;@href&quot;/&gt;
            &lt;/xsl:attribute&gt;
            &lt;xsl:text&gt;Subversion&lt;/xsl:text&gt;
          &lt;/xsl:element&gt;
          &lt;xsl:text&gt; &lt;/xsl:text&gt;
          &lt;xsl:value-of select=&quot;@version&quot;/&gt;
        &lt;/div&gt;
      &lt;/body&gt;
    &lt;/html&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match=&quot;index&quot;&gt;
    &lt;div class=&quot;rev&quot;&gt;
      &lt;xsl:value-of select=&quot;@name&quot;/&gt;
      &lt;xsl:if test=&quot;@base&quot;&gt;
        &lt;xsl:if test=&quot;@name&quot;&gt;
          &lt;xsl:text&gt;:&amp;#xA0; &lt;/xsl:text&gt;
        &lt;/xsl:if&gt;
        &lt;xsl:value-of select=&quot;@base&quot; /&gt;
      &lt;/xsl:if&gt;
      &lt;xsl:if test=&quot;@rev&quot;&gt;
        &lt;xsl:if test=&quot;@base | @name&quot;&gt;
          &lt;xsl:text&gt; &amp;#x2014; &lt;/xsl:text&gt;
        &lt;/xsl:if&gt;
        &lt;xsl:text&gt;Revision &lt;/xsl:text&gt;
        &lt;xsl:value-of select=&quot;@rev&quot;/&gt;
      &lt;/xsl:if&gt;
    &lt;/div&gt;
    &lt;div class=&quot;path&quot;&gt;
      &lt;xsl:value-of select=&quot;@path&quot;/&gt;
    &lt;/div&gt;
    &lt;xsl:apply-templates select=&quot;updir&quot;/&gt;
    &lt;xsl:apply-templates select=&quot;dir&quot;/&gt;
    &lt;xsl:apply-templates select=&quot;file&quot;/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match=&quot;updir&quot;&gt;
    &lt;div class=&quot;updir&quot;&gt;
      &lt;xsl:text&gt;[&lt;/xsl:text&gt;
      &lt;xsl:element name=&quot;a&quot;&gt;
        &lt;xsl:attribute name=&quot;href&quot;&gt;..&lt;/xsl:attribute&gt;
        &lt;xsl:text&gt;Parent Directory&lt;/xsl:text&gt;
      &lt;/xsl:element&gt;
      &lt;xsl:text&gt;]&lt;/xsl:text&gt;
    &lt;/div&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match=&quot;dir&quot;&gt;
    &lt;div class=&quot;dir&quot;&gt;
      &lt;xsl:element name=&quot;a&quot;&gt;
        &lt;xsl:attribute name=&quot;href&quot;&gt;
          &lt;xsl:value-of select=&quot;@href&quot;/&gt;
        &lt;/xsl:attribute&gt;
        &lt;xsl:value-of select=&quot;@name&quot;/&gt;
        &lt;xsl:text&gt;/&lt;/xsl:text&gt;
      &lt;/xsl:element&gt;
    &lt;/div&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match=&quot;file&quot;&gt;
    &lt;div class=&quot;file&quot;&gt;
      &lt;xsl:element name=&quot;a&quot;&gt;
        &lt;xsl:attribute name=&quot;href&quot;&gt;
          &lt;xsl:value-of select=&quot;@href&quot;/&gt;
        &lt;/xsl:attribute&gt;
        &lt;xsl:value-of select=&quot;@name&quot;/&gt;
      &lt;/xsl:element&gt;
    &lt;/div&gt;
  &lt;/xsl:template&gt;

&lt;/xsl:stylesheet&gt;
</pre>
<hr />
</body></html>