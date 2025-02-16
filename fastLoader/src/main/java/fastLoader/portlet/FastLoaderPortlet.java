package fastLoader.portlet;

import fastLoader.constants.FastLoaderPortletKeys;

import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;



import org.osgi.service.component.annotations.Component;

import com.liferay.portal.deploy.hot.CustomJspBag;
import com.liferay.portal.kernel.url.URLContainer;

import java.net.URL;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.osgi.framework.Bundle;
import org.osgi.framework.BundleContext;
import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Component;
/**
 * @author Luis Galo Medina Iglesias - https://www.linkedin.com/in/lmux/
 */
@Component(
	    immediate = true,
	    property = {
	    	"context.id=FastLoaderPortlet",
	        "context.name=Fast load portlet",
	    	"service.ranking:Integer=100"
	    },
	 
	    service=CustomJspBag.class
	)



public class FastLoaderPortlet implements CustomJspBag {

	@Override
	public String getCustomJspDir() {

		return "META-INF/jsps";
	}

	@Override
	public List<String> getCustomJsps() {

		 return _customJsps;
	}

	@Override
	public URLContainer getURLContainer() {

		return _urlContainer;
	}

	@Override
	public boolean isCustomJspGlobal() {

		return true;
	}
	
	@Activate
	protected void activate(BundleContext bundleContext) {
		_bundle = bundleContext.getBundle();

		_customJsps = new ArrayList<>();

		Enumeration<URL> entries = _bundle.findEntries(
			getCustomJspDir(), "*.jsp", true);

		while (entries.hasMoreElements()) {
			URL url = entries.nextElement();

			_customJsps.add(url.getPath());
		}
	}

	private final URLContainer _urlContainer = new URLContainer() {

	    @Override
	    public URL getResource(String name) {
	        return _bundle.getEntry(name);
	    }

	    @Override
	    public Set<String> getResources(String path) {
	        Set<String> paths = new HashSet<>();

	        for (String entry : _customJsps) {
	            if (entry.startsWith(path)) {
	               paths.add(entry);
	            }
	        }

	        return paths;
	    }

	};
	
	private Bundle _bundle;
	private List<String> _customJsps;

}
