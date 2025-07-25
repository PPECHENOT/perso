<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method='html' version='1.0' encoding='UTF-8' indent='yes'/>

<xsl:variable name="DescriptionBR">0</xsl:variable>

<xsl:param name="FixGaps" /> <!--use ONLY if xml has been sorted WITH by-channel -->

<xsl:param name="DisplayLength" />

<xsl:param name="CurrentYear"/>
<xsl:param name="CurrentMonth"/>
<xsl:param name="CurrentDay"/>
<xsl:param name="CurrentHour"/>
<xsl:param name="CurrentMinute"/>
<xsl:param name="Heure"/>

<xsl:param name="StopYear"/>
<xsl:param name="StopMonth"/>
<xsl:param name="StopDay"/>
<xsl:param name="StopHour"/>

<xsl:param name="PrevYear"/>
<xsl:param name="PrevMonth"/>
<xsl:param name="PrevDay"/>
<xsl:param name="PrevHour"/>

<xsl:param name="PopupDelay"/>
<xsl:param name="DescriptionPopups"/>
<xsl:param name="ChannelPopups"/>
<xsl:param name="PopupTimes"/>
<xsl:param name="PopupRating"/>
<xsl:param name="PopupSubtitle"/>
<xsl:param name="PopupDescription"/>
<xsl:param name="PopupDate"/>
<xsl:param name="PopupCategories"/>
<xsl:param name="PopupStarRating"/>
<xsl:param name="Categories"/>
<xsl:param name="AbsoluteIcons"/>
<xsl:param name="Grabber"/>
<xsl:param name="DayFirst"/>
<xsl:param name="EarlierText"/>
<xsl:param name="LaterText"/>

<xsl:param name="OnClick"/>
<xsl:param name="ClickTarget" select="'_blank'"/>
<xsl:param name="HighlightClickable" />
<xsl:param name="HighlightMovies" />
<xsl:param name="HighlightNew"/>
<xsl:param name="PrintDates" />
<xsl:param name="TimeBarFrequency" />

<xsl:param name="MaxStars" select="4" /> <!-- PP nombre maxi d'étoiles si non renseigné -->

<xsl:template match="/">
<div class="xsldiv">
<xsl:variable name="ExtendLeftText">&lt;&lt;</xsl:variable>
<xsl:variable name="ExtendRightText">&gt;&gt;</xsl:variable>

<xsl:variable name="ppMinute" select="number($CurrentMinute)" />
<xsl:variable name="StartDisplayCode" select="number($CurrentHour)*60" /> <!-- These are for rendering the table -->
<xsl:variable name="StopDisplayCode" select="(number($CurrentHour)+number($DisplayLength))*60" />

<xsl:variable name="StartTimeString" select="concat($CurrentYear, format-number($CurrentMonth,'00'), format-number($CurrentDay,'00'), format-number($CurrentHour,'00'), '00')" /> <!-- These are for selecting the appropriate programmes -->
<xsl:variable name="StopTimeString" select="concat($StopYear, format-number($StopMonth,'00'), format-number($StopDay,'00'), format-number($StopHour,'00'), '00')" /> <!-- These are for selecting the appropriate programmes -->
<xsl:variable name="programmes" select="tv/programme[((substring(@stop,1,12) &gt; $StartTimeString and substring(@stop,1,12) &lt;= $StopTimeString) or (substring(@start,1,12) &gt;= $StartTimeString and substring(@start,1,12) &lt; $StopTimeString) or (substring(@start,1,12) &lt;= $StartTimeString and substring(@stop,1,12) &gt;= $StopTimeString))]"/>

<table id="listings">

<xsl:for-each select="/tv/channel">
<xsl:sort select="display-name[3]" data-type="number"></xsl:sort>

<xsl:choose>
	<xsl:when test="(position() mod $TimeBarFrequency = 1) or (position() = 1)">
    <tr class="timebar">
	<th class="topleftcorner">
		<xsl:attribute name="onclick">
			<xsl:value-of select="concat('Init','(',$DisplayLength,',',$PrevHour,',',$PrevDay,',',$PrevMonth,',',$PrevYear,')')" />
		</xsl:attribute>
		<xsl:value-of select="$EarlierText"/>
	</th>
		<xsl:call-template name="for.loop">
			<xsl:with-param name="i"><xsl:value-of select="$CurrentHour"/></xsl:with-param>
			<xsl:with-param name="count"><xsl:value-of select="$DisplayLength + $CurrentHour - 1"/></xsl:with-param>
			<xsl:with-param name="start"><xsl:value-of select="$CurrentHour"/></xsl:with-param>
		</xsl:call-template>
	<th class="toprightcorner">
		<xsl:attribute name="onclick">
			<xsl:value-of select="concat('Init','(',$DisplayLength,',',$StopHour,',',$StopDay,',',$StopMonth,',',$StopYear,')')" />
		</xsl:attribute>
		<xsl:value-of select="$LaterText"/>
	</th>
    </tr>
			</xsl:when>
		</xsl:choose>

<xsl:variable name="channelnumber">
	<xsl:choose>
		<xsl:when test="$Grabber = 'tv_grab_na_dd'">
			<xsl:value-of select="display-name[3]"/>
		</xsl:when>
		<xsl:when test="$Grabber = 'tv_grab_es'">
			<xsl:value-of select="display-name[2]"/>
		</xsl:when>
		<xsl:when test="$Grabber = 'tv_grab_fr'">
			<xsl:value-of select="substring-after(substring-before(./@id,'.'),'C')"/>
		</xsl:when>
		<xsl:when test="$Grabber = 'tv_grab_se' or $Grabber = 'tv_grab_de'"><xsl:text> </xsl:text></xsl:when>
		<xsl:when test="$Grabber = 'tv_grab_huro'">
			<xsl:value-of select="substring(./@id,1,3)"/>
		</xsl:when>
		<xsl:otherwise>
			??
		</xsl:otherwise>
	</xsl:choose>
</xsl:variable>

