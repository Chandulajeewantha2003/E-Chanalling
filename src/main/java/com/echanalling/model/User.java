package com.echanalling.model;

public class User {
    private int id;
    private String name;
    private String email;
    private String password;
    private String role;
    private String specialization;

    
    // ✅ No-arg constructor
    public User() {
    }
       
    // Constructor
    public User(int id, String name, String email, String password, String role) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.role = role;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    
    public String getSpecialization() { return specialization; } // ➕
    public void setSpecialization(String specialization) { this.specialization = specialization; }
    
}
