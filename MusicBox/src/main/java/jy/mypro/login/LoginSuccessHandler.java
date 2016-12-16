package jy.mypro.login;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import jy.mypro.domain.MusicUserVO;
import jy.mypro.service.MusicBoxService;


public class LoginSuccessHandler implements AuthenticationSuccessHandler{
	
	private String login;
	
	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}
	@Inject
	MusicBoxService ms;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication auth)
			throws IOException, ServletException {
		//(User) SecurityContextHolder.getContext().getAuthentication().getPrincipal(); ->>> 사용자 정보 조회
		MusicUserVO user = (MusicUserVO)auth.getPrincipal();
		request.setAttribute("session", true);
		request.setAttribute("user", user);
		try {			
			request.setAttribute("list", ms.getList(user.getUser_id()));
			request.setAttribute("tabs", ms.getUserTabs(user.getUser_id()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher("/");
		dispatcher.forward(request, response);
	}
}