<xsl:variable name="channelshortname">
	<xsl:choose>
		<xsl:when test="$Grabber='tv_grab_na_dd'">
			<xsl:value-of select="normalize-space(substring-after(display-name[1],display-name[3]))"/>
		</xsl:when>
		<xsl:when test="$Grabber='tv_grab_es'">
			<xsl:value-of select="display-name[1]"/>
		</xsl:when>
		<xsl:when test="$Grabber='tv_grab_fr' or $Grabber='tv_grab_se' or $Grabber='tv_grab_de' or $Grabber = 'tv_grab_huro'">
			<xsl:value-of select="display-name"/>
		</xsl:when>
		<xsl:otherwise>
			??
		</xsl:otherwise>
	</xsl:choose>
</xsl:variable>

<xsl:variable name="channellongname">
	<xsl:choose>
		<xsl:when test="$Grabber='tv_grab_na_dd'">
			<xsl:value-of select="display-name[5]" />
		</xsl:when>
		<xsl:when test="$Grabber='tv_grab_es'">
			<xsl:value-of select="display-name[1]"/>
		</xsl:when>
		<xsl:when test="$Grabber='tv_grab_fr' or $Grabber='tv_grab_se' or $Grabber='tv_grab_de' or $Grabber = 'tv_grab_huro'">
			<xsl:value-of select="display-name" />
		</xsl:when>
		<xsl:otherwise>
			??
		</xsl:otherwise>
	</xsl:choose>
</xsl:variable>

			<xsl:variable name="iconname">
    				<xsl:call-template name="filename">
					<xsl:with-param name="x" select="icon/@src"/>
				</xsl:call-template>
			</xsl:variable>
	<tr>
		<xsl:choose>
			<xsl:when test="(position() mod 2 = 1)">
				<xsl:attribute name="class">
					oddrow
				</xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="class">
					evenrow
				</xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
		<th class="channel">
			<xsl:if test="$ChannelPopups">
				<xsl:attribute name="title">
					<xsl:text>header=[</xsl:text>
					<xsl:if test="string-length($iconname) &gt; 0">
						<xsl:text>&lt;img src="</xsl:text>
						<xsl:choose>
							<xsl:when test="$AbsoluteIcons">
								<xsl:value-of select="icon/@src"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat('icons/',$iconname)"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>" alt="" class="popupimage"/></xsl:text>
					</xsl:if>
					<xsl:value-of select="$channellongname" />
					<xsl:text>] body=[</xsl:text>
					<xsl:value-of select="display-name[7]"/>
					<xsl:text>] cssheader=[popupheader] cssbody=[popupbody] requireclick=[on] delay=[</xsl:text>
					<xsl:value-of select="$PopupDelay"/>
					<xsl:text>]</xsl:text>
				</xsl:attribute>
			</xsl:if>

		<table class="leftchanneltable">
    <tr><td class="leftlogocell">
      <xsl:if test="string-length($iconname) &gt; 0">
        <img>
          <xsl:attribute name="alt"><xsl:value-of select="$channellongname" /></xsl:attribute>
          <xsl:attribute name="src">
						<xsl:choose>
							<xsl:when test="$AbsoluteIcons">
								<xsl:value-of select="icon/@src"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat('icons/',$iconname)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
          <xsl:attribute name="class">channelimage</xsl:attribute>
        </img>
      </xsl:if>
          </td><td class="leftnumbercell"><xsl:value-of select="$channelnumber"/></td><td class="middlecell"><span class="leftnumber"><xsl:value-of select="$channelnumber"/></span><br class="leftchannelbr" /><span class="leftnbsp">&#160;</span><span class="channelname"><xsl:value-of select="$channelshortname"/></span><br class="rightchannelbr" /><span class="rightnbsp">&#160;</span><span class="rightnumber"><xsl:value-of select="$channelnumber"/></span></td><td class="rightnumbercell"><xsl:value-of select="$channelnumber"/></td><td class="rightlogocell"><xsl:if test="string-length($iconname) &gt; 0"><img><xsl:attribute name="src">
          		<xsl:choose>
							<xsl:when test="$AbsoluteIcons">
								<xsl:value-of select="icon/@src"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat('icons/',$iconname)"/>
							</xsl:otherwise>
						</xsl:choose>
          </xsl:attribute>
    <xsl:attribute name="class">channelimage</xsl:attribute></img></xsl:if></td></tr></table>
		</th>
		<xsl:variable name="theseprogrammes" select="$programmes[@channel=current()/@id]"/>
		<xsl:for-each select="$theseprogrammes">                                           <!--Program Stop Time is after Display Start   and Program Stop Time is before Display End......or...Program Start Time is after Display Start and Program Start Time is before Display End........or  Program Start Time is before Display Start and Program Stop Time is after Display End. -->
		<xsl:sort select="@start"/>
		<xsl:variable name="StartTime">
			<xsl:choose>
				<xsl:when test="number(substring($StartTimeString,1,8)) &lt; number(substring(@start,1,8))">  <!--it must be starting tomorrow ... Add the number of minutes in a day. -->
					<xsl:value-of select="(number((number(substring(@start,9,2))*60)+number(substring(@start,11,2)))) + 1440"/>
				</xsl:when>
				<xsl:when test="number(substring($StartTimeString,1,8)) &gt; number(substring(@start,1,8))">  <!--it have started yesterday ... Subtract the number of minutes in a day. -->
					<xsl:value-of select="(number((number(substring(@start,9,2))*60)+number(substring(@start,11,2)))) - 1440"/>
				</xsl:when>
				<xsl:otherwise> <!--otherwise it must be starting tomorrow ... Add the number of minutes in a day. -->
					<xsl:value-of select="number((number(substring(@start,9,2))*60)+number(substring(@start,11,2)))"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="NextStartTime">
			<xsl:choose>
				<xsl:when test="$FixGaps">
						<xsl:choose>
							<xsl:when test="number(substring($StartTimeString,1,8)) &lt; number(substring(following::programme[1]/@start,1,8))">
								<xsl:value-of select="(number((number(substring(following::programme[1]/@start,9,2))*60)+number(substring(following::programme[1]/@start,11,2)))) + 1440"/>
							</xsl:when>
							<xsl:when test="number(substring($StartTimeString,1,8)) &gt; number(substring(following::programme[1]/@start,1,8))">
								<xsl:value-of select="(number((number(substring(following::programme[1]/@start,9,2))*60)+number(substring(following::programme[1]/@start,11,2)))) - 1440"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="number((number(substring(following::programme[1]/@start,9,2))*60)+number(substring(following::programme[1]/@start,11,2)))"/>
							</xsl:otherwise>
						</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="Length">
			<xsl:choose>
				<xsl:when test="@stop">
					<xsl:choose>
						<xsl:when test="((number(substring(@stop,9,2))*60)+number(substring(@stop,11,2))) > ((number(substring(@start,9,2))*60)+number(substring(@start,11,2)))">
							<xsl:value-of select="(((number(substring(@stop,9,2))*60)+number(substring(@stop,11,2)))-((number(substring(@start,9,2))*60)+number(substring(@start,11,2))))"/>
						</xsl:when>
						<xsl:otherwise> <!--otherwise it must be concluding tomorrow, so the result will be negative. Add the number of minutes in a day. -->
							<xsl:value-of select="(((number(substring(@stop,9,2))*60)+number(substring(@stop,11,2)))-((number(substring(@start,9,2))*60)+number(substring(@start,11,2)))) + 1440"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$StopDisplayCode - $StartTime"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="StopTime" select="$StartTime+$Length"/>
