
package Connection;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class NewHibernateUtil {

    private static final SessionFactory sessionFactory;
    
    static {
        try {
            sessionFactory = new Configuration().configure().buildSessionFactory();
        } catch (Throwable ex) {
            // Log the exception. 
            System.err.println("Initial SessionFactory creation failed." + ex);
            throw new ExceptionInInitializerError(ex);
        }
    }
    
    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }
}
