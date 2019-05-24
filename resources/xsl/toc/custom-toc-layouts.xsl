<?xml version="1.0" encoding="UTF-8"?>

<!-- Custom table of contents layouts to display levels and publications -->

<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xalan="http://xml.apache.org/xalan"
  xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation"
>

  <xsl:param name="CurrentLang" select="'de'" />

  <!-- "Vol. 67" -->
  <xsl:template match="toc[@layout='series']//level[@field='series.volume']/item" priority="1">
    <xsl:value-of select="i18n:translate('mir.details.volume.journal')" />
    <xsl:text> </xsl:text> 
    <xsl:value-of select="@value" />
  </xsl:template>

 </xsl:stylesheet>