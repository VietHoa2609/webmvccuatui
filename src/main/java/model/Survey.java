package model;

import java.io.Serializable;

public class Survey implements Serializable {
    private static final long serialVersionUID = 1L;

    private String firstName;
    private String lastName;
    private String email;
    private String dob;        // giữ String cho đơn giản (yyyy-MM-dd)
    private String heardFrom;
    private String contactVia;
    private String comments;
    private boolean updates;

    public Survey() {}

    public Survey(String firstName, String lastName, String email, String dob,
                  String heardFrom, String contactVia, String comments, boolean updates) {
        setFirstName(firstName);
        setLastName(lastName);
        setEmail(email);
        setDob(dob);
        setHeardFrom(heardFrom);
        setContactVia(contactVia);
        setComments(comments);
        setUpdates(updates);
    }

    // ===== Getters & Setters (trim null-safe) =====
    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = t(firstName); }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = t(lastName); }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = t(email); }

    public String getDob() { return dob; }
    public void setDob(String dob) { this.dob = t(dob); }

    public String getHeardFrom() { return heardFrom; }
    public void setHeardFrom(String heardFrom) { this.heardFrom = t(heardFrom); }

    public String getContactVia() { return contactVia; }
    public void setContactVia(String contactVia) { this.contactVia = t(contactVia); }

    public String getComments() { return comments; }
    public void setComments(String comments) { this.comments = t(comments); }

    public boolean isUpdates() { return updates; }
    public void setUpdates(boolean updates) { this.updates = updates; }

    // Tiện cho JSP
    public String getFullName() {
        String fn = firstName == null ? "" : firstName;
        String ln = lastName  == null ? "" : lastName;
        return (fn + " " + ln).trim();
    }

    // helper
    private static String t(String s) { return s == null ? null : s.trim(); }
}