<!--PP-->
    <xsl:variable name="Categ"> <!-- pour tester si Film et autoriser double clic TMDB -->
    <xsl:if test="not(episode-num) and credits/actor">
    <xsl:value-of select="substring(category,1,4)" />
    </xsl:if>
    </xsl:variable>
<!--
		<xsl:variable name="RatingRounded">
      <xsl:choose>
        <xsl:when test="string(number(star-rating))!='NaN'">
			     <xsl:choose>
				      <xsl:when test="contains(substring-before(star-rating,'/'),'.')">
					       <xsl:value-of select="number(substring-before(substring-before(star-rating,'/'),'.'))"/>
				      </xsl:when>
				      <xsl:otherwise>
					       <xsl:value-of select="number(substring-before(star-rating,'/'))"/>
 				      </xsl:otherwise>
			     </xsl:choose>
        </xsl:when>
 prise en compte de la note du grab de telecablesat
          <xsl:otherwise>
					   <xsl:value-of select="number(rating)"/> 
          </xsl:otherwise>
      </xsl:choose>
		</xsl:variable>
-->
<!--PP-->
		<xsl:variable name="RatingRounded">
					   <xsl:value-of select="number(star-rating)"/> 
		</xsl:variable>

		<xsl:if test="position()=1 and number($StartTime) &gt; number($StartDisplayCode)"><td class="empty" colspan="{number($StartTime)-number($StartDisplayCode)}"></td></xsl:if>
		<td>
			<xsl:attribute name="onclick">
				<xsl:text>$.featherlight($('#</xsl:text><xsl:value-of select="substring(@start, 1, string-length(@start) - 6)"/><xsl:value-of select = "translate(@channel,'abcedfghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,_:.°+','abcedfghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789')" /><xsl:text>'), {variant:'fixwidth'});</xsl:text>
			</xsl:attribute>
		<xsl:choose>
			<xsl:when test="number($StartTime) &gt;= number($StartDisplayCode) and $StopTime &lt;= $StopDisplayCode">
				<!-- Program starts during and concludes during display window. Putting first since most likely.-->
				<xsl:attribute name="colspan"><xsl:value-of select="$Length"/></xsl:attribute>
			</xsl:when>
			<xsl:when test="number($StartTime) &lt; number($StartDisplayCode) and $StopTime &lt;= $StopDisplayCode">
				<!-- Program starts before and concludes during display window-->
				<xsl:attribute name="colspan"><xsl:value-of select="(($Length - ($StartDisplayCode - $StartTime)))"/></xsl:attribute>
			</xsl:when>
			<xsl:when test="$StartTime &gt;= $StartDisplayCode and $StopTime &gt; $StopDisplayCode">
				<!-- Program starts during and concludes after display window -->
				<xsl:attribute name="colspan"><xsl:value-of select="(($Length - ($StopTime - $StopDisplayCode)))"/></xsl:attribute>
			</xsl:when>
			<xsl:when test="$StartTime &lt; $StartDisplayCode and $StopTime &gt; $StopDisplayCode">
				<!-- Program starts before and concludes after display window. Least likely. -->
				<xsl:attribute name="colspan"><xsl:value-of select="(($Length - ($StopTime - $StopDisplayCode) - ($StartDisplayCode - $StartTime)))"/></xsl:attribute>
			</xsl:when>
			</xsl:choose>
					<xsl:attribute name="class">
						<xsl:if test="$Categories">
							<xsl:value-of select="substring(episode-num[@system='dd_progid'],1,2)"/><xsl:text> </xsl:text>
							<xsl:for-each select="category">
								<xsl:value-of select="translate(.,' ','_')" /><xsl:text> </xsl:text>
							</xsl:for-each>
							<xsl:if test="$Grabber='tv_grab_de' and string(number(category))!='NaN'">
								MV
							</xsl:if>
							<xsl:if test="$Length &gt; 69">
								Longshow
							</xsl:if>
						</xsl:if>
						<xsl:if test="($Length &gt; 69) and (number($RatingRounded) &gt;= number($HighlightMovies))">
							Goodmovie
						</xsl:if> 
						<xsl:if test="$HighlightClickable and ($Categ='Ciné' or $Categ='Film' or $Categ='Acti' or $Categ='Musi' or $Categ='Horr' or $Categ='Guer' or $Categ='Espi' or $Categ='Anti' or $Categ='Poli' or $Categ='Anim' or $Categ='Cata' or $Categ='Hist' or $Categ='Aven' or $Categ='Scie' or $Categ='Fant' or $Categ='Pepl' or $Categ='Dram' or $Categ='Comé' or $Categ='Mélo' or $Categ='West' or $Categ='Thri' or $Categ='Biog' and $OnClick='IMDB' or ($OnClick='URL' and url))">
							Clickable
						</xsl:if>
						<xsl:if test="$HighlightNew and string-length(date) = 8">
							<xsl:if test="(substring(date,1,4)=$CurrentYear) and (substring(date,5,2)=$CurrentMonth) and (substring(date,7,2)=$CurrentDay)">
								Newshow
							</xsl:if>
						</xsl:if>
