package jy.mypro.service;

import java.util.List;
import java.util.Map;

import jy.mypro.domain.MusicPlayList;
import jy.mypro.domain.MusicUserVO;
import jy.mypro.domain.UserTabs;

public interface MusicBoxService {
	public void insertUser(MusicUserVO vo)throws Exception;
	public MusicUserVO login_check(MusicUserVO vo)throws Exception;
	public List<MusicPlayList> getList(String user_id)throws Exception;
	public void insertMusic(MusicPlayList mpl)throws Exception;
	public List<MusicPlayList> getMusic_id(String user_id)throws Exception;
	public List<MusicPlayList> getAddList(String user_id)throws Exception;
	public MusicUserVO getGoogleUser(MusicUserVO vo)throws Exception;
	public void removeMusic(Map<String, String> map)throws Exception;
	public List<UserTabs> getUserTabs(String user_id)throws Exception;
	public Integer getMaxTabId(String user_id)throws Exception;
	public void insertTabs(UserTabs tabs)throws Exception;
	public MusicPlayList getMusicInfo(MusicPlayList vo)throws Exception;
}
