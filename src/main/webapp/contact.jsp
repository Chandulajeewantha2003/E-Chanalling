<%@ page import="java.sql.*, online.echanneling.DBConnection" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

 <!-- ***** Header Area Start ***** -->
<%@ include file="partials/header.jsp" %>

<%
    String userName = (String) session.getAttribute("userName");
    String userEmail = (String) session.getAttribute("userEmail");
%>
 


    <!-- ***** Breadcumb Area Start ***** -->
    <section class="breadcumb-area bg-img gradient-background-overlay" style="background-image: url(img/bg-img/breadcumb3.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="breadcumb-content">
                        <h3 class="breadcumb-title">Contact</h3>
                        <p>Lorem ipsum dolor sit amet, consectetuer</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ***** Breadcumb Area End ***** -->

    <section class="medilife-contact-area section-padding-100">
        <div class="container">
            <div class="row">
                <!-- Contact Form Area -->
                <div class="col-12 col-lg-8">
                    <div class="contact-form">
                        <h5 class="mb-50">Get in touch</h5>

                        <form action="#" method="post">
                            <div class="form-group">
							    <input type="text" class="form-control" id="contact-name" placeholder="Name"
							           value="<%= userName != null ? userName : "" %>" readonly>
							</div>
							<div class="form-group">
							    <input type="email" class="form-control" id="contact-email" placeholder="Email"
							           value="<%= userEmail != null ? userEmail : "" %>" readonly>
							</div>

                            <div class="form-group">
                                <textarea class="form-control" name="message" id="message" cols="30" rows="10" placeholder="Message"></textarea>
                            </div>
                            <button type="submit" class="btn medilife-btn">Send Message <span>+</span></button>
                        </form>
                    </div>
                </div>
                
                

                <div class="col-12 col-lg-4">
                    <div class="content-sidebar">


                        <!-- Contact Card -->
                        <div class="medilife-contact-card mb-50">

                            <div class="single-contact d-flex align-items-center">
                                <div class="contact-icon mr-30">
                                    <i class="icon-doctor"></i>
                                </div>
                                <div class="contact-meta">
                                    <p>Address: 1481 Creekside Lane Avila <br>Beach, CA 93424 </p>
                                </div>
                            </div>

                            <div class="single-contact d-flex align-items-center">
                                <div class="contact-icon mr-30">
                                    <i class="icon-doctor"></i>
                                </div>
                                <div class="contact-meta">
                                    <p>Phone: +53 345 7953 32453</p>
                                </div>
                            </div>

                            <div class="single-contact d-flex align-items-center">
                                <div class="contact-icon mr-30">
                                    <i class="icon-doctor"></i>
                                </div>
                                <div class="contact-meta">
                                    <p>Email: yourmail@gmail.com</p>
                                </div>
                            </div>


                            <div class="contact-social-area">
                                <a href="#"><i class="fa fa-google-plus"></i></a>
                                <a href="#"><i class="fa fa-pinterest"></i></a>
                                <a href="#"><i class="fa fa-facebook"></i></a>
                                <a href="#"><i class="fa fa-twitter"></i></a>
                            </div>

                        </div>
                        

                        <!-- medilife Emergency Card -->
                        <div class="medilife-emergency-card bg-img bg-overlay" style="background-image: url(img/bg-img/about1.jpg);">
                            <i class="icon-smartphone"></i>
                            <h2>For Emergency calls</h2>
                            <h3>+12-823-611-8721</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Google Maps -->
    <div class="map-area mb-100">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div id="googleMap" class="googleMap"></div>
                </div>
            </div>
        </div>
    </div>

    <!-- ***** Footer Area Start ***** -->
    <footer class="footer-area section-padding-100">
        <!-- Main Footer Area -->
        <div class="main-footer-area">
            <div class="container-fluid">
                <div class="row">

                    <div class="col-12 col-sm-6 col-xl-3">
                        <div class="footer-widget-area">
                            <div class="footer-logo">
                                <img src="img/core-img/logo.png" alt="">
                            </div>
                            <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Lorem ipsum dolor sit amet, consectetuer.</p>
                            <div class="footer-social-info">
                                <a href="#"><i class="fa fa-google-plus" aria-hidden="true"></i></a>
                                <a href="#"><i class="fa fa-pinterest" aria-hidden="true"></i></a>
                                <a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a>
                                <a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a>
                            </div>
                        </div>
                    </div>

                    <div class="col-12 col-sm-6 col-xl-3">
                        <div class="footer-widget-area">
                            <div class="widget-title">
                                <h6>Latest News</h6>
                            </div>
                            <div class="widget-blog-post">
                                <!-- Single Blog Post -->
                                <div class="widget-single-blog-post d-flex">
                                    <div class="widget-post-thumbnail">
                                        <img src="img/blog-img/ln1.jpg" alt="">
                                    </div>
                                    <div class="widget-post-content">
                                        <a href="#">Better Health Care</a>
                                        <p>Dec 02, 2017</p>
                                    </div>
                                </div>
                                <!-- Single Blog Post -->
                                <div class="widget-single-blog-post d-flex">
                                    <div class="widget-post-thumbnail">
                                        <img src="img/blog-img/ln2.jpg" alt="">
                                    </div>
                                    <div class="widget-post-content">
                                        <a href="#">A new drug is tested</a>
                                        <p>Dec 02, 2017</p>
                                    </div>
                                </div>
                                <!-- Single Blog Post -->
                                <div class="widget-single-blog-post d-flex">
                                    <div class="widget-post-thumbnail">
                                        <img src="img/blog-img/ln3.jpg" alt="">
                                    </div>
                                    <div class="widget-post-content">
                                        <a href="#">Health department advice</a>
                                        <p>Dec 02, 2017</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-12 col-sm-6 col-xl-3">
                        <div class="footer-widget-area">
                            <div class="widget-title">
                                <h6>Contact Form</h6>
                            </div>
                            <div class="footer-contact-form">
                                <form action="#" method="post">
                                    <input type="text" class="form-control border-top-0 border-right-0 border-left-0" name="footer-name" id="footer-name" placeholder="Name">
                                    <input type="email" class="form-control border-top-0 border-right-0 border-left-0" name="footer-email" id="footer-email" placeholder="Email">
                                    <textarea name="message" class="form-control border-top-0 border-right-0 border-left-0" id="footerMessage" placeholder="Message"></textarea>
                                    <button type="submit" class="btn medilife-btn">Contact Us <span>+</span></button>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="col-12 col-sm-6 col-xl-3">
                        <div class="footer-widget-area">
                            <div class="widget-title">
                                <h6>News Letter</h6>
                            </div>

                            <div class="footer-newsletter-area">
                                <form action="#">
                                    <input type="email" class="form-control border-0 mb-0" name="newsletterEmail" id="newsletterEmail" placeholder="Your Email Here">
                                    <button type="submit">Subscribe</button>
                                </form>
                                <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Lorem ipsum dolor sit amet, consectetuer.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Bottom Footer Area -->
        <div class="bottom-footer-area">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <div class="bottom-footer-content">
                            <!-- Copywrite Text -->
                            <div class="copywrite-text">
                                <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
</p>
<p>Re-distributed by <a href="https://themewagon.com/" target="_blank">Themewagon</a>
</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <!-- ***** Footer Area End ***** -->

    <!-- jQuery (Necessary for All JavaScript Plugins) -->
    <script src="js/jquery/jquery-2.2.4.min.js"></script>
    <!-- Popper js -->
    <script src="js/popper.min.js"></script>
    <!-- Bootstrap js -->-
    <script src="js/bootstrap.min.js"></script>
    <!-- Plugins js -->
    <script src="js/plugins.js"></script>
    <!-- Active js -->
    <script src="js/active.js"></script>
    <!-- Google Maps -->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAwuyLRa1uKNtbgx6xAJVmWy-zADgegA2s"></script>
    <script src="js/map-active.js"></script>

</body>

</html>