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

    if(-not ($KeyValue.ObjectType -ne "Person" -or $KeyValue.ObjectType -ne "Group"))
    {
        throw "Object type $($KeyValue.ObjectType) not supported"
    }

    if($KeyValue.Operation -ne "Update")
    {
        throw "Operation on objectID $($KeyValue.ObjectID) cannot complete, operation $($KeyValue.Operation) is not supported or null"
    }

    if(-not $KeyValue.ObjectName)
    {
        throw "ObjectName $($KeyValue.ObjectName) is not supported or null"
    }

    [string]$ObjectID    = $KeyValue.ObjectID
    [string]$ObjectType  = $KeyValue.ObjectType
    [string]$ObjectName  = $KeyValue.ObjectName
    [string]$ObjectValue = $KeyValue.ObjectValue

    [string]$xPath = "//$ObjectType[@ObjectID = '$ObjectID']"
    Write-Verbose -Message "$f -  xpath = $xPath"

    $obj = $db | Select-Xml -XPath $xPath
    Write-Verbose -Message "$F -  ObjectName = $ObjectName = $ObjectValue"

    $obj.Node.$ObjectName = $ObjectValue

    Set-Variable -Name xml -Value $db.InnerXml -Scope Global    
}