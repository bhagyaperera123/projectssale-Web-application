package DB;
// Generated Mar 3, 2015 12:28:18 AM by Hibernate Tools 3.2.1.GA


import java.util.HashSet;
import java.util.Set;

/**
 * UploadDemo generated by hbm2java
 */
public class UploadDemo  implements java.io.Serializable {


     private Integer idUploadDemo;
     private String name;
     private String path;
     private Set projectses = new HashSet(0);

    public UploadDemo() {
    }

    public UploadDemo(String name, String path, Set projectses) {
       this.name = name;
       this.path = path;
       this.projectses = projectses;
    }
   
    public Integer getIdUploadDemo() {
        return this.idUploadDemo;
    }
    
    public void setIdUploadDemo(Integer idUploadDemo) {
        this.idUploadDemo = idUploadDemo;
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


