xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="www.cencosud.cl/controlDeCredito/actualizacion";
(:: import schema at "../Schemas/ActualizarSchema.xsd" ::)
declare namespace ns2="http://xmlns.cencosud.corp/Core/EBM/Common/EBM";
(:: import schema at "../Schemas/EBM.xsd" ::)
declare namespace ns1="urn:sap-com:document:sap:soap:functions:mc-style";
(:: import schema at "../WSDL/ZWSRFC_ACT_CRED.wsdl" ::)

declare variable $SAP as element() (:: schema-element(ns1:ZrfcActCreditoResponse) ::) external;
declare variable $EBM as element() (:: schema-element(ns2:EBMHeader) ::) external;

declare function local:func($SAP as element() (:: schema-element(ns1:ZrfcActCreditoResponse) ::), 
                            $EBM as element() (:: schema-element(ns2:EBMHeader) ::)) 
                            as element() (:: schema-element(ns3:responseCredito) ::) {
    <ns3:responseCredito>
        <ns3:EBMHeaderSalida>
           {$EBM}
            <ns2:ReturnCode>200</ns2:ReturnCode>
		<ns2:ReturnMessage/>
		<ns2:ErrorCode/>
		<ns2:ErrorDetail>
			<ns2:ErrorType/>
			<ns2:HandlerServiceName/>
			<ns2:SourceApplication/>
			<ns2:SourceServiceName/>
			<ns2:SourceErrorCode/>
			<ns2:SourceErrorMessage/>
			<ns2:SourceErrorTrace/>
		</ns2:ErrorDetail>
            </ns3:EBMHeaderSalida>
        <ns3:idResp>{fn:data($SAP/IResp)}</ns3:idResp>
        <ns3:descResp>{fn:data($SAP/IDetRes)}</ns3:descResp>
    </ns3:responseCredito>
};

local:func($SAP, $EBM)