<!--Clickable-->
          </xsl:attribute>

		<table class="internal"><tr>
		<xsl:if test="number($StartTime) &lt; number($StartDisplayCode)">
			<td class="extendleft"><span><xsl:value-of select="$ExtendLeftText" /></span></td>
		</xsl:if>

<!-- FEATHERLIGHT !!!!!!!!!!!!!!!!!!!!!! -->		
    <div class="lightbox" id="{substring(@start, 1, string-length(@start) - 6)}{translate(@channel,'abcedfghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,_:.°+','abcedfghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789')}">
      <h2><xsl:value-of select="title" /></h2>
			<xsl:if test="$PopupTimes or ($PopupRating and rating) or ($PopupSubtitle and sub-title) or ($PopupDescription and desc or credits) or ($PopupDate and date) or ($PopupCategories and category) or ($PopupStarRating and $RatingRounded)">
  			<xsl:if test="$PopupTimes">
	     		<span class="popuptimes">
					<xsl:value-of select="number(substring(@start,9,2))"/>:<xsl:value-of select="substring(@start,11,2)"/> - <xsl:choose><xsl:when test="@stop"><xsl:value-of select="number(substring(@stop,9,2))"/>:<xsl:value-of select="substring(@stop,11,2)"/></xsl:when><xsl:otherwise>???</xsl:otherwise></xsl:choose>
					</span>
        </xsl:if>
<!--
				<xsl:if test="$PopupRating">
					<span class="popuprating"><xsl:value-of select="rating/value" /></span>
        </xsl:if>
-->
  			<xsl:if test="($PopupTimes or ($PopupRating and rating)) and (($PopupSubtitle and sub-title) or ($PopupDescription and desc or credits))">
	     		 <xsl:if test="$PopupCategories and category">
			       <xsl:if test="$PopupTimes or ($PopupRating and rating) or ($PopupSubtitle and sub-title) or ($PopupDescription and desc or credits) or ($PopupDate and date)">
              <b> | </b>
             </xsl:if>
<!--
				     <xsl:for-each select="category">
		 			      <xsl:if test="($Grabber='tv_grab_de' and string(number(.))='NaN') or $Grabber!='tv_grab_de'">
                  <xsl:value-of select="." /> 
	  				    </xsl:if>
					   </xsl:for-each>
-->
                <xsl:for-each select="category[position() &lt;= 6]">
                  <xsl:if test="position() = last()"><xsl:value-of select="."/></xsl:if>
		  						</xsl:for-each>
				   </xsl:if>
							<xsl:if test="credits">
                <xsl:if test="string(credits/director)">
  		    				<xsl:text> de </xsl:text>
	   							<xsl:value-of select="credits/director"/>
                </xsl:if>
          			<xsl:if test="$PrintDates">
                  <xsl:choose>
                    <xsl:when test="date">
			               (<xsl:value-of select="date"/>)
	                  </xsl:when>
	                  <xsl:otherwise>
                			<xsl:if test="string-length(review) = 4">    <!--PP je vais checher review rempli via MDB car date pas renseignée SUR UN FILM avec TéléCableSat-->
		  		            (<xsl:value-of select="review"/>)
			               </xsl:if>
	                  </xsl:otherwise>
                  </xsl:choose>
<!--
            			<xsl:if test="string-length(date) = 4">
				            (<xsl:value-of select="date"/>)
			            </xsl:if>
-->
			          </xsl:if>
							<xsl:if test="$PopupStarRating and $RatingRounded">
<!--
								<xsl:if test="$PopupTimes or ($PopupRating and rating) or ($PopupSubtitle and sub-title) or ($PopupDescription and desc) or ($PopupDate and date) or ($PopupCategories and category)">
                  <hr class="popuphr4"/>
                </xsl:if>
-->
<!--PP pour tenir compte de la note telecablesat
            		<xsl:variable name="Stars">
                  <xsl:choose>
                    <xsl:when test="string(number(star-rating))!='NaN'">
			                 <xsl:choose>
				                  <xsl:when test="contains(substring-before(star-rating,'/'),'.')">
					                     <xsl:value-of select="number(substring-before(substring-before(star-rating,'/'),'.'))"/>
				                  </xsl:when>
				                  <xsl:otherwise>
					                   <xsl:value-of select="number(substring-before(star-rating,'/'))"/>
 				                 </xsl:otherwise>
			                 </xsl:choose>
                    </xsl:when>
                      <xsl:otherwise>
					               <xsl:value-of select="number(rating)"/>
                      </xsl:otherwise>
                  </xsl:choose>
		            </xsl:variable>
PP-->
            		<xsl:variable name="Stars">
					               <xsl:value-of select="number(star-rating)"/>
		            </xsl:variable>
								<xsl:variable name="StarsHalf">
									<xsl:choose>
										<xsl:when test="contains(substring-before(star-rating,'/'),'.')">
											<xsl:choose>
												<xsl:when test="substring-after(substring-before(star-rating,'/'),'.') &lt; 5">
													<xsl:text>0</xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>1</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>0</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<xsl:variable name="StarsOutOf"><xsl:value-of select="number(substring-after(star-rating,'/'))"/></xsl:variable>
								<ul class="starlist">
	 							<xsl:call-template name="starrating-FANCYBOX">
									<xsl:with-param name="i">1</xsl:with-param>
									<xsl:with-param name="count"><xsl:value-of select="$Stars"/></xsl:with-param>
									<xsl:with-param name="type">filled</xsl:with-param>
								</xsl:call-template>
	 							<xsl:call-template name="starrating-FANCYBOX">
									<xsl:with-param name="i">1</xsl:with-param>
									<xsl:with-param name="count"><xsl:value-of select="$StarsHalf"/></xsl:with-param>
									<xsl:with-param name="type">half</xsl:with-param>
								</xsl:call-template>
	 							<xsl:call-template name="starrating-FANCYBOX">
									<xsl:with-param name="i">1</xsl:with-param>
									<xsl:with-param name="count"><xsl:value-of select="$StarsOutOf - $StarsHalf - $Stars"/></xsl:with-param>
									<xsl:with-param name="type">empty</xsl:with-param>
								</xsl:call-template>
								</ul>
							</xsl:if>
