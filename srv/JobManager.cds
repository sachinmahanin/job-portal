using { sap.jpms as my } from '../db/schema';


service JobManager{
  entity JobPosting as projection on my.JobPosting actions {
    action rejectJobPosting() ;
    action acceptJobPosting();

  };
  @readonly
  entity User as projection on my.User
}
annotate my.JobPosting with @odata.draft.enabled; 
annotate my.JobPosting with @(requires: ['creator','reviewer']);
 
