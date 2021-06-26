/*
This Framework is beneficial when we have more than one triggers on any object.
Developers extend this class, and override necessary methods which are needed.
Then they need to register their classes in a Custom meta data with the context and operation type


    Custom Meta Data details
    1. Class Name : Name of class
    2. Context : Before/After
    3. operation : delete, undelete, insert, update
    4. object name : for which object you want to run given class code
    5. Is Active : to enable /disable trigge logics
    

Usage : sample Account Trigger
trigger AccountTrigger on Account (before insert, after insert) {
    
        AbstractTriggerContext.run('Account',Trigger.operationType,Trigger.new, Trigger.old,Trigger.newMap,Trigger.oldMap);
}
    
*/



global abstract class AbstractTriggerContext {

    global static void run(String objectName, System.TriggerOperation operationType, List<sobject> newList, List<sObject> oldList, Map<Id,sObject> newMap, Map<Id, sObject> oldMap){
        //query the meta data
         for(TriggerContext__mdt record : getMetaData(objectName,operationType)){
             //get the instance
             AbstractTriggerContext instance = (AbstractTriggerContext)Type.forName(record.Class_Name__c).newInstance();
             //call the method
            if(operationType == System.TriggerOperation.BEFORE_INSERT){
                instance.beforeInsert(newList, oldList, newMap, oldMap);
            }else if(operationType == System.TriggerOperation.BEFORE_UPDATE){
                instance.beforeUpdate(newList, oldList, newMap, oldMap);
            }else if(operationType == System.TriggerOperation.BEFORE_DELETE){
                instance.beforeDelete(oldList, oldMap);
            }else if(operationType == System.TriggerOperation.AFTER_INSERT){
                instance.afterInsert(newList, oldList, newMap, oldMap);
            }else if(operationType == System.TriggerOperation.AFTER_UPDATE){
                instance.afterUpdate(newList, oldList, newMap, oldMap);
            }else if(operationType == System.TriggerOperation.AFTER_UNDELETE){
                instance.afterUndelete(newList, newMap);
            }
         }
    }
    
    global virtual void beforeInsert(List<sobject> newList, List<sObject> oldList, Map<Id,sObject> newMap, Map<Id, sObject> oldMap){
        //override for before insert logic
    }
    
    global virtual void beforeUpdate(List<sobject> newList, List<sObject> oldList, Map<Id,sObject> newMap, Map<Id, sObject> oldMap){
        //override for before update logic
    }
    
    global virtual void afterInsert(List<sobject> newList, List<sObject> oldList, Map<Id,sObject> newMap, Map<Id, sObject> oldMap){
        //override for after insert logic
    }
    
    global virtual void afterUpdate(List<sobject> newList, List<sObject> oldList, Map<Id,sObject> newMap, Map<Id, sObject> oldMap){
        //override for after update logic
    }
    
    global virtual void beforeDelete(List<sObject> oldList, Map<Id, sObject> oldMap){
        //override for before delete logic
    }
    
    global virtual void afterUndelete(List<sObject> newList, Map<Id, sObject> newMap){
        //override for after undelete logic
    }
    
    
    global static List<TriggerContext__mdt> getMetaData(String objectName, System.TriggerOperation operationType){
        
        String query = 'Select Class_Name__c from TriggerContext__mdt where Class_Name__c !=null And Is_Active__c = true AND Object_Name__C = :objectName';
        String context = '';
        if(operationType == System.TriggerOperation.BEFORE_INSERT){
            context = ' AND Context__c = \'Before\' AND Operation__c = \'Insert\'';
        }else if(operationType == System.TriggerOperation.BEFORE_UPDATE){
            context = ' AND Context__c = \'Before\' AND Operation__c = \'Update\'';
        }else if(operationType == System.TriggerOperation.BEFORE_DELETE){
            context = ' AND Context__c = \'Before\' AND Operation__c = \'Delete\'';
        }else if(operationType == System.TriggerOperation.AFTER_INSERT){
            context = ' AND Context__c = \'After\' AND Operation__c = \'Insert\'';
        }else if(operationType == System.TriggerOperation.AFTER_UPDATE){
            context = ' AND Context__c = \'After\' AND Operation__c = \'Update\'';
        }else if(operationType == System.TriggerOperation.AFTER_UNDELETE){
            context = ' AND Context__c = \'After\' AND Operation__c = \'UnDelete\'';
        }
        query +=context;
        return (List<TriggerContext__mdt>)Database.query(query);
    }
}