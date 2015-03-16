function Import-Object
{
[cmdletbinding()]
Param(
    [Parameter(Mandatory)]
    [Hashtable]$KeyValue
    ,
    [pscredential]$Credential
    ,
    [string]$Uri
)
    $f = $MyInvocation.InvocationName
    Write-Verbose -Message "$f - START"

    Write-Verbose -Message "$f -  Getting data"
    $db = Get-XMLdocument

    [string]$ObjectID    = $KeyValue.ObjectID
    [string]$ObjectType  = $KeyValue.ObjectType
    [string]$ObjectName  = $KeyValue.ObjectName
    [string]$ObjectValue = $KeyValue.ObjectValue
    [string]$Operation   = $KeyValue.Operation

    if(-not ($ObjectType -ne "Person" -or $ObjectType -ne "Group"))
    {
        throw "Object type '$ObjectType' not supported"
    }

    if($Operation -ne "Update")
    {
        throw "'$Operation' operation on objectID '$ObjectID' cannot complete, the operation is not supported or null"
    }

    if(-not $ObjectName)
    {
        throw "ObjectName '$ObjectName' is not supported or null"
    }

    [string]$xPath = "//$ObjectType[@ObjectID = '$ObjectID']"
    Write-Verbose -Message "$f -  xPath = $xPath"

    $obj = $db | Select-Xml -XPath $xPath
    Write-Verbose -Message "$F -  ObjectName = $ObjectName = $ObjectValue"

    $obj.Node.$ObjectName = $ObjectValue

    Write-Verbose -Message "$f -  Updating global scope variable"
    Set-Variable -Name xml -Value $db.InnerXml -Scope Global 
    
    Write-Verbose -Message "$f - END"   
}