<!-- 5 premiers acteurs sur une ligne
  							<p>
                <xsl:for-each select="credits/actor[position() &lt;= 5]">
                  <xsl:if test="position() = 1 ">Avec </xsl:if>
	    						<xsl:value-of select="."/>
                  <xsl:if test="position() &lt; 5">, </xsl:if>
	  						</xsl:for-each>
                </p>
-->
							</xsl:if>
  						<hr class="popuphr1"/>
							<xsl:if test="$PopupSubtitle and sub-title">
								<span class="subtitle">
								<xsl:value-of select="sub-title"/>
                <xsl:if test="episode-num">(<xsl:value-of select="episode-num"/>)</xsl:if>
								</span>
							</xsl:if>
							<xsl:if test="$PopupDescription">
							  <span class="popupdesc">
<p>
                <xsl:element name="img">
                <xsl:attribute name="src"><xsl:value-of select="icon/@src"/></xsl:attribute>
                <xsl:attribute name="alt"></xsl:attribute>
                <xsl:attribute name="class">popupimage</xsl:attribute>
                </xsl:element>
</p><p>
							<xsl:if test="credits">
                <xsl:if test="string(credits/director)">
  		    				<xsl:text>Réalisation : </xsl:text>
	   							<xsl:value-of select="credits/director"/>
                </xsl:if>
          			<xsl:if test="$PrintDates">
                  <xsl:choose>
                    <xsl:when test="date">
			               (<xsl:value-of select="date"/>)
	                  </xsl:when>
	                  <xsl:otherwise>
                			<xsl:if test="string-length(review) = 4">    <!--PP je vais checher review rempli via MDB car date pas renseignée SUR UN FILM avec TéléCableSat-->
		  		            (<xsl:value-of select="review"/>)
			               </xsl:if>
	                  </xsl:otherwise>
                  </xsl:choose>
			          </xsl:if>
  							<p>
                <xsl:for-each select="credits/actor[position() &lt;= 6]">
	    						<xsl:value-of select="."/> <!--(<xsl:value-of select="@role"/>)-->
                  <xsl:if test="position() &lt; 9"><br></br></xsl:if>   <!-- last() -->
		  						</xsl:for-each>
                  </p>
							</xsl:if>
</p>
<div style="clear:both"></div>
                <p>
 								<xsl:choose>
									<xsl:when test="$DescriptionBR">
										<xsl:call-template name="lf2br"><xsl:with-param name="StringToTransform" select="substring(desc, 1, string-length(desc))"/></xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="desc"/>
                    <!--PP enlever le (n) pour telerama <xsl:value-of select="substring(desc, 1, string-length(desc) - 4)"/> -->
									</xsl:otherwise>
								</xsl:choose>
                </p>
								</span>
							</xsl:if>
			  </xsl:if>
      </xsl:if>
			<xsl:choose>
				<xsl:when test="$OnClick='IMDB' and ($Categ='Ciné' or $Categ='Film' or $Categ='Acti' or $Categ='Musi' or $Categ='Horr' or $Categ='Guer' or $Categ='Espi' or $Categ='Anti' or $Categ='Poli' or $Categ='Anim' or $Categ='Cata' or $Categ='Hist' or $Categ='Aven' or $Categ='Scie' or $Categ='Fant' or $Categ='Pepl' or $Categ='Dram' or $Categ='Comé' or $Categ='Mélo' or $Categ='West' or $Categ='Thri' or $Categ='Biog')">
          <xsl:element name="a">
					<xsl:attribute name="href">
              <xsl:text>http://www.themoviedb.org/search/movie?query=</xsl:text>
							<xsl:call-template name="replace">
								<xsl:with-param name="string">
								<xsl:call-template name="replace">
									<xsl:with-param name="string">
										<xsl:call-template name="replace">
											<xsl:with-param name="string">
												<xsl:call-template name="fixquotes">
												<xsl:with-param name="string" select="translate(title,' éèêàâôöîïù','+eeeaaooiiu')" />
												</xsl:call-template>
											</xsl:with-param>
											<xsl:with-param name="pattern" select="'&amp;'"/>
											<xsl:with-param name="replacement" select="'%26'"/>
										</xsl:call-template>
									</xsl:with-param>
									<xsl:with-param name="pattern" select="'='"/>
									<xsl:with-param name="replacement" select="'%3d'"/>
									</xsl:call-template>
								</xsl:with-param>
								<xsl:with-param name="pattern" select="'?'"/>
								<xsl:with-param name="replacement" select="'%3f'"/>
							</xsl:call-template>
						<xsl:text>&amp;language=fr</xsl:text>						
					</xsl:attribute>
          <xsl:attribute name="target">_blank</xsl:attribute>
          <span style="float:right" class="badge badge-link">TMDb</span>
          </xsl:element>
				</xsl:when>
				<xsl:when test="$OnClick='DuckDuckGo'">
          <xsl:element name="a">
					<xsl:attribute name="href">
						<xsl:text>https://duckduckgo.com/?kae=c&amp;kad=de_DE&amp;k1=-1&amp;kaj=m&amp;kv=l&amp;kp=-1&amp;q=</xsl:text>
							<xsl:call-template name="replace">
								<xsl:with-param name="string">
								<xsl:call-template name="replace">
									<xsl:with-param name="string">
										<xsl:call-template name="replace">
											<xsl:with-param name="string">
												<xsl:call-template name="fixquotes">
												<xsl:with-param name="string" select="translate(title,' ','+')" />
												</xsl:call-template>
											</xsl:with-param>
											<xsl:with-param name="pattern" select="'&amp;'"/>
											<xsl:with-param name="replacement" select="'%26'"/>
										</xsl:call-template>
									</xsl:with-param>
									<xsl:with-param name="pattern" select="'='"/>
									<xsl:with-param name="replacement" select="'%3d'"/>
									</xsl:call-template>
								</xsl:with-param>
								<xsl:with-param name="pattern" select="'?'"/>
								<xsl:with-param name="replacement" select="'%3f'"/>
							</xsl:call-template>
					</xsl:attribute>
          <xsl:attribute name="target">_blank</xsl:attribute>
          <p><span class="badge badge-link">DuckDuckGo</span></p>
          </xsl:element>
				</xsl:when>
				<xsl:when test="$OnClick='URL'">
					<xsl:if test="url">
          <xsl:element name="a">
						<xsl:attribute name="href">
							<xsl:value-of select="url"/>
						</xsl:attribute>
          <xsl:attribute name="target">_blank</xsl:attribute>
          URL
          </xsl:element>
					</xsl:if>
				</xsl:when>
			</xsl:choose>
    </div>
