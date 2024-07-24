CREATE OR REPLACE PROCEDURE random_history(n INT) AUTHID CURRENT_USER AS
    versionHist VARCHAR2(30);
    min_date CONSTANT VARCHAR2(10) := TO_CHAR(DATE '1910-01-01', 'J');
    max_date CONSTANT VARCHAR2(10) := TO_CHAR(DATE '1999-12-31', 'J');
    updateDate DATE;
    trainDs VARCHAR2(30);
    accuracy NUMBER;
    doc VARCHAR2(1000);
    
    history History_Ty;
BEGIN
    FOR i IN 1..n LOOP

        SELECT dbms_random.string('L', 30)
        INTO versionHist FROM dual;
        
        SELECT TO_DATE(TRUNC(dbms_random.value(min_date, max_date)), 'J')
        INTO updateDate FROM dual;
        
        SELECT dbms_random.string('L', 30)
        INTO trainDs FROM dual;
        
        SELECT round(dbms_random.value(0, 1), 2)
        INTO accuracy FROM dual;
        
        SELECT dbms_random.string('L', 1000)
        INTO doc FROM dual;
        
        SELECT History_Ty(null, versionHist, updateDate, trainDs, accuracy, doc)
        INTO history FROM dual;
        
        INSERT INTO History_T
        VALUES(history);
    END LOOP;
END;
/

CREATE OR REPLACE PROCEDURE random_tutorial(n INT) AUTHID CURRENT_USER AS
    topic VARCHAR2(1000);
    title VARCHAR2(30);
    speakerName VARCHAR2(30);
    genre VARCHAR2(30);
    durationInMin NUMBER;
    fileFormat VARCHAR2(30);
    
    tutorial Tutorial_Ty;
BEGIN
    FOR i IN 1..n LOOP

        SELECT dbms_random.string('L', 400)
        INTO topic FROM dual;
        
        SELECT dbms_random.string('L', 30)
        INTO title FROM dual;
                
        SELECT dbms_random.string('L', 30)
        INTO speakerName FROM dual;
                
        SELECT dbms_random.string('L', 30)
        INTO genre FROM dual;
        
        SELECT round(dbms_random.value(0, 30), 2)
        INTO durationInMin FROM dual;

        SELECT dbms_random.string('L', 30)
        INTO fileFormat FROM dual;
        
        SELECT Tutorial_Ty(null, topic, title, speakerName, genre, durationInMin, fileFormat)
        INTO tutorial FROM dual;
        
        INSERT INTO Tutorial_T
        VALUES(tutorial);
    END LOOP;
END;
/

CREATE OR REPLACE PROCEDURE random_webinar(n INT) AUTHID CURRENT_USER AS
    topic VARCHAR2(1000);
    title VARCHAR2(30);
    speakerName VARCHAR2(30);
    genre VARCHAR2(30);
    durationInMin NUMBER;
    fileFormat VARCHAR2(30);
    
    webinar Webinar_Ty;
BEGIN
    FOR i IN 1..n LOOP

        SELECT dbms_random.string('L', 400)
        INTO topic FROM dual;
        
        SELECT dbms_random.string('L', 30)
        INTO title FROM dual;
                
        SELECT dbms_random.string('L', 30)
        INTO speakerName FROM dual;
                
        SELECT dbms_random.string('L', 30)
        INTO genre FROM dual;
        
        SELECT round(dbms_random.value(0, 120), 2)
        INTO durationInMin FROM dual;

        SELECT dbms_random.string('L', 30)
        INTO fileFormat FROM dual;
        
        SELECT Webinar_Ty(null, topic, title, speakerName, genre, durationInMin, fileFormat)
        INTO webinar FROM dual;
        
        INSERT INTO Webinar_T
        VALUES(webinar);
    END LOOP;
END;
/

