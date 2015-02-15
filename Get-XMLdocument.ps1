Function Get-XMLdocument
{
[CmdletBinding()]
Param()
    $f = $MyInvocation.InvocationName
    Write-Verbose -Message "$f - START"

$data = @"
<xml version="1.0" encoding="UTF-8">
    <SillySystem>
        <Person Name="Tore" DisplayName = "Tore Groneng" ObjectID="db8740f2-d7a8-429e-8b3b-0e637c13de61"/>
        <Person Name="John" DisplayName = "Doe" ObjectID="f912a290-0772-4a29-af05-198a383ed72c"/>
        <Group Name="Users" Description = "Contains all users" ObjectID="99c026f4-6a13-489a-84ea-5e070e26cf5f"/>
        <Group Name="Admins" Description = "Contains all admins" ObjectID="41e67c6a-f3a0-4e22-9897-3da5d9898d54"/>
    </SillySystem>
</xml>
"@
    Write-Verbose -Message "$f -  Checking for 'global' data variable"
    if(-not(Get-Variable -Name xml -Scope Global -ErrorAction SilentlyContinue))
    {
        Write-Verbose -Message "$f -  Not found, creating new variable named xml in global scope"
        Set-Variable -Name xml -Value $data -Scope Global
    }
    else
    {
        Write-Verbose -Message "$f -  Variable found, creating XML document"
        $data = (Get-Variable -Name XML -Scope Global).Value
    }
    
    Write-Verbose "$f - END"
    return [xml]($data)
}