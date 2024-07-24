CREATE TABLE creatDate_Dim (
    dateCreatId NUMBER PRIMARY KEY,
    dateCreat DATE
);
/

CREATE SEQUENCE creatDate_Seq;
/

create or replace trigger creatDate_Seq_Tr 
   before insert on "YELLOWCOM2"."CREATDATE_DIM" 
   for each row 
begin  
   if inserting then 
      if :NEW."DATECREATID" is null then 
         select PreTrained_Seq.nextval into :NEW."DATECREATID" from dual; 
      end if; 
   end if; 
end;
/

INSERT INTO creatDate_Dim(datecreatid, datecreat)
(
    SELECT null, "A1"."DATECREAT"   "DATECREAT"
    FROM "YELLOWCOM2"."PRETRAINED_T" "A1"
);


INSERT INTO creatDate_Dim(datecreatid, datecreat)
(
    SELECT null, "A1"."DATECREAT"   "DATECREAT"
    FROM "YELLOWCOM2"."DEPLOYED_T" "A1"
);



CREATE TABLE algoType_Dim (
    algoTypeId NUMBER PRIMARY KEY,
    algoType VARCHAR2(30)
);
/

CREATE SEQUENCE algoType_Seq;
/

create or replace trigger algoType_Seq_Tr 
   before insert on "YELLOWCOM2"."ALGOTYPE_DIM" 
   for each row 
begin  
   if inserting then 
      if :NEW."ALGOTYPEID" is null then 
         select PreTrained_Seq.nextval into :NEW."ALGOTYPEID" from dual; 
      end if; 
   end if; 
end;
/

INSERT INTO algoType_Dim(algotypeid, algotype)
(
    SELECT null, "A1"."ALGOTYPE"    "ALGOTYPE"
    FROM "YELLOWCOM2"."PRETRAINED_T" "A1"
);

INSERT INTO algoType_Dim(algotypeid, algotype)
(
    SELECT null, "A1"."ALGOTYPE"    "ALGOTYPE"
    FROM "YELLOWCOM2"."DEPLOYED_T" "A1"
);



CREATE TABLE modelType_Dim (
    modelTypeId NUMBER PRIMARY KEY,
    modelType VARCHAR2(30)
);
/

INSERT INTO modelType_Dim VALUES (1, 'PreTrained');
INSERT INTO modelType_Dim VALUES (2, 'Deployed');



CREATE TABLE model_Fact (
    idd NUMBER PRIMARY KEY,
    price NUMBER,
    accuracy NUMBER,
    dateCreatId NUMBER,
    algoTypeId NUMBER,
    modelTypeId NUMBER,
    FOREIGN KEY (dateCreatId) REFERENCES CREATDATE_DIM(DATECREATID),
    FOREIGN KEY (algoTypeId) REFERENCES ALGOTYPE_DIM(ALGOTYPEID),
    FOREIGN KEY (modelTypeId) REFERENCES MODELTYPE_DIM(MODELTYPEID)
);
/

CREATE SEQUENCE model_Fact_Seq;
/

create or replace trigger model_Fact_Seq_Tr 
   before insert on "YELLOWCOM2"."MODEL_FACT" 
   for each row 
begin  
   if inserting then 
      if :NEW."IDD" is null then 
         select model_Fact_Seq.nextval into :NEW."IDD" from dual; 
      end if; 
   end if; 
end;
/

INSERT INTO model_Fact(idd, accuracy, price, dateCreatId, algoTypeId, modelTypeId)
(   
    SELECT 
        null,
        "A1"."ACCURACY",
        "A1"."PRICE",
        "A2"."DATECREATID",
        "A3"."ALGOTYPEID",
        1
    FROM "YELLOWCOM2"."PRETRAINED_T" "A1", "YELLOWCOM2"."CREATDATE_DIM" "A2", "YELLOWCOM2"."ALGOTYPE_DIM" "A3"
    WHERE "A2"."DATECREAT" = "A1"."DATECREAT" AND "A3"."ALGOTYPE" = "A1"."ALGOTYPE"
);

INSERT INTO model_Fact(idd, accuracy, price, dateCreatId, algoTypeId, modelTypeId)
(   
    SELECT 
        null,
        "A1"."ACCURACY",
        "A1"."PRICE",
        "A2"."DATECREATID",
        "A3"."ALGOTYPEID",
        2
    FROM "YELLOWCOM2"."DEPLOYED_T" "A1", "YELLOWCOM2"."CREATDATE_DIM" "A2", "YELLOWCOM2"."ALGOTYPE_DIM" "A3"
    WHERE "A2"."DATECREAT" = "A1"."DATECREAT" AND "A3"."ALGOTYPE" = "A1"."ALGOTYPE"
);
