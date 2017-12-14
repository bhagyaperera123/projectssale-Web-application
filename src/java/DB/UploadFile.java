package DB;
// Generated Mar 3, 2015 12:28:18 AM by Hibernate Tools 3.2.1.GA


import java.util.HashSet;
import java.util.Set;

/**
 * UploadFile generated by hbm2java
 */
public class UploadFile  implements java.io.Serializable {


     private Integer idupload;
     private String name;
     private String path;
     private Set projectses = new HashSet(0);

    public UploadFile() {
    }

    public UploadFile(String name, String path, Set projectses) {
       this.name = name;
       this.path = path;
       this.projectses = projectses;
    }
   
    public Integer getIdupload() {
        return this.idupload;
    }
    
    public void setIdupload(Integer idupload) {
        this.idupload = idupload;
    }
    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    public String getPath() {
        return this.path;
    }
    
    public void setPath(String path) {
        this.path = path;
    }
    public Set getProjectses() {
        return this.projectses;
    }
    
    public void setProjectses(Set projectses) {
        this.projectses = projectses;
    }




}

