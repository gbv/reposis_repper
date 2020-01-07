<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation"
    xmlns:mcrver="xalan://org.mycore.common.MCRCoreVersion"
    xmlns:mcrxsl="xalan://org.mycore.common.xml.MCRXMLFunctions"
    xmlns:calendar="xalan://java.util.GregorianCalendar"
    exclude-result-prefixes="i18n mcrver mcrxsl calendar">

  <xsl:import href="resource:xsl/layout/mir-common-layout.xsl" />
  <xsl:param name="piwikID" select="'0'" />

  <xsl:template name="mir.navigation">

    <div id="header_box" class="clearfix container">
      <div id="project_logo_box">
        <a title="zur Homepage" href="{$WebApplicationBaseURL}">
          <img alt="Logo perspectivia.net" src="{$WebApplicationBaseURL}images/logos/perspectivia_logo_p.png" />
          <span id="pp_logo_title">erspectivia</span><span id="pp_suffix">.net</span><br />
          <!-- span id="pp_logo_title" style="color:#961432; margin-left:40px; font-size:36px; margin-top:10px; display:inline-flex;">Testinstanz</span -->
          <span id="pp_logo_subtitle"><xsl:value-of select="i18n:translate('pp.subtitle')"/></span>
        </a>
      </div>

      <div id="options_nav_box" class="mir-prop-nav">

        <div class="searchfield_box">
          <form action="{$WebApplicationBaseURL}servlets/solr/find" class="navbar-form navbar-left float-right form-inline" role="search">
            <div class="form-group">
              <button type="submit" class="btn btn-primary"><i class="fas fa-search"></i></button>
              <input name="condQuery" placeholder="{i18n:translate('mir.navsearch.placeholder')}" class="form-control search-query" id="searchInput" type="text" />
              <xsl:choose>
                <xsl:when test="mcrxsl:isCurrentUserInRole('admin') or mcrxsl:isCurrentUserInRole('editor')">
                  <input name="owner" type="hidden" value="createdby:*" />
                </xsl:when>
                <xsl:when test="not(mcrxsl:isCurrentUserGuestUser())">
                  <input name="owner" type="hidden" value="createdby:{$CurrentUser}" />
                </xsl:when>
              </xsl:choose>
            </div>
          </form>
        </div>

        <nav>
          <ul class="nav navbar-nav navbar-expand">
            <xsl:call-template name="mir.loginMenu" />
            <xsl:call-template name="mir.languageMenu" />
          </ul>
        </nav>

      </div>

    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="navbar navbar-default mir-main-nav">
      <div class="container">
        <nav class="mir-main-nav-entries navbar-expand-md show">
          <button
            class="navbar-toggler float-left"
            type="button"
            data-toggle="collapse"
            data-target="#repper-main-menu"
            aria-controls="navbarSupportedContent"
            aria-expanded="false"
            aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div id="repper-main-menu" class="collapse navbar-collapse">
            <ul class="navbar-nav mr-auto">
              <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='about']" />
              <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='search']" />
              <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='quicklinks']" />
              <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='publish']" />
              <xsl:call-template name="mir.basketMenu" />
            </ul>
          </div>
        </nav>

        <div id="pp_feedback">
          <a href="mailto:perspectivia@MaxWeberStiftung.de">Feedback</a>
        </div>
      </div><!-- /container -->
    </div>
  </xsl:template>

  <xsl:template name="mir.jumbotwo">
    <!-- do nothing special -->
  </xsl:template>

  <xsl:template name="mir.footer">
    <section class="mcr-footer-section mcr-footer-section--menu">
      <div class="container">
        <div class="row">
          <div class="col-4 col-sm-2 col-md-1">
            <a title="zur Homepage" href="{$WebApplicationBaseURL}">
              <img alt="Logo perspectivia.net" src="{$WebApplicationBaseURL}images/logos/perspectivia_logo_complete.png" style="height:134px;" />
            </a>
          </div>
          <div class="col-8 col-sm-10 col-md-3 col-lg-2">
            <ul id="pp_footer-nav" class="nav">
              <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='below']/*" />
            </ul>
          </div>
          <div class="col-sm-6 col-md-4 col-lg-2 mt-3 mt-md-0 text-center">
            <a href="http://www.maxweberstiftung.de/">
              <img class="media-object img-fluid pp_footer-img" src="{$WebApplicationBaseURL}images/logos/Max-Weber-Stiftung-Logo.png" alt="Logo der Max Weber Stiftung" title="Logo der Max Weber Stiftung" />
            </a>
          </div>
          <div class="col-sm-6 col-md-4 col-lg-3 mt-3 mt-md-0 text-center">
            <a href="http://www.bmbf.de/">
              <img class="media-object img-fluid pp_footer-img" src="{$WebApplicationBaseURL}images/logos/BMBF-Logo.png" alt="BMBF-Logo" title="Bundesministerium für Bildung und Forschung (BMBF)" />
            </a>
          </div>
          <!-- footer-social -->
          <div class="offset-md-4 offset-lg-0 col-lg-4 mt-3 mt-lg-0">
            <div id="footer-social">
              <ul class="nav flex-column">
                <li>
                  <a href="https://twitter.com/perspectivia" class="twitter"><span class="fa-stack"><i class="fab fa-twitter fa-stack-2x"></i></span>@perspectivia folgen</a>
                </li>
                <li>
                  <a href="https://www.facebook.com/maxweberstiftung" class="facebook"><span class="fa-stack"><i class="fab fa-facebook-f fa-stack-2x"></i></span>Like Max Weber Stiftung</a>
                </li>
                <li>
                  <a href="http://vimeo.com/maxweberstiftung" class="vimeo-mws"><span class="fa-stack"><i class="fab fa-vimeo-square fa-stack-2x"></i></span>Max Weber Stiftung Videos folgen</a>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </section>
    <section class="mcr-footer-section mcr-footer-section--coop-partners">
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
                <p class="text-center text-md-left">
                  <xsl:text>© Max Weber Stiftung </xsl:text>
                  <xsl:value-of select="calendar:get($tmp, 1)"/>
                </p>
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