CREATE OR REPLACE PROCEDURE random_pre_trained(n INT) AUTHID CURRENT_USER AS
    modelName VARCHAR2(30);
    algoType VARCHAR2(30);
    trainDs VARCHAR2(30);
    accuracy NUMBER;
    min_date CONSTANT VARCHAR2(10) := TO_CHAR(DATE '1910-01-01', 'J');
    max_date CONSTANT VARCHAR2(10) := TO_CHAR(DATE '1999-12-31', 'J');
    dateCreat DATE;
    avail NUMBER;
    price NUMBER;
    highlightTable Highlight_Table_Ty;
    explaination Explaination_Array_Ty;
    currentHist ref History_Ty;
    pastHist History_Array_Ty;
    sizePreTrain NUMBER;
    formatPreTrain VARCHAR2(30);
    dependency VARCHAR2(1000);

    preTrained PreTrained_Ty;
BEGIN
    FOR i IN 1..(n/2) LOOP

        SELECT dbms_random.string('L', 30)
        INTO modelName FROM dual;

        SELECT dbms_random.string('L', 30)
        INTO algoType FROM dual;

        SELECT dbms_random.string('L', 30)
        INTO trainDs FROM dual;

        SELECT round(dbms_random.value(0, 1), 2)
        INTO accuracy FROM dual;

        SELECT TO_DATE(TRUNC(dbms_random.value(min_date, max_date)), 'J')
        INTO dateCreat FROM dual;

        SELECT round(dbms_random.value(0, 1000), 0)
        INTO avail FROM dual;

        SELECT round(dbms_random.value(100, 10000), 2)
        INTO price FROM dual;

        SELECT Highlight_Ty(
                            round(dbms_random.value(2, 20), 0),
                            dbms_random.string('L', 1000),
                            dbms_random.string('L', 1000)
                                )
        BULK COLLECT INTO highlightTable FROM dual CONNECT BY LEVEL <= 5; 

        SELECT REF(h) INTO currentHist
        FROM History_T h
        ORDER BY dbms_random.random
        FETCH FIRST 1 ROWS ONLY;

        SELECT REF(h) BULK COLLECT INTO pastHist
        FROM History_T h
        ORDER BY dbms_random.random
        FETCH FIRST 2 ROWS ONLY;

        SELECT round(dbms_random.value(10, 10000), 2)
        INTO sizePreTrain FROM dual;

        SELECT dbms_random.string('L', 30)
        INTO formatPreTrain FROM dual;

        SELECT dbms_random.string('L', 1000)
        INTO dependency FROM dual;

        SELECT REF(e) BULK COLLECT INTO explaination
        FROM Tutorial_T e
        ORDER BY dbms_random.random
        FETCH FIRST 2 ROWS ONLY;

        SELECT preTrained_Ty(null, modelName, algoType, trainDs, accuracy, dateCreat, avail, price, highlightTable, 
                                explaination, currentHist, pastHist, sizePreTrain, formatPreTrain, dependency
                                )
        INTO preTrained FROM dual;

        INSERT INTO PreTrained_T
        VALUES(preTrained);

    END LOOP;

    FOR i IN 1..(n/2) LOOP

        SELECT dbms_random.string('L', 30)
        INTO modelName FROM dual;

        SELECT dbms_random.string('L', 30)
        INTO algoType FROM dual;

        SELECT dbms_random.string('L', 30)
        INTO trainDs FROM dual;

        SELECT round(dbms_random.value(0, 1), 2)
        INTO accuracy FROM dual;

        SELECT TO_DATE(TRUNC(dbms_random.value(min_date, max_date)), 'J')
        INTO dateCreat FROM dual;

        SELECT round(dbms_random.value(0, 1000), 0)
        INTO avail FROM dual;

        SELECT round(dbms_random.value(100, 10000), 2)
        INTO price FROM dual;

        SELECT Highlight_Ty(
                            round(dbms_random.value(2, 20), 0),
                            dbms_random.string('L', 30),
                            dbms_random.string('L', 30)
                                )
         BULK COLLECT INTO highlightTable FROM dual CONNECT BY LEVEL <= 5;

        SELECT REF(h) INTO currentHist
        FROM History_T h
        ORDER BY dbms_random.random
        FETCH FIRST 1 ROWS ONLY;

        SELECT REF(h) BULK COLLECT INTO pastHist
        FROM History_T h
        ORDER BY dbms_random.random
        FETCH FIRST 2 ROWS ONLY;

        SELECT round(dbms_random.value(10, 10000), 2)
        INTO sizePreTrain FROM dual;

        SELECT dbms_random.string('L', 30)
        INTO formatPreTrain FROM dual;

        SELECT dbms_random.string('L', 1000)
        INTO dependency FROM dual;

        SELECT REF(e) BULK COLLECT INTO explaination
        FROM Webinar_T e
        ORDER BY dbms_random.random
        FETCH FIRST 2 ROWS ONLY;

        SELECT preTrained_Ty(null, modelName, algoType, trainDs, accuracy, dateCreat, avail, price, highlightTable, 
                                explaination, currentHist, pastHist, sizePreTrain, formatPreTrain, dependency
                                )
        INTO preTrained FROM dual;

        INSERT INTO PreTrained_T
        VALUES(preTrained);

    END LOOP;
