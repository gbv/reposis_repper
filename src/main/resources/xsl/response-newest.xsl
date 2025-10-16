<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:mods="http://www.loc.gov/mods/v3" xmlns:encoder="xalan://java.net.URLEncoder"
  xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation" xmlns:str="http://exslt.org/strings" xmlns:exslt="http://exslt.org/common" xmlns:mcr="xalan://org.mycore.common.xml.MCRXMLFunctions"
  xmlns:acl="xalan://org.mycore.access.MCRAccessManager" xmlns:mcrxsl="xalan://org.mycore.common.xml.MCRXMLFunctions" xmlns:basket="xalan://org.mycore.frontend.basket.MCRBasketManager"
  xmlns:decoder="xalan://java.net.URLDecoder" exclude-result-prefixes="i18n mods str exslt mcr acl mcrxsl basket encoder decoder"
  >
  <xsl:include href="MyCoReLayout.xsl" />
  <xsl:include href="response-utils.xsl" />
  <xsl:include href="xslInclude:solrResponse" />

  <xsl:param name="WebApplicationBaseURL" />

  <xsl:variable name="PageTitle">
    <xsl:value-of select="i18n:translate('pp.newestObjects')" />
  </xsl:variable>

  <xsl:template match="/response/result|lst[@name='grouped']/lst[@name='returnId']" priority="20">

    <div class="row result_head">
      <div class="col-12 result_headline">
        <h1 class="pp-newest">
          <xsl:value-of select="i18n:translate('pp.newestObjects')" />
        </h1>
      </div>
    </div>

    <!-- Filter, Pagination & Trefferliste -->
    <div class="row result_body">

      <div class="col-12 col-sm-8 result_list">
        <xsl:comment>
          RESULT LIST START
        </xsl:comment>
        <div id="hit_list">
          <xsl:apply-templates select="doc|arr[@name='groups']/lst/str[@name='groupValue']" mode="resultList" />
        </div>
        <xsl:comment>
          RESULT LIST END
        </xsl:comment>
        <div class="result_list_end" />
      </div>

    </div>
    <xsl:if test="string-length($MCR.ORCID.OAuth.ClientSecret) &gt; 0">
      <script src="{$WebApplicationBaseURL}js/mir/mycore2orcid.js" />
    </xsl:if>

    <script>
      // removes unwanted xsl style part from hit link
      $(function() {
        $(".hit_title a").each(function( index ) {
          $( this).attr("href", $( this ).attr("href").replace("XSL.Style=newest&amp;", ""));
        });
      });
    </script>

  </xsl:template>



</xsl:stylesheet>
