<%@ page import="java.sql.*, online.echanneling.DBConnection" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

 <!-- ***** Header Area Start ***** -->
<%@ include file="partials/header.jsp" %>

    <!-- ***** Breadcumb Area Start ***** -->
    <section class="breadcumb-area bg-img gradient-background-overlay" style="background-image: url(img/bg-img/breadcumb2.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="breadcumb-content">
                        <h3 class="breadcumb-title">Services</h3>
                        <p>Lorem ipsum dolor sit amet, consectetuer</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ***** Breadcumb Area End ***** -->

    <!-- ***** Services Area Start ***** -->
    <div class="medilife-services-area section-padding-100-20">
        <div class="container">
            <div class="row">
                <!-- Single Service Area -->
                <div class="col-12 col-md-6 col-lg-4">
                    <div class="single-service-area d-flex">
                        <div class="service-icon">
                            <i class="icon-doctor"></i>
                        </div>
                        <div class="service-content">
                            <h5>The Best Doctors</h5>
                            <p>Lorem ipsum dolor sit amet, consecte tuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut.</p>
                        </div>
                    </div>
                </div>
                <!-- Single Service Area -->
                <div class="col-12 col-md-6 col-lg-4">
                    <div class="single-service-area d-flex">
                        <div class="service-icon">
                            <i class="icon-blood-donation-1"></i>
                        </div>
                        <div class="service-content">
                            <h5>Baby Nursery</h5>
                            <p>Dolor sit amet, consecte tuer elit, sed diam nonummy nibh euismod tincidunt ut ldolore magna.</p>
                        </div>
                    </div>
                </div>
                <!-- Single Service Area -->
                <div class="col-12 col-md-6 col-lg-4">
                    <div class="single-service-area d-flex">
                        <div class="service-icon">
                            <i class="icon-helicopter"></i>
                        </div>
                        <div class="service-content">
                            <h5>Helicopters</h5>
                            <p>Lorem ipsum dolor sit amet, consecte tuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut.</p>
                        </div>
                    </div>
                </div>
                <!-- Single Service Area -->
                <div class="col-12 col-md-6 col-lg-4">
                    <div class="single-service-area d-flex">
                        <div class="service-icon">
                            <i class="icon-flask"></i>
                        </div>
                        <div class="service-content">
                            <h5>Laboratory</h5>
                            <p>Dolor sit amet, consecte tuer elit, sed diam nonummy nibh euismod tincidunt ut ldolore magna.</p>
                        </div>
                    </div>
                </div>
                <!-- Single Service Area -->
                <div class="col-12 col-md-6 col-lg-4">
                    <div class="single-service-area d-flex">
                        <div class="service-icon">
                            <i class="icon-emergency-call-1"></i>
                        </div>
                        <div class="service-content">
                            <h5>Emergency Room</h5>
                            <p>Dolor sit amet, consecte tuer elit, sed diam nonummy nibh euismod tincidunt ut ldolore magna.</p>
                        </div>
                    </div>
                </div>
                <!-- Single Service Area -->
                <div class="col-12 col-md-6 col-lg-4">
                    <div class="single-service-area d-flex">
                        <div class="service-icon">
                            <i class="icon-blood-donation-2"></i>
                        </div>
                        <div class="service-content">
                            <h5>Cardiology</h5>
                            <p>Dolor sit amet, consecte tuer elit, sed diam nonummy nibh euismod tincidunt ut ldolore magna.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- ***** Services Area End ***** -->

    <div class="medilife-services-area clearfix">
        <!-- Single Services Area -->
        <div class="singleServiceArea equalize d-flex">
            <div class="singleServiceIcon">
                <i class="icon-hospital-4"></i>
            </div>
            <div class="singleServiceText">
                <h2>A new way of running things</h2>
                <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Lorem ipsum dolor sit amet, consectetuer adipiscing eli. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>
            </div>
        </div>

        <!-- Single Services Area -->
        <div class="singleServiceArea equalize bg-img" style="background-image: url(img/bg-img/about1.jpg);"></div>

        <!-- Single Services Area -->
        <div class="singleServiceArea equalize d-flex">
            <div class="singleServiceIcon">
                <i class="icon-clinic-history-2"></i>
            </div>
            <div class="singleServiceText">
                <h2>All Equipments are high tech</h2>
                <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Lorem ipsum dolor sit amet, consectetuer adipiscing eli. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</p>
            </div>
        </div>
    </div>

    <section class="medilife-benefits-area section-padding-100-50">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="section-heading">
                        <h2>We always put <br>our pacients first</h2>
                    </div>
                </div>
            </div>

            <div class="row align-items-center">
                <div class="col-12 col-md-4">
                    <div class="single-benefits-area mb-50 text-right">
                        <div class="single-benefits-title d-flex align-items-end row-reverse">
                            <i class="icon-teeth"></i>
                            <h5>Safe tests</h5>
                        </div>
                        <p>Ipsum dolor sit amet, consectetuer adipiscing eli. Lorem ipsum dolor sit amet, adip iscing.</p>
                    </div>
                    <div class="single-benefits-area mb-50 text-right">
                        <div class="single-benefits-title d-flex align-items-end row-reverse">
                            <i class="icon-hospital-bed-1"></i>
                            <h5>Online results</h5>
                        </div>
                        <p>Ipsum dolor sit amet, consectetuer adipiscing eli. Lorem ipsum dolor sit amet, adip iscing.</p>
                    </div>
                    <div class="single-benefits-area mb-50 text-right">
                        <div class="single-benefits-title d-flex align-items-end row-reverse">
                            <i class="icon-hospital-2"></i>
                            <h5>Imagistic tests</h5>
                        </div>
                        <p>Ipsum dolor sit amet, consectetuer adipiscing eli. Lorem ipsum dolor sit amet, adip iscing.</p>
                    </div>
                </div>
                <div class="col-12 col-md-4">
                    <div class="single-benefits-thumb">
                        <img src="img/bg-img/benefits.png" alt="">
                    </div>
                </div>
                <div class="col-12 col-md-4">
                    <div class="single-benefits-area mb-50">
                        <div class="single-benefits-title d-flex align-items-end">
                            <i class="icon-flask-1"></i>
                            <h5>Safe tests</h5>
                        </div>
                        <p>Ipsum dolor sit amet, consectetuer adipiscing eli. Lorem ipsum dolor sit amet, adip iscing.</p>
                    </div>
                    <div class="single-benefits-area mb-50">
                        <div class="single-benefits-title d-flex align-items-end">
                            <i class="icon-smartphone-1"></i>
                            <h5>Online results</h5>
                        </div>
                        <p>Ipsum dolor sit amet, consectetuer adipiscing eli. Lorem ipsum dolor sit amet, adip iscing.</p>
                    </div>
                    <div class="single-benefits-area mb-50">
                        <div class="single-benefits-title d-flex align-items-end">
                            <i class="icon-nuclear"></i>
                            <h5>Imagistic tests</h5>
                        </div>
                        <p>Ipsum dolor sit amet, consectetuer adipiscing eli. Lorem ipsum dolor sit amet, adip iscing.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ***** CTA Area Start ***** -->
    <div class="medilife-cta-area">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="cta-content">
                        <i class="icon-smartphone"></i>
                        <h2>For Emergency calls</h2>
                        <h3>+12-823-611-8721</h3>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- ***** CTA Area End ***** -->

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
    <!-- Bootstrap js -->
    <script src="js/bootstrap.min.js"></script>
    <!-- Plugins js -->
    <script src="js/plugins.js"></script>
    <!-- Active js -->
    <script src="js/active.js"></script>

</body>

</html>