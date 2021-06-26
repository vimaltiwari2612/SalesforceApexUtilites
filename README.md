# SalesforceApexUtilites

Many times, we came across such scenarios, where we need to use Apex standard APIs like Schema or Describe, and we end up searching the code on the Internet.

Here is a Util class, that you can deploy in your org and use it whenever needed. Also, add new methods in it, if required.

The class had All the bulkified versions of all methods too.

https://medium.com/elevate-salesforce/salesforce-apex-utilities-fe11692a9288


--------------------------------------------------
# Trigger Framework POC 

***This Framework is beneficial when we have more than one triggers on any object. This Framwwork will help us to keep only one trigger on an object irrrespective of different packages and business use cases***

Developers extend "AbstractTriggerContext" class, and override necessary methods which are needed.
Then they need to register their classes in a Custom meta data with the context and operation type

**Framework Overview**

![Image](https://github.com/vimaltiwari2612/SalesforceApexUtilites/blob/master/Trigger%20Framework/TriggerFramework.png)



    Custom Meta Data details
    1. Class Name : Name of class
    2. Context : Before/After
    3. operation : delete, undelete, insert, update
    4. object name : for which object you want to run given class code
    5. Is Active : to enable /disable trigge logics
    

    Usage : Sample Account Trigger
    trigger AccountTrigger on Account (before insert, after insert) {

            AbstractTriggerContext.run('Account',Trigger.operationType,Trigger.new, Trigger.old,Trigger.newMap,Trigger.oldMap);
    }
    


