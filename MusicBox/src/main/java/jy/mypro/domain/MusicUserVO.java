package jy.mypro.domain;

import java.io.Serializable;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Set;
import java.util.SortedSet;
import java.util.TreeSet;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.SpringSecurityCoreVersion;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.util.Assert;

public class MusicUserVO implements UserDetails{
	private String user_id;
	private String user_pw;
	private String user_email;
	private Set<GrantedAuthority> authorities;
	
	public MusicUserVO(){}
	
	public MusicUserVO(String user_id, String user_pw, String user_email, Collection<? extends GrantedAuthority> authorities) {
		super();
		this.user_id = user_id;
		this.user_pw = user_pw;
		this.user_email = user_email;
		this.authorities = Collections.unmodifiableSortedSet(sortAuthorities(authorities));
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pw() {
		return user_pw;
	}
	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public void setAuthorities(Collection<? extends GrantedAuthority> authorities){
		this.authorities = Collections.unmodifiableSet(sortAuthorities(authorities));
	}
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return authorities;
	}
	
	private static SortedSet<GrantedAuthority> sortAuthorities(Collection<? extends GrantedAuthority> authorities){
		Assert.notNull(authorities, "Cannot pass a null GrantedAuthority collection");
		
		SortedSet<GrantedAuthority> sortedAuthorities = new TreeSet<GrantedAuthority>(new AuthorityComparator());
		
		for(GrantedAuthority grantedAuthority : authorities){
			Assert.notNull(grantedAuthority, "GrantedAuthority list cannot contain any null elements");
			
			sortedAuthorities.add(grantedAuthority);
		}
		
		return sortedAuthorities;
	}
	@Override
	public String getPassword() {
		return user_pw;
	}
	@Override
	public String getUsername() {
		return getUser_id();
	}
	@Override
	public boolean isAccountNonExpired() {
		return true;
	}
	@Override
	public boolean isAccountNonLocked() {
		return true;
	}
	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}
	@Override
	public boolean isEnabled() {
		return true;
	}
}
class AuthorityComparator implements Comparator<GrantedAuthority>, Serializable{
	private static final long serialVersionUID = SpringSecurityCoreVersion.SERIAL_VERSION_UID;
	
	public int compare(GrantedAuthority g1, GrantedAuthority g2){
		if(g2.getAuthority() == null){
			return -1;
		}
		
		if(g1.getAuthority() == null){
			return 1;
		}
		
		return g1.getAuthority().compareTo(g2.getAuthority());
	}
}

