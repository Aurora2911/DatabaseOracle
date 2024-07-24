CREATE TABLE PreTrained_T OF PreTrained_ty
    NESTED TABLE highlightTable STORE AS prTrHighlightStorage;
/

CREATE TABLE Deployed_T OF Deployed_Ty
    NESTED TABLE highlightTable STORE AS deplHighlightStorage;
/

CREATE TABLE History_T OF History_Ty;
/

CREATE TABLE Tutorial_T OF Tutorial_Ty;
/

CREATE TABLE Webinar_T OF Webinar_Ty;
/

CREATE TABLE Customer_T OF Customer_Ty
    NESTED TABLE paymentMethTable STORE AS cusPaymMethStorage;
/

CREATE TABLE CreditAccount_T OF CreditAccount_Ty
    NESTED TABLE paymentMethTable STORE AS credAccPaymMethStorage;
/

CREATE TABLE CloudDeplServ_T OF CloudDeplServ_Ty;
/
