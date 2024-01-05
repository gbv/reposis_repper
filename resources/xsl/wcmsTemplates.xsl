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

  <!--
    Matches the "read me" section and builds the complete homepage layout.
    Content from other sections will be added by direct xpath access.
    So it is important to keep the xml structure (hard coded content requests).
    ind of bad style, indeed, but in this way we get the wcms running again.
    Yay!
  -->
  <xsl:template match="div[contains(@class, 'cms-page__base')]">

    <!-- marks this page as homepage -->
    <div class="jumbotwo"></div>

    <!-- intro -->
    <div class="page-section page-section__intro">
      <div class="container">

        <!-- wellcome message -->
        <xsl:variable
          name="introContent"
          select="../../section[contains(@xml:lang, $CurrentLang)]/div[contains(@class, 'cms-intro')]" />
        <div class="row">
          <div class="col">

            <div class="intro-box">
              <h1 class="d-none">perspectivia.net</h1>
              <div class="slogan">
                <div class="slogan__imagebox">
                  <img
                    class="slogan__image"
                    alt="flieder"
                    src="{$WebApplicationBaseURL}images/backgrounds/PatternStrichpunktGrossKreisViertel.svg" />
                  <div class="slogan__text">
                    <xsl:value-of select="$introContent/h1" />
                    <br />
                    <xsl:value-of select="$introContent/h2" />
                  </div>
                </div>
              </div>
              <div class="intro-text">
                <p>
                  <xsl:value-of select="$introContent/p" />
                </p>
              </div>
              <div class="decoration">
                <img
                  class="image-embed-item"
                  alt="flieder"
                  src="{$WebApplicationBaseURL}images/backgrounds/PatternSchlangenlinenGross.svg" />
              </div>
            </div>

          </div>
        </div>

        <!-- news -->
        <div class="row">
          <div class="col">

            <div class="teaser">
              <xsl:variable name="newsContainerClass" select="'cms-news'"/>
              <!-- slot 1 -->
              <xsl:variable name="newsSectionName" select="'News-SLot-One'"/>
              <xsl:variable
                name="newsCurrentEntry"
                select="../../section[contains(@xml:lang, $CurrentLang)][contains(@title, $newsSectionName)]/div[contains(@class, $newsContainerClass)]" />
              <div class="teaser__item">
                <div class="teaser__headline">
                  <xsl:value-of select="$newsCurrentEntry/h1" />
                </div>
                <div class="teaser__date">
                  <xsl:value-of select="$newsCurrentEntry/h2" />
                </div>
                <div class="teaser__text">
                  <xsl:value-of select="$newsCurrentEntry/p" />
                </div>
                <div class="teaser__button">
                  <a>
                    <xsl:attribute name="href">
                      <xsl:value-of select="$newsCurrentEntry/a/@href" />
                    </xsl:attribute>
                    <xsl:value-of select="$newsCurrentEntry/a" />
                    <i class="fas fa-chevron-right"></i>
                  </a>
                </div>
              </div>
              <!-- slot 2 -->
              <xsl:variable name="newsSectionName" select="'News-SLot-Two'"/>
              <xsl:variable
                name="newsCurrentEntry"
                select="../../section[contains(@xml:lang, $CurrentLang) and contains(@title, $newsSectionName)]/div[contains(@class, $newsContainerClass)]" />
              <div class="teaser__item d-none d-sm-block">
                <div class="teaser__headline">
                  <xsl:value-of select="$newsCurrentEntry/h1" />
                </div>
                <div class="teaser__date">
                  <xsl:value-of select="$newsCurrentEntry/h2" />
                </div>
                <div class="teaser__text">
                  <xsl:value-of select="$newsCurrentEntry/p" />
                </div>
                <div class="teaser__button">
                  <a>
                    <xsl:attribute name="href">
                      <xsl:value-of select="$newsCurrentEntry/a/@href" />
                    </xsl:attribute>
                    <xsl:value-of select="$newsCurrentEntry/a" />
                    <i class="fas fa-chevron-right"></i>
                  </a>
                </div>
              </div>
              <!-- slot 3 -->
              <xsl:variable name="newsSectionName" select="'News-SLot-Three'"/>
              <xsl:variable
                name="newsCurrentEntry"
                select="../../section[contains(@xml:lang, $CurrentLang) and contains(@title, $newsSectionName)]/div[contains(@class, $newsContainerClass)]" />
              <div class="teaser__item d-none d-lg-block">
                <div class="teaser__headline">
                  <xsl:value-of select="$newsCurrentEntry/h1" />
                </div>
                <div class="teaser__date">
                  <xsl:value-of select="$newsCurrentEntry/h2" />
                </div>
                <div class="teaser__text">
                  <xsl:value-of select="$newsCurrentEntry/p" />
                </div>
                <div class="teaser__button">
                  <a>
                    <xsl:attribute name="href">
                      <xsl:value-of select="$newsCurrentEntry/a/@href" />
                    </xsl:attribute>
                    <xsl:value-of select="$newsCurrentEntry/a" />
                    <i class="fas fa-chevron-right"></i>
                  </a>
                </div>
              </div>
              <!-- slot 4 -->
              <xsl:variable name="newsSectionName" select="'News-SLot-Four'"/>
              <xsl:variable
                name="newsCurrentEntry"
                select="../../section[contains(@xml:lang, $CurrentLang) and contains(@title, $newsSectionName)]/div[contains(@class, $newsContainerClass)]" />
              <div class="teaser__item">
                <div class="teaser__headline">
                  <xsl:value-of select="$newsCurrentEntry/h1" />
                </div>
                <div class="teaser__date">
                  <xsl:value-of select="$newsCurrentEntry/h2" />
                </div>
                <div class="teaser__text">
                  <xsl:value-of select="$newsCurrentEntry/p" />
                </div>
                <div class="teaser__button">
                  <a>
                    <xsl:attribute name="href">
                      <xsl:value-of select="$newsCurrentEntry/a/@href" />
                    </xsl:attribute>
                    <xsl:value-of select="$newsCurrentEntry/a" />
                    <i class="fas fa-chevron-right"></i>
                  </a>
                </div>
              </div>

            </div>

          </div>
        </div>

      </div>
    </div>

    <!-- links -->
    <div class="page-section page-section__links">
      <div class="container">

        <!-- theme tiles -->
        <div class="row">
          <div class="col">
            <h2 class="d-none">Links</h2>

            <div class="p-tiles">

              <a class="p-tile">
                <xsl:attribute name="href">
                  <xsl:value-of select="../../section[contains(@xml:lang, $CurrentLang) and contains(@title, 'Link-Tile-One')]/div[contains(@class, 'cms-tiles')]/a/@href" />
                </xsl:attribute>
                <img
                  alt=""
                  class="p-tile__background p-tile__petrol"
                  src="{$WebApplicationBaseURL}images/backgrounds/tile-back-basic.svg"
                  width="100%"
                  height="auto" />
                <img
                  alt=""
                  class="p-tile__arrow"
                  src="{$WebApplicationBaseURL}images/icons/icon-feather-arrow-up-right.svg" />
                <div class="p-tile__content">
                  <h3 class="p-tile__headline">
                    <xsl:value-of select="../../section[contains(@xml:lang, $CurrentLang) and contains(@title, 'Link-Tile-One')]/div[contains(@class, 'cms-tiles')]/h1" />
                  </h3>
                  <p class="p-tile__text">
                    <xsl:value-of select="../../section[contains(@xml:lang, $CurrentLang) and contains(@title, 'Link-Tile-One')]/div[contains(@class, 'cms-tiles')]/p" />
                  </p>
                </div>
              </a>

              <a class="p-tile">
                <xsl:attribute name="href">
                  <xsl:value-of select="../../section[contains(@xml:lang, $CurrentLang) and contains(@title, 'Link-Tile-Two')]/div[contains(@class, 'cms-tiles')]/a/@href" />
                </xsl:attribute>
                <img
                  alt=""
                  class="p-tile__background p-tile__purple"
                  src="{$WebApplicationBaseURL}images/backgrounds/tile-back-basic.svg"
                  width="100%"
                  height="auto" />
                <img
                  alt=""
                  class="p-tile__arrow"
                  src="{$WebApplicationBaseURL}images/icons/icon-feather-arrow-up-right.svg" />
                <div class="p-tile__content">
                  <h3 class="p-tile__headline">
                    <xsl:value-of select="../../section[contains(@xml:lang, $CurrentLang) and contains(@title, 'Link-Tile-Two')]/div[contains(@class, 'cms-tiles')]/h1" />
                  </h3>
                  <p class="p-tile__text">
                    <xsl:value-of select="../../section[contains(@xml:lang, $CurrentLang) and contains(@title, 'Link-Tile-Two')]/div[contains(@class, 'cms-tiles')]/p" />
                  </p>
                </div>
              </a>

              <a class="p-tile">
                <xsl:attribute name="href">
                  <xsl:value-of select="../../section[contains(@xml:lang, $CurrentLang) and contains(@title, 'Link-Tile-Three')]/div[contains(@class, 'cms-tiles')]/a/@href" />
                </xsl:attribute>
                <img
                  alt=""
                  class="p-tile__background p-tile__pink"
                  src="{$WebApplicationBaseURL}images/backgrounds/tile-back-basic.svg"
                  width="100%"
                  height="auto" />
                <img
                  alt=""
                  class="p-tile__arrow"
                  src="{$WebApplicationBaseURL}images/icons/icon-feather-arrow-up-right.svg" />
                <div class="p-tile__content">
                  <h3 class="p-tile__headline">
                    <xsl:value-of select="../../section[contains(@xml:lang, $CurrentLang) and contains(@title, 'Link-Tile-Three')]/div[contains(@class, 'cms-tiles')]/h1" />
                  </h3>
                  <p class="p-tile__text">
                    <xsl:value-of select="../../section[contains(@xml:lang, $CurrentLang) and contains(@title, 'Link-Tile-Three')]/div[contains(@class, 'cms-tiles')]/p" />
                  </p>
                </div>
              </a>

              <a class="p-tile">
                <xsl:attribute name="href">
                  <xsl:value-of select="../../section[contains(@xml:lang, $CurrentLang) and contains(@title, 'Link-Tile-Four')]/div[contains(@class, 'cms-tiles')]/a/@href" />
                </xsl:attribute>
                <img
                  alt=""
                  class="p-tile__background p-tile__orange"
                  src="{$WebApplicationBaseURL}images/backgrounds/tile-back-basic.svg"
                  width="100%"
                  height="auto" />
                <img
                  alt=""
                  class="p-tile__arrow"
                  src="{$WebApplicationBaseURL}images/icons/icon-feather-arrow-up-right.svg" />
                <div class="p-tile__content">
                  <h3 class="p-tile__headline">
                    <xsl:value-of select="../../section[contains(@xml:lang, $CurrentLang) and contains(@title, 'Link-Tile-Four')]/div[contains(@class, 'cms-tiles')]/h1" />
                  </h3>
                  <p class="p-tile__text">
                    <xsl:value-of select="../../section[contains(@xml:lang, $CurrentLang) and contains(@title, 'Link-Tile-Four')]/div[contains(@class, 'cms-tiles')]/p" />
                  </p>
                </div>
              </a>

              <a class="p-tile">
                <xsl:attribute name="href">
                  <xsl:value-of select="../../section[contains(@xml:lang, $CurrentLang) and contains(@title, 'Link-Tile-Five')]/div[contains(@class, 'cms-tiles')]/a/@href" />
                </xsl:attribute>
                <img
                  alt=""
                  class="p-tile__background p-tile__petrol"
                  src="{$WebApplicationBaseURL}images/backgrounds/tile-back-basic.svg"
                  width="100%"
                  height="auto" />
                <img
                  alt=""
                  class="p-tile__arrow"
                  src="{$WebApplicationBaseURL}images/icons/icon-feather-arrow-up-right.svg" />
                <div class="p-tile__content">
                  <h3 class="p-tile__headline">
                    <xsl:value-of select="../../section[contains(@xml:lang, $CurrentLang) and contains(@title, 'Link-Tile-Five')]/div[contains(@class, 'cms-tiles')]/h1" />
                  </h3>
                  <p class="p-tile__text">
                    <xsl:value-of select="../../section[contains(@xml:lang, $CurrentLang) and contains(@title, 'Link-Tile-Five')]/div[contains(@class, 'cms-tiles')]/p" />
                  </p>
                  </div>
              </a>

              <a class="p-tile">
                <xsl:attribute name="href">
                  <xsl:value-of select="../../section[contains(@xml:lang, $CurrentLang) and contains(@title, 'Link-Tile-Six')]/div[contains(@class, 'cms-tiles')]/a/@href" />
                </xsl:attribute>
                <img
                  alt=""
                  class="p-tile__background p-tile__purple"
                  src="{$WebApplicationBaseURL}images/backgrounds/tile-back-basic.svg"
                  width="100%"
                  height="auto" />
                <img
                  alt=""
                  class="p-tile__arrow"
                  src="{$WebApplicationBaseURL}images/icons/icon-feather-arrow-up-right.svg" />
                <div class="p-tile__content">
                  <h3 class="p-tile__headline">
                    <xsl:value-of select="../../section[contains(@xml:lang, $CurrentLang) and contains(@title, 'Link-Tile-Six')]/div[contains(@class, 'cms-tiles')]/h1" />
                  </h3>
                  <p class="p-tile__text">
                    <xsl:value-of select="../../section[contains(@xml:lang, $CurrentLang) and contains(@title, 'Link-Tile-Six')]/div[contains(@class, 'cms-tiles')]/p" />
                  </p>
                </div>
              </a>

            </div>
          </div>
        </div>

        <!-- statistics -->
        <div class="row class=">
          <div class="col">
            <h2 class="d-none">Daten</h2>
            <div class="p-statistics">
              <a
                href="../servlets/solr/select?q=%2Bcategory.top%3Amir_genres\:article+%2BobjectType%3Amods+%2Bcategory.top%3Astate\:published"
                class="p-statistic p-statistic__articles">
                <span class="p-statistic__title">
                  <xsl:value-of select="i18n:translate('pp.page.home.statistic.article')" disable-output-escaping="yes" />
                </span>
                <span id="p-statistic__articles__value" class="p-statistic__value">... loading</span>
              </a>
              <a
                href="../servlets/solr/select?q=%2Bcategory.top%3Amir_genres\:research_data+%2BobjectType%3Amods+%2Bcategory.top%3Astate\:published"
                class="p-statistic p-statistic__research">
                <span class="p-statistic__title">
                  <xsl:value-of select="i18n:translate('pp.page.home.statistic.research_data')" disable-output-escaping="yes" />
                </span>
                <span id="p-statistic__research__value" class="p-statistic__value">... loading</span>
              </a>
              <a
                href="../servlets/solr/select?q=%2Bcategory.top:mir_genres\:review+%2BobjectType:mods+%2Bcategory.top:state\:published"
                class="p-statistic p-statistic__reviews">
                <span class="p-statistic__title">
                  <xsl:value-of select="i18n:translate('pp.page.home.statistic.reviews')" disable-output-escaping="yes" />
                </span>
                <span id="p-statistic__reviews__value" class="p-statistic__value">... loading</span>
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- institutions -->
    <!-- TODO: make this genric by elements from wcms -->
    <div class="page-section page-section__institutions">
      <div class="container">
        <div class="row">
          <div class="col">
            <h2 class="">
              <xsl:value-of select="i18n:translate('pp.page.home.institutions')" disable-output-escaping="yes" />
            </h2>
            <div
              class="carousel slide carousel-institutes"
              data-interval="0"
              data-ride="carousel"
              id="carousel-institutes">

              <!-- Indicators -->
              <ol class="carousel-indicators">
                <li class="active" data-slide-to="0" data-target="#carousel-institutes"></li>
                <li data-slide-to="1" data-target="#carousel-institutes"></li>
                <li data-slide-to="2" data-target="#carousel-institutes"></li>
                <li data-slide-to="3" data-target="#carousel-institutes"></li>
                <li data-slide-to="4" data-target="#carousel-institutes"></li>
              </ol>

              <!-- Wrapper for slides -->
              <div class="carousel-inner" role="listbox">

                <div class="carousel-item active">
                  <div class="row carousel-item__content-box">

                    <div class="col-12 col-sm-6 col-lg-3 mb-3 mb-lg-0 carousel-item__tile">
                      <a
                        href="about/institutes/dfk.xml"
                        class="slider-institute slider-institute-dfk">
                        <div class="slider-institute-figure">
                          <img
                            alt=""
                            class="slider-institute-logo"
                            src="{$WebApplicationBaseURL}images/logos/dfk-paris-logo.jpg" />
                          <img
                            alt=""
                            class="img-fluid slider-institute-image"
                            src="{$WebApplicationBaseURL}images/institutes/dfk-louvre.jpg" />
                        </div>
                        <div class="slider-institute-title">
                          <xsl:value-of select="i18n:translate('pp.page.home.institutions.dfk')" disable-output-escaping="yes" />
                        </div>
                      </a>
                    </div>

                    <div class="col-12 col-sm-6 col-lg-3 mb-3 mb-lg-0 carousel-item__tile">
                      <a
                        href="about/institutes/dhi-london.xml"
                        class="slider-institute slider-institute-ghil">
                        <div class="slider-institute-figure">
                          <img
                            alt=""
                            class="slider-institute-logo"
                            src="{$WebApplicationBaseURL}images/logos/dhi-london-logo.jpg" />
                          <img
                            alt=""
                            class="img-fluid slider-institute-image"
                            src="{$WebApplicationBaseURL}images/institutes/dhi-london-figure.jpg" />
                        </div>
                        <div class="slider-institute-title">
                          <xsl:value-of select="i18n:translate('pp.page.home.institutions.ghil')" disable-output-escaping="yes" />
                        </div>
                      </a>
                    </div>

                    <div class="col-12 col-sm-6 col-lg-3 mb-3 mb-lg-0 carousel-item__tile">
                      <a
                        href="about/institutes/dhi-moskau.xml"
                        class="slider-institute slider-institute-moskau">
                        <div class="slider-institute-figure">
                          <img
                            alt=""
                            class="slider-institute-logo"
                            src="{$WebApplicationBaseURL}images/logos/dhi-moskau.png" />
                          <img
                            alt=""
                            class="img-fluid slider-institute-image"
                            src="{$WebApplicationBaseURL}images/institutes/dhi-moskau-figure.jpg" />
                        </div>
                        <div class="slider-institute-title">
                          <xsl:value-of select="i18n:translate('pp.page.home.institutions.dhim')" disable-output-escaping="yes" />
                        </div>
                      </a>
                    </div>

                    <div class="col-12 col-sm-6 col-lg-3 mb-3 mb-lg-0 carousel-item__tile">
                      <a
                        href="about/institutes/dhi-paris.xml"
                        class="slider-institute slider-institute-paris">
                        <div class="slider-institute-figure">
                          <img
                            alt=""
                            class="slider-institute-logo"
                            src="{$WebApplicationBaseURL}images/logos/dhi-paris-logo.jpg" />
                          <img
                            alt=""
                            class="img-fluid slider-institute-image"
                            src="{$WebApplicationBaseURL}images/institutes/dhi-paris-figure.jpg" />
                        </div>
                        <div class="slider-institute-title">
                          <xsl:value-of select="i18n:translate('pp.page.home.institutions.dhip')" disable-output-escaping="yes" />
                        </div>
                      </a>
                    </div>

                  </div>
                </div>

                <div class="carousel-item">
                  <div class="row carousel-item__content-box">

                    <div class="col-12 col-sm-6 col-lg-3 mb-3 mb-lg-0 carousel-item__tile">
                      <a
                        href="about/institutes/dhi-rom.xml"
                        class="slider-institute slider-institute-rom">
                        <div class="slider-institute-figure">
                          <img
                            alt=""
                            class="slider-institute-logo"
                            src="{$WebApplicationBaseURL}images/logos/dhi-rom-logo.jpg" />
                          <img
                            alt=""
                            class="img-fluid slider-institute-image"
                            src="{$WebApplicationBaseURL}images/institutes/dhi-rom-figure.jpg" />
                        </div>
                        <div class="slider-institute-title">
                          <xsl:value-of select="i18n:translate('pp.page.home.institutions.dhir')" disable-output-escaping="yes" />
                        </div>
                      </a>
                    </div>

                    <div class="col-12 col-sm-6 col-lg-3 mb-3 mb-lg-0 carousel-item__tile">
                      <a
                        href="about/institutes/dhi-warschau.xml"
                        class="slider-institute slider-institute-warsaw">
                        <div class="slider-institute-figure">
                          <img
                            alt=""
                            class="slider-institute-logo"
                            src="{$WebApplicationBaseURL}images/logos/dhi-warschau-logo.jpg" />
                          <img
                            alt=""
                            class="img-fluid slider-institute-image"
                            src="{$WebApplicationBaseURL}images/institutes/dhi-warschau-figure.jpg" />
                        </div>
                        <div class="slider-institute-title">
                          <xsl:value-of select="i18n:translate('pp.page.home.institutions.dhiw')" disable-output-escaping="yes" />
                        </div>
                      </a>
                    </div>

                    <div class="col-12 col-sm-6 col-lg-3 mb-3 mb-lg-0 carousel-item__tile">
                      <a
                        href="about/institutes/dhi-washington.xml"
                        class="slider-institute slider-institute-washington">
                        <div class="slider-institute-figure">
                          <img
                            alt=""
                            class="slider-institute-logo"
                            src="{$WebApplicationBaseURL}images/logos/dhi-washingtondc-logo.jpg" />
                          <img
                            alt=""
                            class="img-fluid slider-institute-image"
                            src="{$WebApplicationBaseURL}images/institutes/dhi-washington-figure.jpg" />
                        </div>
                        <div class="slider-institute-title">
                          <xsl:value-of select="i18n:translate('pp.page.home.institutions.dhidc')" disable-output-escaping="yes" />
                        </div>
                      </a>
                    </div>

                    <div class="col-12 col-sm-6 col-lg-3 mb-3 mb-lg-0 carousel-item__tile">
                      <a
                        href="about/institutes/dij.xml"
                        class="slider-institute slider-institute-dij">
                        <div class="slider-institute-figure">
                          <img
                            alt=""
                            class="slider-institute-logo"
                            src="{$WebApplicationBaseURL}images/logos/dij-tokio-logo.jpg" />
                          <img
                            alt=""
                            class="img-fluid slider-institute-image"
                            src="{$WebApplicationBaseURL}images/institutes/dij-figure.jpg" />
                        </div>
                        <div class="slider-institute-title">
                          <xsl:value-of select="i18n:translate('pp.page.home.institutions.dij')" disable-output-escaping="yes" />
                        </div>
                      </a>
                    </div>

                  </div>
                </div>

                <div class="carousel-item">
                  <div class="row carousel-item__content-box">

                    <div class="col-12 col-sm-6 col-lg-3 mb-3 mb-lg-0 carousel-item__tile">
                      <a
                        href="about/institutes/oib.xml"
                        class="slider-institute slider-institute-oib">
                        <div class="slider-institute-figure">
                          <img
                            alt=""
                            class="slider-institute-logo"
                            src="{$WebApplicationBaseURL}images/logos/io-beirut-logo.jpg" />
                          <img
                            alt=""
                            class="img-fluid slider-institute-image"
                            src="{$WebApplicationBaseURL}images/institutes/oib-figure.jpg" />
                        </div>
                        <div class="slider-institute-title">
                          <xsl:value-of select="i18n:translate('pp.page.home.institutions.oib')" disable-output-escaping="yes" />
                        </div>
                      </a>
                    </div>

                    <div class="col-12 col-sm-6 col-lg-3 mb-3 mb-lg-0 carousel-item__tile">
                      <a
                        href="about/institutes/oii.xml"
                        class="slider-institute slider-institute-oii">
                        <div class="slider-institute-figure">
                          <img
                            alt=""
                            class="slider-institute-logo"
                            src="{$WebApplicationBaseURL}images/logos/oii-logo.jpg" />
                          <img
                            alt=""
                            class="img-fluid slider-institute-image"
                            src="{$WebApplicationBaseURL}images/institutes/oii-figure.jpg" />
                        </div>
                        <div class="slider-institute-title">
                          <xsl:value-of select="i18n:translate('pp.page.home.institutions.oii')" disable-output-escaping="yes" />
                        </div>
                      </a>
                    </div>

                    <div class="col-12 col-sm-6 col-lg-3 mb-3 mb-lg-0 carousel-item__tile">
                      <a
                        href="about/institutes/mwf.xml"
                        class="slider-institute slider-institute-mwf">
                        <div class="slider-institute-figure">
                          <img
                            alt=""
                            class="slider-institute-logo"
                            src="{$WebApplicationBaseURL}images/logos/mwf-logo.jpg" />
                          <img
                            alt=""
                            class="img-fluid slider-institute-image"
                            src="{$WebApplicationBaseURL}images/institutes/mwf-figure.jpg" />
                        </div>
                        <div class="slider-institute-title">
                          <xsl:value-of select="i18n:translate('pp.page.home.institutions.mwf')" disable-output-escaping="yes" />
                        </div>
                      </a>
                    </div>

                    <div class="col-12 col-sm-6 col-lg-3 mb-3 mb-lg-0 carousel-item__tile">
                      <a
                        href="about/institutes/mws.xml"
                        class="slider-institute slider-institute-mws">
                        <div class="slider-institute-figure">
                          <img
                            alt=""
                            class="slider-institute-logo"
                            src="{$WebApplicationBaseURL}images/logos/max-weber-stiftung-de.svg" />
                          <img
                            alt=""
                            class="img-fluid slider-institute-image"
                            src="{$WebApplicationBaseURL}images/institutes/mws-figure.jpg" />
                        </div>
                        <div class="slider-institute-title">
                          <xsl:value-of select="i18n:translate('pp.page.home.institutions.mws')" disable-output-escaping="yes" />
                        </div>
                      </a>
                    </div>

                  </div>
                </div>

                <div class="carousel-item">
                  <div class="row carousel-item__content-box">

                    <div class="col-12 col-sm-6 col-lg-3 mb-3 mb-lg-0 carousel-item__tile">
                      <a
                        href="about/institutes/adef.xml"
                        class="slider-institute slider-institute-agf">
                        <div class="slider-institute-figure">
                          <img
                            alt=""
                            class="slider-institute-logo"
                            src="{$WebApplicationBaseURL}images/logos/agf.png" />
                          <img
                            alt=""
                            class="img-fluid slider-institute-image"
                            src="{$WebApplicationBaseURL}images/institutes/adef-figure.jpg" />
                        </div>
                        <div class="slider-institute-title">
                          <xsl:value-of select="i18n:translate('pp.page.home.institutions.agf')" disable-output-escaping="yes" />
                        </div>
                      </a>
                    </div>

                    <div class="col-12 col-sm-6 col-lg-3 mb-3 mb-lg-0 carousel-item__tile">
                      <a
                        href="about/institutes/trafo.xml"
                        class="slider-institute slider-institute-trafo">
                        <div class="slider-institute-figure">
                          <img
                            alt=""
                            class="slider-institute-logo"
                            src="{$WebApplicationBaseURL}images/logos/trafo.jpeg" />
                          <img
                            alt=""
                            class="img-fluid slider-institute-image"
                            src="{$WebApplicationBaseURL}images/institutes/trafo-figure.jpg" />
                        </div>
                        <div class="slider-institute-title">
                          <xsl:value-of select="i18n:translate('pp.page.home.institutions.trafo')" disable-output-escaping="yes" />
                        </div>
                      </a>
                    </div>

                    <div class="col-12 col-sm-6 col-lg-3 mb-3 mb-lg-0 carousel-item__tile">
                      <a
                        href="about/institutes/spsg.xml"
                        class="slider-institute slider-institute-spsg">
                        <div class="slider-institute-figure">
                          <img
                            alt=""
                            class="slider-institute-logo"
                            src="{$WebApplicationBaseURL}images/logos/spsg-logo.png" />
                          <img
                            alt=""
                            class="img-fluid slider-institute-image"
                            src="{$WebApplicationBaseURL}images/institutes/spsg-figure.jpg" />
                        </div>
                        <div class="slider-institute-title">
                          <xsl:value-of select="i18n:translate('pp.page.home.institutions.spsg')" disable-output-escaping="yes" />
                        </div>
                      </a>
                    </div>

                    <div class="col-12 col-sm-6 col-lg-3 mb-3 mb-lg-0 carousel-item__tile">
                      <a
                        href="about/institutes/ieg.xml"
                        class="slider-institute slider-institute-ieg">
                        <div class="slider-institute-figure">
                          <img
                            alt=""
                            class="slider-institute-logo"
                            src="{$WebApplicationBaseURL}images/logos/ieg.jpg" />
                          <img
                            alt=""
                            class="img-fluid slider-institute-image"
                            src="{$WebApplicationBaseURL}images/institutes/ieg-figure.jpg" />
                        </div>
                        <div class="slider-institute-title">
                          <xsl:value-of select="i18n:translate('pp.page.home.institutions.ieg')" disable-output-escaping="yes" />
                        </div>
                      </a>
                    </div>

                  </div>
                </div>

                <div class="carousel-item">
                  <div class="row carousel-item__content-box">

                    <div class="col-12 col-sm-6 col-lg-3 mb-3 mb-lg-0 carousel-item__tile">
                      <a
                        href="about/institutes/dzk.xml"
                        class="slider-institute slider-institute-dzk">
                        <div class="slider-institute-figure">
                          <img
                            alt=""
                            class="slider-institute-logo"
                            src="{$WebApplicationBaseURL}images/logos/dzk-logo.jpg" />
                          <img
                            alt=""
                            class="img-fluid slider-institute-image"
                            src="{$WebApplicationBaseURL}images/institutes/dzk-figure.jpg" />
                        </div>
                        <div class="slider-institute-title">
                          <xsl:value-of select="i18n:translate('pp.page.home.institutions.dzk')" disable-output-escaping="yes" />
                        </div>
                      </a>
                    </div>

                  </div>
                </div>

              </div>
              <a class="carousel-control-prev" href="#carousel-institutes" role="button"
                data-slide="prev">
                <i class="fas fa-chevron-left"></i>
                <span class="sr-only">
                  <xsl:value-of select="i18n:translate('pp.page.home.slider.institutes.previous')" disable-output-escaping="yes" />
                </span>
              </a>
              <a class="carousel-control-next" href="#carousel-institutes" role="button"
                data-slide="next">
                <i class="fas fa-chevron-right"></i>
                <span class="sr-only">
                  <xsl:value-of select="i18n:translate('pp.page.home.slider.institutes.next')" disable-output-escaping="yes" />
                </span>
              </a>
            </div>
            <div class="text-center show-all-institutions-box">
              <a href="#" class="btn btn-primary js-show-all-institutions pp-rounded">
                <xsl:value-of select="i18n:translate('pp.page.home.slider.institutes.show')" disable-output-escaping="yes" />
                <i class="fas fa-chevron-right ml-2"></i>
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- publications -->
    <div class="page-section page-section__slider">
      <div class="container">
        <div class="row ">
          <div class="col-12" lang="de">
            <h2>
              <xsl:value-of select="i18n:translate('pp.page.home.publications')" disable-output-escaping="yes" />
            </h2>
            <div class="pp_carousel-slide" />
          </div>
        </div>
      </div>
    </div>

    <!-- scripts -->
    <script type="text/javascript" src="../../js/jquery.number.js"></script>
    <script>
      $( document ).ready(function() {
        $.ajax({
          type: "GET",
          url: "../../api/v1/search?q=objectType:mods AND state:published AND category.top:\"mir_genres:article\"&amp;rows=0&amp;wt=json&amp;json.wrf=?",
          dataType: "jsonp",
          success: function (data) {
            $('#p-statistic__articles__value').text($.number(data.response.numFound,0, ',', '.'));
          },
        });
        $.ajax({
          type: "GET",
          url: "../../api/v1/search?q=objectType:mods AND state:published AND category.top:\"mir_genres:research_data\"&amp;rows=0&amp;wt=json&amp;json.wrf=?",
          dataType: "jsonp",
          success: function (data) {
            $('#p-statistic__research__value').text($.number(data.response.numFound,0, ',', '.'));
          },
        });
        $.ajax({
          type: "GET",
          url: "../../api/v1/search?q=objectType:mods AND state:published AND category.top:\"mir_genres:review\"&amp;rows=0&amp;wt=json&amp;json.wrf=?",
          dataType: "jsonp",
          success: function (data) {
            $('#p-statistic__reviews__value').text($.number(data.response.numFound,0, ',', '.'));
          },
        });
      });
    </script>

  </xsl:template>

  <!-- prevent rendering page sections sections -->
  <xsl:template match="div[contains(@class, 'cms-intro')]"></xsl:template>
  <xsl:template match="div[contains(@class, 'cms-news')]"></xsl:template>
  <xsl:template match="div[contains(@class, 'cms-tiles')]"></xsl:template>

</xsl:stylesheet>