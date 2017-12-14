package DB;
// Generated Mar 3, 2015 12:28:18 AM by Hibernate Tools 3.2.1.GA


import java.util.HashSet;
import java.util.Set;

/**
 * VacationDuration generated by hbm2java
 */
public class VacationDuration  implements java.io.Serializable {


     private Integer idvacationDuration;
     private String duration;
     private Set vacations = new HashSet(0);

    public VacationDuration() {
    }

    public VacationDuration(String duration, Set vacations) {
       this.duration = duration;
       this.vacations = vacations;
    }
   
    public Integer getIdvacationDuration() {
        return this.idvacationDuration;
    }
    
    public void setIdvacationDuration(Integer idvacationDuration) {
        this.idvacationDuration = idvacationDuration;
    }
    public String getDuration() {
        return this.duration;
    }
    
    public void setDuration(String duration) {
        this.duration = duration;
    }
    public Set getVacations() {
        return this.vacations;
    }
    
    public void setVacations(Set vacations) {
        this.vacations = vacations;
    }




}


