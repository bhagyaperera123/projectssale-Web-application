
USE projectssale;

INSERT INTO `sub_category` (`idSub_Category`,`Name`) VALUES 
 (1,'Mac'),
 (2,'Windows'),
 (3,'Linux'),
 (4,'Apple Mobile'),
 (5,'Window Mobile'),
 (6,'Android Mobile'),
 (7,'Ecommerce'),
 (8,'Cloud'),
 (9,'One Page Web Site'),
 (10,'Social'),
 (11,'Shopping Cart'),
 (12,'Infromation Site'),
 (13,'Other');

INSERT INTO `user_type` (`idUser_type`,`role_name`,`status`) VALUES 
 (1,'Admin',1),
 (2,'User',1),
 (3,'seller',0),
 (4,'Buyer',0),
 (5,'Super Admin',1),
 (6,'ABC',0),
 (7,'bhagya',0),
 (8,'qwe',0),
 (9,'ggggg',0),
 (11,'A',0),
 (12,'Owner',0),
 (13,'You',0);

INSERT INTO `category_type` (`idCategory_type`,`Name`) VALUES 
 (1,'Swing'),
 (2,'Web'),
 (3,'Mobile');

INSERT INTO `database1` (`idDatabase`,`Name`) VALUES 
 (1,'SQL');

INSERT INTO `job_category` (`idjob_type`,`category_name`) VALUES 
 (1,'Programming'),
 (2,'SEO');

INSERT INTO `job_duration` (`idjob_duration`,`time`) VALUES 
 (1,'1 Day'),
 (2,'2 Days'),
 (3,'3 Days'),
 (4,'4 Days'),
 (5,'5 Days');
 
  INSERT INTO `job_display_photo` (`id_job_display_photo`,`path`) VALUES 
 (2,'upload\\Users\\abc_abc@gmail.com\\jobs\\I can create a Software\\1.jpg'),
 (3,'upload\\Users\\ishan_ishan@gmail.com\\jobs\\I can create a Web Application\\4.jpg');

 
INSERT INTO `user` (`iduser`,`fname`,`lname`,`email`,`description`) VALUES 
 (1,'bhagya','perera','bhagyaperera142@gmail.com',NULL),
 (2,'abc','abc','abc@gmail.com',''),
 (3,'abc','abc','abc@gmail.com',NULL),
 (4,'ishan','randeniya','ishan@gmail.com',NULL),
 (5,'seller','seller','seler',''),
 (6,'buyer','buyer','buyer','');

INSERT INTO `user_login` (`iduser_login`,`uname`,`password`,`Location`,`user_iduser`,`Job_Location`,`status`,`User_type_idUser_type`,`demo_File_Location`) VALUES 
 (1,'bhagya','123','upload\\Users\\bhagya_bhagyawijayantha@yahoo.com',1,'upload\\Users\\bhagya_bhagyawijayantha@yahoo.com\\jobs',1,5,'a'),
 (2,'abc1','12345','',2,'',1,1,'a'),
 (3,'abc','123','upload\\Users\\abc_abc@gmail.com',3,'upload\\Users\\abc_abc@gmail.com\\jobs',1,2,'a'),
 (4,'ishan','123','upload\\Users\\ishan_ishan@gmail.com',4,'upload\\Users\\ishan_ishan@gmail.com\\jobs',1,2,'a'),
 (5,'seller','123','',5,'',1,1,'a'),
 (6,'buyer','123','',6,'',1,1,'a');

