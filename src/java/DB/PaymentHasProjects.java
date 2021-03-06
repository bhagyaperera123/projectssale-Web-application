package DB;
// Generated Mar 3, 2015 12:28:18 AM by Hibernate Tools 3.2.1.GA



/**
 * PaymentHasProjects generated by hbm2java
 */
public class PaymentHasProjects  implements java.io.Serializable {


     private Integer idPaymentHasProjects;
     private Projects projects;
     private Payment payment;
     private Integer qty;
     private Integer isPurchase;
     private Double price;

    public PaymentHasProjects() {
    }

	
    public PaymentHasProjects(Projects projects, Payment payment) {
        this.projects = projects;
        this.payment = payment;
    }
    public PaymentHasProjects(Projects projects, Payment payment, Integer qty, Integer isPurchase, Double price) {
       this.projects = projects;
       this.payment = payment;
       this.qty = qty;
       this.isPurchase = isPurchase;
       this.price = price;
    }
   
    public Integer getIdPaymentHasProjects() {
        return this.idPaymentHasProjects;
    }
    
    public void setIdPaymentHasProjects(Integer idPaymentHasProjects) {
        this.idPaymentHasProjects = idPaymentHasProjects;
    }
    public Projects getProjects() {
        return this.projects;
    }
    
    public void setProjects(Projects projects) {
        this.projects = projects;
    }
    public Payment getPayment() {
        return this.payment;
    }
    
    public void setPayment(Payment payment) {
        this.payment = payment;
    }
    public Integer getQty() {
        return this.qty;
    }
    
    public void setQty(Integer qty) {
        this.qty = qty;
    }
    public Integer getIsPurchase() {
        return this.isPurchase;
    }
    
    public void setIsPurchase(Integer isPurchase) {
        this.isPurchase = isPurchase;
    }
    public Double getPrice() {
        return this.price;
    }
    
    public void setPrice(Double price) {
        this.price = price;
    }




}


