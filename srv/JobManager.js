const cds = require("@sap/cds")

class JobManager extends cds.ApplicationService {
init() {

 
  const { JobPosting} = this.entities

  this.before('NEW', 'JobPosting.drafts', async req =>{
    if (req.data) {
      console.log("JobPosting.drafts")
      if (!req.user.is("creator")){
        req.error({code:"500", message: "User not allowed to create a job posting."});
        return;
    }
      const drafts = Array.isArray(req.data) ? req.data : [req.data];
      drafts.forEach((draft) => {
        const { maxID } = SELECT.one `max(jobId) as maxID` .from (JobPosting)
        draft.jobId = maxID + 1
        draft.status_code='D';
      });
    }
  }
  );


  this.before ('CREATE', 'JobPosting', async req => {
    console.log("JobPosting.CREATE");
    console.log(req.user.id)
    if (!req.user.is("creator")){
      req.error({code:"500", message: "User not allowed to create a job posting."});
      return;
  }
    const { maxID } = await SELECT.one `max(jobId) as maxID` .from (JobPosting)
    req.data.jobId = maxID + 1
    req.data.status_code = 'S'
  })

  this.before ('DELETE', 'JobPosting', async req => {
    console.log("JobPosting.Delete");
    if (!req.user.is("creator")){
      req.error({code:"500", message: "User not allowed to create a job posting."});
      return;
  }
  })
    //
    // Action Implementations...
    //
    this.on("acceptJobPosting", async (req) => {
      try {
        const ID = req.params[0];
        console.log("jobUUID for accept Jobposting");
        console.log(ID);
        console.log(req.user.id)
        if (req.user.is("creator")){
          req.error({code:"500", message: "User not allowed to Accept."});
          return;
      }
        const tx = cds.tx(req);
        console.log("tx:", tx);
        const updateResult =await tx
          .update(JobPosting)
          .set({ status_code: 'A' })
          .where(ID);

          if (updateResult === 0) {
            console.log("No matching records found for jobUUID:", ID);
            await tx.commit();
            return { };
          } else {
            await tx.commit();
            return { };
          }
      } catch (error) {
        console.log("error: " + error);
      }
    });

    this.on("rejectJobPosting", async (req) => {
      try {
        const ID = req.params[0];
        console.log("jobUUID for reject Jobposting");
        console.log(ID);
        console.log(req.user.id)
        if (req.user.is("creator")){
          req.error({code:"500", message: "User not allowed to Reject."});
          return;
      }
        const tx = cds.tx(req);
        console.log("tx:", tx);
        const updateResult =await tx
          .update(JobPosting)
          .set({ status_code: 'R' })
          .where(ID);

          if (updateResult === 0) {
            console.log("No matching records found for jobUUID:", ID);
            await tx.commit();
            return { };
          } else {
            await tx.commit();
            return { };
          }
      } catch (error) {
        console.log("error: " + error);
      }
    });
  
    // Add base class's handlers. Handlers registered above go first.
    return super.init()
  }
}
module.exports = { JobManager }
