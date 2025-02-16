<!DOCTYPE html>

<#include init />

<html class="${root_css_class}" lang="${w3c_language_id}">

<head>

	<title>${htmlUtil.escape(the_title)}</title>
	<meta content="initial-scale=1.0, width=device-width" name="viewport" />
	<link rel="stylesheet" href="${css_folder}/main.css?t=${theme_timestamp}">

	<#if !is_signed_in>
		<@liferay_util["include"] page="${dir_include}/common/themes/fast_top_head.jsp" />
	<#else>
		<@liferay_util["include"] page=top_head_include />
		<link rel="stylesheet" href="${css_folder}/admin/portlet.css?t=${theme_timestamp}">
	</#if>
		
</head>

<body class="${css_class}">


<@liferay_util["include"] page=body_top_include />
<@liferay.control_menu />


<div class="container-fluid position-relative" id="wrapper">

	<header id="banner" role="banner">
		<div id="heading">
			<div aria-level="1" class="site-title" role="heading">
				<a class="${logo_css_class}" href="${site_default_url}" title="<@liferay.language_format arguments="${site_name}" key="go-to-x" />">
					<img alt="${logo_description}" height="${site_logo_height}" src="${site_logo}" width="${site_logo_width}" />
				</a>
			</div>
		</div>

		<#if !is_signed_in>
			<a data-redirect="${is_login_redirect_required?string}" href="${sign_in_url}" id="sign-in" rel="nofollow">${sign_in_text}</a>
		</#if>

		<#if has_navigation && is_setup_complete>
			<#include "${full_templates_path}/navigation.ftl" />
		</#if>
	</header>

	<section id="content">

		<#if is_signed_in>

			<#if selectable>
				<@liferay_util["include"] page=content_include />
			<#else>
				${portletDisplay.recycle()}

				${portletDisplay.setTitle(the_title)}

				<@liferay_theme["wrap-portlet"] page="portlet.ftl">
					<@liferay_util["include"] page=content_include />
				</@>
			</#if>
		<#else>
			<#if selectable>
				<@liferay_util["include"] page=content_include />
			<#else>
				${portletDisplay.recycle()}

				<@liferay_theme["wrap-portlet"] page="portlet-default.ftl">
					<@liferay_util["include"] page=content_include />
				</@>
			</#if>
		</#if>

	</section>

	<footer id="footer" role="contentinfo">
		<p class="powered-by">
			<@liferay.language_format
				arguments='<a href="https://www.linkedin.com/in/lmux/" rel="external">Galo</a>'
				key="powered-by-x"
			/>
		</p>
	</footer>
</div>



	

<@liferay_util["include"] page=body_bottom_include />


<#if is_signed_in>
	<@liferay_util["include"] page=bottom_include />
</#if>

<#-- inject:js -->
<#-- endinject -->

</body>

</html>