INSERT INTO `user_login_details` (`iduser_login_details`,`ipaddress`,`intime`,`outtime`,`description`,`user_login_iduser_login`) VALUES 
 (1,'127.0.0.1','Thu Feb 26 13:10:29 IST 2015','','',1),
 (2,'127.0.0.1','Thu Feb 26 13:25:03 IST 2015','Thu Feb 26 13:25:11 IST 2015','',1),
 (3,'127.0.0.1','Thu Feb 26 13:25:31 IST 2015','Thu Feb 26 13:30:00 IST 2015','',1),
 (4,'127.0.0.1','Thu Feb 26 13:30:29 IST 2015','Thu Feb 26 13:30:50 IST 2015','',2),
 (5,'127.0.0.1','Thu Feb 26 13:30:51 IST 2015','Thu Feb 26 14:06:12 IST 2015','',1),
 (6,'127.0.0.1','Thu Feb 26 14:08:10 IST 2015','','',1),
 (7,'127.0.0.1','Thu Feb 26 14:08:33 IST 2015','Thu Feb 26 14:10:35 IST 2015','',1),
 (8,'127.0.0.1','Thu Feb 26 14:10:38 IST 2015','Thu Feb 26 14:10:54 IST 2015','',1),
 (9,'127.0.0.1','Thu Feb 26 14:21:16 IST 2015','Thu Feb 26 14:21:30 IST 2015','',1),
 (10,'127.0.0.1','Thu Feb 26 14:28:54 IST 2015','Thu Feb 26 14:29:00 IST 2015','',1),
 (11,'127.0.0.1','Thu Feb 26 14:29:50 IST 2015','Thu Feb 26 14:29:55 IST 2015','',1),
 (12,'127.0.0.1','Thu Feb 26 15:22:17 IST 2015','Thu Feb 26 15:24:42 IST 2015','',1),
 (13,'127.0.0.1','Thu Feb 26 15:33:48 IST 2015','Thu Feb 26 15:33:51 IST 2015','',1),
 (14,'127.0.0.1','Thu Feb 26 16:00:05 IST 2015','Thu Feb 26 16:00:10 IST 2015','',1),
 (15,'127.0.0.1','Thu Feb 26 16:00:12 IST 2015','','',1),
 (16,'127.0.0.1','Thu Feb 26 16:19:31 IST 2015','Thu Feb 26 16:20:32 IST 2015','',1),
 (17,'127.0.0.1','Thu Feb 26 16:20:47 IST 2015','Thu Feb 26 16:27:06 IST 2015','',1),
 (18,'127.0.0.1','Thu Feb 26 16:27:10 IST 2015','Thu Feb 26 16:27:15 IST 2015','',1),
 (19,'127.0.0.1','Thu Feb 26 16:27:21 IST 2015','Thu Feb 26 16:27:39 IST 2015','',3),
 (20,'127.0.0.1','Thu Feb 26 16:27:47 IST 2015','Thu Feb 26 16:49:21 IST 2015','',4),
 (21,'127.0.0.1','Thu Feb 26 16:49:27 IST 2015','','',4),
 (22,'127.0.0.1','Thu Feb 26 17:08:51 IST 2015','','',1),
 (23,'127.0.0.1','Thu Feb 26 17:46:47 IST 2015','Thu Feb 26 17:47:07 IST 2015','',1),
 (24,'127.0.0.1','Thu Feb 26 17:47:12 IST 2015','','',4);

INSERT INTO `user_page` (`iduser_Page`,`url`,`page_name`,`status`) VALUES 
 (1,'Admin_Console.jsp','Admin Console',1),
 (2,'Create_Admin_Account.jsp','Create New Account',1),
 (3,'view_users.jsp','View All Users',1),
 (4,'Add_User_Role.jsp','Manage User Role',1),
 (5,'View_Login_History.jsp','View User Login History',1),
 (6,'Super_Admin.jsp','Super Admin',1),
 (7,'View_Jobs.jsp','View Jobs',1),
 (8,'View_Login_History.jsp','View Login History ',1),
 (9,'View_projects.jsp','View projects',1),
 (10,'Admin_Profie.jsp','Admin Profie',1),
 (11,'Deleted_Job.jsp','Deleted Job',1),
 (12,'Deleted_Projects.jsp','Deleted Projects ',1),
 (13,'Manage_Job.jsp','Manage Job',1),
 (14,'Manage_Projects.jsp','Manage Projects',1),
 (15,'view_users.jsp','View Users',1),
 (16,'View_History.jsp','View History',1),
 (17,'Other_Function.jsp','Other Function',1),
 (18,'View_Admin.jsp','View Admin',1),
 (19,'Order_view_Admin.jsp','Order view Admin',1);

INSERT INTO `view_type` (`idview_type`,`type_name`) VALUES 
 (1,'Project'),
 (2,'SEO');

  INSERT INTO `add_job` (`idadd_job`,`title`,`job_Category`,`description`,`tags`,`job_duration_idjob_duration`,`instructions_for_buyer`,`user_iduser`,`job_display_photo_id_job_display_photo`,`status`,`job_price_List_idjob_price_List`) VALUES 
 (2,'I can create a Software',1,'no description','Java,Css,Ajax,Xml,Html,',1,'jasnkdajsnkdndjks\r\n                                    ',3,2,1,1),
 (3,'I can create a Web Application',1,'On the Insert tab, the galleries include items that are designed to coordinate with the overall look of your document. You can use these galleries to insert tables, headers, footers, lists, cover pages, and other document building blocks. When you create pictures, charts, or diagrams, they also coordinate with your current document look.\r\nYou can easily change the formatting of selected text in the document text by choosing a look for the selected text from the Quick Styles gallery on the Home tab. You can also format text directly by using the other controls on the Home tab. Most controls offer a choice of using the look from the current theme or using a format that you specify directly.\r\n','Java,Css,Ajax,Xml,Html,',1,'On the Insert tab, the galleries include items that are designed to coordinate with the overall look of your document. You can use these galleries to insert tables, headers, footers, lists, cover pages, and other document building blocks. When you create pictures, charts, or diagrams, they also coordinate with your current document look.\r\nYou can easily change the formatting of selected text in the document text by choosing a look for the selected text from the Quick Styles gallery on the Home tab. You can also format text directly by using the other controls on the Home tab. Most controls offer a choice of using the look from the current theme or using a format that you specify directly.\r\n',4,3,1,1);

