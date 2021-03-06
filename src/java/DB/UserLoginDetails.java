package DB;
// Generated Mar 3, 2015 12:28:18 AM by Hibernate Tools 3.2.1.GA



/**
 * UserLoginDetails generated by hbm2java
 */
public class UserLoginDetails  implements java.io.Serializable {


     private Integer iduserLoginDetails;
     private UserLogin userLogin;
     private String ipaddress;
     private String intime;
     private String outtime;
     private String description;
     private String macAddress;
     private String browserDetails;
     private String operationSystem;

    public UserLoginDetails() {
    }

	
    public UserLoginDetails(UserLogin userLogin) {
        this.userLogin = userLogin;
    }
    public UserLoginDetails(UserLogin userLogin, String ipaddress, String intime, String outtime, String description, String macAddress, String browserDetails, String operationSystem) {
       this.userLogin = userLogin;
       this.ipaddress = ipaddress;
       this.intime = intime;
       this.outtime = outtime;
       this.description = description;
       this.macAddress = macAddress;
       this.browserDetails = browserDetails;
       this.operationSystem = operationSystem;
    }
   
    public Integer getIduserLoginDetails() {
        return this.iduserLoginDetails;
    }
    
    public void setIduserLoginDetails(Integer iduserLoginDetails) {
        this.iduserLoginDetails = iduserLoginDetails;
    }
    public UserLogin getUserLogin() {
        return this.userLogin;
    }
    
    public void setUserLogin(UserLogin userLogin) {
        this.userLogin = userLogin;
    }
    public String getIpaddress() {
        return this.ipaddress;
    }
    
    public void setIpaddress(String ipaddress) {
        this.ipaddress = ipaddress;
    }
    public String getIntime() {
        return this.intime;
    }
    
    public void setIntime(String intime) {
        this.intime = intime;
    }
    public String getOuttime() {
        return this.outtime;
    }
    
    public void setOuttime(String outtime) {
        this.outtime = outtime;
    }
    public String getDescription() {
        return this.description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    public String getMacAddress() {
        return this.macAddress;
    }
    
    public void setMacAddress(String macAddress) {
        this.macAddress = macAddress;
    }
    public String getBrowserDetails() {
        return this.browserDetails;
    }
    
    public void setBrowserDetails(String browserDetails) {
        this.browserDetails = browserDetails;
    }
    public String getOperationSystem() {
        return this.operationSystem;
    }
    
    public void setOperationSystem(String operationSystem) {
        this.operationSystem = operationSystem;
    }




}


