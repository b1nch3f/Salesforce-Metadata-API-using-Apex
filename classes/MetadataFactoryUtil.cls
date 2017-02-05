public with sharing class MetadataFactoryUtil {
	@RemoteAction
    public static String checkRetrieveStatus(String asyncProcessId,Boolean includeZip) {
        MetadataFactory.MetadataOutlet port = getPort();
        
        MetadataFactory.RetrieveResult result = port.checkRetrieveStatus(asyncProcessId, includeZip);
        
        System.debug(result.zipFile);
        
        return result.zipFile;
    }
    
    @RemoteAction
    public static String retrieve_x() {
        MetadataFactory.MetadataOutlet port = getPort();
        
        MetadataFactory.PackageTypeMembers member = new MetadataFactory.PackageTypeMembers();
        member.name = 'ApexTrigger';
        member.members = new String[]{'*'};
        
        MetadataFactory.PackageTypeMembers[] types = new MetadataFactory.PackageTypeMembers[]{member};
        
        MetadataFactory.Package_x pkg = new MetadataFactory.Package_x();
        pkg.types = types;
        
        MetadataFactory.RetrieveRequest r = new MetadataFactory.RetrieveRequest();
        r.apiVersion = 38.0;
        r.unpackaged = pkg;
        r.packageNames = new String[]{};
        r.singlePackage = false;
        r.specificFiles = new String[]{};
        
        MetadataFactory.AsyncResult result = port.retrieve_x(r);
        
        System.debug(result.id);
        System.debug(result.state);
        
        return result.id;
    }
    
    public static MetadataFactory.MetadataOutlet getPort() {
        MetadataFactory.SessionHeader_element sheader = new MetadataFactory.SessionHeader_element();
        sheader.sessionid = UserInfo.getSessionId();
        
        MetadataFactory.AllOrNoneHeader_element aonHeader= new MetadataFactory.AllOrNoneHeader_element();
        aonHeader.allOrNone = true;
        
        MetadataFactory.MetadataOutlet port = new MetadataFactory.MetadataOutlet();
        port.SessionHeader = sheader;
        port.AllOrNoneHeader = aonHeader;
        return port;
    }
}