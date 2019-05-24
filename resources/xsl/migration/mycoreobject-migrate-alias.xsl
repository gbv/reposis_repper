<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:mcrxml="xalan://org.mycore.common.xml.MCRXMLFunctions">
  
  <xsl:include href="copynodes.xsl" />
  <xsl:include href="coreFunctions.xsl"/>


  <xsl:template match="servflag[@type='alias']">
    <xsl:copy>
      <xsl:apply-templates select="@*" />
      <xsl:call-template name="substring-after-last">
        <xsl:with-param name="string" select="." />
        <xsl:with-param name="delimiter" select="'/'" />
      </xsl:call-template>
    </xsl:copy>
  </xsl:template>


  <xsl:template name="substring-after-last">
    <xsl:param name="string" />
    <xsl:param name="delimiter" />
    <xsl:choose>
      <xsl:when test="contains($string, $delimiter)">
        <xsl:call-template name="substring-after-last">
          <xsl:with-param name="string"
            select="substring-after($string, $delimiter)" />
          <xsl:with-param name="delimiter" select="$delimiter" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$string" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>