END;
/

CREATE OR REPLACE PROCEDURE random_deployed(n INT) AUTHID CURRENT_USER AS
    modelName VARCHAR2(30);
    algoType VARCHAR2(30);
    trainDs VARCHAR2(30);
    accuracy NUMBER;
    min_date CONSTANT VARCHAR2(10) := TO_CHAR(DATE '1910-01-01', 'J');
    max_date CONSTANT VARCHAR2(10) := TO_CHAR(DATE '1999-12-31', 'J');
    dateCreat DATE;
    avail NUMBER;
    price NUMBER;
    highlightTable Highlight_Table_Ty;
    explaination Explaination_Array_Ty;
    currentHist ref History_Ty;
    pastHist History_Array_Ty;
    platfType VARCHAR2(30);
    ResAlloc VARCHAR2(30);
    URLDepl VARCHAR2(30);
    downloadNumb NUMBER;

    deployed Deployed_Ty;
BEGIN
    FOR i IN 1..(n/2) LOOP

        SELECT dbms_random.string('L', 30)
        INTO modelName FROM dual;

        SELECT dbms_random.string('L', 30)
        INTO algoType FROM dual;

        SELECT dbms_random.string('L', 30)
        INTO trainDs FROM dual;

        SELECT round(dbms_random.value(0, 1), 2)
        INTO accuracy FROM dual;

        SELECT TO_DATE(TRUNC(dbms_random.value(min_date, max_date)), 'J')
        INTO dateCreat FROM dual;

        SELECT round(dbms_random.value(0, 1000), 0)
        INTO avail FROM dual;

        SELECT round(dbms_random.value(100, 10000), 2)
        INTO price FROM dual;

        SELECT Highlight_Ty(
                            round(dbms_random.value(2, 20), 0),
                            dbms_random.string('L', 30),
                            dbms_random.string('L', 30)
                                )
        BULK COLLECT INTO highlightTable FROM dual CONNECT BY LEVEL <= 5;

        SELECT REF(h) INTO currentHist
        FROM History_T h
        ORDER BY dbms_random.random
        FETCH FIRST 1 ROWS ONLY;

        SELECT REF(h) BULK COLLECT INTO pastHist
        FROM History_T h
        ORDER BY dbms_random.random
        FETCH FIRST 2 ROWS ONLY;

        SELECT dbms_random.string('L', 30)
        INTO platfType FROM dual;

        SELECT dbms_random.string('L', 30)
        INTO ResAlloc FROM dual;
        
        SELECT dbms_random.string('L', 30)
        INTO URLDepl FROM dual;
        
        SELECT round(dbms_random.value(0, 100000), 0)
        INTO downloadNumb FROM dual;

        SELECT REF(e) BULK COLLECT INTO explaination
        FROM Tutorial_T e
        ORDER BY dbms_random.random
        FETCH FIRST 2 ROWS ONLY;

        SELECT deployed_Ty(null, modelName, algoType, trainDs, accuracy, dateCreat, avail, price, highlightTable, 
                                explaination, currentHist, pastHist, platfType, ResAlloc, URLDepl, downloadNumb
                                )
        INTO deployed FROM dual;
        
        INSERT INTO Deployed_T
        VALUES(deployed);
    
    END LOOP;

    FOR i IN 1..(n/2) LOOP

        SELECT dbms_random.string('L', 30)
        INTO modelName FROM dual;

        SELECT dbms_random.string('L', 30)
        INTO algoType FROM dual;

        SELECT dbms_random.string('L', 30)
        INTO trainDs FROM dual;

        SELECT round(dbms_random.value(0, 1), 2)
        INTO accuracy FROM dual;

        SELECT TO_DATE(TRUNC(dbms_random.value(min_date, max_date)), 'J')
        INTO dateCreat FROM dual;

        SELECT round(dbms_random.value(0, 1000), 0)
        INTO avail FROM dual;

        SELECT round(dbms_random.value(100, 10000), 2)
        INTO price FROM dual;

        SELECT Highlight_Ty(
                            round(dbms_random.value(2, 20), 0),
                            dbms_random.string('L', 700),
                            dbms_random.string('L', 700)
                                )
        BULK COLLECT INTO highlightTable FROM dual CONNECT BY LEVEL <= 5;

        SELECT REF(h) INTO currentHist
        FROM History_T h
        ORDER BY dbms_random.random
        FETCH FIRST 1 ROWS ONLY;

        SELECT REF(h) BULK COLLECT INTO pastHist
        FROM History_T h
        ORDER BY dbms_random.random
        FETCH FIRST 2 ROWS ONLY;

        SELECT dbms_random.string('L', 30)
        INTO platfType FROM dual;

        SELECT dbms_random.string('L', 30)
        INTO ResAlloc FROM dual;
        
        SELECT dbms_random.string('L', 30)
        INTO URLDepl FROM dual;
        
        SELECT round(dbms_random.value(0, 100000), 0)
        INTO downloadNumb FROM dual;

        SELECT REF(e) BULK COLLECT INTO explaination
        FROM Webinar_T e
        ORDER BY dbms_random.random
        FETCH FIRST 2 ROWS ONLY;

        SELECT deployed_Ty(null, modelName, algoType, trainDs, accuracy, dateCreat, avail, price, highlightTable, 
                                explaination, currentHist, pastHist, platfType, ResAlloc, URLDepl, downloadNumb
                                )
        INTO deployed FROM dual;
        
        INSERT INTO Deployed_T
        VALUES(deployed);
    
    END LOOP;
