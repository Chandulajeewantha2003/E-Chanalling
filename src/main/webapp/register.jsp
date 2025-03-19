<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Register Page</title>
    <!-- Bootstrap CSS -->

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome for Social Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        .divider:after,
        .divider:before {
            content: "";
            flex: 1;
            height: 1px;
            background: #eee;
        }

        .h-custom {
            height: calc(100% - 73px);
        }

        @media (max-width: 450px) {
            .h-custom {
                height: 100%;
            }
        }
    </style>
</head>

<body>
    <section class="vh-100">
        <div class="container-fluid h-custom">
            <div class="row d-flex justify-content-center align-items-center h-100">
                <div class="col-md-9 col-lg-6 col-xl-5">
                    <!-- Updated img tag with the correct src attribute for displaying image -->
                   
                    <img src="img/bg-img/doctor.png" class="img-fluid" alt="Doctor Image">
                    
                </div>
                <div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1">
                    <form action="RegisterServlet" method="post">
                        <h3 class="mb-4">Create an Account</h3>

                        <!-- Full Name -->
                        <div class="form-outline mb-3">
                            <input type="text" name="name" class="form-control form-control-lg" placeholder="Enter your full name" required />
                            <label class="form-label" for="fullname">Full Name</label>
                        </div>

                        <!-- Email input -->
                        <div class="form-outline mb-3">
                            <input type="email" name="email" class="form-control form-control-lg" placeholder="Enter a valid email address" required />
                            <label class="form-label" for="email">Email address</label>
                        </div>

                        <!-- Password input -->
                        <div class="form-outline mb-3">
                            <input type="password" name="password" class="form-control form-control-lg" placeholder="Enter password" required />
                            <label class="form-label" for="password">Password</label>
                        </div>

                        <!-- Role -->
                        <div class="form-outline mb-3">
                            <label class="form-label" for="role">Role</label>
                            <select name="role" class="form-select form-select-lg" required>
                                <option value="patient">Patient</option>
                                <option value="doctor">Doctor</option>
                            </select>
                        </div>

                        <!-- Submit button -->
                        <div class="text-center text-lg-start mt-4 pt-2">
                            <button type="submit" class="btn btn-primary btn-lg" style="padding-left: 2.5rem; padding-right: 2.5rem;">Register</button>
                            <p class="small fw-bold mt-2 pt-1 mb-0">Already have an account? <a href="login.jsp" class="link-danger">Login</a></p>
                        </div>

                    </form>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <div class="d-flex flex-column flex-md-row text-center text-md-start justify-content-between py-4 px-4 px-xl-5 bg-primary">
            <div class="text-white mb-3 mb-md-0">
                Copyright © 2025. All rights reserved.
            </div>
            <div>
                <a href="#" class="text-white me-4"><i class="fab fa-facebook-f"></i></a>
                <a href="#" class="text-white me-4"><i class="fab fa-twitter"></i></a>
                <a href="#" class="text-white me-4"><i class="fab fa-google"></i></a>
                <a href="#" class="text-white"><i class="fab fa-linkedin-in"></i></a>
            </div>
        </div>
    </section>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
