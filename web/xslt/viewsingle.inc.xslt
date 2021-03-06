<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- SKIP -->
<xsl:template match="agentSet/display | id | location[@type='repository'] | position | relationSet | subjectSet | textref | titleSet"/>

<!-- Replaced these templates on 2009-10-27 with the one below 
<xsl:template match="text[@type='resolvedText' and (following-sibling::text or preceding-sibling::text)]"/>
<xsl:template match="text[@type='resolvedCaption' and (following-sibling::text or preceding-sibling::text)]"/>
<xsl:template match="text[@type='Caption' and (following-sibling::text or preceding-sibling::text)]"/>
<xsl:template match="text[@type='text' and (following-sibling::text or preceding-sibling::text)]"/>
-->

<xsl:template
 match="text[(
   @type='resolvedText' or
   @type='resolvedCaption' or
   @type='caption' or 
   @type='text' 
  ) and ( 
   following-sibling::text[@type='resolvedText'] or
   following-sibling::text[@type='resolvedCaption'] or
   following-sibling::text[@type='Caption'] or
   following-sibling::text[@type='text'] or
   following-sibling::text[@type='displayCaption'] or
   following-sibling::text[@type='displayInscription'] or
   following-sibling::text[@type='displayLabel'] or
   following-sibling::text[@type='displayText'] or
   preceding-sibling::text[@type='resolvedText'] or
   preceding-sibling::text[@type='resolvedCaption'] or
   preceding-sibling::text[@type='Caption'] or
   preceding-sibling::text[@type='text'] or
   preceding-sibling::text[@type='displayCaption'] or
   preceding-sibling::text[@type='displayInscription'] or
   preceding-sibling::text[@type='displayLabel'] or
   preceding-sibling::text[@type='displayText']
  )]"/>

<!-- * -->
<xsl:template match="*">
<xsl:apply-templates/>
</xsl:template>

<!-- AGENT -->
<xsl:template match="agent[1]">
  <tr>
    <th><strong><xsl:value-of select="role"/>:</strong></th>
    <td>
      <xsl:value-of select="name"/><xsl:apply-templates select="following-sibling::agent" mode="next"/>
    </td>
  </tr>
</xsl:template>

<xsl:template match="agent[position() &gt; 1]"/>

<xsl:template match="agent" mode="next">
  <br/><xsl:value-of select="name"/>
</xsl:template>

<!-- AGENTSET -->
<xsl:template match="agentSet">
<xsl:apply-templates select="agent[role/text()='Engraver (printmaker)']"/>
<xsl:apply-templates select="agent[role/text()='Etcher (printmaker)']"/>
<xsl:apply-templates select="agent[role/text()='Architect']"/>
<xsl:apply-templates select="agent[role/text()='Artist']"/>
<xsl:apply-templates select="agent[role/text()='Designer']"/>
<xsl:apply-templates select="agent[role/text()='Painter (artist)']"/>
<xsl:apply-templates select="agent[role/text()='Sculptor (artist)']"/>
<xsl:apply-templates select="agent[role/text()='Publisher']"/>
</xsl:template>

<!-- BR -->
<xsl:template match="br">
   <br/>
</xsl:template>

<!-- COLLECTION -->
<xsl:template match="collection">
<xsl:copy-of select="$header"/>
<xsl:apply-templates/>
</xsl:template>

<!-- DATESET -->
<xsl:template match="dateSet">
<tr><th>Publication Date:</th><td><xsl:value-of select="display"/></td></tr>
</xsl:template>

<!-- DESCRIPTIONSET -->
<xsl:template match="descriptionSet">
<tr><th>Description:</th><td><xsl:apply-templates select="description"/></td></tr>
</xsl:template>

<xsl:template match="descriptionSet/description">
<xsl:apply-templates/><br/>
</xsl:template>

<xsl:template match="description"/>