END;
/

CREATE OR REPLACE PROCEDURE random_cloud_depl_serv(n INT) AUTHID CURRENT_USER AS
    status VARCHAR2(30);
    costServ NUMBER;
    supportLevel VARCHAR2(30);
    min_date CONSTANT VARCHAR2(10) := TO_CHAR(DATE '1910-01-01', 'J');
    max_date CONSTANT VARCHAR2(10) := TO_CHAR(DATE '1999-12-31', 'J');
    startingDate DATE;
    endingDate DATE;

    cloud_depl_serv CloudDeplServ_Ty;
BEGIN
    FOR i IN 1..n LOOP

        SELECT dbms_random.string('L', 30)
        INTO status FROM dual;

        SELECT round(dbms_random.value(50, 1000), 2)
        INTO costServ FROM dual;

        SELECT dbms_random.string('L', 30)
        INTO supportLevel FROM dual;

        SELECT TO_DATE(TRUNC(dbms_random.value(min_date, max_date)), 'J')
        INTO startingDate FROM dual;

        SELECT startingDate + TRUNC(dbms_random.value(1, 365))
        INTO endingDate FROM dual;

        SELECT CloudDeplServ_Ty(null, status, costServ, supportLevel, startingDate, endingDate)
        INTO cloud_depl_serv FROM dual;

        INSERT INTO CloudDeplServ_T
        VALUES(cloud_depl_serv);
    END LOOP;