<!-- FIN FEATHERLIGHT !!!!!!!!!!!!!!!!!!!!!! -->		
    <td class="program">
<!--
			<xsl:if test="premiere or previously-shown">
-->
  		<xsl:if test="contains(@channel,'sport') or contains(@channel,'Sport') or contains(@channel,'SPORT') or contains(@channel,'quipe')">
			<xsl:if test="category and not(contains(title,category))">
        <xsl:for-each select="category">
          <xsl:if test="position() = last()">
			  <xsl:if test="($Grabber='tv_grab_de' and string(number(.))='NaN') or $Grabber!='tv_grab_de'">
            <xsl:value-of select="." /> 
<!--
    						<xsl:text>&lt;img src="</xsl:text>
								<xsl:value-of select="icon/@src"/>
		    				<xsl:text>" alt="" class="popupimage"/></xsl:text>
								&lt;/span&gt;
								&lt;br /&gt;
-->
	        </xsl:if>
	        </xsl:if>
        </xsl:for-each>
        :
      </xsl:if>
      </xsl:if>
<!--
<xsl:element name="a">
<xsl:attribute name="data-featherlight">#<xsl:value-of select="substring(@start, 1, string-length(@start) - 6)"/><xsl:value-of select = "translate(@channel,'abcedfghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,_:.°+','abcedfghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789')" /></xsl:attribute>
<xsl:attribute name="data-featherlight-variant">fixwidth</xsl:attribute>
<xsl:attribute name="href">#</xsl:attribute>
-->
			<xsl:value-of select="title" />
	<xsl:if test="$Categ='Ciné' or $Categ='Film' or $Categ='Acti' or $Categ='Musi' or $Categ='Horr' or $Categ='Guer' or $Categ='Espi' or $Categ='Anti' or $Categ='Poli' or $Categ='Anim' or $Categ='Cata' or $Categ='Hist' or $Categ='Aven' or $Categ='Scie' or $Categ='Fant' or $Categ='Pepl' or $Categ='Cine' or $Categ='Dram' or $Categ='Comé' or $Categ='Mélo' or $Categ='West' or $Categ='Thri' or $Categ='Biog'">
<!--c'est donc un film, j'affiche la catégorie !-->
      - 
                <xsl:for-each select="category[position() &lt;= 6]">
                  <xsl:if test="position() = last()"><xsl:value-of select="."/></xsl:if>
		  						</xsl:for-each>
          			<xsl:if test="$PrintDates">
                  <xsl:choose>
                    <xsl:when test="date">
			               (<xsl:value-of select="date"/>)
	                  </xsl:when>
	                  <xsl:otherwise>
                			<xsl:if test="string-length(review) = 4">
		  		            (<xsl:value-of select="review"/>)
			               </xsl:if>
	                  </xsl:otherwise>
                  </xsl:choose>
			          </xsl:if>
			</xsl:if>
			<xsl:if test="previously-shown and (contains(@channel,'sport') or contains(@channel,'Sport') or contains(@channel,'SPORT') or contains(@channel,'quipe') or contains(@channel,'Golf'))">
        <ul class="starlist">
        <span class="badge badge-warning">Rediffusion</span>
        </ul>
      </xsl:if>
<!--			<xsl:if test="premiere and (contains(@channel,'sport') or contains(@channel,'Sport') or contains(@channel,'SPORT') or contains(@channel,'quipe') or contains(@channel,'Golf'))"> -->
			<xsl:if test="premiere and (contains(title,'⚡') or contains(category,'Sport'))">
        <ul class="starlist">
        <span class="badge badge-danger">LIVE</span>
        </ul>
      </xsl:if>
<!-- j'affiche les etoiles dans les cases 
            		<xsl:variable name="Stars">
                  <xsl:choose>
                    <xsl:when test="string(number(star-rating))!='NaN'">
			                 <xsl:choose>
				                  <xsl:when test="contains(substring-before(star-rating,'/'),'.')">
					                     <xsl:value-of select="number(substring-before(substring-before(star-rating,'/'),'.'))"/>
				                  </xsl:when>
				                  <xsl:otherwise>
					                   <xsl:value-of select="number(substring-before(star-rating,'/'))"/>
 				                 </xsl:otherwise>
			                 </xsl:choose>
                    </xsl:when>
                      <xsl:otherwise>
					               <xsl:value-of select="number(rating)"/>
                      </xsl:otherwise>
                  </xsl:choose>
		            </xsl:variable>
