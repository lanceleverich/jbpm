alter table RequestInfo add column priority integer;
alter table ProcessInstanceLog add column processType integer;

update ProcessInstanceLog set processType = 1;
update RequestInfo set priority = 5;

create table CaseIdInfo (
    id bigint generated by default as identity (start with 1),
    caseIdPrefix varchar(255),
    currentValue bigint,
    primary key (id)
);

create table CaseRoleAssignmentLog (
    id bigint generated by default as identity (start with 1),
    caseId varchar(255),
    entityId varchar(255),
    processInstanceId bigint not null,
    roleName varchar(255),
    type integer not null,
    primary key (id)
);

alter table CaseIdInfo 
        add constraint UK_CaseIdInfo_1 unique (caseIdPrefix);
        
ALTER TABLE NodeInstanceLog ADD COLUMN referenceId bigint;
ALTER TABLE NodeInstanceLog ADD COLUMN nodeContainerId varchar(255);  

ALTER TABLE RequestInfo ADD COLUMN processInstanceId bigint;

ALTER TABLE AuditTaskImpl ADD COLUMN lastModificationDate timestamp;
update AuditTaskImpl ati set lastModificationDate = (
    select max(logTime) from TaskEvent where taskId=ati.taskId group by taskId
);

create table CaseFileDataLog (
    id bigint generated by default as identity (start with 1),
    caseDefId varchar(255),
    caseId varchar(255),
    itemName varchar(255),
    itemType varchar(255),
    itemValue varchar(255),
    lastModified timestamp,
    lastModifiedBy varchar(255),
    primary key (id)
);

create table ExecutionErrorInfo (
    id bigint generated by default as identity (start with 1),
    ERROR_ACK boolean,
    ERROR_ACK_AT timestamp,
    ERROR_ACK_BY varchar(255),
    ACTIVITY_ID bigint,
    ACTIVITY_NAME varchar(255),
    DEPLOYMENT_ID varchar(255),
    ERROR_INFO longvarchar,
    ERROR_DATE timestamp,
    ERROR_ID varchar(255),
    ERROR_MSG varchar(255),
    JOB_ID bigint,
    PROCESS_ID varchar(255),
    PROCESS_INST_ID bigint,
    ERROR_TYPE varchar(255),
    primary key (id)
);