END;
/

CREATE OR REPLACE PROCEDURE random_customer(n INT) AUTHID CURRENT_USER AS
    firstName VARCHAR2(30);
    surname VARCHAR2(30);
    email VARCHAR2(30);
    companyName VARCHAR2(30);
    paymentMethTable MethOfPaym_Table_Ty;

    customer Customer_Ty;
BEGIN
    FOR i IN 1..n LOOP

        SELECT dbms_random.string('L', 30)
        INTO firstName FROM dual;

        SELECT dbms_random.string('L', 30)
        INTO surname FROM dual;

        SELECT dbms_random.string('L', 5) || '@' || dbms_random.string('L', 5) || '.com'
        INTO email FROM dual;

        SELECT dbms_random.string('L', 30)
        INTO companyName FROM dual;

        SELECT MethOfPaym_Ty(
                            dbms_random.string('L', 30),
                            round(dbms_random.value(0, 50), 2)
                                )
        BULK COLLECT INTO paymentMethTable FROM dual CONNECT BY LEVEL <= 3;

        SELECT Customer_Ty(null, firstName, surname, email, companyName, paymentMethTable)
        INTO customer FROM dual;

        INSERT INTO Customer_T
        VALUES(customer);
    END LOOP;
END;
/

CREATE OR REPLACE PROCEDURE random_credit_account(n INT) AUTHID CURRENT_USER AS
    firstName VARCHAR2(30);
    surname VARCHAR2(30);
    email VARCHAR2(30);
    companyName VARCHAR2(30);
    paymentMethTable MethOfPaym_Table_Ty;
    creditLimit NUMBER;
    interestRate NUMBER;
    serviceAccessed CloudDeplServ_Array_Ty;

    creditAccount creditAccount_Ty;
BEGIN
    FOR i IN 1..n LOOP

        SELECT dbms_random.string('L', 30)
        INTO firstName FROM dual;

        SELECT dbms_random.string('L', 30)
        INTO surname FROM dual;

        SELECT dbms_random.string('L', 5) || '@' || dbms_random.string('L', 5) || '.com'
        INTO email FROM dual;

        SELECT dbms_random.string('L', 30)
        INTO companyName FROM dual;

        SELECT MethOfPaym_Ty(
                            dbms_random.string('L', 30),
                            round(dbms_random.value(0, 50), 2)
                                )
        BULK COLLECT INTO paymentMethTable FROM dual CONNECT BY LEVEL <= 2;

        SELECT round(dbms_random.value(1000, 10000), 0)
        INTO creditLimit FROM dual;

        SELECT round(dbms_random.value(2, 10), 0)
        INTO creditLimit FROM dual;

        SELECT REF(s) BULK COLLECT INTO serviceAccessed
        FROM CloudDeplServ_T s
        ORDER BY dbms_random.random
        FETCH FIRST 2 ROWS ONLY;

        SELECT creditAccount_Ty(null, firstName, surname, email, companyName, paymentMethTable, creditLimit, interestRate, serviceAccessed)
        INTO creditAccount FROM dual;

        INSERT INTO CreditAccount_T
        VALUES(creditAccount);
    END LOOP;
END;
/

EXECUTE random_history(35000); 
/

EXECUTE random_tutorial(25000);
/

EXECUTE random_webinar(15000);
/

EXECUTE random_cloud_depl_serv(8000);
/

EXECUTE random_customer(40000);
/

EXECUTE random_credit_account(10000);
/

EXECUTE random_pre_trained(2000);
/

EXECUTE random_deployed(2000);
/