PP-->
            		<xsl:variable name="Stars">
					               <xsl:value-of select="number(star-rating)"/>
		            </xsl:variable>
								<xsl:variable name="StarsHalf">
									<xsl:choose>
										<xsl:when test="contains(substring-before(star-rating,'/'),'.')">
											<xsl:choose>
												<xsl:when test="substring-after(substring-before(star-rating,'/'),'.') &lt; 5">
													<xsl:text>0</xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>1</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>0</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<xsl:variable name="StarsOutOf"><xsl:value-of select="number(substring-after(star-rating,'/'))"/></xsl:variable>
								<ul class="starlist">
	 							<xsl:call-template name="starrating-FANCYBOX">
									<xsl:with-param name="i">1</xsl:with-param>
									<xsl:with-param name="count"><xsl:value-of select="$Stars"/></xsl:with-param>
									<xsl:with-param name="type">filled</xsl:with-param>
								</xsl:call-template>
	 							<xsl:call-template name="starrating-FANCYBOX">
									<xsl:with-param name="i">1</xsl:with-param>
									<xsl:with-param name="count"><xsl:value-of select="$StarsHalf"/></xsl:with-param>
									<xsl:with-param name="type">half</xsl:with-param>
								</xsl:call-template>
	 							<xsl:call-template name="starrating-FANCYBOX">
									<xsl:with-param name="i">1</xsl:with-param>
									<xsl:with-param name="count"><xsl:value-of select="$StarsOutOf - $StarsHalf - $Stars"/></xsl:with-param>
									<xsl:with-param name="type">empty</xsl:with-param>
								</xsl:call-template>
								</ul>
<!--
</xsl:element>
-->
		</td>
<!--
</xsl:element>
-->
		<xsl:if test="number($StopTime) &gt; number($StopDisplayCode)">
			<td class="extendright"><span><xsl:value-of select="$ExtendRightText" /></span></td>
		</xsl:if>
		</tr>
    </table>

		</td>
		<xsl:if test="$FixGaps = 1 and position()!=last() and number($StopTime) &lt; number($NextStartTime)"><td class="empty" colspan="{number($NextStartTime)-number($StopTime)}"></td></xsl:if>
		<xsl:if test="position()=last() and number($StopTime) &lt; number($StopDisplayCode)"><td class="empty" colspan="{number($StopDisplayCode)-number($StopTime)}"></td></xsl:if>
		</xsl:for-each>
		<!--check for a row with no programs and fill it in with an empty row-->
		<xsl:if test="not($theseprogrammes)"><td class="empty" colspan="{number($StopDisplayCode)-number($StartDisplayCode)}"></td></xsl:if>
		<th class="channel">
			<xsl:if test="$ChannelPopups">
				<xsl:attribute name="title">
					<xsl:text>header=[</xsl:text>
					<xsl:if test="string-length($iconname) &gt; 0">
						<xsl:text>&lt;img src="</xsl:text>
												<xsl:choose>
							<xsl:when test="$AbsoluteIcons">
								<xsl:value-of select="icon/@src"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat('icons/',$iconname)"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>" alt="" class="popupimage"/></xsl:text>
					</xsl:if>
					<xsl:value-of select="$channellongname" />
					<xsl:text>] body=[</xsl:text>
					<xsl:value-of select="display-name[7]"/>
					<xsl:text>] cssheader=[popupheader] cssbody=[popupbody] requireclick=[on] delay=[</xsl:text>
					<xsl:value-of select="$PopupDelay"/>
					<xsl:text>]</xsl:text>
				</xsl:attribute>
			</xsl:if>
		<table class="rightchanneltable"><tr><td class="leftlogocell"><xsl:if test="string-length($iconname) &gt; 0"><img><xsl:attribute name="src">						<xsl:choose>
							<xsl:when test="$AbsoluteIcons">
								<xsl:value-of select="icon/@src"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat('icons/',$iconname)"/>
							</xsl:otherwise>
						</xsl:choose>
</xsl:attribute><xsl:attribute name="class">channelimage</xsl:attribute></img></xsl:if></td><td class="leftnumbercell"><xsl:value-of select="$channelnumber"/></td><td class="middlecell"><span class="leftnumber"><xsl:value-of select="$channelnumber"/></span><br class="leftchannelbr" /><span class="leftnbsp">&#160;</span><span class="channelname"><xsl:value-of select="$channelshortname"/></span><br class="rightchannelbr" /><span class="rightnbsp">&#160;</span><span class="rightnumber"><xsl:value-of select="$channelnumber"/></span></td><td class="rightnumbercell"><xsl:value-of select="$channelnumber"/></td><td class="rightlogocell"><xsl:if test="string-length($iconname) &gt; 0"><img><xsl:attribute name="src">						<xsl:choose>
							<xsl:when test="$AbsoluteIcons">
								<xsl:value-of select="icon/@src"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat('icons/',$iconname)"/>
							</xsl:otherwise>
						</xsl:choose>
</xsl:attribute><xsl:attribute name="class">channelimage</xsl:attribute></img></xsl:if></td></tr></table>
		</th></tr>
    </xsl:for-each>
</table>
</div>
</xsl:template>

<xsl:template name="for.loop">
<!--
This template from http://www.bigbold.com/snippets/tag/hello
-->
	<xsl:param name="i" />
	<xsl:param name="count" />
	<xsl:param name="start" />
   <!--begin_: Line_by_Line_Output -->
   <xsl:if test="$i &lt;= $count">
	<xsl:choose>
		<xsl:when test="$i &gt; 23">
			<th colspan="30" class="time">
			<xsl:if test="($i - $start)">
				<xsl:attribute name="onclick">
					<xsl:value-of select="concat('Init','(',$DisplayLength,',',$CurrentHour,',',$CurrentDay,',',$CurrentMonth,',',$CurrentYear,',',($i - $start),')')" />
				</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="$i - 24" />:00</th>
			<th colspan="30" class="time">
			<xsl:if test="($i - $start)">
				<xsl:attribute name="onclick">
					<xsl:value-of select="concat('Init','(',$DisplayLength,',',$CurrentHour,',',$CurrentDay,',',$CurrentMonth,',',$CurrentYear,',',($i - $start),')')" />
				</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="$i - 24" />:30</th>
		</xsl:when>
		<xsl:otherwise>
			<th colspan="30" class="time">
			<xsl:if test="($i - $start)">
				<xsl:attribute name="onclick">
					<xsl:value-of select="concat('Init','(',$DisplayLength,',',$CurrentHour,',',$CurrentDay,',',$CurrentMonth,',',$CurrentYear,',',($i - $start),')')" />
				</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="$i" />:00</th>
			<th colspan="30" class="time">
			<xsl:if test="($i - $start)">
				<xsl:attribute name="onclick">
					<xsl:value-of select="concat('Init','(',$DisplayLength,',',$CurrentHour,',',$CurrentDay,',',$CurrentMonth,',',$CurrentYear,',',($i - $start),')')" />
				</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="$i" />:30</th>
		</xsl:otherwise>
	</xsl:choose>
   </xsl:if>

	<!--begin_: RepeatTheLoopUntilFinished-->
	<xsl:if test="$i &lt;= $count">
		<xsl:call-template name="for.loop">
			<xsl:with-param name="i">
				<xsl:value-of select="$i + 1"/>
			</xsl:with-param>
			<xsl:with-param name="count">
				<xsl:value-of select="$count"/>
			</xsl:with-param>
			<xsl:with-param name="start">
				<xsl:value-of select="$start"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>

