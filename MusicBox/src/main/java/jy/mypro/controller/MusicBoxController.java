package jy.mypro.controller;

import java.util.List;
import javax.inject.Inject;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import jy.mypro.domain.MusicPlayList;
import jy.mypro.domain.MusicUserVO;
import jy.mypro.service.MusicBoxService;

@Controller
public class MusicBoxController {
	
	@Inject
	MusicBoxService ms;
	
	//Main 폼
	@RequestMapping("/")
	public String musicBox_Main(Model model, HttpServletRequest request)throws Exception{
		MusicUserVO user = (MusicUserVO) request.getSession().getAttribute("userSession");
		if(user != null){
			List<MusicPlayList> list = ms.getList(user.getUser_id());		
			model.addAttribute("list", list);
		}
		return "MusicBox";
	}
	
	//회원가입 폼
	@RequestMapping(value="/sign_in", method=RequestMethod.POST)
	public String signIn_user(MusicUserVO vo)throws Exception{
		ms.insertUser(vo);
		return "redirect:/";
	}
	
	//로그인 폼
	@RequestMapping(value="/login_form", method=RequestMethod.POST)
	public String login_user(MusicUserVO vo, HttpServletRequest request)throws Exception{
		MusicUserVO user = ms.login_check(vo);
		if(user == null){
			return "redirect:/LoginFail";
		}else{
			request.getSession().setAttribute("userSession", user);
			return "redirect:/";
		}
		
	}
}
