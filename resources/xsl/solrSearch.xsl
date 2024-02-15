<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation"
                xmlns:mcrxsl="xalan://org.mycore.common.xml.MCRXMLFunctions"
                xmlns:mods="http://www.loc.gov/mods/v3"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:encoder="xalan://java.net.URLEncoder"
                xmlns:exslt="http://exslt.org/common"
                xmlns:xsL="http://www.w3.org/1999/XSL/Transform"
                version="1.0"
                exclude-result-prefixes="i18n mcrxsl encoder mods xlink exslt">

  <!-- embed a solr search into the about us > institution pages -->
  <xsl:template match="div[contains(@class, 'solrsearch')]">
    <!-- the search query -->
    <xsl:variable name="parameters" select="@data-parameters" />
    <xsl:variable name="classes" select="@data-classes" />
    <xsl:variable name="thumbnail" select="@data-defaultThumbnail" />

    <xsl:variable name="searchResult">
      <xsl:choose>
        <xsl:when test="mcrxsl:isCurrentUserInRole('admin') or mcrxsl:isCurrentUserInRole('editor')">
          <xsl:copy-of select="document(concat('solr:', $parameters, '&amp;sort=id asc&amp;rows=100'))" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:copy-of
            select="document(concat('solr:', $parameters, '%20AND%20state:published&amp;sort=id asc&amp;rows=100'))" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:if test="exslt:node-set($searchResult)//result/@numFound!=0">
      <h3>
        <xsl:choose>
          <xsl:when test="contains($parameters, 'NOT%20(mods.genre%3Asource_edition)')">
            <xsl:value-of select="i18n:translate('mir.publication_selection')" /> <!-- Auswahl Publikationsreihen -->
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="i18n:translate('mir.source_editions')" /> <!-- Digitale Quelleneditionen -->
          </xsl:otherwise>
        </xsl:choose>
        
      </h3>
      <div
        class="row {$classes}">
        <xsl:for-each select="exslt:node-set($searchResult)//doc">
          <xsl:variable name="id" select="str[@name='id']/text()" />
        <xsl:variable name="mcrobject"
            select="document(concat('mcrobject:', $id))" />
          <div class="col-xs-4 col-md-2">
            <xsl:call-template name="displayPreviewIMG">
              <xsl:with-param name="derobject"
                select="$mcrobject/mycoreobject/structure/derobjects/derobject[classification[@classid='derivate_types'][@categid='thumbnail']]" />
              <xsl:with-param name="defaultThumbnail" select="$thumbnail" />
              <xsl:with-param name="id" select="$id" />
            </xsl:call-template>
          </div>
          <div
            class="col-xs-8 col-md-4">
            <a class="external-link" href="{$WebApplicationBaseURL}receive/{$id}">
              <xsl:value-of select="./str[@name='mods.title.main']" />
              <xsl:if test="./str[@name='mods.title.subtitle']">
                <xsl:value-of select="concat(' : ', ./str[@name='mods.title.subtitle'])" />
              </xsl:if>
            </a>
            <xsl:if test="./str[@name='mods.abstract.result']">
              <p>
                <xsl:value-of select="./str[@name='mods.abstract.result']" />
              </p>
            </xsl:if>
          </div>
        </xsl:for-each>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template name="displayPreviewIMG">
    <xsl:param name="derobject" />
    <xsl:param name="defaultThumbnail" />
    <xsl:param name="id" />
    <xsl:variable
      name="defaultThumbnailImg">
      <img class="img-responsive" src="{$defaultThumbnail}" />
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="string-length($derobject)&gt;0">
        <xsl:variable name="derivateID" select="$derobject/@xlink:href" />
        <xsl:variable
          name="maindoc" select="$derobject/maindoc" />
        <xsl:variable name="contentType"
          select="document(concat('ifs:/',$derivateID))/mcr_directory/children/child[name=$maindoc]/contentType" />
        <xsl:variable
          name="fileEnding_">
          <xsl:call-template name="get-file-extension">
            <xsl:with-param name="path" select="$maindoc" />
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable
          name="fileEnding" select="translate($fileEnding_, $uppercase, $lowercase)" />
        <xsl:choose>
          <xsl:when test="$fileEnding='pdf'">
            <img class="img-responsive"
              src="{concat($WebApplicationBaseURL, 'api/iiif/image/v2/thumbnail/', $id, '/full/!300,300/0/default.jpg')}" />
          </xsl:when>
          <xsl:when
            test="string-length($fileEnding)&gt;0 and string-length($contentType)&gt;0 and contains($MCR.Module-iview2.SupportedContentTypes, $contentType)">
            <img class="img-responsive"
              src="{concat($WebApplicationBaseURL, 'api/iiif/image/v2/thumbnail/', $id, '/full/!300,300/0/default.jpg')}" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:copy-of select="$defaultThumbnailImg" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy-of select="$defaultThumbnailImg" />
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <!--
  http://morg.nl/2012/02/get-file-extention-in-xslt/
  Determine File Extention template
  -->
  <xsl:template name="get-file-extension">
    <xsl:param name="path" />
    <xsl:choose>
      <xsl:when test="contains($path, '/')">
        <xsl:call-template name="get-file-extension">
          <xsl:with-param name="path" select="substring-after($path, '/')" />
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="contains($path, '.')">
        <xsl:call-template name="get-file-extension">
          <xsl:with-param name="path" select="substring-after($path, '.')" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$path" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
  <xsl:param name="MCR.Module-iview2.SupportedContentTypes" />

</xsl:stylesheet>