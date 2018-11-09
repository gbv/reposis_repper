<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation"
                xmlns:mcrxsl="xalan://org.mycore.common.xml.MCRXMLFunctions"
                xmlns:mods="http://www.loc.gov/mods/v3"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:encoder="xalan://java.net.URLEncoder"
                xmlns:xsL="http://www.w3.org/1999/XSL/Transform" version="1.0"
                exclude-result-prefixes="i18n mcrxsl encoder mods xlink">

  <!-- embed a solr search into the about us > institution pages -->
  <xsl:template match="div[contains(@class, 'solrsearch')]">
    <!-- the search query -->
    <xsl:variable name="parameters" select="@data-parameters" />
    <xsl:variable name="classes" select="@data-classes" />
    <xsl:variable name="thumbnail" select="@data-defaultThumbnail" />

    <xsl:variable name="searchResult" select="document(concat('solr:', $parameters))" />

    <h3>
      <xsl:value-of select="i18n:translate('mir.publication_selection')" /> <!-- Auswahl Publikationsreihen -->
    </h3>
    <xsl:for-each select="$searchResult//doc">
      <xsl:variable name="id" select="str[@name='id']/text()" />
      <xsl:variable name="mcrobject" select="document(concat('mcrobject:', $id))" />


      <div class="row {$classes}">
        <div class="col-xs-4">
          <xsl:call-template name="displayPreviewIMG">
            <xsl:with-param name="derivateID"
                            select="$mcrobject/mycoreobject/structure/derobjects/derobject[1]/@xlink:href" />
            <xsl:with-param name="defaultThumbnail" select="$thumbnail" />
          </xsl:call-template>
        </div>
        <div class="col-xs-8">
          <a class="external-link" href="{$WebApplicationBaseURL}receive/{$id}">
            <xsl:value-of select="./str[@name='mods.title.main']" />
            <xsl:if test="./str[@name='mods.title.subtitle']">
              <xsl:value-of select="concat(' : ', ./str[@name='mods.title.subtitle'])" />
            </xsl:if>
          </a>
        </div>
      </div>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="displayPreviewIMG">
    <xsl:param name="derivateID" />
    <xsl:param name="defaultThumbnail" />
    <xsl:variable name="defaultThumbnailImg">
      <img class="img-responsive" src="{$defaultThumbnail}" />
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="string-length($derivateID)&gt;0">
        <xsl:variable name="derivate" select="document(concat('mcrobject:',$derivateID))" />
        <xsl:variable name="maindoc"
                      select="$derivate/mycorederivate/derivate/internals[@class='MCRMetaIFS']/internal/@maindoc" />
        <xsl:variable name="contentType"
                      select="document(concat('ifs:/',$derivateID))/mcr_directory/children/child[name=$maindoc]/contentType" />
        <xsl:variable name="fileEnding_">
          <xsl:call-template name="get-file-extension">
            <xsl:with-param name="path" select="$maindoc" />
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="fileEnding" select="translate($fileEnding_, $uppercase, $lowercase)" />
        <xsl:choose>
          <xsl:when test="$fileEnding='pdf'">
            <a href="{concat($WebApplicationBaseURL, 'rsc/viewer/', $derivateID, '/', encoder:encode($maindoc))}">
              <a href="{concat($WebApplicationBaseURL, 'rsc/viewer/', $derivateID, '/', encoder:encode($maindoc))}">
                <img class="img-responsive"
                     src="{concat($WebApplicationBaseURL, 'img/pdfthumb/', $derivateID, '/', encoder:encode($maindoc), '?centerThumb=no')}" />
              </a>
            </a>
          </xsl:when>
          <xsl:when
            test="string-length($fileEnding)&gt;0 and contains($MCR.Module-iview2.SupportedContentTypes, $contentType)">
            <a href="{concat($WebApplicationBaseURL, 'rsc/viewer/', $derivateID, '/', encoder:encode($maindoc))}">
              <img class="img-responsive"
                   src="{concat($WebApplicationBaseURL, 'servlets/MCRTileCombineServlet/MID/', $derivateID, '/', encoder:encode($maindoc))}" />
            </a>
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

