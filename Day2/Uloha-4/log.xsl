<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
        <xsl:output method="text"/>
        <xsl:variable name="delimiter" select="';'"/>

        <xsl:template match="/">

                <xsl:for-each select="log/logentry">
                        <xsl:value-of select="concat(@revision,$delimiter,author,$delimiter,date,$delimiter,msg)" /><xsl:text>&#xa;</xsl:text>
                </xsl:for-each>

        </xsl:template>
</xsl:stylesheet>