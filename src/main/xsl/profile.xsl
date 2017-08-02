<?xml version="1.0"?>
<!--
 * Copyright (c) 2016-2017 Zerocracy
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to read
 * the Software only. Permissions is hereby NOT GRANTED to use, copy, modify,
 * merge, publish, distribute, sublicense, and/or sell copies of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml" version="1.0">
    <xsl:output method="html" doctype-system="about:legacy-compat"
        encoding="UTF-8" indent="yes" />
    <xsl:strip-space elements="*"/>
    <xsl:include href="/xsl/inner-layout.xsl"/>
    <xsl:template match="page" mode="head">
        <title>
            <xsl:text>@</xsl:text>
            <xsl:value-of select="identity/login"/>
        </title>
    </xsl:template>
    <xsl:template match="page" mode="inner">
        <xsl:apply-templates select="details"/>
        <xsl:if test="vacation/text() = 'true'">
            <p>
                <xsl:text>On vacation</xsl:text>
            </p>
        </xsl:if>
        <p>
            <xsl:text>Total points: </xsl:text>
            <a href="/u/{identity/login}/awards">
                <xsl:if test="awards &gt;= 0">
                    <xsl:text>+</xsl:text>
                </xsl:if>
                <xsl:value-of select="awards"/>
            </a>
            <xsl:text>.</xsl:text>
        </p>
        <p>
            <xsl:text>Total jobs: </xsl:text>
            <a href="/u/{identity/login}/agenda">
                <xsl:value-of select="agenda"/>
            </a>
            <xsl:text>.</xsl:text>
        </p>
    </xsl:template>
    <xsl:template match="details">
        <p>
            <xsl:text>Rate: </xsl:text>
            <xsl:value-of select="rate"/>
            <xsl:text>, wallet: </xsl:text>
            <code>
                <xsl:value-of select="wallet"/>
            </code>
            <xsl:text> at </xsl:text>
            <xsl:value-of select="bank"/>
            <xsl:text>.</xsl:text>
        </p>
        <xsl:apply-templates select="projects"/>
        <p>
            <xsl:if test="skills/skill">
                <xsl:value-of select="count(skills/skill)"/>
                <xsl:text> skill</xsl:text>
                <xsl:if test="count(skills/skill) &gt; 1">
                    <xsl:text>s</xsl:text>
                </xsl:if>
                <xsl:text>: </xsl:text>
                <xsl:for-each select="skills/skill">
                    <xsl:if test="position() &gt; 1">
                        <xsl:text>, </xsl:text>
                    </xsl:if>
                    <xsl:value-of select="."/>
                </xsl:for-each>
            </xsl:if>
            <xsl:if test="not(skills/skill)">
                <xsl:text>none</xsl:text>
            </xsl:if>
            <xsl:text>.</xsl:text>
        </p>
        <p>
            <xsl:if test="links/link">
                <xsl:value-of select="count(links/link)"/>
                <xsl:text> link</xsl:text>
                <xsl:if test="count(links/link) &gt; 1">
                    <xsl:text>s</xsl:text>
                </xsl:if>
                <xsl:text>: </xsl:text>
                <xsl:for-each select="links/link">
                    <xsl:if test="position() &gt; 1">
                        <xsl:text>, </xsl:text>
                    </xsl:if>
                    <code>
                        <xsl:value-of select="."/>
                    </code>
                </xsl:for-each>
            </xsl:if>
            <xsl:if test="not(links/link)">
                <xsl:text>none</xsl:text>
            </xsl:if>
            <xsl:text>.</xsl:text>
        </p>
    </xsl:template>
    <xsl:template match="projects[project]">
        <p>
            <xsl:value-of select="count(projects/project)"/>
            <xsl:text> project</xsl:text>
            <xsl:if test="count(projects/project) &gt; 1">
                <xsl:text>s</xsl:text>
            </xsl:if>
            <xsl:text>: </xsl:text>
            <xsl:for-each select="projects/project">
                <xsl:if test="position() &gt; 1">
                    <xsl:text>, </xsl:text>
                </xsl:if>
                <a href="/p/{.}">
                    <xsl:value-of select="."/>
                </a>
            </xsl:for-each>
            <xsl:text>.</xsl:text>
        </p>
    </xsl:template>
    <xsl:template match="projects[not(project)]">
        <p>
            <xsl:text>You're in no projects yet.</xsl:text>
        </p>
    </xsl:template>
</xsl:stylesheet>
