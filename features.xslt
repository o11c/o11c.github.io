<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
    exclude-result-prefixes="exsl set"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:exsl="http://exslt.org/common"
    xmlns:set="http://exslt.org/sets"
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
        <style>
          table, th, td { border: 1px solid black; }
          code { font-family: monospace }

          .bug { background-color: #FF8080; }
          .text { background-color: #FFAA55; }
          .feature { background-color: #80FF80; }
          .design { background-color: #FFFF00; }
        </style>
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
          <caption>FreeOrion Wishlist (<xsl:value-of select="count(*)"/> items)</caption>
          <thead>
            <tr>
              <th>Category</th>
              <th>Priority</th>
              <th>Difficulty</th>
              <th>Description</th>
            </tr>
          </thead>
          <tfoot>
            <tr>
              <th>Category</th>
              <th>Priority</th>
              <th>Difficulty</th>
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
    <tr class="{name()}">
      <td><xsl:value-of select="name()"/></td>
      <td><xsl:call-template name="defaulter"><xsl:with-param name="attr" select="@priority"/><xsl:with-param name="def" select="'default'"/></xsl:call-template></td>
      <td><xsl:call-template name="defaulter"><xsl:with-param name="attr" select="@difficulty"/><xsl:with-param name="def" select="'default'"/></xsl:call-template></td>
      <td><xsl:for-each select="*|text()"><xsl:copy-of select="."/></xsl:for-each></td>
    </tr>
  </xsl:template>

  <xsl:template name="defaulter">
    <xsl:param name="attr"/>
    <xsl:param name="def"/>
    <xsl:param name="empty">
      <span style="color: gray">
        <xsl:value-of select="$def"/>
      </span>
    </xsl:param>
    <xsl:choose>
      <!-- Present in xml file with non-empty value. -->
      <xsl:when test="string($attr)">
        <xsl:call-template name="tree-or-value"><xsl:with-param name="object" select="$attr"/></xsl:call-template>
      </xsl:when>
      <!-- Present in xml file with empty value. -->
      <xsl:when test="$attr">
        <xsl:call-template name="tree-or-value"><xsl:with-param name="object" select="$empty"/></xsl:call-template>
      </xsl:when>
      <!-- Not present in xml file. -->
      <xsl:otherwise>
        <xsl:call-template name="tree-or-value"><xsl:with-param name="object" select="$def"/></xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="tree-or-value">
    <xsl:param name="object"/>
    <xsl:choose>
      <!-- copy-of fails on attributes -->
      <xsl:when test="(exsl:object-type($object) = 'node-set' and not(set:has-same-node($object/parent::node()/@*, $object))) or exsl:object-type($object) = 'RTF'">
        <xsl:copy-of select="$object"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$object"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
