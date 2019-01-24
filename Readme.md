# Get-IPLocation

Get-IPLocation is a Windows PowerShell Module developed to provide an offline method of resolving IPv4 addresses to geo-locations.

Please note that you need to download the IP2LOCATION DB11.LITE database from http://lite.ip2location.com and convert it to a sqlite database. __The database schema should be as follows:__
`ip_from` INT(10),
`ip_to` INT(10),
`country_code` CHAR(2),
`country_name` VARCHAR(64),
`region_name` VARCHAR(128),
`city_name` VARCHAR(128),
`latitude` DOUBLE,
`longitude` DOUBLE,
`zip_code` VARCHAR(30),
`time_zone` VARCHAR(8),

You can easily import the CSV into the sqlite db and configure the schema using sqlite studio (https://sqlitestudio.pl/)

# Usage

#### Get IP Information -
    Get-IPLocation -IPAddress #.#.#.#
##### Example output:
country_code : US
country_name : United States
region_name  : California
city_name    : Mountain View
latitude     : 37.405992
longitude    : -122.078515
zip_code     : 94043
time_zone    : -08:00


#### Get IP Information (Single Property) -
    (Get-IPLocation -IPAddress #.#.#.#).country_code
##### Example output:
US


# Changelog

#### v1.0.0 -
    - Initial Release

# To-do
    - Have script output a PSObject for use in the pipeline
