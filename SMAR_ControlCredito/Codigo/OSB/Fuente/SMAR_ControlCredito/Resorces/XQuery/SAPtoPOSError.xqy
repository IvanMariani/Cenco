xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="www.cencosud.cl/controlDeCredito/actualizacion";
(:: import schema at "../Schemas/ActualizarSchema.xsd" ::)
declare namespace ns1="http://xmlns.cencosud.corp/Core/EBM/Common/EBM";
(:: import schema at "../Schemas/EBM.xsd" ::)

declare variable $EBM as element() (:: schema-element(ns1:EBMHeader) ::) external;
declare variable $Fault as element() external;

declare function local:func($EBM as element() (:: schema-element(ns1:EBMHeader) ::), 
                            $Fault as element()) 
                            as element() (:: schema-element(ns2:responseCredito) ::) {
        <ns2:responseCredito>
        <ns2:EBMHeaderSalida>
           {$EBM}
            <ns1:ReturnCode>503</ns1:ReturnCode>
		<ns1:ReturnMessage/>
		<ns1:ErrorCode>{data($Fault/*:errorCode)}</ns1:ErrorCode>
		<ns1:ErrorDetail>
		<ns1:ErrorType>{data($Fault/*:reason)}</ns1:ErrorType>
			<ns1:HandlerServiceName/>
			<ns1:SourceApplication/>
			<ns1:SourceServiceName/>
			<ns1:SourceErrorCode/>
			<ns1:SourceErrorMessage/>
			<ns1:SourceErrorTrace/>
		</ns1:ErrorDetail>
          </ns2:EBMHeaderSalida>
        <ns2:idResp/>
        <ns2:descResp/>
        </ns2:responseCredito>
};
local:func($EBM, $Fault)
