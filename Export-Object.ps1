function Export-Object
{
[cmdletbinding()]
Param(
    [Parameter(Mandatory)]
    [string]$xPath
    ,
    [pscredential]$Credential
    ,
    [string]$Uri
)
    $f = $MyInvocation.InvocationName
    Write-Verbose -Message "$f - START"
    
    Write-Verbose -Message "$f -  Getting data"
    $data = Get-XMLdocument

    Write-Verbose -Message "$f - xpath = $xPath"

    Write-Verbose -Message "$f -  Returning objects"
    Select-Xml -Xml $data -XPath $xPath

    Write-Verbose -Message "$f - END"
}