package jy.mypro.service;

import jy.mypro.domain.MusicUserVO;

public interface MusicBoxService {
	public void insertUser(MusicUserVO vo)throws Exception;
	public MusicUserVO login_check(MusicUserVO vo)throws Exception;
}
