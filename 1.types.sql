CREATE OR REPLACE TYPE Highlight_Ty AS OBJECT
(
    keyFeat NUMBER,
    dataPrepr VARCHAR2(1000),
    keyInsight VARCHAR2(1000)
)
INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE Highlight_Table_Ty AS TABLE OF Highlight_Ty;
/

CREATE OR REPLACE TYPE Explaination_Ty AS OBJECT
(
    idd NUMBER,
    topic VARCHAR2(1000),
    title VARCHAR2(30),
    speakerName VARCHAR2(30),
    genre VARCHAR2(30),
    durationInMin NUMBER,
    fileFormat VARCHAR2(30)
)
NOT INSTANTIABLE NOT FINAL;
/

CREATE OR REPLACE TYPE Explaination_Array_Ty AS VARRAY(10) OF ref Explaination_Ty;
/

CREATE OR REPLACE TYPE Tutorial_Ty UNDER Explaination_Ty
()
INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE Webinar_Ty UNDER Explaination_Ty
()
INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE History_Ty AS OBJECT
(
    idd NUMBER,
    versionHist VARCHAR2(30),
    updateDate DATE,
    trainDs VARCHAR2(30),
    accuracy NUMBER,
    doc VARCHAR2(1000)
)
INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE History_Array_Ty AS VARRAY(10) OF ref History_Ty;
/

CREATE OR REPLACE TYPE Model_Ty AS OBJECT
(
    idd NUMBER,
    modelName VARCHAR2(30),
    algoType VARCHAR2(30),
    trainDs VARCHAR2(30),
    accuracy NUMBER,
    dateCreat DATE,
    avail NUMBER,
    price NUMBER,
    highlightTable Highlight_Table_Ty,
    explaination Explaination_Array_Ty,
    currentHist ref History_Ty,
    pastHist History_Array_Ty
)
NOT INSTANTIABLE NOT FINAL;
/

CREATE OR REPLACE TYPE PreTrained_Ty UNDER Model_Ty
(
    sizePreTrain NUMBER,
    formatPreTrain VARCHAR2(30),
    dependency VARCHAR2(1000)
)
INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE Deployed_Ty UNDER Model_Ty
(
    platfType VARCHAR2(30),
    ResAlloc VARCHAR2(30),
    URLDepl VARCHAR2(30),
    downloadNumb NUMBER
)
INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE CloudDeplServ_Ty AS OBJECT
(
    idd NUMBER,
    status VARCHAR2(30),
    costServ NUMBER,
    supportLevel VARCHAR2(30),
    startingDate DATE,
    endingDate DATE
)
INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE CloudDeplServ_Array_Ty AS VARRAY(10) OF ref CloudDeplServ_Ty;
/

CREATE OR REPLACE TYPE MethOfPaym_Ty AS OBJECT
(
    typeMethPaym VARCHAR2(30),
    commission NUMBER
)
INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE MethOfPaym_Table_Ty AS TABLE OF MethOfPaym_Ty;
/

CREATE OR REPLACE TYPE Customer_Ty AS OBJECT
(
    matr VARCHAR2(30),
    firstName VARCHAR2(30),
    surname VARCHAR2(30),
    email VARCHAR2(30),
    companyName VARCHAR2(30),
    paymentMethTable MethOfPaym_Table_Ty
)
INSTANTIABLE NOT FINAL;
/

CREATE OR REPLACE TYPE CreditAccount_Ty UNDER Customer_Ty
(
    creditLimit NUMBER,
    interestRate NUMBER,
    serviceAccessed CloudDeplServ_Array_Ty
)
INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE Transaction_Ty AS OBJECT
( 
    code NUMBER,
    dateTrans DATE,
    totalPrice NUMBER,
    modelInvolved ref Model_Ty,
    webinarRegistration ref Webinar_Ty,
    customerTrans ref Customer_Ty,
    cloudServSubscribed ref CloudDeplServ_Ty
)
INSTANTIABLE FINAL;
/