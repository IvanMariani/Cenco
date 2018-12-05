xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="www.cencosud.cl/controlDeCredito/actualizacion";
(:: import schema at "../Schemas/ActualizarSchema.xsd" ::)
declare namespace ns2="urn:sap-com:document:sap:soap:functions:mc-style";
(:: import schema at "../WSDL/ZWSRFC_ACT_CRED.wsdl" ::)

declare namespace ns3 = "http://xmlns.cencosud.corp/Core/EBM/Common/EBM";

declare variable $POS as element() (:: schema-element(ns1:ActualizarCredito) ::) external;
declare variable $saldo := fn:data($POS/ns1:Import) div 100 ;


declare function local:func($POS as element() (:: schema-element(ns1:ActualizarCredito) ::)) as element() (:: schema-element(ns2:ZrfcActCredito) ::) {
    <ns2:ZrfcActCredito>
        <IBukrs>{fn:data($POS/ns3:EBMHeader/ns3:Sender/ns3:LegalEntity)}</IBukrs>
        <ICpudt>{fn:data($POS/ns1:FecTransaccion)}</ICpudt>
        <ICputm>{fn:data($POS/ns1:HoraTransaccion)}</ICputm>
        <ISaldo>{$saldo}</ISaldo>   
        <IXblnr>{fn:data($POS/ns1:DNI)}</IXblnr>
        <IStcd1>{fn:translate($POS/ns1:Cuit, '-', '')}</IStcd1>
    </ns2:ZrfcActCredito>
};

local:func($POS)
