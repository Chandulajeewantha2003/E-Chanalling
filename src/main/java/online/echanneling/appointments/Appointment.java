package online.echanneling.appointments;

public class Appointment {
    private int id;
    private int patientId;
    private int doctorId;
    private String specialization;
    private String problem;
    private String appointmentDate;
    private String status;
 
    // Constructor
    public Appointment(int id, int patientId, int doctorId, String specialization, String problem, String appointmentDate, String status) {
        this.id = id;
        this.patientId = patientId;
        this.doctorId = doctorId;
        this.specialization = specialization;
        this.problem = problem;
        this.appointmentDate = appointmentDate;
        this.status = status;
    }

    // Getters and Setters
    public int getId() {
        return id;
    } 

    public void setId(int id) {
        this.id = id;
    }

    public int getPatientId() {
        return patientId;
    }

    public void setPatientId(int patientId) {
        this.patientId = patientId;
    }

    public int getDoctorId() {
        return doctorId;
    }

    public void setDoctorId(int doctorId) {
        this.doctorId = doctorId;
    }

    public String getSpecialization() {
        return specialization;
    }

    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }

    public String getProblem() {
        return problem;
    }

    public void setProblem(String problem) {
        this.problem = problem;
    }

    public String getAppointmentDate() {
        return appointmentDate;
    }

    public void setAppointmentDate(String appointmentDate) {
        this.appointmentDate = appointmentDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
