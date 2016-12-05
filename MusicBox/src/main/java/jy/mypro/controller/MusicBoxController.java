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
	public static String google_user = "false";
	
	@Inject
	BCryptPasswordEncoder encoder;
	
	//Main 폼
	@RequestMapping("/")
	public String musicBox_Main(Model model)throws Exception{
		model.addAttribute("logoutFail", "none");
		model.addAttribute("session", session);
		return "/main";
	}
	@RequestMapping("/googlee3b57ab611071f86.html")
	public String google_auth()throws Exception{
		return "/googlee3b57ab611071f86";
	}
	//회원가입 폼
	@RequestMapping(value="/sign_in", method=RequestMethod.POST)
	public String signIn_user(MusicUserVO vo)throws Exception{
		String bCryptString = encoder.encode(vo.getUser_pw());
		vo.setUser_pw(bCryptString);
		ms.insertUser(vo);
		return "redirect:/";
	}
	//구글 로그인
	@RequestMapping(value="/googleLogin", method=RequestMethod.GET)
	public String google_Login(@RequestParam("googleArr") String[] arr,Model model)throws Exception{
		session = true;
		google_user = "true";
		System.out.println("google");
		String de_str = URLDecoder.decode(arr[1],"UTF-8");
		String user_name = arr[2].substring(0, arr[2].indexOf("@"));
		MusicUserVO vo = new MusicUserVO();
		vo.setUser_pw(arr[0]);
		vo.setUser_id(user_name);
		vo.setUser_email(arr[2]);
		MusicUserVO check = ms.getGoogleUser(vo);
		if(check == null){
			ms.insertUser(vo);
		}
		MusicUserVO user = ms.getGoogleUser(vo);
		model.addAttribute("user", user);
		model.addAttribute("session", session);
		model.addAttribute("google_user", google_user);
		model.addAttribute("list", ms.getList(user.getUser_id()));
		return "/main";
	}
	@RequestMapping(value="/google_Login", method=RequestMethod.GET)
	public String google_Login2()throws Exception{
		return "/google_login";
	}
	//로그인 실패
	@RequestMapping("/loginFail")
	public String loginFail(Model model)throws Exception{
		System.out.println("로그아웃 실패");
		model.addAttribute("logoutFail", "true");
		return "/main";
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
		System.out.println("logout");
		session = false;
		google_user = "false";
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/";
	}
}
