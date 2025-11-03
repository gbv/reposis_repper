<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:mods="http://www.loc.gov/mods/v3"
                exclude-result-prefixes="mods">

  <xsl:import href="xslImport:badges:badges/mir-badges-pubversion.xsl"/>
  <xsl:include href="resource:xsl/badges/mir-badges-style-template.xsl"/>

  <xsl:variable name="tooltip-pubversion" select="document('i18n:component.mods.metaData.dictionary.publication_version')/i18n/text()"/>

  <xsl:template match="doc" mode="resultList">
    <xsl:apply-imports/>

    <xsl:variable name="publicationVersion">
      <xsl:choose>
        <xsl:when test="arr[@name='category.top']/str[contains(text(), 'versions:')] and
                        not(arr[@name='category.top']/str[contains(text(), 'versions:')][last()]='EV')">
          <xsl:value-of select="'ZV'" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'EV'" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="label-text-native" select="document(concat('callJava:org.mycore.common.xml.MCRXMLFunctions:getDisplayName:versions:', $publicationVersion))"/>

    <xsl:call-template name="output-badge">
      <xsl:with-param name="of-type" select="'hit_pubversion'"/>
      <xsl:with-param name="badge-type" select="concat('badge-primary mir-', $publicationVersion)"/>
      <xsl:with-param name="label" select="document(concat('callJava:org.apache.commons.lang3.StringUtils:capitalize:', $label-text-native))"/>
      <xsl:with-param name="tooltip" select="$tooltip-pubversion"/>
    </xsl:call-template>

  </xsl:template>

  <xsl:template match="mycoreobject" mode="mycoreobject-badge">
    <xsl:apply-imports/>

    <xsl:variable name="publicationVersion">
      <xsl:choose>
        <xsl:when test="//mods:mods/mods:classification[contains(@authorityURI, 'classifications/versions')] and
                        not(substring-after(//mods:mods/mods:classification[contains(@authorityURI, 'classifications/versions')]/@valueURI, '#')='EV')">
          <xsl:value-of select="'ZV'" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'EV'" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:if test="string-length($publicationVersion) &gt; 0">
      <xsl:variable name="label-text-native" select="document(concat('callJava:org.mycore.common.xml.MCRXMLFunctions:getDisplayName:versions:', $publicationVersion))"/>

      <xsl:call-template name="output-badge">
        <xsl:with-param name="of-type" select="'hit_pubversion'"/>
        <xsl:with-param name="badge-type" select="concat('badge-primary mir-', $publicationVersion)"/>
        <xsl:with-param name="label" select="document(concat('callJava:org.apache.commons.lang3.StringUtils:capitalize:', $label-text-native))"/>
        <xsl:with-param name="tooltip" select="$tooltip-pubversion"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
