/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import DB.Payment;
import java.util.Date;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Bhagya
 */
public class Main {

    public static int valid_url(String s) {

        try {
            String deval = Security.Security.decrypt(s);
            int i = Integer.parseInt(deval);
            return i;
        } catch (Exception e) {
            return 0;
        }

    }

    public static int int_Value(String s) {

        try {
            int i = Integer.parseInt(s);
            return i;
        } catch (Exception e) {
            return 0;
        }

    }

    public static void Save_data(DB.CartHasProject chpro, int id, DB.User us) {
        DB.Payment pay = new Payment();
        String s = chpro.getQty() + "";
        String[] a = s.split(".0");
        int qty = 0;
        Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
        Transaction tr = ses.beginTransaction();
        for (int i = 0; i < a.length; i++) {
            qty = Integer.parseInt(a[i]);
        }
        pay.setDateTime(new Date() + "");
        pay.setProjectCount(qty);
        pay.setTotalAmount(chpro.getPrice());
        pay.setUser(us);
        DB.Projects pro = (DB.Projects) ses.load(DB.Projects.class, chpro.getProjects().getIdprojects());
        ses.save(pay);
        tr.commit();
        ses.flush();
        ses.close();
    }

    public static void cateTYpe_Has_Subcate(int cid , int scid) {
        Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
        Transaction tr = ses.beginTransaction();
        try {
            DB.CategoryType catetype = (DB.CategoryType) ses.load(DB.CategoryType.class, cid);
            DB.SubCategory subcat = (DB.SubCategory) ses.load(DB.SubCategory.class, scid);
            DB.Category cate = new DB.Category();
            cate.setSubCategory(subcat);
            cate.setCategoryType(catetype);
            ses.save(cate);
            tr.commit();
            ses.flush();
            ses.close();  
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
