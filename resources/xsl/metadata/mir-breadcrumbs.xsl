<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:mcrxml="xalan://org.mycore.common.xml.MCRXMLFunctions"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:mods="http://www.loc.gov/mods/v3"
  exclude-result-prefixes="mcrxml xlink mods">
  
  <xsl:import href="xslImport:modsmeta:metadata/mir-breadcrumbs.xsl" />
  
  <xsl:template match="/">
    <xsl:variable name="mods" select="mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods" />
    <xsl:variable name="relatedItemPath">
      <xsl:choose>
        <xsl:when test="$mods/mods:relatedItem[@type='host']">
          <xsl:call-template name="repperPrintRelPath">
            <xsl:with-param name="id" select="$mods/mods:relatedItem[@type='host']/@xlink:href" />
            <xsl:with-param name="title" select="$mods/mods:relatedItem[@type='host']/mods:titleInfo[not(@type)]" />
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="$mods/mods:relatedItem[@type='series']">
          <xsl:call-template name="repperPrintRelPath">
            <xsl:with-param name="id" select="$mods/mods:relatedItem[@type='series']/@xlink:href" />
            <xsl:with-param name="title" select="$mods/mods:relatedItem[@type='series']/mods:titleInfo[not(@type)]" />
          </xsl:call-template>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="relatedItemPathGrany">
      <xsl:choose>
        <xsl:when test="$mods/mods:relatedItem[contains('host series',@type)]/mods:relatedItem[@type='host']/@xlink:href">
          <xsl:call-template name="repperPrintRelPath">
            <xsl:with-param name="id" select="$mods/mods:relatedItem[contains('host series',@type)]/mods:relatedItem[@type='host']/@xlink:href" />
            <xsl:with-param name="title" select="$mods/mods:relatedItem[contains('host series',@type)]/mods:relatedItem[@type='host']/mods:titleInfo[not(@type)]" />
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="$mods/mods:relatedItem[contains('host series',@type)]/mods:relatedItem[@type='series']">
          <xsl:call-template name="repperPrintRelPath">
            <xsl:with-param name="id" select="$mods/mods:relatedItem[contains('host series',@type)]/mods:relatedItem[@type='series']/@xlink:href" />
            <xsl:with-param name="title" select="$mods/mods:relatedItem[contains('host series',@type)]/mods:relatedItem[@type='series']/mods:titleInfo[not(@type)]" />
          </xsl:call-template>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="relatedItemPathGreatGrany">
      <xsl:choose>
        <xsl:when test="$mods/mods:relatedItem[contains('host series',@type)]/mods:relatedItem[contains('host series',@type)]/mods:relatedItem[@type='host']/@xlink:href">
          <xsl:call-template name="repperPrintRelPath">
            <xsl:with-param name="id" select="$mods/mods:relatedItem[contains('host series',@type)]/mods:relatedItem[contains('host series',@type)]/mods:relatedItem[@type='host']/@xlink:href" />
            <xsl:with-param name="title" select="$mods/mods:relatedItem[contains('host series',@type)]/mods:relatedItem[contains('host series',@type)]/mods:relatedItem[@type='host']/mods:titleInfo[not(@type)]" />
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="$mods/mods:relatedItem[contains('host series',@type)]/mods:relatedItem[contains('host series',@type)]/mods:relatedItem[@type='series']">
          <xsl:call-template name="repperPrintRelPath">
            <xsl:with-param name="id" select="$mods/mods:relatedItem[contains('host series',@type)]/mods:relatedItem[contains('host series',@type)]/mods:relatedItem[@type='series']/@xlink:href" />
            <xsl:with-param name="title" select="$mods/mods:relatedItem[contains('host series',@type)]/mods:relatedItem[contains('host series',@type)]/mods:relatedItem[@type='series']/mods:titleInfo[not(@type)]" />
          </xsl:call-template>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="owner">
      <xsl:choose>
        <xsl:when test="mcrxml:isCurrentUserInRole('admin') or mcrxml:isCurrentUserInRole('editor')">
          <xsl:text>*</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$CurrentUser" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <div id="mir-breadcrumb">
      <ul class="breadcrumb">
        <xsl:if test="string-length($relatedItemPathGreatGrany) &gt; 0">
          <li class="breadcrumb-item">
            <xsl:copy-of select="$relatedItemPathGreatGrany"/>
          </li>
        </xsl:if>
        <xsl:if test="string-length($relatedItemPathGrany) &gt; 0">
          <li class="breadcrumb-item">
            <xsl:copy-of select="$relatedItemPathGrany"/>
          </li>
        </xsl:if>
        <li class="breadcrumb-item">
          <xsl:choose>
            <xsl:when test="string-length($relatedItemPath) &gt; 0">
              <xsl:copy-of select="$relatedItemPath"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="categorySearchLink">
                <xsl:with-param name="class" select="'navtrail'" />
                <xsl:with-param name="node" select="$mods/mods:genre[@type='intern']"/>
                <xsl:with-param name="parent" select="true()" />
                <xsl:with-param name="owner"  select="$owner" />
              </xsl:call-template>
            </xsl:otherwise>
          </xsl:choose>
        </li>
        <li class="breadcrumb-item active">
          <xsl:variable name="completeTitle">
            <xsl:apply-templates select="$mods" mode="mods.title" />
          </xsl:variable>
          <xsl:value-of select="mcrxml:shortenText($completeTitle,70)" />
        </li>
      </ul>
    </div>
    <xsl:apply-imports />
  </xsl:template>
  
  <xsl:template name="repperPrintRelPath">
    <xsl:param name="id" />
    <xsl:param name="title" />
    <a href="{$WebApplicationBaseURL}receive/{$id}">
      <xsl:apply-templates select="$title" mode="mods.printTitle">
        <xsl:with-param name="asHTML" select="true()" />
        <xsl:with-param name="withSubtitle" select="false()" />
      </xsl:apply-templates>
    </a>
  </xsl:template>
</xsl:stylesheet>