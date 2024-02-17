CREATE TABLE AIRPORT(
    Airport_code    VARCHAR(64)     NOT NULL,
    City            VARCHAR(64)     NOT NULL,
    [State]         VARCHAR(64)     NOT NULL,
    [Name]          VARCHAR(64)     NOT NULL,
    PRIMARY KEY (Airport_code),
);

CREATE TABLE AIRPLANE_TYPE(
    Type_name   VARCHAR(64)     NOT NULL,
    Max_seats   INT             NOT NULL,
    Company     VARCHAR(64)     NOT NULL,
    PRIMARY KEY (Type_name),
);

CREATE TABLE CAN_LAND(
    ARPT_Airport_code   VARCHAR(64)     NOT NULL,
    ARPLT_Type_name     VARCHAR(64)     NOT NULL,
    PRIMARY KEY (ARPT_Airport_code, ARPLT_Type_name),
    FOREIGN KEY (ARPT_Airport_code) REFERENCES AIRPORT(Airport_code),
    FOREIGN KEY (ARPLT_Type_name) REFERENCES AIRPLANE_TYPE(Type_name),
);

CREATE TABLE AIRPLANE(
    Airplane_id             VARCHAR(64)     NOT NULL,
    Total_no_of_seats       INT             NOT NULL,
    ARPLT_Type_name         VARCHAR(64)     NOT NULL,
    PRIMARY KEY (Airplane_id),
    FOREIGN KEY (ARPLT_Type_name) REFERENCES AIRPLANE_TYPE(Type_name),
);

CREATE TABLE FLIGHT(
    [Number]    VARCHAR(64)     NOT NULL,
    Airline     VARCHAR(64)     NOT NULL,
    Weekdays    VARCHAR(64)     NOT NULL,
    PRIMARY KEY ([Number]),
);

CREATE TABLE FLIGHT_LEG(
    Leg_no              INT             NOT NULL,
    F_Number            VARCHAR(64)     NOT NULL,
    ARR_Airport_code    VARCHAR(64)     NOT NULL,
    DPA_Airport_code    VARCHAR(64)     NOT NULL,
    Scheduled_dep_time  DATETIME        NOT NULL,
    Scheduled_arr_time  DATETIME        NOT NULL,
    PRIMARY KEY (Leg_no, F_Number),
    FOREIGN KEY (F_Number)  REFERENCES FLIGHT([Number]),
    FOREIGN KEY (ARR_Airport_code) REFERENCES AIRPORT(Airport_code),
    FOREIGN KEY (DPA_Airport_code) REFERENCES AIRPORT(Airport_code),
);

CREATE TABLE LEG_INSTANCE(
    [Date]                  DATE            NOT NULL,
    No_of_avail_seats       INT             NOT NULL,
    ARPL_airplane_id        VARCHAR(64)     NOT NULL,
    FL_Leg_no               INT             NOT NULL,
    F_Number                VARCHAR(64)     NOT NULL,
    Dep_time                DATETIME        NOT NULL,
    Arr_time                DATETIME        NOT NULL,
    PRIMARY KEY ([Date], ARPL_airplane_id, FL_Leg_no, F_Number),
    FOREIGN KEY (ARPL_airplane_id) REFERENCES AIRPLANE(Airplane_id),
    FOREIGN KEY (FL_Leg_no, F_Number) REFERENCES FLIGHT_LEG(Leg_no, F_Number),
);

CREATE TABLE FARE(
    Amount          INT             NOT NULL,
    Code            VARCHAR(64)     NOT NULL,
    Restrictions    VARCHAR(1024)   NOT NULL,
    F_Number        VARCHAR(64)     NOT NULL,
    PRIMARY KEY (Code, F_Number),
    FOREIGN KEY (F_Number) REFERENCES FLIGHT([Number]),
);

CREATE TABLE SEAT(
    Seat_no         VARCHAR(3)      NOT NULL,
    Customer_name   VARCHAR(64)     NOT NULL,
    CPhone          VARCHAR(64)     NOT NULL,
    LI_Date         DATE            NOT NULL,
	ARPL_airplane_id        VARCHAR(64)     NOT NULL,
    FL_Leg_no       INT             NOT NULL,
    F_Number        VARCHAR(64)     NOT NULL,
    PRIMARY KEY (Seat_no, ARPL_airplane_id, LI_Date, FL_Leg_no, F_Number),
    FOREIGN KEY (LI_Date, ARPL_airplane_id, FL_Leg_no, F_Number) REFERENCES LEG_INSTANCE([Date], ARPL_airplane_id, FL_Leg_no, F_Number),
);