package jy.mypro.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import jy.mypro.domain.MusicPlayList;
import jy.mypro.domain.MusicUserVO;
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

}
