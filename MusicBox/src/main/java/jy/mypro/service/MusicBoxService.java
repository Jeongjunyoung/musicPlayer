package jy.mypro.service;

import java.util.List;

import jy.mypro.domain.MusicPlayList;
import jy.mypro.domain.MusicUserVO;

public interface MusicBoxService {
	public void insertUser(MusicUserVO vo)throws Exception;
	public MusicUserVO login_check(MusicUserVO vo)throws Exception;
	public List<MusicPlayList> getList(String user_id)throws Exception;
	public void insertMusic(MusicPlayList mpl)throws Exception;
	public List<MusicPlayList> getMusic_id(String user_id)throws Exception;
}
