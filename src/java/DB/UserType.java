package DB;
// Generated Mar 3, 2015 12:28:18 AM by Hibernate Tools 3.2.1.GA


import java.util.HashSet;
import java.util.Set;

/**
 * UserType generated by hbm2java
 */
public class UserType  implements java.io.Serializable {


     private Integer idUserType;
     private String roleName;
     private Integer status;
     private Set userLogins = new HashSet(0);
     private Set userTypeHasUserPages = new HashSet(0);

    public UserType() {
    }

    public UserType(String roleName, Integer status, Set userLogins, Set userTypeHasUserPages) {
       this.roleName = roleName;
       this.status = status;
       this.userLogins = userLogins;
       this.userTypeHasUserPages = userTypeHasUserPages;
    }
   
    public Integer getIdUserType() {
        return this.idUserType;
    }
    
    public void setIdUserType(Integer idUserType) {
        this.idUserType = idUserType;
    }
    public String getRoleName() {
        return this.roleName;
    }
    
    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }
    public Integer getStatus() {
        return this.status;
    }
    
    public void setStatus(Integer status) {
        this.status = status;
    }
    public Set getUserLogins() {
        return this.userLogins;
    }
    
    public void setUserLogins(Set userLogins) {
        this.userLogins = userLogins;
    }
    public Set getUserTypeHasUserPages() {
        return this.userTypeHasUserPages;
    }
    
    public void setUserTypeHasUserPages(Set userTypeHasUserPages) {
        this.userTypeHasUserPages = userTypeHasUserPages;
    }




}

