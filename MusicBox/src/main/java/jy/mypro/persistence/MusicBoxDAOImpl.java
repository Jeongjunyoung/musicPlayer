package jy.mypro.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class MusicBoxDAOImpl implements MusicBoxDAO {
	
	@Inject
	private SqlSession sqlSession;	
	private static String namespace = "jy.mypro.mapper.musicBox";
	
	
	
}
