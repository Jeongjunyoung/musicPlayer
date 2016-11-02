package jy.mypro.interceptors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface Interceptors {
	public boolean loginHandle(HttpServletRequest request, HttpServletResponse response, Object handle)throws Exception;
}
