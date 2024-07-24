CREATE OR REPLACE TRIGGER trg_check_size_pretrain
AFTER INSERT ON PreTrained_T
FOR EACH ROW
BEGIN
    IF :NEW.sizePreTrain <= 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Pretrained size must be greater than zero.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_check_cloud_service_dates
AFTER INSERT ON CloudDeplServ_T
FOR EACH ROW
BEGIN
    IF :NEW.startingDate >= :NEW.endingDate THEN
        RAISE_APPLICATION_ERROR(-20004, 'Starting date must be less than ending date.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_check_accuracy_range_prtr
BEFORE INSERT OR UPDATE ON PreTrained_T
FOR EACH ROW
BEGIN
    IF :NEW.accuracy < 0 OR :NEW.accuracy > 1 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Accuracy must be between 0 and 1.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_check_accuracy_range_depl
BEFORE INSERT OR UPDATE ON Deployed_T
FOR EACH ROW
BEGIN
    IF :NEW.accuracy < 0 OR :NEW.accuracy > 1 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Accuracy must be between 0 and 1.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_update_support_level
AFTER UPDATE ON CloudDeplServ_T
FOR EACH ROW
BEGIN
    IF :NEW.costServ > 500 THEN
        UPDATE CloudDeplServ_T
        SET supportLevel = 'Premium'
        WHERE idd = :NEW.idd;
    ELSIF :NEW.costServ <= 500 THEN
        UPDATE CloudDeplServ_T
        SET supportLevel = 'Standard'
        WHERE idd = :NEW.idd;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_check_payment_methods
BEFORE INSERT OR UPDATE ON Customer_T
FOR EACH ROW
DECLARE
    payment_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO payment_count
    FROM TABLE(:NEW.paymentMethTable);

    IF payment_count > 5 THEN
        RAISE_APPLICATION_ERROR(-20017, 'A customer can have at most five methods of payment stored.');
    END IF;
END;
/