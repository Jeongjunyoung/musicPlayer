package jy.mypro.domain;

public class MusicPlayList {
	private String user_id;
	private String music_id;
	private String music_name;
	private String music_index;
	public String getMusic_index() {
		return music_index;
	}
	public void setMusic_index(String music_index) {
		this.music_index = music_index;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getMusic_id() {
		return music_id;
	}
	public void setMusic_id(String music_id) {
		this.music_id = music_id;
	}
	public String getMusic_name() {
		return music_name;
	}
	public void setMusic_name(String music_name) {
		this.music_name = music_name;
	}
}
