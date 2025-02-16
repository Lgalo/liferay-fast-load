<h1>Liferay Minimal CSS and JS Load</h1>

<p>
<a href="https://github.com/Lgalo/liferay-fast-load/blob/main/README.md"><img src="https://camo.githubusercontent.com/ab91b3ba36ba79164b62986c1ec145a106d1a43ff96dffb1453c5c63163a2d10/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f6c616e672d65732d79656c6c6f772e737667" alt="es"></a>&nbsp;
<a href="https://github.com/Lgalo/liferay-fast-load/blob/main/README.en.md"><img src="https://camo.githubusercontent.com/736d66edfae50fb3866a35c7f976538d8c18f8c04d1f5719602a07ad43876305/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f6c616e672d656e2d7265642e737667" /></a>

</p>

<h3>Liferay without Bootstrap, with the minimum required CSS and JavaScript calls to ensure faster load times.</h3>

<strong>¡IMPORTANT!</strong> These developments have been designed for Liferay 7.4 and later versions.

There are two methods to reduce the load of styles and JavaScript in Liferay:
<ul>
  <li>Decouple Bootstrap/Clay from the appearance theme on the public side and load it only when management permissions are granted on the administrative side (back-end).</li>
  <li>Eliminate the additional load of scripts and styles in the header and footer that Liferay adds by default.</li>
</ul>
<p>&nbsp;</p>
<h3>1. Decouple Bootstrap from the appearance theme:</h3>
<p data-start="695" data-end="1290">Bootstrap/Clay is necessary in the content management area on the front-end, but it is not required when accessing as a user without administrative permissions. To achieve this, we have created a rule in the <code data-start="903" data-end="922">portal_normal.ftl</code> file, which, through a conditional, applies a specific CSS file called <code data-start="994" data-end="1014">/admin/portlet.css</code> when the user is authenticated. This CSS file contains all the necessary Bootstrap/Clay, limited to the portlet management layer. While I’ve chosen to apply this approach for authenticated users for faster implementation, ideally, this logic should be applied via user roles.</p>
<p data-start="1292" data-end="1444">On the other hand, when the user is not authenticated, a call is made only to the <code data-start="1374" data-end="1384">main.css</code> file of our theme, which is completely free from Bootstrap.</p>
<p data-start="1446" data-end="1649">It is worth mentioning that in <code data-start="1477" data-end="1490">portlet.css</code>, I have included everything needed for minimal Liferay management. If you need to add more rules for your development, you can extend this CSS file as needed.</p>
<p data-start="1651" data-end="1810">Currently, the appearance theme is set to load the <code data-start="1702" data-end="1714">fastLoader</code> file by default, which I developed to remove all scripts and styles from the header and footer.</p>
<p data-start="1812" data-end="1933">If you do not wish to use this functionality, you will need to remove the following lines of code where the call is made:</p>
<pre><code><@liferay_util["include"] page="${dir_include}/common/themes/fast_top_head.jsp" /></code></pre>
<p data-start="2030" data-end="2067">And remove from the <code data-start="2050" data-end="2054">IF</code> conditional:</p>
<pre><code><@liferay_util["include"] page=top_head_include /></code></pre>
<p>&nbsp;</p>
<h3>2. Remove CSS and JavaScript from Liferay’s header:</h3>
<p data-start="2192" data-end="2502">I created a Gradle portlet called <code data-start="2226" data-end="2238">fastLoader</code>, which uses the Liferay JSP Bag. <strong data-start="2272" data-end="2286">FastLoader</strong> clones the JSP file provided by Liferay (<code data-start="2328" data-end="2362">/html/common/themes/top_head.jsp</code>) and cleans it of JavaScript and CSS calls, generating a clean file called <code data-start="2438" data-end="2457">fast_top_head.ftl</code>, located in the same folder as the original.</p>
<p data-start="2504" data-end="2898">The styles and scripts in <code data-start="2530" data-end="2544">top_head.jsp</code> are necessary for Liferay to work correctly in the administration panel, but they are not required when the user is not authenticated. For this reason, I implemented an <code data-start="2714" data-end="2725">IF - ELSE</code> conditional, similar to the one used for Bootstrap, which determines whether the user is authenticated or not. When the user is authenticated, the following file is loaded:</p>
<pre><code><@liferay_util["include"] page=top_head_include /></code></pre>
<p data-start="2963" data-end="3030">When the user is not authenticated, the <code data-start="3003" data-end="3014">fast_load</code> file is loaded:</p>
<pre><code><@liferay_util["include"] page="${dir_include}/common/themes/fast_top_head.jsp" /></code></pre>
<p>&nbsp;</p>
<p data-start="3127" data-end="3365">I have attached the <code data-start="3147" data-end="3157">fastLoad</code> portlet in Gradle and its compiled file in the repository so that you can deploy it in a Liferay environment, along with an appearance theme with decoupled Bootstrap and fully functional on the private side.</p>
<hr>
<p><a href="https://www.linkedin.com/in/lmux/">Luis Galo Medina Iglesias -  © 2025</a></p>