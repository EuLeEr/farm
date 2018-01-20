<?xml version="1.0"?>
<!--
Copyright (c) 2016-2018 Zerocracy

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to read
the Software only. Permissions is hereby NOT GRANTED to use, copy, modify,
merge, publish, distribute, sublicense, and/or sell copies of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" version="1.0">
  <xsl:output method="html" doctype-system="about:legacy-compat" encoding="UTF-8" indent="yes"/>
  <xsl:strip-space elements="*"/>
  <xsl:include href="/xsl/inner-layout.xsl"/>
  <xsl:template match="page" mode="head">
    <title>
      <xsl:text>Files @</xsl:text>
      <xsl:value-of select="artifact"/>
    </title>
  </xsl:template>
  <xsl:template match="page" mode="inner">
    <form action="/upload/{project}" method="post" autocomplete="off" enctype="multipart/form-data">
      <label>
        <xsl:text>Upload file: </xsl:text>
      </label>
      <input type="text" name="artifact" size="20" maxlength="60" placeholder="e.g. vesting.xml"/>
      <input type="file" name="file"/>
      <button type="submit">
        <xsl:text>Upload</xsl:text>
      </button>
    </form>
    <p>
      <xsl:text>All files available at </xsl:text>
      <a href="/p/{project}">
        <xsl:value-of select="title"/>
      </a>
      <xsl:text>:</xsl:text>
    </p>
    <table>
      <thead>
        <tr>
          <th>
            <xsl:text>File</xsl:text>
          </th>
          <th>
            <xsl:text>Size</xsl:text>
          </th>
          <th>
            <xsl:text>Modified</xsl:text>
          </th>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates select="items"/>
      </tbody>
    </table>
  </xsl:template>
  <xsl:template match="item">
    <tr>
      <td>
        <xsl:value-of select="name"/>
      </td>
      <td style="text-align:right;">
        <xsl:value-of select="size"/>
      </td>
      <td>
        <xsl:value-of select="modified"/>
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>