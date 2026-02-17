package com.skishop.service;

import com.skishop.model.entity.User;

import java.util.Optional;

public interface UserService {

    Optional<User> findById(String id);

    Optional<User> findByEmail(String email);

    User register(String email, String username, String password);

    boolean updatePassword(String userId, String oldPassword, String newPassword);

    void lockUser(String userId);

    void unlockUser(String userId);
}
