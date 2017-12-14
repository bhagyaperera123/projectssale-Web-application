/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import DB.UserTypeHasUserPage;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Bhagya
 */
public class user_has_page {

    public static void Save_(DB.UserType type, int page_id) {

        try {
            Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
            Transaction tr = ses.beginTransaction();

            DB.UserTypeHasUserPage uhp = new UserTypeHasUserPage();

            DB.UserPage up = (DB.UserPage) ses.load(DB.UserPage.class, page_id);

            uhp.setUserPage(up);
            uhp.setUserType(type);
            ses.save(uhp);
            tr.commit();
            ses.flush();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
