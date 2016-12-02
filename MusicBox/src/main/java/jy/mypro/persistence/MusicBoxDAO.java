package jy.mypro.persistence;

import java.util.List;

import jy.mypro.domain.MusicPlayList;
import jy.mypro.domain.MusicUserVO;

public interface MusicBoxDAO {
	public void signInUser(MusicUserVO vo)throws Exception;
	public MusicUserVO loginUser(MusicUserVO vo)throws Exception;
	public List<MusicPlayList> getPlayList(String user_id)throws Exception;
	public void addMusic(MusicPlayList mpl)throws Exception;
	public List<MusicPlayList> getUserList(String user_id)throws Exception;
	public String getMaxIndex(String user_id)throws Exception;
	public List<MusicPlayList> getAddList(String user_id)throws Exception;
	public MusicUserVO getGoogleUser(MusicUserVO vo)throws Exception;
}
