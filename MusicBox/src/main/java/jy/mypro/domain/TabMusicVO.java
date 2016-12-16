package jy.mypro.domain;

public class TabMusicVO {
	private String tab_id;
	private String tabs_music_id;
	private String tabs_music_name;
	private String user_id;
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getTab_id() {
		return tab_id;
	}
	public void setTab_id(String tab_id) {
		this.tab_id = tab_id;
	}
	public String getTabs_music_id() {
		return tabs_music_id;
	}
	public void setTabs_music_id(String tabs_music_id) {
		this.tabs_music_id = tabs_music_id;
	}
	public String getTabs_music_name() {
		return tabs_music_name;
	}
	public void setTabs_music_name(String tabs_music_name) {
		this.tabs_music_name = tabs_music_name;
	}
}
