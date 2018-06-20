<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation"
    xmlns:mcrver="xalan://org.mycore.common.MCRCoreVersion"
    xmlns:mcrxsl="xalan://org.mycore.common.xml.MCRXMLFunctions"
    exclude-result-prefixes="i18n mcrver mcrxsl">

  <xsl:import href="resource:xsl/layout/mir-common-layout.xsl" />
  <xsl:param name="piwikID" select="'0'" />

  <xsl:template name="mir.navigation">

    <div id="header_box" class="clearfix container">
      <div id="project_logo_box">
        <a title="zur Homepage" href="{$WebApplicationBaseURL}">
          <img alt="Logo perspectivia.net" src="{$WebApplicationBaseURL}images/logos/perspectivia_logo_p.png" />
          <span id="pp_logo_title">erspectivia</span><span id="pp_suffix">.net</span><br />
          <span id="pp_logo_subtitle"><xsl:value-of select="i18n:translate('pp.subtitle')"/></span>
        </a>
      </div>
      <div id="options_nav_box" class="mir-prop-nav">

        <div class="searchfield_box">
          <form action="{$WebApplicationBaseURL}servlets/solr/find" class="navbar-form navbar-left pull-right" role="search">
            <button type="submit" class="btn btn-primary"><i class="fa fa-search"></i></button>
            <div class="form-group">
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
          <ul class="nav navbar-nav pull-right">
            <xsl:call-template name="mir.loginMenu" />
            <xsl:call-template name="mir.languageMenu" />
          </ul>
        </nav>
      </div>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="navbar navbar-default mir-main-nav">
      <div class="container">

        <div class="navbar-header">
          <button class="navbar-toggle" type="button" data-toggle="collapse" data-target=".mir-main-nav-entries">
            <span class="sr-only"> Toggle navigation </span>
            <span class="icon-bar">
            </span>
            <span class="icon-bar">
            </span>
            <span class="icon-bar">
            </span>
          </button>
        </div>

        <nav class="collapse navbar-collapse mir-main-nav-entries">
          <ul class="nav navbar-nav pull-left">
            <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='about']" />
            <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='search']" />
            <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='quicklinks']" />
            <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='publish']" />
            <xsl:call-template name="mir.basketMenu" />
          </ul>
        </nav>

      </div><!-- /container -->
    </div>
  </xsl:template>

  <xsl:template name="mir.jumbotwo">
    <!-- do nothing special -->
  </xsl:template>

  <xsl:template name="mir.footer">
    
    <div class="container footer-wrapper">  
      <footer id="footer">
        <div id="portal-siteactions">
        <!-- footer-siteactions -->
        <div class="row">
          <div class="col-lg-12 footer-sitemap">
            <div class="col-xs-12 col-sm-4 col-md-3">
              <div class="media">
                <div class="col-xs-2 col-md-3 media-right">
                  <a title="zur Homepage" href="{$WebApplicationBaseURL}">
                    <img alt="Logo perspectivia.net" src="{$WebApplicationBaseURL}images/logos/perspectivia_logo_complete.png" />
                  </a>
                </div>
              </div> 
              <div class="footer-list col-md-12">
                <ul id="" class="nav nav-pills nav-stacked">
                  <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='below']/*" />
                </ul>
              </div><!-- footer-list--> 
            </div><!-- col-lg-3 -->
            <div class="col-xs-12 col-md-offset-1 col-sm-4 col-md-4 footer-info">
              <div class="row">
                <div class="media">
                  <div class="col-xs-10 col-md-9 media-body">
                    <h4 class="media-heading">Max Weber Stiftung</h4>
                    <a href="http://www.maxweberstiftung.de/" title="Max Weber Stiftung" alt="Max Weber Stiftung">Kontakt</a>
                  </div>
                  <div class="col-xs-2 col-md-3 media-right">
                    <a href="http://www.maxweberstiftung.de/">
                      <img class="media-object img-responsive" src="{$WebApplicationBaseURL}images/logos/Max-Weber-Stiftung-Logo.png" alt="Max-Weber-Stiftung-Logo" title="Max-Weber-Stiftung-Logo">
                    </a>
                  </div>
                </div> 
                <div class="divider"></div>
                <div class="media">
                  <div class="col-xs-10 col-md-9 media-body">
                    <h4 class="media-heading">Die Max Weber Stiftung wird gefördert durch das </h4>
                    <a href="http://www.bmbf.de/" title="Bundesministerium für Bildung und Forschung (BMBF)" alt="Bundesministerium für Bildung und Forschung (BMBF)">Bundesministerium für Bildung und Forschung (BMBF)</a>
                  </div>
                  <div class="col-xs-2 col-md-3 media-right">
                    <a href="http://www.bmbf.de/">
                      <img class="media-object img-responsive" src="{$WebApplicationBaseURL}images/logos/BMBF-Logo.png" alt="BMBF-Logo" title="Bundesministerium für Bildung und Forschung (BMBF)">
                    </a>
                  </div>
                </div> 
                <div class="divider"></div>
                <div class="media">
                  <div class="col-xs-10 col-md-9 media-body">
                    <h4 class="media-heading">perspectivia.net kooperiert mit der  </h4>
                    <a href="http://www.bsb-muenchen.de/" title="Bayerischen Staatsbibliothek in München" alt="Bayerischen Staatsbibliothek in München">Bayerischen Staatsbibliothek in München</a><br>
                  </div>
                  <div class="col-xs-2 col-md-3 media-right">
                    <a href="http://www.bsb-muenchen.de/">
                      <img class="media-object img-responsive" src="{$WebApplicationBaseURL}images/logos/bsb.png" alt="Bayerischen Staatsbibliothek in München" title="Bayerischen Staatsbibliothek in München">
                    </a>
                  </div>
                </div> 
                <div class="divider"></div>
              </div>
            </div><!-- col-lg-6 -->
            <!-- footer-social -->
            <div class="col-xs-12 col-md-offset-1 col-sm-4 col-md-3">
              <div id="footer-social" class="">
                <div class="media">
                  <div class="col-xs-12 col-md-12 media-body">
                    <h4 class="media-heading">Social Media@Max Weber Stiftung</h4>
                  </div>
                </div>
                <ul class="nav nav-pills nav-stacked">
                  <li><a href="https://twitter.com/perspectivia" class="twitter">
                    <span class="fa-stack fa-lg">
                      <i class="fa fa-circle fa-stack-2x"></i>
                      <i class="fa fa-twitter fa-stack-1x fa-inverse"></i>
                    </span>
                    @perspectiva folgen</a></li>
                  <li><a href="https://www.facebook.com/maxweberstiftung" class="facebook">
                    <span class="fa-stack fa-lg">
                      <i class="fa fa-circle fa-stack-2x"></i>
                      <i class="fa fa-facebook fa-stack-1x fa-inverse"></i>
                    </span>
                    Like Max Weber Stiftung</a></li>
                  <li><a href="http://vimeo.com/maxweberstiftung" class="vimeo-mws">
                    <span class="fa-stack fa-lg">
                      <i class="fa fa-circle fa-stack-2x"></i>
                      <i class="fa fa-vimeo-square fa-stack-1x fa-inverse"></i>
                    </span>
                    Max Weber Stiftung Videos folgen</a></li>
                  <li><a href="http://mws.hypotheses.org/" class="blog-mws">
                    <span class="icon-w_grau" style="font-size:32px; margin-left:0.05em;margin-right:-0.2em;vertical-align:middle;">
                    </span>
                    Blog folgen</a></li>
                  <li><a href="http://www.maxweberstiftung.de/" class="main-mws">
                    <span class="icon-mws_grau" style="font-size:32px; margin-left:0.05em;margin-right:-0.2em;vertical-align:middle;">
                    </span>
                    Max Weber Stiftung folgen</a></li>
                  
                </ul>
              </div>
            </div>
          </div>
          
        </div>
      </div>
      </footer>
      
    </div>

  </xsl:template>

  <xsl:template name="mir.powered_by">
    <xsl:variable name="mcr_version" select="concat('MyCoRe ',mcrver:getCompleteVersion())" />
    <div class="container">
      <div class="row">
        <div class="col-md-4">
          <p>© perspectivia.net 2018</p>
        </div>
        <div class="col-md-4">
          <div id="powered_by">
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