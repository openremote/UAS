CREATE MEMORY TABLE ACCOUNT(OID BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY);
CREATE MEMORY TABLE CONTROLLER(OID BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,LINKED BOOLEAN NOT NULL,MACADDRESS VARCHAR(255),ACCOUNT_OID BIGINT,CONSTRAINT FK25FE639CB58BED1B FOREIGN KEY(ACCOUNT_OID) REFERENCES ACCOUNT(OID));
CREATE MEMORY TABLE ROLE(OID BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,NAME VARCHAR(255));
CREATE MEMORY TABLE USER(OID BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,EMAIL VARCHAR(255),PASSWORD VARCHAR(255) NOT NULL,REGISTER_TIME TIMESTAMP,TOKEN VARCHAR(255),USERNAME VARCHAR(255) NOT NULL,VALID BOOLEAN NOT NULL,ACCOUNT_OID BIGINT,CONSTRAINT SYS_CT_52 UNIQUE(USERNAME),CONSTRAINT FK36EBCBB58BED1B FOREIGN KEY(ACCOUNT_OID) REFERENCES ACCOUNT(OID));
CREATE MEMORY TABLE COMMAND_REF_ITEM(TYPE VARCHAR(31) NOT NULL,OID BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,OFF_SWITCH_OID BIGINT,TARGET_DEVICE_COMMAND_OID BIGINT,SENSOR_OID BIGINT,SLIDER_OID BIGINT,ON_SWITCH_OID BIGINT);
CREATE MEMORY TABLE CONTROLLER_CONFIG(OID BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,CATEGORY VARCHAR(255),NAME VARCHAR(255) NOT NULL,VALUE LONGVARCHAR NOT NULL,ACCOUNT_OID BIGINT,CONSTRAINT FK7283154589CBAF07 FOREIGN KEY(ACCOUNT_OID) REFERENCES ACCOUNT(OID));
CREATE MEMORY TABLE DEVICE(OID BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,MODEL VARCHAR(255),NAME VARCHAR(255) NOT NULL,VENDOR VARCHAR(255),ACCOUNT_OID BIGINT,CONSTRAINT FKB06B1E5689CBAF07 FOREIGN KEY(ACCOUNT_OID) REFERENCES ACCOUNT(OID));
CREATE MEMORY TABLE DEVICE_ATTR(OID BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,NAME VARCHAR(255) NOT NULL,VALUE VARCHAR(255) NOT NULL,DEVICE_OID BIGINT NOT NULL,CONSTRAINT FKA400FA3A99B85655 FOREIGN KEY(DEVICE_OID) REFERENCES DEVICE(OID));
CREATE MEMORY TABLE DEVICE_COMMAND(OID BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,NAME VARCHAR(255) NOT NULL,SECTIONID VARCHAR(255),DEVICE_OID BIGINT,PROTOCOL_OID BIGINT NOT NULL,CONSTRAINT FKAE9FEE6299B85655 FOREIGN KEY(DEVICE_OID) REFERENCES DEVICE(OID));
CREATE MEMORY TABLE DEVICE_MACRO(OID BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,NAME VARCHAR(255) NOT NULL,ACCOUNT_OID BIGINT,CONSTRAINT FKDCBE84A389CBAF07 FOREIGN KEY(ACCOUNT_OID) REFERENCES ACCOUNT(OID));
CREATE MEMORY TABLE DEVICE_MACRO_ITEM(TYPE VARCHAR(31) NOT NULL,OID BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,DELAYSECOND VARCHAR(255),TARGET_DEVICE_CMD_OID BIGINT,PARENT_DEVICE_MACRO_OID BIGINT,TARGET_DEVICE_MACRO_OID BIGINT,CONSTRAINT FKC5461D2F84454B54 FOREIGN KEY(TARGET_DEVICE_MACRO_OID) REFERENCES DEVICE_MACRO(OID),CONSTRAINT FKC5461D2FC738A95B FOREIGN KEY(PARENT_DEVICE_MACRO_OID) REFERENCES DEVICE_MACRO(OID),CONSTRAINT FKC5461D2F11E9EF81 FOREIGN KEY(TARGET_DEVICE_CMD_OID) REFERENCES DEVICE_COMMAND(OID));
CREATE MEMORY TABLE PROTOCOL(OID BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,TYPE VARCHAR(255) NOT NULL);
CREATE MEMORY TABLE PROTOCOL_ATTR(OID BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,NAME VARCHAR(255) NOT NULL,VALUE LONGVARCHAR NOT NULL,PROTOCOL_OID BIGINT NOT NULL,CONSTRAINT FK2A276338BCA9D659 FOREIGN KEY(PROTOCOL_OID) REFERENCES PROTOCOL(OID));
CREATE MEMORY TABLE RANGE_SENSOR(MAX_VALUE INTEGER,MIN_VALUE INTEGER,OID BIGINT NOT NULL PRIMARY KEY);
CREATE MEMORY TABLE SENSOR(DTYPE VARCHAR(31) NOT NULL,OID BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,NAME VARCHAR(255) NOT NULL,TYPE INTEGER,ACCOUNT_OID BIGINT,DEVICE_OID BIGINT,CONSTRAINT FKCA0053BA99B85655 FOREIGN KEY(DEVICE_OID) REFERENCES DEVICE(OID),CONSTRAINT FKCA0053BA89CBAF07 FOREIGN KEY(ACCOUNT_OID) REFERENCES ACCOUNT(OID));
CREATE MEMORY TABLE SENSOR_REF_ITEM(TYPE VARCHAR(31) NOT NULL,OID BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,TARGET_SENSOR_OID BIGINT,SWITCH_OID BIGINT,SLIDER_OID BIGINT,CONSTRAINT FK9D044E24AAFF5E8B FOREIGN KEY(TARGET_SENSOR_OID) REFERENCES SENSOR(OID));
CREATE MEMORY TABLE SLIDER(OID BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,NAME VARCHAR(255),DEVICE_OID BIGINT,ACCOUNT_OID BIGINT,CONSTRAINT FKCA6078E189CBAF07 FOREIGN KEY(ACCOUNT_OID) REFERENCES ACCOUNT(OID),CONSTRAINT FKCA6078E199B85655 FOREIGN KEY(DEVICE_OID) REFERENCES DEVICE(OID));
CREATE MEMORY TABLE STATE(OID BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,NAME VARCHAR(255),VALUE VARCHAR(255),SENSOR_OID BIGINT NOT NULL,CONSTRAINT FK68AC49131441F6E FOREIGN KEY(SENSOR_OID) REFERENCES SENSOR(OID));
CREATE MEMORY TABLE SWITCH(OID BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,NAME VARCHAR(255),ACCOUNT_OID BIGINT,DEVICE_OID BIGINT,CONSTRAINT FKCAFBB73499B85655 FOREIGN KEY(DEVICE_OID) REFERENCES DEVICE(OID),CONSTRAINT FKCAFBB73489CBAF07 FOREIGN KEY(ACCOUNT_OID) REFERENCES ACCOUNT(OID));
CREATE MEMORY TABLE USER_ROLE(USER_OID BIGINT NOT NULL,ROLE_OID BIGINT NOT NULL,CONSTRAINT FK143BF46AF5DF7E3F FOREIGN KEY(USER_OID) REFERENCES USER(OID),CONSTRAINT FK143BF46AF5DC5A15 FOREIGN KEY(ROLE_OID) REFERENCES ROLE(OID));
ALTER TABLE COMMAND_REF_ITEM ADD CONSTRAINT FK160435B3EAC16F1D FOREIGN KEY(SENSOR_OID) REFERENCES SENSOR(OID);
ALTER TABLE COMMAND_REF_ITEM ADD CONSTRAINT FK160435B36B091F71 FOREIGN KEY(ON_SWITCH_OID) REFERENCES SWITCH(OID);
ALTER TABLE COMMAND_REF_ITEM ADD CONSTRAINT FK160435B3124D9292 FOREIGN KEY(TARGET_DEVICE_COMMAND_OID) REFERENCES DEVICE_COMMAND(OID);
ALTER TABLE COMMAND_REF_ITEM ADD CONSTRAINT FK160435B3BA0B25E1 FOREIGN KEY(OFF_SWITCH_OID) REFERENCES SWITCH(OID);
ALTER TABLE COMMAND_REF_ITEM ADD CONSTRAINT FK160435B3C70CCDEB FOREIGN KEY(SLIDER_OID) REFERENCES SLIDER(OID);
ALTER TABLE DEVICE_COMMAND ADD CONSTRAINT FKAE9FEE62BCA9D659 FOREIGN KEY(PROTOCOL_OID) REFERENCES PROTOCOL(OID);
ALTER TABLE RANGE_SENSOR ADD CONSTRAINT FKDE21A8FC8C6C4043 FOREIGN KEY(OID) REFERENCES SENSOR(OID);
ALTER TABLE SENSOR_REF_ITEM ADD CONSTRAINT FK9D044E24C70CCDEB FOREIGN KEY(SLIDER_OID) REFERENCES SLIDER(OID);
ALTER TABLE SENSOR_REF_ITEM ADD CONSTRAINT FK9D044E247105E911 FOREIGN KEY(SWITCH_OID) REFERENCES SWITCH(OID);
ALTER TABLE ACCOUNT ALTER COLUMN OID RESTART WITH 8;
ALTER TABLE CONTROLLER ALTER COLUMN OID RESTART WITH 1;
ALTER TABLE ROLE ALTER COLUMN OID RESTART WITH 5;
ALTER TABLE USER ALTER COLUMN OID RESTART WITH 8;
ALTER TABLE COMMAND_REF_ITEM ALTER COLUMN OID RESTART WITH 11;
ALTER TABLE CONTROLLER_CONFIG ALTER COLUMN OID RESTART WITH 30;
ALTER TABLE DEVICE ALTER COLUMN OID RESTART WITH 4;
ALTER TABLE DEVICE_ATTR ALTER COLUMN OID RESTART WITH 1;
ALTER TABLE DEVICE_COMMAND ALTER COLUMN OID RESTART WITH 7;
ALTER TABLE DEVICE_MACRO ALTER COLUMN OID RESTART WITH 1;
ALTER TABLE DEVICE_MACRO_ITEM ALTER COLUMN OID RESTART WITH 1;
ALTER TABLE PROTOCOL ALTER COLUMN OID RESTART WITH 7;
ALTER TABLE PROTOCOL_ATTR ALTER COLUMN OID RESTART WITH 4;
ALTER TABLE SENSOR ALTER COLUMN OID RESTART WITH 6;
ALTER TABLE SENSOR_REF_ITEM ALTER COLUMN OID RESTART WITH 3;
ALTER TABLE SLIDER ALTER COLUMN OID RESTART WITH 3;
ALTER TABLE STATE ALTER COLUMN OID RESTART WITH 2;
ALTER TABLE SWITCH ALTER COLUMN OID RESTART WITH 2;
INSERT INTO ROLE VALUES(1,'ROLE_DESIGNER');
INSERT INTO ROLE VALUES(2,'ROLE_MODELER');
INSERT INTO ROLE VALUES(3,'ROLE_ADMIN');
INSERT INTO ROLE VALUES(4,'ROLE_ACCOUNT_MANAGER');
INSERT INTO ACCOUNT VALUES(1);
INSERT INTO USER VALUES(1,'designer_appl@openremote.org','password',NULL,NULL,'designer_appl',TRUE,1);
INSERT INTO USER_ROLE VALUES(1, 4);