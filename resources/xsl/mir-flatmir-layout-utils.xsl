<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation"
    xmlns:mcrver="xalan://org.mycore.common.MCRCoreVersion"
    xmlns:mcrxsl="xalan://org.mycore.common.xml.MCRXMLFunctions"
    xmlns:calendar="xalan://java.util.GregorianCalendar"
    xmlns:i18ntr="http://www.mycore.org/i18n"
    exclude-result-prefixes="i18n mcrver mcrxsl calendar i18ntr">

  <xsl:import href="resource:xsl/layout/mir-common-layout.xsl" />
  <xsl:param name="piwikID" select="'0'" />

  <xsl:template name="mir.navigation">

    <div class="header_box container-fluid">

      <div class="project_logo_box">
        <a title="zur Homepage" href="{$WebApplicationBaseURL}">
          <img alt="Logo perspectivia.net" src="{$WebApplicationBaseURL}images/logos/perspectivia.net.svg" />
        </a>
      </div>

      <div class="project_nav_box">

        <nav class="mir-prop-nav">
          <ul class="nav navbar-nav navbar-expand">
            <xsl:call-template name="mir.loginMenu" />
            <xsl:call-template name="mir.languageMenu" />
          </ul>
        </nav>

        <div class="search-button search-toggler js-search-toggler">
          <span class="search-button__label">Schnellsuche</span>
          <i class="fas fa-search search-button__icon"></i>
        </div>

        <div class="searchfield_box">
          <button class="btn js-search-close text-primary">
            <i class="far fa-times-circle search-button__close"></i>
          </button>
          <form
            id="bs-searchHeader"
            action="{$WebApplicationBaseURL}servlets/solr/find"
            class="bs-search form-inline"
            role="search">
            <div class="js-searchbar">
              <input
                id="searchbar"
                name="condQuery"
                placeholder="{i18n:translate('mir.navsearch.placeholder')}"
                class="form-control search-query"
                type="text" />
              <xsl:choose>
                <xsl:when test="mcrxsl:isCurrentUserInRole('admin') or mcrxsl:isCurrentUserInRole('editor')">
                  <input name="owner" type="hidden" value="createdby:*" />
                </xsl:when>
                <xsl:when test="not(mcrxsl:isCurrentUserGuestUser())">
                  <input name="owner" type="hidden" value="createdby:{$CurrentUser}" />
                </xsl:when>
              </xsl:choose>
              <button type="submit" class="btn pnt-primary text-primary">
                <i class="fas fa-search search-button__icon"></i>
              </button>
            </div>
          </form>
        </div>

        <div class="mir-main-nav pp-main-nav">
          <nav class="navbar navbar-expand-lg navbar-light">
            <button
              class="navbar-toggler"
              type="button"
              data-toggle="collapse"
              data-target=".mir-main-nav__entries--mobile"
              aria-controls="mir-main-nav__entries--mobile"
              aria-expanded="false"
              aria-label="Toggle navigation">
              <span class="navbar-toggler-icon text-primary"></span>
            </button>
            <div class="collapse navbar-collapse mir-main-nav__entries">
              <ul class="navbar-nav">
                <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='about']" />
                <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='search']" />
                <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='quicklinks']" />
                <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='publish']" />
                <xsl:call-template name="mir.basketMenu" />
              </ul>
            </div>
          </nav>
        </div>

      </div>
    </div>
    <div id="pp_feedback">
      <a href="mailto:perspectivia@MaxWeberStiftung.de">Feedback</a>
    </div>

    <div class="collapse mir-main-nav__entries--mobile">
      <button
        class="mir-main-nav__entries--mobile-close btn"
        type="button"
        data-toggle="collapse"
        data-target=".mir-main-nav__entries--mobile"
        aria-controls="mir-main-nav__entries--mobile"
        aria-expanded="false"
        aria-label="Toggle navigation">
        <i class="far fa-times-circle "></i>
      </button>

      <ul class="navbar-nav">
        <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='about']" />
        <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='search']" />
        <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='quicklinks']" />
        <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='publish']" />
        <xsl:call-template name="mir.basketMenu" />
      </ul>
    </div>

  </xsl:template>

  <xsl:template name="mir.jumbotwo">
    <!-- do nothing special -->
  </xsl:template>

  <xsl:template name="mir.footer">
    <section class="mcr-footer-section mcr-footer-section--menu">
      <div class="container">
        <div class="row">

          <div class="col mws-logo">
            <xsl:choose>
              <xsl:when test="$CurrentLang = 'de'">
                <a href="http://www.maxweberstiftung.de/">
                  <img
                    class="media-object img-fluid pp_footer-img"
                    src="{$WebApplicationBaseURL}images/logos/max-weber-stiftung-de.svg"
                    alt="Logo der Max Weber Stiftung"
                    title="Zur Max Weber Stiftung" />
                </a>
              </xsl:when>
              <xsl:otherwise>
                <a href="https://www.maxweberstiftung.de/en">
                  <img
                    class="media-object img-fluid pp_footer-img"
                    src="{$WebApplicationBaseURL}images/logos/mws_logo_standard_en_schwarz.jpg"
                    alt="Logo of Max Weber Stiftung"
                    title="Go to Max Weber Stiftung" />
                </a>
              </xsl:otherwise>
            </xsl:choose>
          </div>

          <div class="col footer-nav">
            <ul id="pp_footer-nav" class="nav flex-column flex-md-row flex-lg-column">
              <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='below']/*" />
            </ul>
          </div>

          <div class="col social-nav" id="footer-social" >
            <ul class="nav flex-xl-column">
              <li>
                <a
                  href="https://twitter.com/perspectivia"
                  class="twitter">
                  <span class="fa-stack">
                    <i class="fab fa-twitter fa-stack-2x"></i>
                  </span>
                  <span class="d-none d-xl-inline">@perspectivia folgen</span>
                </a>
              </li>
              <li>
                <a
                  href="https://www.facebook.com/maxweberstiftung"
                  class="facebook">
                  <span class="fa-stack">
                    <i class="fab fa-facebook-f fa-stack-2x"></i>
                  </span>
                  <span class="d-none d-xl-inline">Like Max Weber Stiftung</span>
                </a>
              </li>
              <li>
                <a
                  href="http://vimeo.com/maxweberstiftung"
                  class="vimeo-mws">
                  <span class="fa-stack">
                    <i class="fab fa-vimeo-v fa-stack-2x"></i>
                  </span>
                  <span class="d-none d-xl-inline">Max Weber Stiftung Videos folgen</span>
                </a>
              </li>
            </ul>
          </div>

        </div>
      </div>
    </section>

    <section class="mcr-footer-section mcr-footer-section--coop-partners d-none">
      <div class="container">
        <div class="row"><!-- cooperation partners -->
          <div class="col-md-4 text-center">
            <a href="http://www.ub.uni-heidelberg.de/">
              <img class="media-object img-responsive pp_footer-img" src="{$WebApplicationBaseURL}images/logos/ubh.png" alt="Universitätsbibliothek Heidelberg" title="Universitätsbibliothek Heidelberg" style="margin-top: 10px;" />
            </a>
          </div>
          <div class="col-md-4 text-center">
            <a href="http://www.bsb-muenchen.de/">
              <img class="media-object img-responsive pp_footer-img center-block" src="{$WebApplicationBaseURL}images/logos/bsb.png" alt="Bayerischen Staatsbibliothek in München" title="Bayerischen Staatsbibliothek in München" style="margin-top: 45px;" />
            </a>
          </div>
          <div class="col-md-4 text-center">
            <a href="http://www.gbv.de/">
              <img class="media-object img-responsive pp_footer-img" src="{$WebApplicationBaseURL}images/logos/vzg.png" alt="Verbundzentrale des GBV (VZG)" title="Verbundzentrale des GBV (VZG)" style="margin-top: 39px;" />
            </a>
          </div>
        </div>
      </div>
    </section>

  </xsl:template>

  <xsl:template name="mir.powered_by">
    <xsl:variable name="mcr_version" select="concat('MyCoRe ',mcrver:getCompleteVersion())" />
      <section class="mcr-footer-section mcr-footer-section--copyright">
        <div class="container">
          <div class="row">
            <div class="col-md-4">
              <xsl:variable name="tmp" select="calendar:new()"/>
              <div id="copyright_by">
                <div class="text-center text-md-left">
                  <xsl:text>© Max Weber Stiftung </xsl:text>
                  <xsl:value-of select="calendar:get($tmp, 1)"/>
                </div>
              </div>
            </div>
            <div class="col-md-4">
              <div id="powered_by" class="text-center">
                <a href="http://www.mycore.de">
                  <img src="{$WebApplicationBaseURL}mir-layout/images/mycore_logo_small_invert.png" title="{$mcr_version}" alt="powered by MyCoRe" />
                </a>
              </div>
            </div>
            <div class="col-md-4">
              <div id="pp_goTop">
                <!-- a href="http://www.dfg.de">
                  <img src="{$WebApplicationBaseURL}images/logos/dfg_logo_gbv.svg" title="Die Entwicklung der Datenbank ist ein Kooperationsprojekt mit der VZG und wurde von der DFG gefördert. " alt="sponsored by DFG, hostet by VZG" />
                </a -->
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- Matomo -->
      <xsl:if test="$piwikID &gt; 0">
        <script type="text/javascript">
              var _paq = _paq || [];
              _paq.push(['setDoNotTrack', true]);
              _paq.push(['trackPageView']);
              _paq.push(['enableLinkTracking']);
              (function() {
                var u="https://matomo.gbv.de/";
                var objectID = '<xsl:value-of select="//site/@ID" />';
                if(objectID != "") {
                  _paq.push(["setCustomVariable",1, "object", objectID, "page"]);
                }
                _paq.push(['setTrackerUrl', u+'piwik.php']);
                _paq.push(['setSiteId', '<xsl:value-of select="$piwikID" />']);
                _paq.push(['setDownloadExtensions', '7z|aac|arc|arj|asf|asx|avi|bin|bz|bz2|csv|deb|dmg|doc|exe|flv|gif|gz|gzip|hqx|jar|jpg|jpeg|js|mp2|mp3|mp4|mpg|mpeg|mov|movie|msi|msp|odb|odf|odg|odp|ods|odt|ogg|ogv|pdf|phps|png|ppt|qt|qtm|ra|ram|rar|rpm|sea|sit|tar|tbz|tbz2|tgz|torrent|txt|wav|wma|wmv|wpd|z|zip']);
                var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
                g.type='text/javascript'; g.async=true; g.defer=true; g.src=u+'piwik.js'; s.parentNode.insertBefore(g,s);
              })();
        </script>
        <noscript><p><img src="https://matomo.gbv.de/piwik.php?idsite={$piwikID}" style="border:0;" alt="" /></p></noscript>
      </xsl:if>
      <!-- End Piwik Code -->

  </xsl:template>

</xsl:stylesheet>
