package jy.mypro.controller;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jy.mypro.domain.MusicPlayList;
import jy.mypro.domain.MusicUserVO;
import jy.mypro.domain.TabMusicVO;
import jy.mypro.domain.Top100VO;
import jy.mypro.domain.UserTabs;
import jy.mypro.service.MusicBoxService;

@Controller
public class MusicBoxController {
	@Inject
	MusicBoxService ms;
	public static boolean Social_session = false;
	public static String google_user = "false";
	@Inject
	BCryptPasswordEncoder encoder;
	//Main 폼
	@RequestMapping("/")
	public String musicBox_Main(Model model)throws Exception{
		model.addAttribute("logoutFail", "none");
		//model.addAttribute("session", Social_session);
		model.addAttribute("top100", ms.getTop100List());
		return "/newHome";
	}
	//구글 인증
	@RequestMapping("/googlee3b57ab611071f86.html")
	public String google_auth()throws Exception{
		return "/googlee3b57ab611071f86";
	}
	//회원가입 폼
	@RequestMapping(value="/sign_in", method=RequestMethod.POST)
	public String signIn_user(MusicUserVO vo)throws Exception{
		UserTabs tabs = new UserTabs();
		String bCryptString = encoder.encode(vo.getUser_pw());
		vo.setUser_pw(bCryptString);
		ms.insertUser(vo);
		return "redirect:/";
	}
	//구글 로그인
	@RequestMapping(value="/googleLogin", method=RequestMethod.POST)
	@ResponseBody
	public MusicUserVO google_Login(MusicUserVO vo, Model model, HttpServletRequest request)throws Exception{
		HttpSession session = request.getSession();
		System.out.println(vo.getUser_email());
		String email = vo.getUser_email();
		//String de_str = URLDecoder.decode(arr[1],"UTF-8");
		String user_name = email.substring(0, email.indexOf("@"));
		vo.setUser_id(user_name);
		MusicUserVO check = ms.getGoogleUser(vo);
		if(check == null){
			ms.insertUser(vo);
		}
		MusicUserVO user = ms.getGoogleUser(vo);
		session.setAttribute("googleUser", user);
		return user;
	}
	//구글 로그인 셋팅
	@RequestMapping(value="/googleSet", method=RequestMethod.GET)
	public String googleSet(Model model, HttpServletRequest request)throws Exception{
		Social_session = true;
		google_user = "trueS";
		System.out.println("google setting");
		HttpSession session = request.getSession();
		MusicUserVO user = (MusicUserVO) session.getAttribute("googleUser");
		System.out.println(user.getUser_email());
		model.addAttribute("user", user);
		model.addAttribute("session", Social_session);
		model.addAttribute("google_user", google_user);
		model.addAttribute("top100", ms.getTop100List());
		model.addAttribute("list", ms.getList(user.getUser_id()));
		request.setAttribute("tabs", ms.getUserTabs(user.getUser_id()));
		request.setAttribute("tabMusic", ms.getTabsMusic(user.getUser_id()));
		return "/main";
	}
	@RequestMapping(value="/google_Login", method=RequestMethod.GET)
	public String google_Login2()throws Exception{
		return "/google_login";
	}
	//로그인 실패
	@RequestMapping("/loginFail")
	public String loginFail(Model model)throws Exception{
		model.addAttribute("loginFail", "true");
		return "/newHome";
	}
	//음악 추가
	@RequestMapping(value="/addPlayList", method=RequestMethod.GET)
	@ResponseBody
	public List<MusicPlayList> addPlayList(@RequestParam("music_id") String music_id, 
								@RequestParam("music_name") String music_name, 
										HttpServletRequest request)throws Exception{
		Social_session = true;
		HttpSession session = request.getSession();
		MusicUserVO user_id;
		if((MusicUserVO) session.getAttribute("googleUser") == null){
			user_id = (MusicUserVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		}else{
			user_id = (MusicUserVO) session.getAttribute("googleUser");
		}
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
	//로그아웃
	@RequestMapping("/logout")
	public String logout_user(HttpServletRequest request)throws Exception{
		Social_session = false;
		google_user = "false";
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/";
	}
	//TEST
	@RequestMapping("/testPage")
	public String test()throws Exception{
		return "testPage";
	}
	//New Home
	@RequestMapping("/nh")
	public String newHome()throws Exception{
		return "newHome";
	}
	//음악 삭제
	@RequestMapping("/delPlayList")
	@ResponseBody
	public List<MusicPlayList> del_Music(@RequestParam("editArr") String[] editArr,
			@RequestParam("tab") String tab,
			HttpServletRequest request, Model model)throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		HttpSession session = request.getSession();
		MusicUserVO user;
		if((MusicUserVO) session.getAttribute("googleUser") == null){
			user = (MusicUserVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		}else{
			user = (MusicUserVO) session.getAttribute("googleUser");
		}
		String user_id = user.getUser_id();
		if(tab.equals("myList")){
			for(int i=0;i<editArr.length;i++){
				map.put("user_id", user_id);
				map.put("music_id", editArr[i]);
				ms.removeMusic(map);
			}
		}else{
			for(int i=0;i<editArr.length;i++){
				map.put("user_id", user_id);
				map.put("music_id", editArr[i]);
				ms.removeSelectTabsMusic(map);
			}
		}
		/*model.addAttribute("user", user);
		model.addAttribute("session", Social_session);
		model.addAttribute("google_user", google_user);
		model.addAttribute("list", ms.getList(user.getUser_id()));*/
		return ms.getList(user_id);
	}
	//탭 추가
	@RequestMapping("/addTabs")
	@ResponseBody
	public UserTabs add_tabs(@RequestParam("tab_name") String tab_name, HttpServletRequest request)throws Exception{
		HttpSession session = request.getSession();
		UserTabs tabs = new UserTabs();
		String tab_DeName = URLDecoder.decode(tab_name, "UTF-8");
		MusicUserVO user;
		if((MusicUserVO) session.getAttribute("googleUser") == null){
			user = (MusicUserVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		}else{
			user = (MusicUserVO) session.getAttribute("googleUser");
		}
		String user_id = user.getUser_id();
		int get_tab_id = ms.getMaxTabId(user_id);
		int tab_id_num = get_tab_id+1;
		String str_num = Integer.toString(tab_id_num);
		String tab_id = user_id+"tab_"+str_num;
		tabs.setTab_id(tab_id);
		tabs.setUser_id(user_id);
		tabs.setTab_name(tab_DeName);
		ms.insertTabs(tabs);
		return tabs;
	}
	@RequestMapping("/addTabMusic")
	@ResponseBody
	public List<TabMusicVO> add_TabMusic(@RequestParam("arr") String[] arr, 
			@RequestParam("arr_top") String[] arr_top, 
			@RequestParam("tab_id") String tab_id, 
			HttpServletRequest request)throws Exception{
		HttpSession session = request.getSession();
		MusicUserVO user;
		MusicPlayList mpl = new MusicPlayList();
		List<TabMusicVO> list = new ArrayList<TabMusicVO>();
		if((MusicUserVO) session.getAttribute("googleUser") == null){
			user = (MusicUserVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		}else{
			user = (MusicUserVO) session.getAttribute("googleUser");
		}
		mpl.setUser_id(user.getUser_id());
		if(arr != null){
			for(int i=0;i<arr.length;i++){
				mpl.setMusic_id(arr[i]);
				MusicPlayList tabMusic = ms.getMusicInfo(mpl);
				TabMusicVO tvo = new TabMusicVO();
				tvo.setTab_id(tab_id);
				tvo.setTabs_music_id(tabMusic.getMusic_id());
				tvo.setTabs_music_name(tabMusic.getMusic_name());
				tvo.setUser_id(user.getUser_id());
				ms.insertTabMusic(tvo);
				list.add(tvo);
			}
		}
		if(arr_top != null){
			for(int i=0;i<arr_top.length;i++){
				Top100VO vo = ms.getTop100MusicInfo(arr_top[i]);
				TabMusicVO tvo = new TabMusicVO();
				tvo.setTab_id(tab_id);
				tvo.setTabs_music_id(vo.getMusic_id());
				tvo.setTabs_music_name(vo.getMusic_name());
				tvo.setUser_id(user.getUser_id());
				ms.insertTabMusic(tvo);
				list.add(tvo);
			}
		}
		return list;
	}
	@RequestMapping("/deleteTab")
	@ResponseBody
	public String removeTab(@RequestParam("tab_id") String tab_id)throws Exception{
		ms.removeTab(tab_id);
		return "success";
	}
}