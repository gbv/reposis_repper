<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:mcr="xalan://org.mycore.common.xml.MCRXMLFunctions"
                xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation"
                xmlns:mods="http://www.loc.gov/mods/v3"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:acl="xalan://org.mycore.access.MCRAccessManager"
                xmlns:embargo="xalan://org.mycore.mods.MCRMODSEmbargoUtils"
                xmlns:piUtil="xalan://org.mycore.pi.frontend.MCRIdentifierXSLUtils"
                exclude-result-prefixes="i18n mcr mods acl xlink embargo"
>
  <xsl:import href="xslImport:modsmeta:metadata/mir-collapse-files.xsl" />
  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="key('rights', mycoreobject/@ID)/@read or key('rights', mycoreobject/structure/derobjects/derobject/@xlink:href)/@accKeyEnabled">

        <!-- START - perspectivia: show only logged in users -->
        <xsl:if test="not(mcr:isCurrentUserGuestUser())">

        <xsl:variable name="objID" select="mycoreobject/@ID" />

        <div id="mir-collapse-files">
          <xsl:for-each select="mycoreobject/structure/derobjects/derobject[key('rights', @xlink:href)/@read]">
            <xsl:variable name="derId" select="@xlink:href" />

            <div id="files{$derId}" class="file_box">
              <div class="row header">
                <div class="col-12">
                  <div class="headline">
                    <div class="title">
                      <a class="btn btn-primary btn-sm file_toggle dropdown-toggle" data-toggle="collapse" href="#collapse{$derId}" aria-expanded="false" aria-controls="collapse{$derId}">
                        <span>
                          <xsl:choose>
                            <xsl:when test="titles/title[@xml:lang=$CurrentLang]">
                              <xsl:value-of select="titles/title[@xml:lang=$CurrentLang]" />
                            </xsl:when>
                            <xsl:when test="classification[@classid='derivate_types']">
                              <xsl:value-of select="i18n:translate(concat('metadata.files.file.', classification[@classid='derivate_types']/@categid))" />
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:value-of select="i18n:translate('metadata.files.file')" />
                            </xsl:otherwise>
                          </xsl:choose>
                        </span>
                        <!-- xsl:if test="position() > 1">
                          <span class="set_number">
                            <xsl:value-of select="position()" />
                          </span>
                        </xsl:if -->
                      </a>

                    </div>
                    <xsl:apply-templates select="." mode="derivateActions">
                      <xsl:with-param name="deriv" select="$derId" />
                      <xsl:with-param name="parentObjID" select="$objID" />
                    </xsl:apply-templates>
                    <div class="clearfix" />
                  </div>
                </div>
              </div>

              <xsl:choose>
                <xsl:when test="key('rights', $derId)/@read">
                  <xsl:variable name="maindoc" select="maindoc" />
                  <div class="file_box_files" data-objID="{$objID}" data-deriID="{$derId}" data-mainDoc="{$maindoc}" data-writedb="{acl:checkPermission($derId,'writedb')}"
                    data-deletedb="{acl:checkPermission($derId,'deletedb')}">
                    <xsl:if test="not(mcr:isCurrentUserGuestUser())">
                      <xsl:attribute name="data-jwt">
                        <xsl:value-of select="'required'" />
                      </xsl:attribute>
                    </xsl:if>
                    <div class="filelist-loading">
                      <div class="bounce1"></div>
                      <div class="bounce2"></div>
                      <div class="bounce3"></div>
                    </div>
                  </div>
                  <noscript>
                    <br />
                  <a href="{$ServletsBaseURL}MCRFileNodeServlet/{$derId}/">
                      <xsl:value-of select="i18n:translate('metadata.files.toDerivate')" />
                    </a>
                  </noscript>
                </xsl:when>
                <xsl:otherwise>
                  <div id="collapse{$derId}" class="row body collapse in show">
                    <div class="col-12">
                      <xsl:value-of select="i18n:translate('mir.derivate.no_access')" />
                    </div>
                  </div>
                </xsl:otherwise>
              </xsl:choose>

            </div>
          </xsl:for-each>


          <xsl:if
            test="mycoreobject/structure/derobjects/derobject and
                        not(mycoreobject/structure/derobjects/derobject[key('rights', @xlink:href)/@read])"
          >
            <div id="mir-access-restricted">
              <h3>
                <xsl:value-of select="i18n:translate('metadata.files.file')" />
              </h3>
              <div class="alert alert-warning" role="alert">
                <xsl:variable name="embargoDate" select="embargo:getEmbargo(mycoreobject/@ID)" />
                <xsl:choose>
                  <xsl:when test="not(mcr:isDisplayedEnabledDerivate(mycoreobject/structure/derobjects/derobject/@xlink:href))">
                    <xsl:value-of select="i18n:translate('mir.derivate.no_access')" />
                  </xsl:when>
                  <xsl:when test="string-length($embargoDate)&gt;0">
                    <!-- embargo is active for guest user -->
                    <xsl:value-of select="i18n:translate('component.mods.metaData.dictionary.accessCondition.embargo.available',$embargoDate)" />
                  </xsl:when>
                  <xsl:otherwise>
                    <strong>
                      <xsl:value-of select="i18n:translate('mir.access')" />
                    </strong>
                    &#160;
                    <xsl:apply-templates select="mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:accessCondition[@type='restriction on access']"
                      mode="printModsClassInfo" />
                  </xsl:otherwise>
                </xsl:choose>
              </div>
            </div>
          </xsl:if>
        </div>
          
        </xsl:if>

        <!-- START: Add download button for perspectivia -->
        <xsl:for-each select="mycoreobject/structure/derobjects/derobject[key('rights', @xlink:href)/@read]">
          <xsl:if test="not(contains(classification[@classid='derivate_types']/@categid,'thumbnail')) and
                        not(contains(classification[@classid='derivate_types']/@categid,'toc')) and
                        not(contains(classification[@classid='derivate_types']/@categid,'presentation')) and
                        not(contains(classification[@classid='derivate_types']/@categid,'additional_av')) and
                        not(contains(classification[@classid='derivate_types']/@categid,'navigation'))">
            <div id="repper-download-box">
              <a href="{$WebApplicationBaseURL}servlets/MCRFileNodeServlet/{@xlink:href}/{maindoc}" class="btn btn-secondary" style="background-color: #75adad;border-color: #75adad;margin-bottom: 10px;width: 100%;">
                <i style="margin-right: 5px;" class="fas fa-download"></i>Download</a>
            </div>
          </xsl:if>
        </xsl:for-each>
        <!-- END -->
        
        <!-- START: Add cover box for perspectivia -->
        <xsl:if test="mycoreobject/structure/derobjects/derobject/classification[@classid='derivate_types'][@categid='thumbnail'] and
                      (mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:location/mods:url[@access='object in context'] or
                      mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:location/mods:url[@access='raw object'])">
          <xsl:variable name="derId" select="mycoreobject/structure/derobjects/derobject[classification[@classid='derivate_types'][@categid='thumbnail']]/@xlink:href" />
          <xsl:variable name="maindoc" select="mycoreobject/structure/derobjects/derobject[classification[@classid='derivate_types'][@categid='thumbnail']]/maindoc" />
          <xsl:variable name="fulltext_or_print">
            <xsl:choose>
              <xsl:when test="mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:location/mods:url[@access='object in context'] and
                              mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:location/mods:url[@access='raw object']">
                <xsl:value-of select="'both'"/>
              </xsl:when>
              <xsl:when test="mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:location/mods:url[@access='object in context']">
                <xsl:value-of select="'print'"/>
              </xsl:when>
              <xsl:when test="mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:location/mods:url[@access='raw object']">
                <xsl:value-of select="'fulltext'"/>
              </xsl:when>
            </xsl:choose>
          </xsl:variable>
          <div id="repper-cover-box">
            <div id="pp_coverCard" class="card">
              <div class="card-header">
                <h3 class="card-title"><xsl:value-of select="i18n:translate(concat('pp.coverPanel.title.', $fulltext_or_print))" /></h3>
              </div>
              <div class="card-body">
                <p>
                  <xsl:choose>
                    <xsl:when test="mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:location/mods:url[@access='object in context'] and
                      mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:location/mods:url[@access='raw object']">
                      <a href="{mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:location/mods:url[@access='raw object']}">
                        <img src="{$WebApplicationBaseURL}servlets/MCRTileCombineServlet/THUMBNAIL/{$derId}/{$maindoc}" />
                        <br />
                        <i class="fas fa-file-import" aria-hidden="true"></i>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="i18n:translate('pp.coverPanel.text.fulltext')" />
                      </a>
                      <br />
                      <a href="{mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:location/mods:url[@access='object in context']}">
                        <i class="fas fa-shopping-cart" aria-hidden="true"></i>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="i18n:translate('pp.coverPanel.text.print')" />
                      </a>
                    </xsl:when>
                    <xsl:when test="mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:location/mods:url[@access='object in context']">
                      <a href="{mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:location/mods:url[@access='object in context']}">
                        <img src="{$WebApplicationBaseURL}servlets/MCRTileCombineServlet/THUMBNAIL/{$derId}/{$maindoc}" />
                        <br />
                        <i class="fas fa-shopping-cart" aria-hidden="true"></i>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="i18n:translate('pp.coverPanel.text.print')" />
                      </a>
                    </xsl:when>
                    <xsl:when test="mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:location/mods:url[@access='raw object']">
                      <a href="{mycoreobject/metadata/def.modsContainer/modsContainer/mods:mods/mods:location/mods:url[@access='raw object']}">
                        <img src="{$WebApplicationBaseURL}servlets/MCRTileCombineServlet/THUMBNAIL/{$derId}/{$maindoc}" />
                        <br />
                        <i class="fas fa-file-import" aria-hidden="true"></i>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="i18n:translate('pp.coverPanel.text.fulltext')" />
                      </a>
                    </xsl:when>
                  </xsl:choose>
                </p>
              </div>
            </div>
          </div>
        </xsl:if>
        <!-- END -->

      </xsl:when>
      <xsl:otherwise>
        <xsl:comment>
          <xsl:value-of select="'mir-collapse-files: no &quot;view&quot; permission'" />
        </xsl:comment>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:apply-imports />
  </xsl:template>
</xsl:stylesheet>
