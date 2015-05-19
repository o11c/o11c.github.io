<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/index">
    <html>
    <body>
      <h2>Merge test</h2>
      <table border="1">
        <tr>
          <th>Attr</th>
          <th>Value</th>
        </tr>
        <xsl:apply-templates select="document(include/@name)"/>
      </table>
    </body>
    </html>
  </xsl:template>
  <xsl:template match="root">
    <xsl:for-each select="foo">
      <tr>
        <td><xsl:value-of select="@x"/></td>
        <td><xsl:value-of select="text()"/></td>
      </tr>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="identity">
    <xsl:copy>
      <xsl:for-each select="node()|@*">
        <xsl:call-template name="identity"/>
      </xsl:for-each>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
