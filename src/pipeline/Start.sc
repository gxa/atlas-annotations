import $file.retrieve.Tasks
import $file.retrieve.Retrieve
import $file.is_ready.PropertiesAdequate
import $file.Log

/**
  * This method first verifies the annotation sources against all experiment
  * folders. The method will exit completely on any failure. If all validations go through
  * then it will proceed to perform all the biomart tasks through BioMart.sc
  *
  * @param force
  */
@main
def runAll(force:Boolean=false) = {
  Log.log("Going through experiment directories to verify our annotation sources")
  (PropertiesAdequate.main,force) match {
    case (Left(err),false)
      => {
        Log.log("Failed validation - annotation sources not sufficient, see err")
        Log.err(err)
        System.exit(1)
      }
    case (t, _)
      => {
        Log.log(t.right.map(Function.const("Validated annotation sources contain the array designs we need")).merge)
        System.exit(
            Retrieve.performBioMartTasks(
                Tasks.allTasks
            )
        )
      }
  }
}
