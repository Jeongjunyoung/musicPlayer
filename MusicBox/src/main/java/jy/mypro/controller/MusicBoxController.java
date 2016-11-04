package jy.mypro.controller;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jy.mypro.domain.MusicPlayList;
import jy.mypro.domain.MusicUserVO;
import jy.mypro.service.MusicBoxService;

@Controller
public class MusicBoxController {
	
	@Inject
	MusicBoxService ms;
	public static boolean session = false;
	
	
	//Main 폼
	@RequestMapping("/")
	public String musicBox_Main(Model model, HttpServletRequest request)throws Exception{
		MusicUserVO user = (MusicUserVO) request.getSession().getAttribute("userSession");
		if(user != null){
			List<MusicPlayList> list = ms.getList(user.getUser_id());		
			model.addAttribute("list", list);
			model.addAttribute("session", session);
		}
		return "main";
	}
	
	//회원가입 폼
	@RequestMapping(value="/sign_in", method=RequestMethod.POST)
	public String signIn_user(MusicUserVO vo)throws Exception{
		ms.insertUser(vo);
		return "redirect:/";
	}
	
	//로그인 폼
	@RequestMapping(value="/login_form", method=RequestMethod.POST)
	public String login_user(Model model, MusicUserVO vo, HttpServletRequest request)throws Exception{
		MusicUserVO user = ms.login_check(vo);
		session = true;
		if(user == null){
			return "redirect:/LoginFail";
		}else{
			request.getSession().setAttribute("userSession", user);
			model.addAttribute("list", ms.getList(user.getUser_id()));
			model.addAttribute("session", session);
			return "main";
		}
	}
	
	//음악 추가
	@RequestMapping(value="/addPlayList", method=RequestMethod.GET)
	public String addPlayList(@RequestParam("music_id") String[] music_id, 
								@RequestParam("music_name") String[] music_name, 
										HttpServletRequest request)throws Exception{
		session = true;
		MusicUserVO user_id = (MusicUserVO) request.getSession().getAttribute("userSession");
		MusicPlayList user = new MusicPlayList();
		for(int i=0;i<music_id.length;i++){
			String music_name_de = URLDecoder.decode(music_name[i], "UTF-8");
			user.setUser_id(user_id.getUser_id());
			user.setMusic_id(music_id[i]);
			user.setMusic_name(music_name_de);			
			ms.insertMusic(user);
		}	
		return "redirect:/";
	}
	
	//현재 로그인 되어있는 아이디의 플레이 리스트
	@RequestMapping("/getPlayList")
	@ResponseBody
	public List<MusicPlayList> getUserList(@RequestParam("user_id") String user_id)throws Exception{
		List<MusicPlayList> list = ms.getMusic_id(user_id);
		if(list != null){
			return list;
		}else{
			return null;
		}		
	}
	
	//로그아웃
	@RequestMapping("/logout")
	public String logout_user(HttpServletRequest request)throws Exception{
		session = false;
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/";
	}
}
