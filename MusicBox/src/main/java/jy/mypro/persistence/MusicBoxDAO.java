package jy.mypro.persistence;

import jy.mypro.domain.MusicUserVO;

public interface MusicBoxDAO {
	public void signInUser(MusicUserVO vo)throws Exception;
	public MusicUserVO loginUser(MusicUserVO vo)throws Exception;
}
