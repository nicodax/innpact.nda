ALTER TABLE loan_provisions
    ADD
        SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN
           DEFAULT SYSUTCDATETIME()
      , SysEndTime DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN
          DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
        PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);

ALTER TABLE loan_provisions
    SET (SYSTEM_VERSIONING = ON);

ALTER TABLE loan_request_documents
    ADD
        SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN
           DEFAULT SYSUTCDATETIME()
      , SysEndTime DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN
          DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
        PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);

ALTER TABLE loan_request_documents
    SET (SYSTEM_VERSIONING = ON);

ALTER TABLE loan_requests
    ADD
        SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN
           DEFAULT SYSUTCDATETIME()
      , SysEndTime DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN
          DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
        PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);

ALTER TABLE loan_requests
    SET (SYSTEM_VERSIONING = ON);

ALTER TABLE loan_types
    ADD
        SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN
           DEFAULT SYSUTCDATETIME()
      , SysEndTime DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN
          DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
        PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);

ALTER TABLE loan_types
    SET (SYSTEM_VERSIONING = ON);

ALTER TABLE loan_versions
    ADD
        SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN
           DEFAULT SYSUTCDATETIME()
      , SysEndTime DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN
          DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
        PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);

ALTER TABLE loan_versions
    SET (SYSTEM_VERSIONING = ON);

ALTER TABLE loans
    ADD
        SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN
           DEFAULT SYSUTCDATETIME()
      , SysEndTime DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN
          DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
        PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);

ALTER TABLE loans
    SET (SYSTEM_VERSIONING = ON);