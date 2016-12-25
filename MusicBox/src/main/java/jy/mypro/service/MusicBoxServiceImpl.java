package jy.mypro.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import jy.mypro.domain.MusicPlayList;
import jy.mypro.domain.MusicUserVO;
import jy.mypro.domain.TabMusicVO;
import jy.mypro.domain.Top100VO;
import jy.mypro.domain.UserTabs;
import jy.mypro.persistence.MusicBoxDAO;

@Service
public class MusicBoxServiceImpl implements MusicBoxService {

	@Inject
	MusicBoxDAO dao;
	
	@Override
	public void insertUser(MusicUserVO vo) throws Exception {
		dao.signInUser(vo);
	}
	@Override
	public MusicUserVO login_check(MusicUserVO vo) throws Exception {
		return dao.loginUser(vo);
	}
	@Override
	public List<MusicPlayList> getList(String user_id) throws Exception {
		return dao.getPlayList(user_id);
	}
	@Override
	public void insertMusic(MusicPlayList mpl) throws Exception {
		String user = mpl.getUser_id();
		String maxIndex = dao.getMaxIndex(user);
		String music_index = "";
		if(maxIndex == null){
			music_index = user+"_1";
		}else{
			int index = Integer.parseInt(maxIndex)+1;
			music_index = user+"_"+index;
		}
		mpl.setMusic_index(music_index);
		dao.addMusic(mpl);
	}
	@Override
	public List<MusicPlayList> getMusic_id(String user_id) throws Exception {
		return dao.getUserList(user_id);
	}
	@Override
	public List<MusicPlayList> getAddList(String user_id) throws Exception {
		return dao.getAddList(user_id);
	}
	@Override
	public MusicUserVO getGoogleUser(MusicUserVO vo) throws Exception {
		return dao.getGoogleUser(vo);
	}
	@Override
	public void removeMusic(Map<String, String> map) throws Exception {
		dao.delMusic(map);
	}
	@Override
	public List<UserTabs> getUserTabs(String user_id) throws Exception {
		return dao.selectTabs(user_id);
	}
	@Override
	public Integer getMaxTabId(String user_id) throws Exception {
		int get_maxTabid = 0;
		try {
			get_maxTabid = dao.getMaxTabId(user_id);
		} catch (Exception e) {}
		return get_maxTabid;
	}
	@Override
	public void insertTabs(UserTabs tabs) throws Exception {
		dao.addTabs(tabs);
	}
	@Override
	public MusicPlayList getMusicInfo(MusicPlayList vo) throws Exception {
		return dao.getMusicInfo(vo);
	}
	@Override
	public void insertTabMusic(TabMusicVO tvo) throws Exception {
		dao.insertTabMusic(tvo);
	}
	@Override
	public List<TabMusicVO> getTabsMusic(String user_id) throws Exception {
		return dao.getTabsMusic(user_id);
	}
	@Override
	public void removeTab(String tab_id) throws Exception {
		dao.deleteTabMusic(tab_id);
		dao.deleteTab(tab_id);
	}
	@Override
	public List<Top100VO> getTop100List() throws Exception {
		return dao.getTop100List();
	}
}
