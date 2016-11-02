package jy.mypro.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import jy.mypro.domain.MusicUserVO;
import jy.mypro.service.MusicBoxService;

@Controller
public class MusicBoxController {
	
	@Inject
	MusicBoxService ms;
	
	@RequestMapping("/")
	public String musicBox_Main(){
		return "MusicBox";
	}
	@RequestMapping(value="/sign_in", method=RequestMethod.POST)
	public String signIn_user(MusicUserVO vo)throws Exception{
		ms.insertUser(vo);
		return "redirect:/";
	}
	@RequestMapping(value="/login_form", method=RequestMethod.POST)
	public String login_user(MusicUserVO vo, HttpServletRequest request)throws Exception{
		MusicUserVO user = ms.login_check(vo);
		if(user == null){
			return "redirect:/LoginFail";
		}else{
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("user_id", user.getUser_id());
			map.put("user_name", "복규");
			request.getSession().setAttribute("userSession", map);
			return "redirect:/";
		}
		
	}
}
