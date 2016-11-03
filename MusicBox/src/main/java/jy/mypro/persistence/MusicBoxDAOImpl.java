package jy.mypro.persistence;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import jy.mypro.domain.MusicPlayList;
import jy.mypro.domain.MusicUserVO;

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
}