</xsl:template>

<xsl:template name="starrating">

   <xsl:param name="i"/>
   <xsl:param name="count"/>
   <xsl:param name="type"/>

   <!--begin_: Line_by_Line_Output -->
   <xsl:if test="$i &lt;= $count">
	<xsl:choose>
		<xsl:when test="$type='filled'">
			&lt;li class="starfilled"&gt;&lt;span&gt;X&lt;/span&gt;&lt;/li&gt;
		</xsl:when>
		<xsl:when test="$type='half'">
			&lt;li class="starhalf"&gt;&lt;span&gt;x&lt;/span&gt;&lt;/li&gt;
		</xsl:when>
		<xsl:when test="$type='empty'">
			&lt;li class="starempty"&gt;&lt;span&gt;-&lt;/span&gt;&lt;/li&gt;
		</xsl:when>
	</xsl:choose>
   </xsl:if>

   <!--begin_: RepeatTheLoopUntilFinished-->
   <xsl:if test="$i &lt;= $count">
      <xsl:call-template name="starrating">
          <xsl:with-param name="i">
              <xsl:value-of select="$i + 1"/>
          </xsl:with-param>
          <xsl:with-param name="count">
              <xsl:value-of select="$count"/>
          </xsl:with-param>
          <xsl:with-param name="type">
              <xsl:value-of select="$type"/>
          </xsl:with-param>
      </xsl:call-template>
   </xsl:if>

</xsl:template>

<xsl:template name="starrating-FANCYBOX">

   <xsl:param name="i"/>
   <xsl:param name="count"/>
   <xsl:param name="type"/>

   <!--begin_: Line_by_Line_Output -->
   <xsl:if test="$i &lt;= $count">
	<xsl:choose>
		<xsl:when test="$type='filled'">
			<li class="starfilled"><span>X</span></li>
		</xsl:when>
		<xsl:when test="$type='half'">
			<li class="starhalf"><span>x</span></li>
		</xsl:when>
		<xsl:when test="$type='empty'">
			<li class="starempty"><span>-</span></li>
		</xsl:when>
	</xsl:choose>
   </xsl:if>

   <!--begin_: RepeatTheLoopUntilFinished-->
   <xsl:if test="$i &lt;= $count">
      <xsl:call-template name="starrating-FANCYBOX">
          <xsl:with-param name="i">
              <xsl:value-of select="$i + 1"/>
          </xsl:with-param>
          <xsl:with-param name="count">
              <xsl:value-of select="$count"/>
          </xsl:with-param>
          <xsl:with-param name="type">
              <xsl:value-of select="$type"/>
          </xsl:with-param>
      </xsl:call-template>
   </xsl:if>

</xsl:template>

<xsl:template name="filename">
<!--
This template from http://www.maya.com/local/doc/xslt/FAQ/html_format/xsl/sect2/N7240.html
-->
<xsl:param name="x"/>
<xsl:choose>
<xsl:when test="contains($x,'/')">
  <xsl:call-template name="filename">
    <xsl:with-param name="x" select="substring-after($x,'/')"/>
  </xsl:call-template>
</xsl:when>
<xsl:otherwise>
  <xsl:value-of select="$x"/>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template name="replace"> 
 <!--
This template by Greg Faron on http://www.biglist.com/lists/xsl-list/archives/200211/msg00335.html
-->
<xsl:param name="string" select="''"/>
<xsl:param name="pattern" select="''"/>
<xsl:param name="replacement" select="''"/>
<xsl:choose>
<xsl:when test="$pattern != '' and $string != '' and contains($string, $pattern)">
<xsl:value-of select="substring-before($string, $pattern)"/>
<xsl:copy-of select="$replacement"/>
<xsl:call-template name="replace">
<xsl:with-param name="string" select="substring-after($string, $pattern)"/>
<xsl:with-param name="pattern" select="$pattern"/>
<xsl:with-param name="replacement" select="$replacement"/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="$string"/>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template name="fixquotes">
   <xsl:param name="string"/>
    <xsl:choose>
      <xsl:when test="contains($string, &quot;'&quot;)">
        <xsl:value-of select="substring-before($string, &quot;'&quot;)"/>
        <xsl:text>\'</xsl:text>
        <xsl:call-template name="fixquotes">
          <xsl:with-param name="string"
            select="substring-after($string, &quot;'&quot;)"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$string"/>
      </xsl:otherwise>
    </xsl:choose>
</xsl:template>

	<xsl:template name="lf2br">
		<xsl:param name="StringToTransform"/>
		<xsl:choose>
			<xsl:when test="contains($StringToTransform,'&#xA;')">
				<xsl:value-of select="substring-before($StringToTransform,'&#xA;')"/>&lt;br /&gt;
				<xsl:call-template name="lf2br">
					<xsl:with-param name="StringToTransform">
						<xsl:value-of select="substring-after($StringToTransform,'&#xA;')"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="contains($StringToTransform,'&#xD;')">
				<xsl:value-of select="substring-before($StringToTransform,'&#xD;')"/>&lt;br /&gt;
				<xsl:call-template name="lf2br">
					<xsl:with-param name="StringToTransform">
						<xsl:value-of select="substring-after($StringToTransform,'&#xD;')"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<!-- string does not contain newline, so just output it -->
			<xsl:otherwise>
				<xsl:value-of select="$StringToTransform"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
