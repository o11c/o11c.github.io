<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>
  <xsl:output method="xml" indent="yes"
      encoding="utf-8"
      media-type="application/xhtml+xml"
      doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
      doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
  />
  <xsl:strip-space elements="*"/>

  <xsl:template match="/features">
    <html>
      <head>
        <title>o11c's notes on FreeOrion bugs / features</title>
        <style>table, th, td { border: 1px solid black; }</style>
      </head>
      <body>
        Categories:
        <ul>
          <li>old-*: was written for FreeOrion 0.4.4, not 0.4.5; there may be duplicates or fixed issues here.</li>
          <li>feature: it would be nice, but does not fundamentally affect gameplay</li>
          <li>text: it works but is confusing</li>
          <li>bug: it doesn't work, or is extremely resource intensive</li>
          <li>design: it would fundamentally change gameplay or the way the program is written</li>
        </ul>
        <xsl:comment>I suck at HTML but at least I can do XSLT</xsl:comment>
        <table>
          <thead>
            <tr>
              <th>Category</th>
              <th>Description</th>
            </tr>
          </thead>
          <tfoot>
            <tr>
              <th>Category</th>
              <th>Description</th>
            </tr>
          </tfoot>
          <tbody>
            <xsl:apply-templates select="*"/>
          </tbody>
        </table>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="*">
    <tr>
      <td><xsl:value-of select="name()"/></td>
      <td><xsl:value-of select="text()"/></td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