<!-- HUREF -->
<xsl:template match="huref">
<tr><th>Huelsen Number:</th><td><xsl:apply-templates/></td></tr>
</xsl:template>

<!-- I -->
<xsl:template match="i">
  <i><xsl:apply-templates/></i>
</xsl:template>

<!-- INSCRIPTION -->
<xsl:template match="inscription">
  <xsl:apply-templates/>
</xsl:template>

<!-- LOCATION -->
<xsl:template match="location">
<tr><th>Location (<xsl:value-of select='@type'/>):</th><td><xsl:apply-templates/></td></tr>
</xsl:template>

<!-- MEASUREMENTS -->
<xsl:template match="measurementsSet">
<tr><th>Measurements:</th><td><xsl:value-of select="display"/></td></tr>
</xsl:template>

<!-- NAME -->
<xsl:template match="name">
<xsl:apply-templates/>
</xsl:template>

<!-- NOTES -->
<xsl:template match="notes">
<tr><th>Description:</th><td><xsl:apply-templates/></td></tr>
</xsl:template>

<!-- REFERENCES -->
<xsl:template match="ref[1]">
<tr><th>References:</th><td><xsl:apply-templates/><xsl:apply-templates select="following-sibling::ref" mode="next"/></td></tr>
</xsl:template>

<xsl:template match="ref"/>

<xsl:template match="ref" mode="next">
<br/><xsl:apply-templates/>
</xsl:template>

<!-- REFID -->
<xsl:template match="refid[@type]">
(<xsl:value-of select="@type"/># <xsl:apply-templates/>)
</xsl:template>

<xsl:template match="refid[not(@type)]">
, <xsl:apply-templates/>)
</xsl:template>

<!-- RELATION -->
<xsl:template match="relation[@type='larger context for']">
<a href="/{@relids}"><xsl:apply-templates/></a>
<xsl:if test="following-sibling::relation">
<xsl:text>, </xsl:text>
</xsl:if>
</xsl:template>

<xsl:template match="relation[@type='part of']">
<a href="/search.php?detail={@relids}"><xsl:apply-templates/></a>
<xsl:if test="following-sibling::relation">
<xsl:text>, </xsl:text>
</xsl:if>
</xsl:template>

<!-- RELATIONSET -->
<xsl:template match="relationSet[relation/@type='part of']">
<tr><th>Groups:</th><td>This work is part of the following groups: <xsl:apply-templates/></td></tr>
</xsl:template>

<xsl:template match="relationSet[relation/@type='larger context for']">
<tr><th>Works:</th><td>This group includes the following works: <xsl:apply-templates/></td></tr>
</xsl:template>

<!-- TECHNIQUE -->
<xsl:template match="technique">
<xsl:apply-templates/><xsl:if test="position() &lt; last()">, </xsl:if>
</xsl:template>

<!-- TECHNIQUESET -->
<xsl:template match="techniqueSet">
<tr><th>Techniques:</th>
<td>
<xsl:choose>
<xsl:when test="display"><xsl:apply-templates select="display"/></xsl:when>
<xsl:otherwise><xsl:apply-templates select="technique"/></xsl:otherwise>
</xsl:choose>
</td>
</tr>
</xsl:template>

<!-- TEXT -->
<!-- if a series of text nodes has a 'DisplayText', just print that one.  -->
<xsl:template match="text">
<tr><th>
<xsl:call-template name="capitalize">
<xsl:with-param name="string" select="@type"/>
</xsl:call-template>
<xsl:if test="parent::*/position"> (<xsl:value-of select="parent::*/position"/>)</xsl:if>:
</th>
<td>
<xsl:choose>
<xsl:when test="@href"><a href="{@href}"><xsl:apply-templates/></a></xsl:when>
<xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
</xsl:choose>
</td>
</tr>
</xsl:template>

<xsl:template match="text[@type='displayCaption']">
<tr><th>Caption<xsl:if test="parent::*/position"> (<xsl:value-of select="parent::*/position"/>)</xsl:if>:</th><td><xsl:apply-templates/></td></tr>
</xsl:template>

