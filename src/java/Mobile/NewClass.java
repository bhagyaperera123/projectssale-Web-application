/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Mobile;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Bhagya
 */
public class NewClass {

    public static void main(String[] args) {
        try {

//            Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
//            Criteria cr1 = ses.createCriteria(DB.UserType.class);
//            cr1.add(Restrictions.eq("roleName", "Niro"));
//            DB.UserType ttt = (DB.UserType) cr.uniqueResult();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
