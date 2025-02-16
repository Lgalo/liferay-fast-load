<h1>Liferay carga mínima CSS y JS</h1>

<p>
<a href="https://github.com/Lgalo/liferay-fast-load/blob/main/README.en.md"><img src="https://camo.githubusercontent.com/736d66edfae50fb3866a35c7f976538d8c18f8c04d1f5719602a07ad43876305/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f6c616e672d656e2d7265642e737667" /></a>&nbsp;
<a href="https://github.com/Lgalo/liferay-fast-load/blob/main/README.md"><img src="https://camo.githubusercontent.com/ab91b3ba36ba79164b62986c1ec145a106d1a43ff96dffb1453c5c63163a2d10/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f6c616e672d65732d79656c6c6f772e737667" alt="es"></a>
</p>
<h3>Liferay sin bootstrap y con las llamadas de estilos CSS y Javascripts mínimos para garantizar la carga más rápida</h3>

<strong>¡IMPORTANTE!</strong> Estos desarrollos han sido diseñados para Liferay 7.4 y versiones posteriores.

Existen dos métodos para reducir la carga de estilos y JavaScript en Liferay:
<ul>
  <li>Desacoplar Bootstrap/Clay del tema de apariencia en la parte pública y cargarlo solo cuando se tienen permisos de gestión en la parte administrativa (back-end).</li>
  <li>Eliminar la carga adicional de scripts y estilos en el encabezado (header) y pie de página (footer) que Liferay añade por defecto.</li>
</ul>
<p>&nbsp;</p>
<h3>1. Desacoplar Bootstrap del tema de apariencia:</h3>
<p>Bootstrap/Clay es necesario en la parte de gestión de contenidos en el front-end, pero no es requerido cuando se accede como un usuario sin permisos administrativos. Para ello, hemos creado una regla en el archivo <code>portal_normal.ftl</code>, que, mediante un condicional, aplica un archivo CSS específico denominado <code>/admin/portlet.css</code> cuando el usuario está autenticado. Este archivo CSS contiene todo el Bootstrap/Clay necesario, limitado únicamente a la capa de gestión de los portlets. Aunque he optado por usar este enfoque con usuarios autenticados para mayor agilidad, <strong>lo ideal sería aplicar esta lógica mediante roles de usuario</strong>.</p>
<p>Por otro lado, cuando el usuario no está autenticado, se hace una llamada únicamente al archivo <code>main.css</code> de nuestro tema, completamente limpio de Bootstrap.</p>
<p>Cabe destacar que en <code>portlet.css</code> he incluido todo lo necesario para una gestión mínima de Liferay. Si necesitas agregar más reglas para tu desarrollo, puedes extender este archivo CSS según lo requieras.</p>
<p>Actualmente, el tema de apariencia está configurado para cargar, por defecto, el archivo <strong>fastLoader</strong>, desarrollado por mí, para eliminar todos los scripts y estilos de la cabecera y pie de página.</p>
<p>Si no deseas utilizar esta funcionalidad, tendrás que eliminar las siguientes líneas de código donde se realiza la llamada:</p>
<pre><code><@liferay_util["include"] page="${dir_include}/common/themes/fast_top_head.jsp" /></code></pre>
<p>Y sacar del condicional <code>IF</code>:</p>
<pre><code><@liferay_util["include"] page=top_head_include /></code></pre>
<p>&nbsp;</p>
<h3>2. Eliminar los estilos y JavaScript del header de Liferay:</h3>
<p>He creado un portlet en Gradle denominado <strong>fastLoader</strong>, que utiliza el <strong>JSP Bag de Liferay</strong>. FastLoader clona el archivo JSP proporcionado por Liferay <code>(/html/common/themes/top_head.jsp)</code> y lo limpia de las llamadas a JavaScript y CSS, generando un archivo limpio denominado <code>fast_top_head.ftl</code>, ubicado en la misma carpeta que el original.</p>
<p>Los estilos y scripts contenidos en <code>top_head.jsp</code> son necesarios para que Liferay funcione correctamente en el panel de administración, pero no son requeridos cuando el usuario no está autenticado. Por esta razón, he implementado un condicional <code>IF - ELSE</code>, similar al utilizado para Bootstrap, que determina cuándo el usuario está autenticado y cuándo no. Cuando el usuario está autenticado, se carga el archivo:</p>
<pre><code><@liferay_util["include"] page=top_head_include /></code></pre>
<p>Cuando el usuario no está autenticado, se carga el archivo <code>fast_load</code>:</p>
<pre><code><@liferay_util["include"] page="${dir_include}/common/themes/fast_top_head.jsp" /></code></pre>
<p>&nbsp;</p>
<p>Adjunto en el repositorio el portlet fastLoad en gradle y su archivo compilado, para que puedas desplegarlo en un entorno Liferay junto con un tema de apariencia con bootstrap desacoplado y funcional en su parte privada.</p>
<hr>
<p><a href="https://www.linkedin.com/in/lmux/">Luis Galo Medina Iglesias -  © 2025</a></p>
