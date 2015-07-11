<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html"/>

  <!-- ** XML2e ** -->
  <!-- to follow the book's example, see this and the sections below -->
  <xsl:template match="/">

    <html>
      <head>
        <title>Wonders of the World</title>
      </head>
      <body>
        <h1>Seven Wonders of the Ancient World</h1>

        <h2>Overview</h2>
        <table border="1">
          <tr>
            <th>Wonder Name</th>
            <th>City</th>
            <th>Country</th>
            <th>Years<br /> Standing</th>
            <th>Height</th>
            
          </tr>

         <xsl:apply-templates select="ancient_wonders/wonder[height &gt; -1]"> 
             
            <xsl:sort select="height" order="descending" data-type="number" />
          </xsl:apply-templates>

          <tr>
            <td valign="top" align="right" colspan="4">
              Average Height:
            </td>
            <td valign="top">
              <xsl:value-of select="format-number(sum(/ancient_wonders/wonder/height) 
                            div 
                            count(/ancient_wonders/wonder/height[.!=0]),'##0.0')" /> ft
            </td>
          </tr>
        </table>
            
          <!-- ** XML2e ** -->
          <!-- to follow the book's example, see this and the sections below -->
          
           
        <h2>History</h2>
        <xsl:apply-templates select="ancient_wonders/wonder/history">
          <xsl:sort select="year_built" order="descending" data-type="number"/>
        </xsl:apply-templates> 
        

      </body>
    </html>
  </xsl:template>

  <!-- ** XML2e ** -->
  <!-- to follow the book's example, see this and the sections below -->
  <xsl:template match="wonder">
    <tr>
      <td>
        <a>
          <xsl:attribute name="href">
            #<xsl:value-of select="name[@language='English']"/>
          </xsl:attribute>
          <strong>
            <xsl:value-of select="name[@language='English']"/>
          </strong>
        </a>
        <br/>

        <!-- ** XML2e ** -->
        <!-- to follow the book's example, see this and the sections below -->
        <xsl:apply-templates select="name[@language!='English']"/>
      </td>
      <td valign="top">
        <xsl:value-of select="substring-before(location, ', ')"/>
      </td>
      <td valign="top">
        <xsl:value-of select="substring-after(location, ', ')"/>
      </td>
      <td valign="top">
        <xsl:choose>
          <xsl:when test="history/year_destroyed !=0">

            <xsl:choose>
              <xsl:when test="history/year_destroyed/@era='BC'">
                <xsl:value-of select="history/year_built - year_destroyed"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="history/year_built + history/year_destroyed - 1"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="history/year_built + 2015 - 1"/>
          </xsl:otherwise>
        </xsl:choose>
      </td>
      <td>
        <xsl:choose>
          <xsl:when test="height != 0">
            <xsl:value-of select="height"/> feet<br />
            (<em>
              <xsl:value-of select=
              "format-number (height * 0.3048, '##0.0')"/> m </em>)
          </xsl:when>
          <xsl:otherwise>
            unknown
          </xsl:otherwise>
        </xsl:choose>
      </td>
      
    </tr>
  </xsl:template>

  <!-- ** XML2e ** -->
  <!-- to follow the book's example, see this section below -->
  <xsl:template match="name[@language!='English']">
    (<em>
      <xsl:value-of select="."/>
    </em>)
  </xsl:template>

  <xsl:template match="history">
    <a>
      <xsl:attribute name="name">
        <xsl:value-of select="../name[@language='English']"/>
      </xsl:attribute>
    </a>
    <img>
      <xsl:attribute name="src">images/<xsl:value-of select="../main_image/@file"/>
      </xsl:attribute>
    </img>
     <br></br>The <xsl:value-of select="../name[@language='English']"/>
    <xsl:apply-templates select="../name[@language!='English']"/>
    was built in <xsl:value-of select="year_built"/><xsl:text> </xsl:text><xsl:value-of select="year_built/@era"/>
    <xsl:choose>
      <xsl:when test="year_destroyed != 0">
        and was destroyed by <xsl:value-of select="how_destroyed"/> in <xsl:value-of select="year_destroyed"/>
        <xsl:text> </xsl:text><xsl:value-of select="year_destroyed/@era"/>.
      </xsl:when>
      <xsl:otherwise>
        and is still standing today.
      </xsl:otherwise>
    </xsl:choose>
    <br /><br />
  </xsl:template>

</xsl:stylesheet>
