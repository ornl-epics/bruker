#!../../bin/linux-x86_64/bl4a-bruker

## You may have to change bl4a-bruker to something else
## everywhere it appears in this file

< envPaths

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/bl4a-bruker.dbd"




bl4a_bruker_registerRecordDeviceDriver pdbbase
asynSetAutoConnectTimeout(1.0)
drvAsynIPPortConfigure( "bruker1", "10.112.131.20:4002 tcp", 0, 0, 0 )


#enables debugging 0xff is the max setting
#asynSetTraceIOMask("bruker1", 0,0xff)
#asynSetTraceMask("bruker1", 0,0xff)



## Load record instances
#dbLoadRecords("db/xxx.db","user=zmaHost")
dbLoadRecords("db/bruker1.db")


#################################################################
#autosave

epicsEnvSet("IOCNAME","bl4a-Bruker")
epicsEnvSet("SAVE_DIR","/home/controls/var/$(IOCNAME)")

save_restoreSet_Debug(0)

### status-PV prefix, so save_restore can find its status PV's.
save_restoreSet_status_prefix("BL4A:SE:Bruker:")

set_requestfile_path("$(SAVE_DIR)")
set_savefile_path("$(SAVE_DIR)")

save_restoreSet_NumSeqFiles(3)
save_restoreSet_SeqPeriodInSeconds(600)
set_pass0_restoreFile("$(IOCNAME).sav")

#################################################################

var mediatorVerbosity 7

var mySubDebug 7 

cd ${TOP}/iocBoot/${IOC}
iocInit


epicsThreadSleep(5)
makeAutosaveFileFromDbInfo("$(SAVE_DIR)/$(IOCNAME).req", "autosaveFields")
create_monitor_set("$(IOCNAME).req", 5)


#enables debugging 0xff is the max setting 
asynSetTraceIOMask("bruker1", 0,0xff) 
asynSetTraceMask("bruker1", 0,0xff) 

