<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation" exclude-result-prefixes="i18n xlink">
  <xsl:variable name="Type" select="'document'" />

  <xsl:variable name="PageTitle" select="i18n:translate('titles.pageTitle.error',concat(' ',/mcr_error/@HttpError))" />

  <xsl:template match="/mcr_error">
    <div class="row">
      <div class="col-md-8" lang="de">
        <h1>
          <xsl:value-of select="i18n:translate('pp.pageError.title')" />
        </h1>

        <xsl:choose>
          <xsl:when test="/mcr_error/@HttpError = '500'">
            <h2><xsl:value-of select="i18n:translate('pp.pageError.title.500')" /></h2>
            <!-- <xsl:value-of select="i18n:translate('pp.pageError.text.500')" disable-output-escaping="yes" /> -->
            <xsl:value-of select="i18n:translate('pp.pageError.text.404')" disable-output-escaping="yes" />
          </xsl:when>
          <xsl:when test="/mcr_error/@HttpError = '404'">
              <h2><xsl:value-of select="." /></h2>
              <xsl:value-of select="i18n:translate('pp.pageError.text.404')" disable-output-escaping="yes" />
          </xsl:when>
          <xsl:when test="/mcr_error/@HttpError = '403'">
              <h2>Zugriff verweigert</h2>
              <p>Sie haben keine Berechtigung diese Seite zu sehen. Melden Sie sich bitte am System an.
              Sollten Sie trotz Anmeldung nicht die nötigen Rechte haben um diese Seite zu sehen, wenden
              Sie sich ggf. an Ihren Administrator oder
              schreiben Sie eine Mail an <span class="madress">perspectivia [at] maxweberstiftung.de</span>.</p>
              <p>Vorrübergehend ist die alte perspectivia.net Webseite auch noch zu erreichen unter:
                <a href="https://prae.perspectivia.net">prae.perspectivia.net</a>
              <br/><br/>
              Vielen Dank!</p>
          </xsl:when>
          <xsl:otherwise>
              <h2><xsl:value-of select="."></xsl:value-of></h2>
              <p>Es ist leider ein Fehler aufgetreten. Sollte dies wiederholt der Fall sein,
              schreiben Sie bitte eine Mail an <span class="madress">dms-list [at] lists.gbv.de</span> und
              schildern kurz wie es dazu kam.
              <br/><br/>
              Vielen Dank!</p>
          </xsl:otherwise>
        </xsl:choose>
      </div>
      <xsl:if test="exception">
      <div class="hidden">
        <div class="card bg-warning">
          <div class="card-header">
            <xsl:value-of select="concat(i18n:translate('error.stackTrace'),' :')" />
          </div>
          <div class="card-body">
            <xsl:for-each select="exception/trace">
              <pre style="font-size:0.8em;">
                <xsl:value-of select="." />
              </pre>
            </xsl:for-each>
          </div>
        </div>
      </div>
      </xsl:if>
    </div>
  </xsl:template>
  <xsl:include href="MyCoReLayout.xsl" />
</xsl:stylesheet>
