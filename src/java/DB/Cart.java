package DB;
// Generated Mar 3, 2015 12:28:18 AM by Hibernate Tools 3.2.1.GA


import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Cart generated by hbm2java
 */
public class Cart  implements java.io.Serializable {


     private Integer idcart;
     private User user;
     private Integer productCount;
     private Double totalAmount;
     private Date dateTime;
     private Set cartHasProjects = new HashSet(0);

    public Cart() {
    }

	
    public Cart(User user) {
        this.user = user;
    }
    public Cart(User user, Integer productCount, Double totalAmount, Date dateTime, Set cartHasProjects) {
       this.user = user;
       this.productCount = productCount;
       this.totalAmount = totalAmount;
       this.dateTime = dateTime;
       this.cartHasProjects = cartHasProjects;
    }
   
    public Integer getIdcart() {
        return this.idcart;
    }
    
    public void setIdcart(Integer idcart) {
        this.idcart = idcart;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    public Integer getProductCount() {
        return this.productCount;
    }
    
    public void setProductCount(Integer productCount) {
        this.productCount = productCount;
    }
    public Double getTotalAmount() {
        return this.totalAmount;
    }
    
    public void setTotalAmount(Double totalAmount) {
        this.totalAmount = totalAmount;
    }
    public Date getDateTime() {
        return this.dateTime;
    }
    
    public void setDateTime(Date dateTime) {
        this.dateTime = dateTime;
    }
    public Set getCartHasProjects() {
        return this.cartHasProjects;
    }
    
    public void setCartHasProjects(Set cartHasProjects) {
        this.cartHasProjects = cartHasProjects;
    }




}


