xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.cencosud.corp/Core/EBM/Common/EBM";
(:: import schema at "../Schemas/EBM.xsd" ::)

declare variable $EBMHeader as element() (:: schema-element(ns1:EBMHeader) ::) external;
declare variable $EBMID as xs:string external;
declare variable $Application as xs:string external;
declare variable $Target as xs:string external;
declare variable $BusinessUnit as xs:string external;
declare variable $IntegrationCode as xs:string external;

declare function local:func($POS as element() (:: schema-element(ns1:EBMHeader) ::), 
                            $EBMID as xs:string, 
                            $Application as xs:string, 
                            $Target as xs:string, 
                            $BusinessUnit as xs:string, 
                            $IntegrationCode as xs:string) 
                            as element() (:: schema-element(ns1:EBMHeader) ::) 
                            
    {
   
   <ns1:EBMHeader>{
    if (fn:data($POS/ns1:EBMID) = '') 
    then<ns1:EBMID>{$EBMID}</ns1:EBMID>
    else<ns1:EBMID>{fn:data($POS/ns1:EBMID)}</ns1:EBMID>
    }
    {
    if ($POS/ns1:CreationDateTime)
    then     
            if (xs:string($POS/ns1:CreationDateTime) = '')
            then <ns1:CreationDateTime>{fn:current-dateTime()}</ns1:CreationDateTime>
            else <ns1:CreationDateTime>{fn:data($POS/ns1:CreationDateTime)}</ns1:CreationDateTime>
        else()
        }
        {
            if ($POS/ns1:Sender)
            then 
                <ns1:Sender>
                    {
                        if (fn:data($POS/ns1:Sender/ns1:Application) = '')
                        then <ns1:Application>{$Application}</ns1:Application>
                        else <ns1:Application>{fn:data($POS/ns1:Sender/ns1:Application)}</ns1:Application>
                    }
                    {
                        if ($POS/ns1:Sender/ns1:Country)
                        then <ns1:Country>{fn:data($POS/ns1:Sender/ns1:Country)}</ns1:Country>
                        else ()
                    }
                    {
                        if ($POS/ns1:Sender/ns1:ApplicationModule)
                        then <ns1:ApplicationModule>{fn:data($POS/ns1:Sender/ns1:ApplicationModule)}</ns1:ApplicationModule>
                        else ()
                    }
                    {
                        if ($POS/ns1:Sender/ns1:CallingServiceName)
                        then <ns1:CallingServiceName>{fn:data($POS/ns1:Sender/ns1:CallingServiceName)}</ns1:CallingServiceName>
                        else ()
                    }
                    {
                        if (fn:data($POS/ns1:Sender/ns1:BusinessUnit) = '')
                        then <ns1:BusinessUnit>{$BusinessUnit}</ns1:BusinessUnit>
                        else <ns1:BusinessUnit>{fn:data($POS/ns1:Sender/ns1:BusinessUnit)}</ns1:BusinessUnit>
                    }
                    {
                        if ($POS/ns1:Sender/ns1:LegalEntity)
                        then <ns1:LegalEntity>{fn:data($POS/ns1:Sender/ns1:LegalEntity)}</ns1:LegalEntity>
                        else ()
                    }
                </ns1:Sender>
            else ()
        }
        {
      if ($POS/ns1:Target)
      then    
            if (fn:data($POS/ns1:Target) = '')
            then <ns1:Target>{$Target}</ns1:Target>
            else <ns1:Target>{fn:data($POS/ns1:Target)}</ns1:Target>
            
      else()
        }
        {
            for $BusinessScope in $POS/ns1:BusinessScope
            return 
            <ns1:BusinessScope>{fn:data($POS/ns1:BusinessScope)}</ns1:BusinessScope>
        }
        {
            if ($POS/ns1:QualityOfService)
            then 
                <ns1:QualityOfService>
                    {
                        if ($POS/ns1:QualityOfService/ns1:RetryCount)
                        then <ns1:RetryCount>{fn:data($POS/ns1:QualityOfService/ns1:RetryCount)}</ns1:RetryCount>
                        else ()
                    }
                </ns1:QualityOfService>
            else ()
        }
        {
            for $EBMTracking in $POS/ns1:EBMTracking
            return 
            <ns1:EBMTracking>
                {
                    if ($EBMTracking/ns1:FileName)
                    then <ns1:FileName>{fn:data($EBMTracking/ns1:FileName)}</ns1:FileName>
                    else ()
                }
                {
                    if ($EBMTracking/ns1:ParentEBMID)
                    then <ns1:ParentEBMID>{fn:data($EBMTracking/ns1:ParentEBMID)}</ns1:ParentEBMID>
                    else ()
                }
                {
                    if (fn:data($EBMTracking/ns1:IntegrationCode) = '')
                    then <ns1:IntegrationCode>{$IntegrationCode}</ns1:IntegrationCode>
                    else <ns1:IntegrationCode>{fn:data($EBMTracking/ns1:IntegrationCode)}</ns1:IntegrationCode>
                }
                {
                    if ($EBMTracking/ns1:ReferenceID)
                    then <ns1:ReferenceID>{fn:data($EBMTracking/ns1:ReferenceID)}</ns1:ReferenceID>
                    else ()
                }
            </ns1:EBMTracking>
        }
    </ns1:EBMHeader>
};

local:func($EBMHeader, $EBMID, $Application, $BusinessUnit, $Target, $IntegrationCode)