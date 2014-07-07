<!--
This XSL stylesheet updates version in Magento's package.xml
to the one provided as parameter $package_version.
Usage from command line:
xsltproc ++stringparam package_version "1.1.22" utils/update_version.xsl public/var/connect/package.xml

After that <version> tag contents will be updated to 1.1.22 in package.xml

NB! XML comments don't allow double hyphens. stringparam argument must use double hyphens instead of ++.
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes" encoding="utf-8"/>
    <xsl:param name="package_version" select="$package_version"/>
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="version">
        <xsl:element name="version">
		<xsl:choose>
			<!-- appends package version as last number if specified version contains . -->
			<!-- otherwise sets full package version as specified by argument -->
			<xsl:when test="contains($package_version, '.')">
				<xsl:value-of select="$package_version"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="text()" /><xsl:text>.</xsl:text><xsl:value-of select="$package_version"/>
			</xsl:otherwise>
		</xsl:choose>
        </xsl:element>
    </xsl:template>

    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
