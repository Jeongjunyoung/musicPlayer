package jy.mypro.persistence;

import java.util.List;
import java.util.Map;

import jy.mypro.domain.MusicPlayList;
import jy.mypro.domain.MusicUserVO;
import jy.mypro.domain.TabMusicVO;
import jy.mypro.domain.Top100VO;
import jy.mypro.domain.UserTabs;

public interface MusicBoxDAO {
	public void signInUser(MusicUserVO vo)throws Exception;
	public MusicUserVO loginUser(MusicUserVO vo)throws Exception;
	public List<MusicPlayList> getPlayList(String user_id)throws Exception;
	public void addMusic(MusicPlayList mpl)throws Exception;
	public List<MusicPlayList> getUserList(String user_id)throws Exception;
	public String getMaxIndex(String user_id)throws Exception;
	public List<MusicPlayList> getAddList(String user_id)throws Exception;
	public MusicUserVO getGoogleUser(MusicUserVO vo)throws Exception;
	public void delMusic(Map<String, String> map)throws Exception;
	public List<UserTabs> selectTabs(String user_id)throws Exception;
	public Integer getMaxTabId(String user_id)throws Exception;
	public void addTabs(UserTabs tabs)throws Exception;
	public MusicPlayList getMusicInfo(MusicPlayList vo)throws Exception;
	public Top100VO getTop100MusicInfo(String music_id)throws Exception;
	public void insertTabMusic(TabMusicVO tvo)throws Exception;
	public List<TabMusicVO> getTabsMusic(String user_id)throws Exception;
	public void deleteTab(String tab_id)throws Exception;
	public void deleteTabMusic(String tab_id)throws Exception;
	public List<Top100VO> getTop100List()throws Exception;
	public void del_selectMusic(Map<String, String> map)throws Exception;
}
