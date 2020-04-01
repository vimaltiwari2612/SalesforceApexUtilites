global class ApexUtilities{

	/*
	*	@methodName = getAllFields
	*	@return = Set of field Names
	*	@params = object name (both custom and standard)
	*	@description = Method takes object name as an argument and return all (both custom and standard) fields
	*/
	global static Set<String> getAllFields(String objectName){
		Map<String, Schema.SObjectType> completeSchema = Schema.getGlobalDescribe(); 
		Schema.SObjectType requiredObject = completeSchema.get(objectName);
		return requiredObject.getDescribe().fields.getMap().keySet();
	}
    
    /*
	*	@methodName = getAllFields
	*	@return = Map of object names and their field Names
	*	@params = List of object name (both custom and standard)
	*	@description = Method takes object name as an argument and return Map of object name and their (both custom and standard) fields
	*/
	global static Map<String, Set<String>> getAllFields(List<String> objectNames){
		Map<String, Schema.SObjectType> completeSchema = Schema.getGlobalDescribe(); 
        Map<String, Set<String>> objectVsFieldMap = new Map<String, Set<String>>();
        for(String objectName : objectNames){
            Schema.SObjectType requiredObject = completeSchema.get(objectName);
            objectVsFieldMap.put(objectName,requiredObject.getDescribe().fields.getMap().keySet());
        }
		return objectVsFieldMap;
	}
    
    /*
	*	@methodName = getAllCustomFields
	*	@return = Set of field Names
	*	@params = object name (both custom and standard)
	*	@description = Method takes object name as an argument and return all Custom fields
	*/
	global static Set<String> getAllCustomFields(String objectName){
		Map<String, Schema.SObjectType> completeSchema = Schema.getGlobalDescribe(); 
		Schema.SObjectType requiredObject = completeSchema.get(objectName);
        Set<String> customFields = new Set<String>(); 
        for(String field : requiredObject.getDescribe().fields.getMap().keySet()){
        	if(field.endsWithIgnoreCase('__c')){
                customFields.add(field);
            }
        }
        return customFields;
	}
    
    /*
	*	@methodName = getAllCustomFields
	*	@return = Map of object names and their field Names
	*	@params = List of object name (both custom and standard)
	*	@description = Method takes object name as an argument and return Map of object name and their (custom) fields
	*/
	global static Map<String, Set<String>> getAllCustomFields(List<String> objectNames){
		Map<String, Schema.SObjectType> completeSchema = Schema.getGlobalDescribe(); 
        Map<String, Set<String>> objectVsFieldMap = new Map<String, Set<String>>();
        for(String objectName : objectNames){
            Schema.SObjectType requiredObject = completeSchema.get(objectName);
            Set<String> customFields = new Set<String>(); 
            for(String field : requiredObject.getDescribe().fields.getMap().keySet()){
                if(field.endsWithIgnoreCase('__c')){
                    customFields.add(field);
                }
            }
            objectVsFieldMap.put(objectName,customFields);
        }
		return objectVsFieldMap;
	}
    
    /*
	*	@methodName = getAllStandardFields
	*	@return = Set of field Names
	*	@params = object name (both custom and standard)
	*	@description = Method takes object name as an argument and return all Standard fields
	*/
	global static Set<String> getAllStandardFields(String objectName){
		Map<String, Schema.SObjectType> completeSchema = Schema.getGlobalDescribe(); 
		Schema.SObjectType requiredObject = completeSchema.get(objectName);
        Set<String> standardFields = new Set<String>(); 
        for(String field : requiredObject.getDescribe().fields.getMap().keySet()){
        	if(!field.endsWithIgnoreCase('__c')){
                standardFields.add(field);
            }
        }
        return standardFields;
	}
    
    /*
	*	@methodName = getAllStandardFields
	*	@return = Map of object names and their field Names
	*	@params = List of object name (both custom and standard)
	*	@description = Method takes object name as an argument and return Map of object name and their (standard) fields
	*/
	global static Map<String, Set<String>> getAllStandardFields(List<String> objectNames){
		Map<String, Schema.SObjectType> completeSchema = Schema.getGlobalDescribe(); 
        Map<String, Set<String>> objectVsFieldMap = new Map<String, Set<String>>();
        for(String objectName : objectNames){
            Schema.SObjectType requiredObject = completeSchema.get(objectName);
            Set<String> sFields = new Set<String>(); 
            for(String field : requiredObject.getDescribe().fields.getMap().keySet()){
                if(!field.endsWithIgnoreCase('__c')){
                    sFields.add(field);
                }
            }
            objectVsFieldMap.put(objectName,sFields);
        }
		return objectVsFieldMap;
	}
    
    /*
	*	@methodName = getAllFieldsInNameSpace
	*	@return = Set of field Names
	*	@params = object name (both custom and standard), namespace
	*	@description = Method takes object name as an argument and return all Standard fields
	*/
    global static Set<String> getAllFieldsInNameSpace(String objectName,String namespace){
		Map<String, Schema.SObjectType> completeSchema = Schema.getGlobalDescribe(); 
		Schema.SObjectType requiredObject = completeSchema.get(objectName);
        Set<String> requiredFields = new Set<String>(); 
        for(String field : requiredObject.getDescribe().fields.getMap().keySet()){
        	if(field.startsWithIgnoreCase(namespace+'__')){
                requiredFields.add(field);
            }
        }
        return requiredFields;
	}
    
    /*
	*	@methodName = getAllFieldsInNameSpace
	*	@return = Map of object names and their field Names
	*	@params = list of object name (both custom and standard), namespace
	*	@description = Method takes object name as an argument and return Map of object name and their fields
	*/
	global static Map<String, Set<String>> getAllFieldsInNameSpace(List<String> objectNames,String namespace){
		Map<String, Schema.SObjectType> completeSchema = Schema.getGlobalDescribe(); 
        Map<String, Set<String>> objectVsFieldMap = new Map<String, Set<String>>();
        for(String objectName : objectNames){
            Schema.SObjectType requiredObject = completeSchema.get(objectName);
            Set<String> requiredFields = new Set<String>(); 
            for(String field : requiredObject.getDescribe().fields.getMap().keySet()){
                if(field.startsWithIgnoreCase(namespace+'__')){
                	requiredFields.add(field);
            	}
            }
            objectVsFieldMap.put(objectName,requiredFields);
        }
		return objectVsFieldMap;
	}
}
