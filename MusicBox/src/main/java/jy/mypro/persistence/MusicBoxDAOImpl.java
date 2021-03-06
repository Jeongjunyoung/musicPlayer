package jy.mypro.persistence;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import jy.mypro.domain.MusicPlayList;
import jy.mypro.domain.MusicUserVO;
import jy.mypro.domain.TabMusicVO;
import jy.mypro.domain.Top100VO;
import jy.mypro.domain.UserTabs;

@Repository
public class MusicBoxDAOImpl implements MusicBoxDAO {
	
	@Inject
	private SqlSession sqlSession;	
	private static String namespace = "jy.mypro.mapper.musicBox";
	@Override
	public void signInUser(MusicUserVO vo) throws Exception {
		sqlSession.insert(namespace+".sign_in",vo);
	}
	@Override
	public MusicUserVO loginUser(MusicUserVO vo) throws Exception {
		return sqlSession.selectOne(namespace+".login_user", vo);
	}
	@Override
	public List<MusicPlayList> getPlayList(String user_id) throws Exception {
		return sqlSession.selectList(namespace+".playList", user_id);
	}
	@Override
	public void addMusic(MusicPlayList mpl) throws Exception {
		sqlSession.insert(namespace+".add_Music",mpl);
	}
	@Override
	public List<MusicPlayList> getUserList(String user_id) throws Exception {
		return sqlSession.selectList(namespace+".getUserList", user_id);
	}
	@Override
	public String getMaxIndex(String user_id) throws Exception {
		return sqlSession.selectOne(namespace+".maxIndex", user_id);
	}
	@Override
	public List<MusicPlayList> getAddList(String user_id) throws Exception {
		return sqlSession.selectList(namespace+".getAddList", user_id);
	}
	@Override
	public MusicUserVO getGoogleUser(MusicUserVO vo) throws Exception {
		return sqlSession.selectOne(namespace+".google_user", vo);
	}
	@Override
	public void delMusic(Map<String, String> map) throws Exception {
		sqlSession.delete(namespace+".delMusic", map);
	}
	@Override
	public List<UserTabs> selectTabs(String user_id) throws Exception {
		return sqlSession.selectList(namespace+".selectUserTabs", user_id);
	}
	@Override
	public Integer getMaxTabId(String user_id) throws Exception {
		return sqlSession.selectOne(namespace+".maxTabId", user_id);
	}
	@Override
	public void addTabs(UserTabs tabs) throws Exception {
		sqlSession.insert(namespace+".add_Tab", tabs);
	}
	@Override
	public MusicPlayList getMusicInfo(MusicPlayList vo) throws Exception {
		return sqlSession.selectOne(namespace+".getMusicInfo", vo);
	}
	@Override
	public void insertTabMusic(TabMusicVO tvo) throws Exception {
		sqlSession.insert(namespace+".addTabMusic", tvo);
	}
	@Override
	public List<TabMusicVO> getTabsMusic(String user_id) throws Exception {
		return sqlSession.selectList(namespace+".tabsMusic", user_id);
	}
	@Override
	public void deleteTab(String tab_id) throws Exception {
		sqlSession.delete(namespace+".delTab", tab_id);
	}
	@Override
	public void deleteTabMusic(String tab_id) throws Exception {
		sqlSession.delete(namespace+".delTabMusic", tab_id);
	}
	@Override
	public List<Top100VO> getTop100List() throws Exception {
		return sqlSession.selectList(namespace+".get_Top100List");
	}
	@Override
	public void del_selectMusic(Map<String, String> map) throws Exception {
		sqlSession.delete(namespace+".del_SelectMusic", map);
	}
	@Override
	public Top100VO getTop100MusicInfo(String music_id) throws Exception {
		return sqlSession.selectOne(namespace+".getTop100MusicInfo", music_id);
	}
}
