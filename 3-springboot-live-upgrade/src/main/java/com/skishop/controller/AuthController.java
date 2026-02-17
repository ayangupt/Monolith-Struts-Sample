package com.skishop.controller;

import com.skishop.dto.RegisterRequest;
import com.skishop.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;

@Controller
public class AuthController {

    private static final Logger logger = LoggerFactory.getLogger(AuthController.class);

    private final UserService userService;

    public AuthController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/login")
    public String loginPage() {
        return "auth/login";
    }

    @GetMapping("/register")
    public String registerPage(Model model) {
        model.addAttribute("registerRequest", new RegisterRequest());
        return "auth/register";
    }

    @PostMapping("/register")
    public String register(@Valid @ModelAttribute("registerRequest") RegisterRequest request,
                          BindingResult bindingResult,
                          RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            return "auth/register";
        }

        if (!request.isPasswordMatching()) {
            bindingResult.rejectValue("confirmPassword", "error.confirmPassword", "Passwords do not match");
            return "auth/register";
        }

        try {
            userService.register(request.getEmail(), request.getUsername(), request.getPassword());
            redirectAttributes.addFlashAttribute("successMessage", "Registration successful. Please login.");
            return "redirect:/login";
        } catch (IllegalArgumentException e) {
            bindingResult.rejectValue("email", "error.email", e.getMessage());
            return "auth/register";
        }
    }

    @GetMapping("/password/forgot")
    public String forgotPasswordPage() {
        return "auth/forgot-password";
    }

    @PostMapping("/password/forgot")
    public String forgotPassword(String email, RedirectAttributes redirectAttributes) {
        // TODO: Implement password reset email
        redirectAttributes.addFlashAttribute("message", "If the email exists, a reset link has been sent.");
        return "redirect:/login";
    }
}
