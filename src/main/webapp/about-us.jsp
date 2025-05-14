<%@ page import="java.sql.*, online.echanneling.DBConnection" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

 <!-- ***** Header Area Start ***** -->
<%@ include file="partials/header.jsp" %>

    <!-- ***** Breadcumb Area Start ***** -->
    <section class="breadcumb-area bg-img gradient-background-overlay" style="background-image: url(img/bg-img/breadcumb1.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="breadcumb-content">
                        <h3 class="breadcumb-title">About us</h3>
                        
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ***** Breadcumb Area End ***** -->

    <!-- ***** Features Area Start ***** -->
    <div class="medilife-features-area section-padding-100">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-12 col-lg-6">
                    <div class="features-content">
                        <h2>We always put our pacients first</h2>
                        <p>At the heart of our service is a deep commitment to the well-being and comfort of every individual who walks through our doors. We believe that quality healthcare is not just about treatment—it's about compassion, respect, and building trust. Our team of dedicated professionals works tirelessly to ensure that each patient receives personalized attention, timely care, and support throughout their journey. Whether it’s through advanced medical expertise or a reassuring smile, we strive to make every experience as comfortable and human-centered as possible.</p>
                        <a href="#" class="btn medilife-btn mt-50">View the services <span>+</span></a>
                    </div>
                </div>
                <div class="col-12 col-lg-6">
                    <div class="features-thumbnail">
                        <img src="img/bg-img/about1.jpg" alt="">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- ***** Features Area End ***** -->

    <!-- ***** Video Area Start ***** -->
    <section class="medilife-video-area section-padding-100 bg-overlay bg-img" style="background-image: url(img/bg-img/video.jpg);">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-12 col-lg-8">
                    <div class="video-box bg-overlay-black">
                        <img src="img/bg-img/video2.jpg" alt="">
                        <div class="play-btn">
                            <h6>Our Payments Methods are coming soon..</h6>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-lg-4">
                    <div class="video-content">
                        <h2>A day at Medilife Online Payments</h2>
                        <p>We're working hard to bring you secure and convenient payment options. Stay tuned for updates as we enhance your experience with flexible ways to pay online.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ***** Video Area End ***** -->


    <!-- ***** Tabs Area Start ***** -->
    <section class="medilife-tabs-area section-padding-100">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="medilife-tabs-content">
                        <ul class="nav nav-tabs" id="myTab" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link" id="institution-tab" data-toggle="tab" href="#institution" role="tab" aria-controls="institution" aria-selected="false">Doctor1</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="faq-tab" data-toggle="tab" href="#faq" role="tab" aria-controls="faq" aria-selected="false">Doctor2</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link active" id="specialities-tab" data-toggle="tab" href="#specialities" role="tab" aria-controls="specialities" aria-selected="true">Doctor3</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="laboratory-tab" data-toggle="tab" href="#laboratory" role="tab" aria-controls="laboratory" aria-selected="false">Doctor4</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="emergencies-tab" data-toggle="tab" href="#emergencies" role="tab" aria-controls="emergencies" aria-selected="false">Doctor5</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="scolarship-tab" data-toggle="tab" href="#scolarship" role="tab" aria-controls="scolarship" aria-selected="false">Doctor6</a>
                            </li>
                        </ul>

                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade" id="institution" role="tabpanel" aria-labelledby="institution-tab">
                                <div class="medilife-tab-content d-md-flex align-items-center">
                                    <!-- Medilife Tab Text  -->
                                    <div class="medilife-tab-text">
                                        <h2>Take a look at this</h2>
                                        <p>Coming Soon Doctors Details........</p>
                                    </div>
                                    <!-- Medilife Tab Img  -->
                                    <div class="medilife-tab-img">
                                        <img src="img/bg-img/about1.jpg" alt="">
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="faq" role="tabpanel" aria-labelledby="faq-tab">
                                <div class="medilife-tab-content d-md-flex align-items-center">
                                    <!-- Medilife Tab Text  -->
                                    <div class="medilife-tab-text">
                                        <h2>Take a look at this</h2>
                                        <p>Coming Soon Doctors Details........</p>
                                    </div>
                                    <!-- Medilife Tab Img  -->
                                    <div class="medilife-tab-img">
                                        <img src="img/bg-img/medical1.png" alt="">
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade show active" id="specialities" role="tabpanel" aria-labelledby="specialities-tab">
                                <div class="medilife-tab-content d-md-flex align-items-center">
                                    <!-- Medilife Tab Text  -->
                                    <div class="medilife-tab-text">
                                        <h2>Take a look at this</h2>
                                        <p>Coming Soon Doctors Details........</p>
                                    </div>
                                    <!-- Medilife Tab Img  -->
                                    <div class="medilife-tab-img">
                                        <img src="img/bg-img/tab.jpg" alt="">
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="laboratory" role="tabpanel" aria-labelledby="laboratory-tab">
                                <div class="medilife-tab-content d-md-flex align-items-center">
                                    <!-- Medilife Tab Text  -->
                                    <div class="medilife-tab-text">
                                        <h2>Take a look at this</h2>
                                        <p>Coming Soon Doctors Details........</p>
                                    </div>
                                    <!-- Medilife Tab Img  -->
                                    <div class="medilife-tab-img">
                                        <img src="img/bg-img/medical1.png" alt="">
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="emergencies" role="tabpanel" aria-labelledby="emergencies-tab">
                                <div class="medilife-tab-content d-md-flex align-items-center">
                                    <!-- Medilife Tab Text  -->
                                    <div class="medilife-tab-text">
                                        <h2>Take a look at this</h2>
                                        <p>Coming Soon Doctors Details........</p>
                                    </div>
                                    <!-- Medilife Tab Img  -->
                                    <div class="medilife-tab-img">
                                        <img src="img/bg-img/about1.jpg" alt="">
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="scolarship" role="tabpanel" aria-labelledby="scolarship-tab">
                                <div class="medilife-tab-content d-md-flex align-items-center">
                                    <!-- Medilife Tab Text  -->
                                    <div class="medilife-tab-text">
                                        <h2>Take a look at this</h2>
                                        <p>Coming Soon Doctors Details........</p>
                                    </div>
                                    <!-- Medilife Tab Img  -->
                                    <div class="medilife-tab-img">
                                        <img src="img/bg-img/medical1.png" alt="">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ***** Tabs Area End ***** -->

        <!-- ***** Footer Area Start ***** -->
   <%@ include file="partials/footer.jsp" %>