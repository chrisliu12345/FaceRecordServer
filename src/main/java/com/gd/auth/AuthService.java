package com.gd.auth;



import java.text.ParseException;

public interface AuthService {
//    User register(User userToAdd);
    String login(String username, String password);
    String refresh(String oldToken) throws ParseException;
}
