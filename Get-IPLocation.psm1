function Get-IPLocation {
Param(
[Parameter()]$IPAddress
)

Add-Type -Path ($PSScriptRoot + "\System.Data.SQLite.dll")

$extracted = [regex]::Match($IPAddress, `
"^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\." + 
"(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")

if($extracted.Success -eq $false){throw "Please enter a valid IPv4 address"}

$IP_W = [int]($extracted.Groups[1].Value) * 16777216
$IP_X = [int]($extracted.Groups[2].Value) * 65536
$IP_Y = [int]($extracted.Groups[3].Value) * 256
$IP_Z = [int]($extracted.Groups[4].Value)

$IPNUMBER = ($IP_W + $IP_X + $IP_Y + $IP_Z)

$con = New-Object -TypeName System.Data.SQLite.SQLiteConnection
$con.ConnectionString = "Data Source=$PSScriptRoot\IPLOC11.sqlite"
$con.Open()

$sql = $con.CreateCommand()

$sql.CommandText = "SELECT country_code, country_name, region_name, city_name, latitude, longitude, zip_code, time_zone FROM IP2LOCATION WHERE $IPNUMBER BETWEEN ip_from AND ip_to"
$adapter = New-Object -TypeName System.Data.SQLite.SQLiteDataAdapter $sql
$data = New-Object System.Data.DataSet
[void]$adapter.Fill($data)

$sql.Dispose()
$con.Close()

return ($data.Tables)

}

Export-ModuleMember Get-IPLocation