namespace sap.jpms;

using
{
    managed,
    sap.common.CodeList,
    cuid
}
from '@sap/cds/common';

entity Status : CodeList
{
    key code : String enum
    {
        DRAFT = 'D';
        SUBMITTED = 'S';
        APPROVED = 'A';
        REJECTED = 'R';
    };
}

entity JobPosting : cuid, managed
{
    jobId : Integer default 0
        @readonly
        @Common.Text : description;
    title : String(100);
    description : String(5000);
    requirements : String(5000);
    location : String(30);
    salary : Integer;
    creator : Association to one User on creator.name;
    reviewer : Association to one User on reviewer.name;
    status : Association to one Status;
}

entity User : cuid
{
    userId : Integer default 0
        @readonly
        @Common.Text : name;
    name : String(100);
    userType : Association to one UserType;
}

entity UserType : CodeList
{
    key code : String enum
    {
        CREATOR = 'C';
        REVIEWER = 'R';
    };
}

