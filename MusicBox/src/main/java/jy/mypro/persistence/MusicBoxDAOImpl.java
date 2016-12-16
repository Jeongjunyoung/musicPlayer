package jy.mypro.persistence;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import jy.mypro.domain.MusicPlayList;
import jy.mypro.domain.MusicUserVO;
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
}
