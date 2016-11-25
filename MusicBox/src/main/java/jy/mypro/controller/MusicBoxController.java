package jy.mypro.controller;

import java.net.URLDecoder;
import java.util.List;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	
	@Inject
	BCryptPasswordEncoder encoder;
	
	//Main 폼
	@RequestMapping("/")
	public String musicBox_Main(Model model)throws Exception{
		model.addAttribute("logoutFail", "none");
		return "main";
	}
	
	//회원가입 폼
	@RequestMapping(value="/sign_in", method=RequestMethod.POST)
	public String signIn_user(MusicUserVO vo)throws Exception{
		String bCryptString = encoder.encode(vo.getUser_pw());
		vo.setUser_pw(bCryptString);
		ms.insertUser(vo);
		return "redirect:/";
	}
	
	@RequestMapping("/loginFail")
	public String loginFail(Model model)throws Exception{
		System.out.println("로그아웃 실패");
		model.addAttribute("logoutFail", "true");
		return "main";
	}
	//음악 추가
	@RequestMapping(value="/addPlayList", method=RequestMethod.GET)
	@ResponseBody
	public List<MusicPlayList> addPlayList(@RequestParam("music_id") String music_id, 
								@RequestParam("music_name") String music_name, 
										HttpServletRequest request)throws Exception{
		session = true;
		MusicUserVO user_id = (MusicUserVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MusicPlayList user = new MusicPlayList();
		String music_name_de = URLDecoder.decode(music_name, "UTF-8");
		user.setUser_id(user_id.getUser_id());
		user.setMusic_id(music_id);
		user.setMusic_name(music_name_de);			
		ms.insertMusic(user);
		return ms.getAddList(user_id.getUser_id());
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
	
	///로그아웃
	@RequestMapping("/logout")
	public String logout_user(HttpServletRequest request)throws Exception{
		session = false;
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/";
	}
}
