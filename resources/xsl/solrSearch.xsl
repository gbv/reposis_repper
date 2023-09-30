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
          <xsl:copy-of select="document(concat('solr:', $parameters, '&amp;sort=id asc'))" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:copy-of
            select="document(concat('solr:', $parameters, '%20AND%20state:published&amp;sort=id asc&amp;'))" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <h3>
      <xsl:value-of select="i18n:translate('mir.publication_selection')" /> <!-- Auswahl
      Publikationsreihen -->
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

  <xsl:template match="div[contains(@class, 'pp_carousel-slide')]">

    <div class="carousel slide" data-interval="0" data-ride="carousel"
      id="carousel-publications"><!-- Indicators -->
      <ol class="carousel-indicators">
        <li class="active" data-slide-to="0" data-target="#carousel-publications"></li>
        <li data-slide-to="1" data-target="#carousel-publications"></li>
        <li data-slide-to="2" data-target="#carousel-publications"></li>
        <li data-slide-to="3" data-target="#carousel-publications"></li>
      </ol>
      <!-- Wrapper for slides -->

      <div class="carousel-inner" role="listbox">

        <div class="carousel-item active">
          <div class="carousel-item__content-box">

            <xsl:variable name="newest_article">
              <xsl:copy-of select="document('solr:q=category.top%3A%22mir_genres%3Aarticle%22%20AND%20state%3Apublished&amp;rows=1&amp;sort=mods.dateIssued+desc,modified+desc&amp;fl=id,search_result_link_text,mods.abstract.result')" />
            </xsl:variable>
            <xsl:variable name="newest_article_id" select="exslt:node-set($newest_article)//doc/str[@name='id']/text()" />
            <xsl:variable name="newest_article_title" select="exslt:node-set($newest_article)//doc/str[@name='search_result_link_text']/text()" />
            <xsl:variable name="newest_article_mcrobject" select="document(concat('mcrobject:', $newest_article_id))" />

            <img
              alt=""
              class="carousel-item__image"
              src="{$WebApplicationBaseURL}api/iiif/image/v2/thumbnail/{$newest_article_id}/full/max/0/default.jpg" />
            <h3><xsl:value-of select="exslt:node-set($newest_article)//doc/str[@name='search_result_link_text']/text()" /></h3>
            <!-- ToDo: Auslesen aus Objekt und sprachabhängig ausgeben -->
            <p>
              <xsl:value-of select="exslt:node-set($newest_article)//doc/str[@name='mods.abstract.result']/text()" />
            </p>
            <p>
              <a href="{$WebApplicationBaseURL}receive/{$newest_article_id}">zum Eintrag in perspectivia.net</a>
              <xsl:if test="$newest_article_mcrobject//mods:mods/mods:url[@access='raw object']">
                <a href="{$newest_article_mcrobject//mods:mods/mods:url[@access='raw object']}">zum Volltext</a>
              </xsl:if>
              <xsl:if test="$newest_article_mcrobject//mods:mods/mods:url[@access='object in context']">
                <a href="{$newest_article_mcrobject//mods:mods/mods:url[@access='object in context']}">zur Druckversion</a>
              </xsl:if>
            </p>

          </div>
        </div>

        <div class="carousel-item">
          <div class="carousel-item__content-box">

            <xsl:variable name="newest_book">
              <xsl:copy-of select="document('solr:q=category.top%3A%22mir_genres%3Abook%22%20AND%20state%3Apublished&amp;rows=1&amp;sort=mods.dateIssued+desc,modified+desc&amp;fl=id,search_result_link_text,mods.abstract.result')" />
            </xsl:variable>
            <xsl:variable name="newest_book_id" select="exslt:node-set($newest_book)//doc/str[@name='id']/text()" />
            <xsl:variable name="newest_book_title" select="exslt:node-set($newest_book)//doc/str[@name='search_result_link_text']/text()" />
            <xsl:variable name="newest_book_mcrobject" select="document(concat('mcrobject:', $newest_book_id))" />

            <img
              alt=""
              class="carousel-item__image"
              src="{$WebApplicationBaseURL}api/iiif/image/v2/thumbnail/{$newest_book_id}/full/max/0/default.jpg" />
            <h3><xsl:value-of select="exslt:node-set($newest_book)//doc/str[@name='search_result_link_text']/text()" /></h3>
            <!-- ToDo: Auslesen aus Objekt und sprachabhängig ausgeben -->
            <p>
              <xsl:value-of select="exslt:node-set($newest_book)//doc/str[@name='mods.abstract.result']/text()" />
            </p>
            <p>
              <a href="{$WebApplicationBaseURL}receive/{$newest_book_id}">zum Eintrag in perspectivia.net</a>
              <xsl:if test="$newest_book_mcrobject//mods:mods/mods:url[@access='raw object']">
                <a href="{$newest_book_mcrobject//mods:mods/mods:url[@access='raw object']}">zum Volltext</a>
              </xsl:if>
              <xsl:if test="$newest_book_mcrobject//mods:mods/mods:url[@access='object in context']">
                <a href="{$newest_book_mcrobject//mods:mods/mods:url[@access='object in context']}">zur Druckversion</a>
              </xsl:if>
            </p>

          </div>
        </div>

        <div class="carousel-item">
          <div class="carousel-item__content-box">

            <xsl:variable name="newest_collection">
              <xsl:copy-of select="document('solr:q=category.top%3A%22mir_genres%3Acollection%22%20AND%20state%3Apublished&amp;rows=1&amp;sort=mods.dateIssued+desc,modified+desc&amp;fl=id,search_result_link_text,mods.abstract.result')" />
            </xsl:variable>
            <xsl:variable name="newest_collection_id" select="exslt:node-set($newest_collection)//doc/str[@name='id']/text()" />
            <xsl:variable name="newest_collection_title" select="exslt:node-set($newest_collection)//doc/str[@name='search_result_link_text']/text()" />
            <xsl:variable name="newest_collection_mcrobject" select="document(concat('mcrobject:', $newest_collection_id))" />

            <img
              alt=""
              class="carousel-item__image"
              src="{$WebApplicationBaseURL}api/iiif/image/v2/thumbnail/{$newest_collection_id}/full/max/0/default.jpg" />
            <h3><xsl:value-of select="exslt:node-set($newest_collection)//doc/str[@name='search_result_link_text']/text()" /></h3>
            <!-- ToDo: Auslesen aus Objekt und sprachabhängig ausgeben -->
            <p>
              <xsl:value-of select="exslt:node-set($newest_collection)//doc/str[@name='mods.abstract.result']/text()" />
            </p>
            <p>
              <a href="{$WebApplicationBaseURL}receive/{$newest_collection_id}">zum Eintrag in perspectivia.net</a>
              <xsl:if test="$newest_collection_mcrobject//mods:mods/mods:url[@access='raw object']">
                <a href="{$newest_collection_mcrobject//mods:mods/mods:url[@access='raw object']}">zum Volltext</a>
              </xsl:if>
              <xsl:if test="$newest_collection_mcrobject//mods:mods/mods:url[@access='object in context']">
                <a href="{$newest_collection_mcrobject//mods:mods/mods:url[@access='object in context']}">zur Druckversion</a>
              </xsl:if>
            </p>

          </div>
        </div>

        <div class="carousel-item">
          <div class="carousel-item__content-box">

            <xsl:variable name="newest_source">
              <xsl:copy-of select="document('solr:q=category.top%3A%22mir_genres%3Asource_edition%22%20AND%20state%3Apublished&amp;rows=1&amp;sort=mods.dateIssued+desc,modified+desc&amp;fl=id,search_result_link_text,mods.abstract.result')" />
            </xsl:variable>
            <xsl:variable name="newest_source_id" select="exslt:node-set($newest_source)//doc/str[@name='id']/text()" />
            <xsl:variable name="newest_source_title" select="exslt:node-set($newest_source)//doc/str[@name='search_result_link_text']/text()" />
            <xsl:variable name="newest_source_mcrobject" select="document(concat('mcrobject:', $newest_source_id))" />

            <img
              alt=""
              class="carousel-item__image"
              src="{$WebApplicationBaseURL}api/iiif/image/v2/thumbnail/{$newest_source_id}/full/max/0/default.jpg" />
            <h3><xsl:value-of select="exslt:node-set($newest_source)//doc/str[@name='search_result_link_text']/text()" /></h3>
            <!-- ToDo: Auslesen aus Objekt und sprachabhängig ausgeben -->
            <p>
              <xsl:value-of select="exslt:node-set($newest_source)//doc/str[@name='mods.abstract.result']/text()" />
            </p>
            <p>
              <a href="{$WebApplicationBaseURL}receive/{$newest_source_id}">zum Eintrag in perspectivia.net</a>
              <xsl:if test="$newest_source_mcrobject//mods:mods/mods:url[@access='raw object']">
                <a href="{$newest_source_mcrobject//mods:mods/mods:url[@access='raw object']}">zum Volltext</a>
              </xsl:if>
              <xsl:if test="$newest_source_mcrobject//mods:mods/mods:url[@access='object in context']">
                <a href="{$newest_source_mcrobject//mods:mods/mods:url[@access='object in context']}">zur Druckversion</a>
              </xsl:if>
            </p>

          </div>
        </div>

      </div>
      <a class="carousel-control-prev" href="#carousel-publications" role="button"
        data-slide="prev">
        <i class="fas fa-chevron-left"></i>
        <span class="sr-only">
          Vorherige
          <!-- i18n:de>Vorherige</i18n:de>
          <i18n:en>Previous</i18n:en>
          <i18n:fr>Précédent</i18n:fr -->
        </span>
      </a>
      <a class="carousel-control-next" href="#carousel-publications" role="button"
        data-slide="next">
        <i class="fas fa-chevron-right"></i>
        <span class="sr-only">
          Nächste
          <!-- i18n:de>Nächste</i18n:de>
          <i18n:en>Next</i18n:en>
          <i18n:fr>Prochain</i18n:fr -->
        </span>
      </a>
    </div>
  </xsl:template>


  <xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
  <xsl:param name="MCR.Module-iview2.SupportedContentTypes" />

</xsl:stylesheet>