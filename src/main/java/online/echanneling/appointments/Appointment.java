package online.echanneling.appointments;

import java.util.Date;

public class Appointment {
    private int patientId;
    private int doctorId;
    private String specialization;
    private String problem;
    private Date appointmentDate;

    public Appointment(int patientId, int doctorId, String specialization, String problem, Date appointmentDate) {
        this.patientId = patientId;
        this.doctorId = doctorId;
        this.specialization = specialization;
        this.problem = problem;
        this.appointmentDate = appointmentDate;
    }

    // Getters and Setters
    public int getPatientId() { return patientId; }
    public int getDoctorId() { return doctorId; }
    public String getSpecialization() { return specialization; }
    public String getProblem() { return problem; }
    public Date getAppointmentDate() { return appointmentDate; }
}
