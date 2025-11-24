<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
                xmlns:html="http://www.w3.org/TR/REC-html40"
                xmlns:sitemap="http://www.sitemaps.org/schemas/sitemap/0.9"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml" dir="rtl" lang="fa">
            <head>
                <title>نقشه سایت XML</title>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
                <style type="text/css">
                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                    }
                    body {
                        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        min-height: 100vh;
                        padding: 20px;
                    }
                    .container {
                        max-width: 1200px;
                        margin: 0 auto;
                        background: white;
                        border-radius: 16px;
                        box-shadow: 0 20px 60px rgba(0,0,0,0.3);
                        overflow: hidden;
                    }
                    .header {
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        color: white;
                        padding: 40px;
                        text-align: center;
                    }
                    .header h1 {
                        font-size: 2.5em;
                        margin-bottom: 10px;
                    }
                    .header p {
                        font-size: 1.2em;
                        opacity: 0.9;
                    }
                    .content {
                        padding: 40px;
                    }
                    .info {
                        background: linear-gradient(135deg, #e0f2fe 0%, #dbeafe 100%);
                        padding: 25px;
                        border-radius: 12px;
                        margin-bottom: 30px;
                        border-right: 5px solid #667eea;
                    }
                    .info h2 {
                        color: #1e40af;
                        margin-bottom: 15px;
                        font-size: 1.5em;
                    }
                    .info p {
                        color: #1e3a8a;
                        line-height: 1.8;
                        font-size: 1.1em;
                    }
                    table {
                        width: 100%;
                        border-collapse: collapse;
                        margin-top: 20px;
                        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
                        border-radius: 8px;
                        overflow: hidden;
                    }
                    thead {
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    }
                    th {
                        color: white;
                        padding: 18px;
                        text-align: right;
                        font-weight: bold;
                        font-size: 1.1em;
                    }
                    td {
                        padding: 16px;
                        border-bottom: 1px solid #e5e7eb;
                        text-align: right;
                    }
                    tbody tr {
                        background: white;
                        transition: all 0.3s ease;
                    }
                    tbody tr:nth-child(even) {
                        background: #f9fafb;
                    }
                    tbody tr:hover {
                        background: #eff6ff;
                        transform: scale(1.01);
                        box-shadow: 0 2px 8px rgba(102, 126, 234, 0.2);
                    }
                    a {
                        color: #667eea;
                        text-decoration: none;
                        font-weight: 600;
                        transition: color 0.3s ease;
                    }
                    a:hover {
                        color: #764ba2;
                        text-decoration: underline;
                    }
                    .priority-high {
                        color: #059669;
                        font-weight: bold;
                    }
                    .priority-medium {
                        color: #f59e0b;
                        font-weight: bold;
                    }
                    .priority-low {
                        color: #dc2626;
                        font-weight: bold;
                    }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h1>🗺️ نقشه سایت XML</h1>
                        <p>این فایل برای موتورهای جستجو طراحی شده است</p>
                    </div>
                    <div class="content">
                        <div class="info">
                            <h2>📊 اطلاعات نقشه سایت</h2>
                            <p><strong>دامنه:</strong> classschedules.vercel.app</p>
                            <p><strong>تعداد کل URL‌ها:</strong> <xsl:value-of select="count(sitemap:urlset/sitemap:url)"/></p>
                            <p><strong>توضیحات:</strong> این sitemap به موتورهای جستجو کمک می‌کند تا صفحات سایت را بهتر ایندکس کنند.</p>
                        </div>
                        <table>
                            <thead>
                                <tr>
                                    <th>آدرس URL</th>
                                    <th>آخرین بروزرسانی</th>
                                    <th>تکرار تغییرات</th>
                                    <th>اولویت</th>
                                </tr>
                            </thead>
                            <tbody>
                                <xsl:for-each select="sitemap:urlset/sitemap:url">
                                    <tr>
                                        <td>
                                            <a href="{sitemap:loc}">
                                                <xsl:value-of select="sitemap:loc"/>
                                            </a>
                                        </td>
                                        <td>
                                            <xsl:value-of select="sitemap:lastmod"/>
                                        </td>
                                        <td>
                                            <xsl:value-of select="sitemap:changefreq"/>
                                        </td>
                                        <td>
                                            <xsl:choose>
                                                <xsl:when test="sitemap:priority &gt;= 0.8">
                                                    <span class="priority-high">
                                                        <xsl:value-of select="sitemap:priority"/>
                                                    </span>
                                                </xsl:when>
                                                <xsl:when test="sitemap:priority &gt;= 0.5">
                                                    <span class="priority-medium">
                                                        <xsl:value-of select="sitemap:priority"/>
                                                    </span>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <span class="priority-low">
                                                        <xsl:value-of select="sitemap:priority"/>
                                                    </span>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </td>
                                    </tr>
                                </xsl:for-each>
                            </tbody>
                        </table>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