<xsl:template match="text[@type='displayCaption/Signature']">
<tr><th>Caption<xsl:if test="parent::*/position"> (<xsl:value-of select="parent::*/position"/>)</xsl:if>:</th><td><xsl:apply-templates/></td></tr>
</xsl:template>

<xsl:template match="text[@type='displayInscription' or @type='inscription']">
<tr><th>Inscription on Monument<xsl:if test="parent::*/position"> (<xsl:value-of select="parent::*/position"/>)</xsl:if>:&#160;</th><td><xsl:apply-templates/></td></tr>
</xsl:template>

<xsl:template match="text[@type='displayLabel']">
<tr><th>Label<xsl:if test="parent::*/position"> (<xsl:value-of select="parent::*/position"/>)</xsl:if>:</th><td><xsl:apply-templates/></td></tr>
</xsl:template>

<xsl:template match="text[@type='displaySignature']">
<tr><th>Signature<xsl:if test="parent::*/position"> (<xsl:value-of select="parent::*/position"/>)</xsl:if>:</th><td><xsl:apply-templates/></td></tr>
</xsl:template>

<xsl:template match="text[@type='displayText']">
<tr><th>Text<xsl:if test="parent::*/position"> (<xsl:value-of select="parent::*/position"/>)</xsl:if>:</th><td><xsl:apply-templates/></td></tr>
</xsl:template>

<!-- TEXTREF -->
<xsl:template match="textrefSet">
<tr><th>References:</th><td><xsl:apply-templates/></td></tr>
</xsl:template>

<xsl:template match="textref">
<xsl:apply-templates/><br/>
</xsl:template>

<xsl:template match="inscription//textref"/>

<xsl:template match="uln">
<em><xsl:apply-templates/></em>
</xsl:template>

<!-- WORK -->
<xsl:template match="work">
<xsl:copy-of select="$header"/>

<p>
<a href="view.php?id={@id}-001&amp;title=({@refid})%20{titleSet/title}">
<img src="http://speculum.lib.uchicago.edu/images/searchthumbs/{@id}-001t.jpg"/>
</a>
<br/>
<a href="view.php?id={@id}-001&amp;title=({@refid})%20{titleSet/title}">
View zoomable image
</a>
</p>

<form action="view2.php" method="get">
<input type="hidden" name="id1" value="{@id}-001"/>
<p>
Compare with Chicago Number ('A1', '994'):<xsl:text>&#160;</xsl:text>
<input type="text" name="id2" size="5"/><xsl:text>&#160;</xsl:text>
<input type="submit" value="submit"/>
</p>
</form>

<br style="height: 2em;"/>

<xsl:if test="@id = 'speculum-0295'">
<p>
<a href="view.php?id={@id}-002&amp;title=({@refid})%20{titleSet/title}">
<img src="images/searchthumbs/{@id}-002t.jpg"/>
</a>
<br/>
<a href="view.php?id={@id}-002&amp;title=({@refid})%20{titleSet/title}">
View zoomable image
</a>
</p>

<form action="view2.php" method="get">
<input type="hidden" name="id1" value="{@id}-002"/>
<p>
Compare with Chicago Number ('A1', '994'):<xsl:text>&#160;</xsl:text>
<input type="text" name="id2" size="5"/><xsl:text>&#160;</xsl:text>
<input type="submit" value="submit"/>
</p>
</form>

<br style="height: 2em;"/>

<p>
<a href="view.php?id={@id}-003&amp;title=({@refid})%20{titleSet/title}">
<img src="images/searchthumbs/{@id}-003t.jpg"/>
</a>
<br/>
<a href="view.php?id={@id}-003&amp;title=({@refid})%20{titleSet/title}">
View zoomable image 
</a>
</p>

