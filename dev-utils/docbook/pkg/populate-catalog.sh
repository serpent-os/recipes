#!/bin/sh

# Inspired by https://www.linuxfromscratch.org/blfs/view/svn/pst/docbook.html

if [ $# -ne 5 ]; then
    echo "You must pass, in this order, type, version, datadir, vendordir, and installroot" >&2
    exit 1
fi
type=$1
version=$2
datadir=$3
vendordir=$4
installroot=$5
if [ $type != "xml" ] [ $type != "xsl" ]; then
    echo "Type must be xml or xsl. You passed '$type'" >&2
    exit 1
fi

populate_xml_docbook() {
    install -dm00755 ${installroot}/${datadir}/xml/docbook/xml-dtd-${version}
    install -dm00755 ${installroot}/${vendordir}/xml
    xmlcatalog --noout --create ${installroot}/${vendordir}/xml/docbook
    xmlcatalog --noout --add "public" \
        "-//OASIS//DTD DocBook XML V${version}//EN" \
        "http://www.oasis-open.org/docbook/xml/${version}/docbookx.dtd" \
        ${installroot}/${vendordir}/xml/docbook
    xmlcatalog --noout --add "public" \
        "-//OASIS//DTD DocBook XML CALS Table Model V${version}//EN" \
        "file://${installroot}/${datadir}/xml/docbook/xml-dtd-${version}/calstblx.dtd" \
        ${installroot}/${vendordir}/xml/docbook
    xmlcatalog --noout --add "public" \
        "-//OASIS//DTD XML Exchange Table Model 19990315//EN" \
        "file://${installroot}/${datadir}/xml/docbook/xml-dtd-${version}/soextblx.dtd" \
        ${installroot}/${vendordir}/xml/docbook
    xmlcatalog --noout --add "public" \
        "-//OASIS//ELEMENTS DocBook XML Information Pool V${version}//EN" \
        "file://${installroot}/${datadir}/xml/docbook/xml-dtd-${version}/dbpoolx.mod" \
        ${installroot}/${vendordir}/xml/docbook
    xmlcatalog --noout --add "public" \
        "-//OASIS//ELEMENTS DocBook XML Document Hierarchy V${version}//EN" \
        "file://${installroot}/${datadir}/xml/docbook/xml-dtd-${version}/dbhierx.mod" \
        ${installroot}/${vendordir}/xml/docbook
    xmlcatalog --noout --add "public" \
        "-//OASIS//ELEMENTS DocBook XML HTML Tables V${version}//EN" \
        "file://${installroot}/${datadir}/xml/docbook/xml-dtd-${version}/htmltblx.mod" \
        ${installroot}/${vendordir}/xml/docbook
    xmlcatalog --noout --add "public" \
        "-//OASIS//ENTITIES DocBook XML Notations V${version}//EN" \
        "file://${installroot}/${datadir}/xml/docbook/xml-dtd-${version}/dbnotnx.mod" \
        ${installroot}/${vendordir}/xml/docbook
    xmlcatalog --noout --add "public" \
        "-//OASIS//ENTITIES DocBook XML Character Entities V${version}//EN" \
        "file://${installroot}/${datadir}/xml/docbook/xml-dtd-${version}/dbcentx.mod" \
        ${installroot}/${vendordir}/xml/docbook
    xmlcatalog --noout --add "public" \
        "-//OASIS//ENTITIES DocBook XML Additional General Entities V${version}//EN" \
        "file://${installroot}/${datadir}/xml/docbook/xml-dtd-${version}/dbgenent.mod" \
        ${installroot}/${vendordir}/xml/docbook
    xmlcatalog --noout --add "rewriteSystem" \
        "http://www.oasis-open.org/docbook/xml/${version}" \
        "file://${installroot}/${datadir}/xml/docbook/xml-dtd-${version}" \
        ${installroot}/${vendordir}/xml/docbook
    xmlcatalog --noout --add "rewriteURI" \
        "http://www.oasis-open.org/docbook/xml/${version}" \
        "file://${installroot}/${datadir}/xml/docbook/xml-dtd-${version}" \
        ${installroot}/${vendordir}/xml/docbook
}

populate_xml_catalog() {
    xmlcatalog --noout --create ${installroot}/${vendordir}/xml/catalog
    xmlcatalog --noout --add "delegatePublic" \
        "-//OASIS//ENTITIES DocBook XML" \
        "file://${installroot}/${vendordir}/xml/docbook" \
        ${installroot}/${vendordir}/xml/catalog
    xmlcatalog --noout --add "delegatePublic" \
        "-//OASIS//DTD DocBook XML" \
        "file://${installroot}/${vendordir}/xml/docbook" \
        ${installroot}/${vendordir}/xml/catalog
    xmlcatalog --noout --add "delegateSystem" \
        "http://www.oasis-open.org/docbook/" \
        "file://${installroot}/${vendordir}/xml/docbook" \
        ${installroot}/${vendordir}/xml/catalog
    xmlcatalog --noout --add "delegateURI" \
        "http://www.oasis-open.org/docbook/" \
        "file://${installroot}/${vendordir}/xml/docbook" \
        ${installroot}/${vendordir}/xml/catalog
}

populate_xml_retrocompatibility() {
    for DTDVERSION in 4.1.2 4.2 4.3 4.4; do
        xmlcatalog --noout --add "public" \
            "-//OASIS//DTD DocBook XML V$DTDVERSION//EN" \
            "http://www.oasis-open.org/docbook/xml/$DTDVERSION/docbookx.dtd" \
            ${installroot}/${vendordir}/xml/docbook
        xmlcatalog --noout --add "rewriteSystem" \
            "http://www.oasis-open.org/docbook/xml/$DTDVERSION" \
            "file://${installroot}/${datadir}/xml/docbook/xml-dtd-${version}" \
            ${installroot}/${vendordir}/xml/docbook
        xmlcatalog --noout --add "rewriteURI" \
            "http://www.oasis-open.org/docbook/xml/$DTDVERSION" \
            "file://${installroot}/${datadir}/xml/docbook/xml-dtd-${version}" \
            ${installroot}/${vendordir}/xml/docbook
        xmlcatalog --noout --add "delegateSystem" \
            "http://www.oasis-open.org/docbook/xml/$DTDVERSION/" \
            "file://${installroot}/${vendordir}/xml/docbook" \
            ${installroot}/${vendordir}/xml/catalog
        xmlcatalog --noout --add "delegateURI" \
            "http://www.oasis-open.org/docbook/xml/$DTDVERSION/" \
            "file://${installroot}/${vendordir}/xml/docbook" \
            ${installroot}/${vendordir}/xml/catalog
    done
}

populate_xsl_catalog() {
    xmlcatalog --noout --add "rewriteSystem" \
        "https://cdn.docbook.org/release/xsl-nons/${version}" \
        "${datadir}/xml/docbook/xsl-stylesheets-nons-${version}" \
        ${installroot}/${vendordir}/xml/catalog

    xmlcatalog --noout --add "rewriteURI" \
        "https://cdn.docbook.org/release/xsl-nons/${version}" \
        "${datadir}/xml/docbook/xsl-stylesheets-nons-${version}" \
        ${installroot}/${vendordir}/xml/catalog

    xmlcatalog --noout --add "rewriteSystem" \
        "https://cdn.docbook.org/release/xsl-nons/current" \
        "${datadir}/xml/docbook/xsl-stylesheets-nons-${version}" \
        ${installroot}/${vendordir}/xml/catalog

    xmlcatalog --noout --add "rewriteURI" \
        "https://cdn.docbook.org/release/xsl-nons/current" \
        "${datadir}/xml/docbook/xsl-stylesheets-nons-${version}" \
        ${installroot}/${vendordir}/xml/catalog

    xmlcatalog --noout --add "rewriteSystem" \
        "http://docbook.sourceforge.net/release/xsl/current" \
        "${datadir}/xml/docbook/xsl-stylesheets-nons-${version}" \
        ${installroot}/${vendordir}/xml/catalog

    xmlcatalog --noout --add "rewriteURI" \
        "http://docbook.sourceforge.net/release/xsl/current" \
        "${datadir}/xml/docbook/xsl-stylesheets-nons-${version}" \
        ${installroot}/${vendordir}/xml/catalog
}

populate_xsl_retrocompatibility() {
    for RELEASE in 1.67.2; do
        xmlcatalog --noout --add "rewriteSystem" \
            "http://docbook.sourceforge.net/release/xsl/${RELEASE}" \
            "${installroot}/${datadir}/xml/docbook/xsl-stylesheets-${RELEASE}" \
            ${installroot}/${vendordir}/xml/catalog &&

        xmlcatalog --noout --add "rewriteURI" \
            "http://docbook.sourceforge.net/release/xsl/${RELEASE}" \
            "${installroot}/${datadir}/xml/docbook/xsl-stylesheets-${RELEASE}" \
            ${installroot}/${vendordir}/xml/catalog
    done
}

set -x
case ${type} in
    'xml')
        populate_xml_docbook
        populate_xml_catalog
        populate_xml_retrocompatibility
        ;;
    'xsl')
        populate_xsl_catalog
        populate_xsl_retrocompatibility
        ;;
esac

