CREATE SEQUENCE PreTrained_Seq;
/

CREATE SEQUENCE Deployed_Seq;
/

CREATE SEQUENCE History_Seq;
/

CREATE SEQUENCE Tutorial_Seq;
/

CREATE SEQUENCE Webinar_Seq;
/

CREATE SEQUENCE Customer_Seq;
/

CREATE SEQUENCE CreditAccount_Seq;
/

CREATE SEQUENCE CloudDeplServ_Seq;
/

create or replace trigger PreTrained_Seq_Tr 
   before insert on "YELLOWCOM2"."PRETRAINED_T" 
   for each row 
begin  
   if inserting then 
      if :NEW."IDD" is null then 
         select PreTrained_Seq.nextval into :NEW."IDD" from dual; 
      end if; 
   end if; 
end;
/

create or replace trigger Deployed_Seq_Tr 
   before insert on "YELLOWCOM2"."DEPLOYED_T" 
   for each row 
begin  
   if inserting then 
      if :NEW."IDD" is null then 
         select Deployed_Seq.nextval into :NEW."IDD" from dual; 
      end if; 
   end if; 
end;
/

create or replace trigger History_Seq_Tr 
   before insert on "YELLOWCOM2"."HISTORY_T" 
   for each row 
begin  
   if inserting then 
      if :NEW."IDD" is null then 
         select History_Seq.nextval into :NEW."IDD" from dual; 
      end if; 
   end if; 
end;
/

create or replace trigger Tutorial_Seq_Tr 
   before insert on "YELLOWCOM2"."TUTORIAL_T" 
   for each row 
begin  
   if inserting then 
      if :NEW."IDD" is null then 
         select Tutorial_Seq.nextval into :NEW."IDD" from dual; 
      end if; 
   end if; 
end;
/

create or replace trigger Webinar_Seq_Tr 
   before insert on "YELLOWCOM2"."WEBINAR_T" 
   for each row 
begin  
   if inserting then 
      if :NEW."IDD" is null then 
         select Webinar_Seq.nextval into :NEW."IDD" from dual; 
      end if; 
   end if; 
end;
/

create or replace trigger Customer_Seq_Tr 
   before insert on "YELLOWCOM2"."CUSTOMER_T" 
   for each row 
begin  
   if inserting then 
      if :NEW."MATR" is null then 
         select Customer_Seq.nextval into :NEW."MATR" from dual; 
      end if; 
   end if; 
end;
/

create or replace trigger CreditAccount_Seq_Tr 
   before insert on "YELLOWCOM2"."CREDITACCOUNT_T" 
   for each row 
begin  
   if inserting then 
      if :NEW."MATR" is null then 
         select CreditAccount_Seq.nextval into :NEW."MATR" from dual; 
      end if; 
   end if; 
end;
/

create or replace trigger CloudDeplServ_Seq_Tr 
   before insert on "YELLOWCOM2"."CLOUDDEPLSERV_T" 
   for each row 
begin  
   if inserting then 
      if :NEW."IDD" is null then 
         select CloudDeplServ_Seq.nextval into :NEW."IDD" from dual; 
      end if; 
   end if; 
end;
/
