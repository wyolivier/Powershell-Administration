function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [parameter(Mandatory = $true)]
        [ValidateSet("Enabled","Disabled")]
        [System.String]$State
    )

    $Value = (Get-WindowsErrorReporting).value__
    Write-Verbose "Windows Error Reporting raw value is : $($Value.ToString())"

    Switch ($Value) {
        0 { $State = "Disabled"; Break }
        1 { $State = "Enabled"; Break }
    }

    $returnValue = @{
    State = $State
    }
    $returnValue
}

function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory = $true)]
        [ValidateSet("Enabled","Disabled")]
        [System.String]$State
    )

    Switch ($State) {
        "Enabled" { Enable-WindowsErrorReporting ; Break}
        "Disabled" { Disable-WindowsErrorReporting ; Break }
    }
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [parameter(Mandatory = $true)]
        [ValidateSet("Enabled","Disabled")]
        [System.String]$State
    )

    $CurrentState = (Get-TargetResource -State $State).Values[0] | Out-String
    $CurrentStateTrimmed = $CurrentState.Trim()
    Write-Verbose "Windows Error Reporting is currently : $CurrentStateTrimmed"
    
    $result = $CurrentStateTrimmed -eq $State
    $result
}