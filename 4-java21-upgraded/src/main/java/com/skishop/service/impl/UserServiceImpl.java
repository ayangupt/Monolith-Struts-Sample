package com.skishop.service.impl;

import com.skishop.model.entity.User;
import com.skishop.repository.UserRepository;
import com.skishop.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;
import java.util.UUID;

@Service
@Transactional
public class UserServiceImpl implements UserService {

    private static final Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public UserServiceImpl(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<User> findById(String id) {
        return userRepository.findById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<User> findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    @Override
    public User register(String email, String username, String password) {
        logger.info("Registering new user with email: {}", email);

        if (userRepository.existsByEmail(email)) {
            throw new IllegalArgumentException("Email already registered");
        }

        User user = new User();
        user.setId(UUID.randomUUID().toString());
        user.setEmail(email);
        user.setUsername(username);
        user.setPasswordHash(passwordEncoder.encode(password));
        user.setSalt(""); // Not needed when using BCrypt
        user.setStatus("ACTIVE");
        user.setRole("USER");

        return userRepository.save(user);
    }

    @Override
    public boolean updatePassword(String userId, String oldPassword, String newPassword) {
        Optional<User> userOpt = userRepository.findById(userId);
        if (userOpt.isEmpty()) {
            return false;
        }

        User user = userOpt.get();
        if (!passwordEncoder.matches(oldPassword, user.getPasswordHash())) {
            return false;
        }

        user.setPasswordHash(passwordEncoder.encode(newPassword));
        userRepository.save(user);
        logger.info("Password updated for user: {}", userId);
        return true;
    }

    @Override
    public void lockUser(String userId) {
        userRepository.findById(userId).ifPresent(user -> {
            user.setStatus("LOCKED");
            userRepository.save(user);
            logger.info("User locked: {}", userId);
        });
    }

    @Override
    public void unlockUser(String userId) {
        userRepository.findById(userId).ifPresent(user -> {
            user.setStatus("ACTIVE");
            userRepository.save(user);
            logger.info("User unlocked: {}", userId);
        });
    }
}
