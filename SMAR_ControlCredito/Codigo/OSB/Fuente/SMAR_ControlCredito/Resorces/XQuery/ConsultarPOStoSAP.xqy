xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="www.cencosud.cl/controlDeCredito/consulta";
(:: import schema at "../Schemas/ConsultaSchema.xsd" ::)
declare namespace ns2="urn:sap-com:document:sap:soap:functions:mc-style";
(:: import schema at "../WSDL/ZWSRFC_CON_CRED.wsdl" ::)

declare namespace ns3 = "http://xmlns.cencosud.corp/Core/EBM/Common/EBM";

declare variable $POS as element() (:: schema-element(ns1:ConsultaCredito) ::) external;
declare variable $saldo := fn:data($POS/ns1:Import) div 100 ;

declare function local:func($POS as element() (:: schema-element(ns1:ConsultaCredito) ::)) as element() (:: schema-element(ns2:ZrfcConsCredito) ::) {
    <ns2:ZrfcConsCredito>
        <IBukrs>{fn:data($POS/ns3:EBMHeader/ns3:Sender/ns3:LegalEntity)}</IBukrs>
        <ISaldo>{$saldo}</ISaldo>
        <IStcd1>{fn:translate($POS/ns1:Cuit, '-', '')}</IStcd1>
    </ns2:ZrfcConsCredito>
};

local:func($POS)