<form action="view2.php" method="get">
<input type="hidden" name="id1" value="{@id}-003"/>
<p>
Compare with Chicago Number ('A1', '994'):<xsl:text>&#160;</xsl:text>
<input type="text" name="id2" size="5"/><xsl:text>&#160;</xsl:text>
<input type="submit" value="submit"/>
</p>
</form>

<p>
<a href="view.php?id={@id}-004&amp;title=({@refid})%20{titleSet/title}">
<img src="images/searchthumbs/{@id}-004t.jpg"/>
</a>
<br/>
<a href="view.php?id={@id}-004&amp;title=({@refid})%20{titleSet/title}">
View zoomable image
</a>
</p>

<form action="view2.php" method="get">
<input type="hidden" name="id1" value="{@id}-004"/>
<p>
Compare with Chicago Number ('A1', '994'):<xsl:text>&#160;</xsl:text>
<input type="text" name="id2" size="5"/><xsl:text>&#160;</xsl:text>
<input type="submit" value="submit"/>
</p>
</form>

<br style="height: 2em;"/>

</xsl:if>

<table class="details">
<!-- some elements should always appear first, in order -->
<xsl:apply-templates select="agentSet"/>
<xsl:apply-templates select="dateSet"/>
<xsl:apply-templates select="locationSet"/>
<xsl:apply-templates select="measurementsSet"/>
<xsl:apply-templates select="techniqueSet"/>

<!-- everything else, in document order -->
<xsl:apply-templates select="*[not(
    self::agentSet or
    self::dateSet or
    self::locationSet or
    self::measurementsSet or
    self::techniqueSet
)]"/>
</table>

<br style="height: 2em;"/>

<p>
<a href="printableview.php?id={@refid}">Printable Image</a> |
<a href="xmlview.php?id={@refid}">XML Record</a> 
</p>
</xsl:template>

<!-- NAMED TEMPLATE TO CAPITALIZE STRINGS -->
<xsl:template name="capitalize">
<xsl:param name="string"/>
<xsl:variable name="decamel">
<xsl:call-template name="breakIntoWords">
<xsl:with-param name="string" select="$string"/>
</xsl:call-template>
</xsl:variable>
<xsl:value-of select="concat(translate(substring($decamel, 1, 1), 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'), substring($decamel, 2))"/>
</xsl:template>

<!--
<xsl:template name="capitalize">
<xsl:param name="string"/>
<xsl:variable name="decamel">
</xsl:variable>
<xsl:value-of select="concat(translate(substring($string, 1, 1), 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'), substring($string, 2))"/>
</xsl:template>
-->

<xsl:template name="breakIntoWords">
  <xsl:param name="string" />
  <xsl:choose>
    <xsl:when test="string-length($string) &lt; 2">
      <xsl:value-of select="$string" />
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="breakIntoWordsHelper">
        <xsl:with-param name="string" select="$string" />
        <xsl:with-param name="token" select="substring($string, 1, 1)"
/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="breakIntoWordsHelper">
  <xsl:param name="string" select="''" />
  <xsl:param name="token" select="''" />
  <xsl:choose>
    <xsl:when test="string-length($string) = 0" />
    <xsl:when test="string-length($token) = 0" />
    <xsl:when test="string-length($string) = string-length($token)">
      <xsl:value-of select="$token" />
    </xsl:when>
    <xsl:when
test="contains('ABCDEFGHIJKLMNOPQRSTUVWXYZ',substring($string,
string-length($token) + 1, 1))">
      <xsl:value-of select="concat($token, ' ')" />
      <xsl:call-template name="breakIntoWordsHelper">
        <xsl:with-param name="string" select="substring-after($string,
$token)" />
        <xsl:with-param name="token" select="substring($string,
string-length($token), 1)" />
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="breakIntoWordsHelper">
        <xsl:with-param name="string" select="$string" />
        <xsl:with-param name="token" select="substring($string, 1,
string-length($token) + 1)" />
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