INSERT INTO `upload_pic` (`idupload_pic`,`name`,`path`) VALUES 
 (1,'2.jpg','upload\\Users\\abc_abc@gmail.com\\Projects\\Ecommerce application\\img\\2.jpg'),
 (2,'3.jpg','upload\\Users\\abc_abc@gmail.com\\Projects\\Ecommerce application 2\\img\\3.jpg'),
 (3,'5.jpg','upload\\Users\\ishan_ishan@gmail.com\\Projects\\cloud application\\img\\5.jpg');

INSERT INTO `upload_file` (`idupload`,`name`,`path`) VALUES 
 (1,'TableTools example - Bootstrap styling.pdf','upload\\Users\\abc_abc@gmail.com\\Projects\\Ecommerce application\\file\\TableTools example - Bootstrap styling.pdf'),
 (2,'TableTools example - Bootstrap styling.pdf','upload\\Users\\abc_abc@gmail.com\\Projects\\Ecommerce application 2\\file\\TableTools example - Bootstrap styling.pdf'),
 (3,'5.jpg','upload\\Users\\ishan_ishan@gmail.com\\Projects\\cloud application\\file\\5.jpg');

 INSERT INTO `user_type_has_user_page` (`idUser_type_has_user_page`,`User_type_idUser_type`,`User_page_iduser_Page`) VALUES 
 (59,1,1),
 (60,5,1),
 (61,5,4),
 (62,5,2),
 (63,5,3),
 (64,5,5),
 (65,5,6),
 (66,5,7),
 (67,5,8),
 (68,5,9),
 (69,5,10),
 (70,5,11),
 (71,5,12),
 (72,5,13),
 (73,5,14),
 (75,1,10),
 (76,5,15),
 (78,13,3);

 INSERT INTO `category` (`idCategory`,`idSub_Category`,`idCategory_type`) VALUES 
 (1,1,1),
 (2,2,1),
 (3,3,1),
 (4,7,2),
 (5,8,2),
 (6,9,2),
 (7,10,2),
 (8,11,2),
 (9,12,2),
 (10,13,2),
 (11,4,3),
 (12,5,3),
 (13,6,3);
 
  INSERT INTO `projects` (`idprojects`,`Project_name`,`Price`,`user_iduser`,`Category_idCategory`,`description`,`Database_idDatabase`,`pro_lan`,`Sub_Category_id`,`upload_file_idupload`,`upload_pic_idupload_pic`,`status`,`Upload_demo_idUpload_demo`) VALUES 
 (1,'Ecommerce application','12000',3,1,'On the Insert tab, the galleries include items that are designed to coordinate with the overall look of your document. You can use these galleries to insert tables, headers, footers, lists, cover pages, and other document building blocks. When you create pictures, charts, or diagrams, they also coordinate with your current document look.\r\nYou can easily change the formatting of selected text in the document text by choosing a look for the selected text from the Quick Styles gallery on the Home tab. You can also format text directly by using the other controls on the Home tab. Most controls offer a choice of using the look from the current theme or using a format that you specify directly.\r\n',1,'Java,Css,Ajax,Xml,Html,Jsp,Javascript,',1,1,1,1,1),
 (2,'Ecommerce application 2','3200',3,1,'On the Insert tab, the galleries include items that are designed to coordinate with the overall look of your document. You can use these galleries to insert tables, headers, footers, lists, cover pages, and other document building blocks. When you create pictures, charts, or diagrams, they also coordinate with your current document look.\r\nYou can easily change the formatting of selected text in the document text by choosing a look for the selected text from the Quick Styles gallery on the Home tab. You can also format text directly by using the other controls on the Home tab. Most controls offer a choice of using the look from the current theme or using a format that you specify directly.\r\n',1,'Java,Php,Css,Ajax,Xml,Html,',1,2,2,1,1),
 (3,'cloud application','4600',4,1,'On the Insert tab, the galleries include items that are designed to coordinate with the overall look of your document. You can use these galleries to insert tables, headers, footers, lists, cover pages, and other document building blocks. When you create pictures, charts, or diagrams, they also coordinate with your current document look.\r\nYou can easily change the formatting of selected text in the document text by choosing a look for the selected text from the Quick Styles gallery on the Home tab. You can also format text directly by using the other controls on the Home tab. Most controls offer a choice of using the look from the current theme or using a format that you specify directly.\r\n',1,'Java,Jsp,Css,Ajax,Xml,Bootstrap,',1,3,3,1,1);
 