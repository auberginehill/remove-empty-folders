<#
Remove-EmptyFolders.ps1
#>


[CmdletBinding()]
Param (
    [Parameter(ValueFromPipeline=$true,
    ValueFromPipelineByPropertyName=$true,
      HelpMessage='Which folder, directory or path would you like to target? Please enter a valid file system path to a directory (a full path name of a directory (a.k.a. a folder) i.e. folder path such as C:\Windows). If the path name includes space characters, please enclose the path name in quotation marks (single or double). The -Path parameter accepts a collection of path names (separated by comma) and also takes an array of strings.')]
    [Alias("Start","Begin","Folder","From")]
    [string[]]$Path = "$env:temp",
    [Alias("ReportPath")]
    [string]$Output = "$env:temp",
    [ValidateScript({
        # Credit: Mike F Robbins: "PowerShell Advanced Functions: Can we build them better?" http://mikefrobbins.com/2015/03/31/powershell-advanced-functions-can-we-build-them-better-with-parameter-validation-yes-we-can/
        If ($_ -match '^(?!^(PRN|AUX|CLOCK\$|NUL|CON|COM\d|LPT\d|\..*)(\..+)?$)[^\x00-\x1f\\?*:\"";|/]+$') {
                $True
        } Else {
                Throw "$_ is either not a valid filename or it is not recommended. If the filename includes space characters, please enclose the filename in quotation marks."
        }
    })]
    [Alias("File")]
    [string]$FileName = "deleted_folders.txt",
    [switch]$Recurse,
    [switch]$Audio
)




Begin {


    # Establish some common variables.
    $ErrorActionPreference = "Stop"
    $separator = "---------------------"
    $empty_line = ""
    $empty_folders = @()
    $deleted_folders = @()

    # Test if the path exists
    If ((Test-Path $Path) -eq $false) {

        $invalid_path_was_found = $true

        # Display an error message in console
        $empty_line | Out-String
        Write-Warning "'$Path' doesn't seem to be a valid path name."
        $empty_line | Out-String
        Write-Verbose "Please consider checking that the starting point location (the '-Path' variable value of) '$Path' was typed correctly and that it is a valid file system path, which points to a directory. If the path name includes space characters, please enclose the path name in quotation marks (single or double)." -verbose
        $empty_line | Out-String
        $skip_text = "Couldn't open -Path '$Path'..."
        Write-Output $skip_text
        $empty_line | Out-String
        Exit
        Return

    } Else {

        # Resolve path (if the path is specified as relative)
        $real_path = Resolve-Path -Path $Path

    } # else (if)


    # Test if the Output-path ("ReportPath") exists
    If ((Test-Path $Output) -eq $false) {

        $invalid_output_path_was_found = $true

        # Display an error message in console
        $empty_line | Out-String
        Write-Warning "'$Output' doesn't seem to be a valid path name."
        $empty_line | Out-String
        Write-Verbose "Please consider checking that the Output ('ReportPath') location '$Output', where the resulting TXT-file is ought to be written, was typed correctly and that it is a valid file system path, which points to a directory. If the path name includes space characters, please enclose the path name in quotation marks (single or double)." -verbose
        $empty_line | Out-String
        $skip_text = "Couldn't find -Output folder '$Output'..."
        Write-Output $skip_text
        $empty_line | Out-String
        Exit
        Return

    } Else {

        # Resolve the Output-path ("ReportPath") (if the Output-path is specified as relative)
        $real_output_path = Resolve-Path -Path $Output
        $txt_file = "$real_output_path\$FileName"

    } # else (if)

} # begin




Process {

    # Search for the empty folders at $real_path (i.e. $path) according to the user-set recurse option
    # Note: For best results against nested empty folders, please run the script iteratively until no empty folders are found.
    # Credit: Mekac: "Get folder where Access is denied" https://social.technet.microsoft.com/Forums/en-US/4d78bba6-084a-4a41-8d54-6dde2408535f/get-folder-where-access-is-denied?forum=winserverpowershell

    $available_folders = Get-ChildItem $real_path -Recurse:$Recurse -Force -ErrorAction SilentlyContinue | Where-Object { $_.PSIsContainer -eq $true } | Select-Object FullName, @{ Label="AclDenied"; Expression={ (Get-Acl $_.FullName).AreAccessRulesProtected }} | Where-Object { $_.AclDenied -eq $false } | Select-Object FullName | Sort FullName

    $unavailable_folders = Get-ChildItem $real_path -Recurse:$Recurse -Force -ErrorAction SilentlyContinue | Where-Object { $_.PSIsContainer -eq $true } | Select-Object FullName, @{ Label="AclDenied"; Expression={ (Get-Acl $_.FullName).AreAccessRulesProtected }} | Where-Object { $_.AclDenied -eq $null } | Select-Object FullName | Sort FullName

    If ($available_folders -eq $null) {
        $continue = $true
    } Else {

        ForEach ($folder in ($available_folders)) {

                $the_query_of_empty_folders = Get-ItemProperty $folder.FullName | Where-Object { ($_.GetFiles().Count -eq 0) -and ($_.GetDirectories().Count -eq 0) } | Select-Object FullName

                        If ($the_query_of_empty_folders -ne $null) {

                                $empty_folders += New-Object -TypeName PSCustomObject -Property @{
                                        'FullName'         = $folder.FullName
                                } # New-Object

                        } Else {
                                $continue = $true
                        } # Else (If $the_query_of_empty_folders)

        } # ForEach $folder

    } # else (if $available_folders)

} # Process




End {


    If ($empty_folders.Count -eq 0) {

        $empty_line | Out-String
        "Didn't find any empty folders at $real_path." | Out-String
        $empty_line | Out-String
        Exit
        Return

    } Else {

                # Create a list of the empty folders and delete the empty folders
                ForEach ($directory in $empty_folders) {

                        $deleted_folders += New-Object -TypeName PSCustomObject -Property @{
                                'Deleted Empty Folders'         = $directory.FullName
                        } # New-Object

                        Remove-Item $directory.FullName -Force

                } # ForEach

        # Write the deleted directory paths in console
        $empty_line | Out-String
        $deleted_folders.PSObject.TypeNames.Insert(0,"Deleted Empty Folders")
        Write-Output $deleted_folders
        $empty_line | Out-String

        # Write the deleted directory paths to a TXT-file (located at the current temp-folder)

                If ((Test-Path $txt_file) -eq $false) {
                        $deleted_folders | Out-File "$txt_file" -Encoding UTF8 -Force
                        Add-Content -Path "$txt_file" -Value "Date: $(Get-Date -Format g)"
                } Else {
                        $pre_existing_content = Get-Content $txt_file
                        ($pre_existing_content + $empty_line + $separator + $empty_line + ($deleted_folders | Select-Object -ExpandProperty 'Deleted Empty Folders') + $empty_line) | Out-File "$txt_file" -Encoding UTF8 -Force
                        Add-Content -Path "$txt_file" -Value "Date: $(Get-Date -Format g)"
                } # Else (If Test-Path)

        # Sound the bell if set to do so with the -Audio parameter (ASCII character 7)
        If ( -not $Audio ) {
                $continue = $true
        } Else {
                [char]7
        } # else

    } # Else (If $empty_folders.Count)

} # End




# [End of Line]


<#


   _____
  / ____|
 | (___   ___  _   _ _ __ ___ ___
  \___ \ / _ \| | | | '__/ __/ _ \
  ____) | (_) | |_| | | | (_|  __/
 |_____/ \___/ \__,_|_|  \___\___|


https://social.technet.microsoft.com/Forums/en-US/4d78bba6-084a-4a41-8d54-6dde2408535f/get-folder-where-access-is-denied?forum=winserverpowershell      # Mekac: "Get folder where Access is denied"
http://mikefrobbins.com/2015/03/31/powershell-advanced-functions-can-we-build-them-better-with-parameter-validation-yes-we-can/                         # Mike F Robbins: "PowerShell Advanced Functions: Can we build them better?"


  _    _      _
 | |  | |    | |
 | |__| | ___| |_ __
 |  __  |/ _ \ | '_ \
 | |  | |  __/ | |_) |
 |_|  |_|\___|_| .__/
               | |
               |_|
#>

<#

.SYNOPSIS
Removes empty folders from a specified directory recursively or non-recursively.

.DESCRIPTION
Remove-EmptyFolders searches for empty folders from a directory specified with the
-Path parameter. By default the search is limited to the first directory level
(i.e. the search and removal of the empty folders is done non-recursively), but
if a -Recurse parameter is added to the launching command, Remove-EmptyFolders
will remove empty folders from the subdirectories as well (i.e. the search and
removal is done recursively). If no -Path parameter is provided,
Remove-EmptyFolders will search for empty folders from the current temporary file
location ($env:temp).

If deletions are made, a log-file (deleted_folders.txt by default) is created to
$env:temp, which points to the current temporary file location and is set in the
system (- for more information about $env:temp, please see the Notes section). The
filename of the log-file can be set with the -FileName parameter (a filename with a
.txt ending is recommended) and the default output destination folder may be changed
with the -Output parameter. During the possibly invoked log-file creation procedure
Remove-EmptyFolders tries to preserve any pre-existing content rather than overwrite
the specified file, so if the -FileName parameter points to an existing file, new
log-info data is appended to the end of that file.

If the -Audio parareter has been used, an audible beep will be emitted after
Remove-EmptyFolders has deleted one or more folders. Please note that if any of
the parameter values (after the parameter name itself) includes space characters,
the value should be enclosed in quotation marks (single or double) so that
PowerShell can interpret the command correctly.

.PARAMETER Path
with aliases -Start, -Begin, -Folder, and -From. The -Path parameter determines the
starting point of the empty folder analyzation. The -Path parameter also accepts a
collection of path names (separated by a comma). It's not mandatory to write -Path
in the remove empty folders command to invoke the -Path parameter, as is shown in
the Examples below, since Remove-EmptyFolders is trying to decipher the inputted
queries as good as it is machinely possible within a 30 KB size limit.

The paths should be valid file system paths to a directory (a full path name of a
directory (i.e. folder path such as C:\Windows)). In case the path name includes
space characters, please enclose the path name in quotation marks (single or double).
If a collection of path names is defined for the -Path parameter, please separate
the individual path names with a comma. The -Path parameter also takes an array of
strings for paths and objects could be piped to this parameter, too. If no path is 
defined in the command launching Remove-EmptyFolders $env:temp gets searched for 
empty folders (and the found empty folders under $env:temp would be deleted). 
How deeply the filesystem structure is analysed (and how deeply buried empty 
folders are deleted) is toggled with the -Recurse parameter.

.PARAMETER Output
with an alias -ReportPath. Specifies where the log-file
(deleted_folders.txt by default, which is created or updated when deletions are 
made) is to be saved. The default save location is $env:temp, which points to the 
current temporary file location, which is set in the system. The default -Output 
save location is defined at line 14 with the $Output variable. In case the path name
includes space characters, please enclose the path name in quotation marks (single
or double). For usage, please see the Examples below and for more information about
$env:temp, please see the Notes section below.

.PARAMETER FileName
with an alias -File. The filename of the log-file can be set with the -FileName
parameter (a filename with a .txt ending is recommended, the default filename is
deleted_folders.txt). During the possibly invoked log-file creation procedure
Remove-EmptyFolders tries to preserve any pre-existing content rather than overwrite
the specified file, so if the -FileName parameter points to an existing file, new
log-info data is appended to the end of that file. If the filename includes space
characters, please enclose the filename in quotation marks (single or double).

.PARAMETER Recurse
If the -Recurse parameter is added to the command launching Remove-EmptyFolders,
also each and every sub-folder in any level, no matter how deep in the directory
structure or behind how many sub-folders, is searched for empty folders and all
found empty folders regardless of the sub-level are deleted. For best results
against nested empty folders, it is recommended to run Remove-EmptyFolders
iteratively with the -Recurse parameter until no empty folders are found.

If the -Recurse parameter is not used, the search is limited to the first directory
level (i.e. the search is done non-recursively) and only empty folders from the 
first level (as indicated with the -Path parameter with the common command "dir",
for example) are deleted.

.PARAMETER Audio
If this parameter is used in the remove empty folders command, an audible beep 
will occur, if any deletions are made by Remove-EmptyFolders.

.OUTPUTS
Deletes empty folders.
Displays results about deleting empty folders in console, and if any deletions were
made, writes or updates a logfile (deleted_folders.txt) at $env:temp. The filename
of the log-file can be set with the -FileName parameter (a filename with a .txt
ending is recommended) and the default output destination folder may be changed with
the -Output parameter.


    Default values (the log-file creation/updating procedure only occurs if 
    deletion(s) is/are made by Remove-EmptyFolders):


        $env:temp\deleted_folders.txt       : TXT-file     : deleted_folders.txt


.NOTES
Please note that all the parameters can be used in one remove empty folders command
and that each of the parameters can be "tab completed" before typing them fully (by
pressing the [tab] key).

Please note that the default starting point location (the '-Path' variable value)
is defined at line 12 for the -Path parameter with the $Path variable.

Please also note that the possibly generated log-file is created in a directory,
which is end-user settable in each remove empty folders command with the -Output
parameter. The default save location is defined with the $Output variable (at
line 14). The $env:temp variable points to the current temp folder. The default
value of the $env:temp variable is C:\Users\<username>\AppData\Local\Temp
(i.e. each user account has their own separate temp folder at path
%USERPROFILE%\AppData\Local\Temp). To see the current temp path, for instance
a command

    [System.IO.Path]::GetTempPath()

may be used at the PowerShell prompt window [PS>]. To change the temp folder for
instance to C:\Temp, please, for example, follow the instructions at
http://www.eightforums.com/tutorials/23500-temporary-files-folder-change-location-windows.html

    Homepage:           https://github.com/auberginehill/remove-empty-folders
    Short URL:          http://tinyurl.com/zbug5ep
    Version:            1.0

.EXAMPLE
./Remove-EmptyFolders
Run the script. Please notice to insert ./ or .\ before the script name.
Uses the default location ($env:temp) as the starting point for 'removing the empty
folders' and for storing the generated log-file(, if any deletions were made). 
Searches for empty folders at the first level of $env:temp (i.e. search is done 
non-recursively, similarly to a common command "dir", for example). During the 
possibly invoked log-file creation procedure Remove-EmptyFolders tries to preserve
any pre-existing content rather than overwrite the file, so if the default log-file
(deleted_folders.txt) already exists, new log-info data is appended to the end of 
that file.

.EXAMPLE
help ./Remove-EmptyFolders -Full
Display the help file.

.EXAMPLE
./Remove-EmptyFolders -Path "E:\chiore" -Output "C:\Scripts"

Run the script and remove all empty folders from the first level of E:\chiore
(i.e. those empty folders, which would be listed with the "dir E:\chiore" command,
and if any deletions were made, save the log-file to C:\Scripts with the default
filename (deleted_folders.txt). Please note, that -Path can be omitted
in this example, because

    ./Remove-EmptyFolders "E:\chiore" -Output "C:\Scripts"

will result in the exact same outcome.

.EXAMPLE
./Remove-EmptyFolders -Path "C:\Users\Dropbox" -Recurse

Will delete all empty folders from C:\Users\Dropbox and also from all
sub-directories of the sub-directories of the sub-directories and their
sub-directories as well (the search is done recursively). If any deletions were
made, the log-file is saved to the default location ($env:temp) with the default
filename (deleted_folders.txt). The Path variable value is case-insensitive
(as is most of the PowerShell), and since the path name doesn't contain any space
characters, it doesn't need to be enveloped with quotation marks. Actually the
-Path parameter may be left out from the command, too, since, for example,

    ./Remove-EmptyFolders c:\users\dROPBOx -Recurse

is the exact same command in nature.

.EXAMPLE
.\Remove-EmptyFolders.ps1 -From C:\dc01 -ReportPath C:\Scripts -File log.txt -Recurse -Audio

Run the script and search recursively for empty folders from C:\dc01 and delete all
recursively found empty folders under C:\dc01. If any deletions were made, the
log-file would be saved to C:\Scripts with the filename log.txt and an audible beep
would occur. This command will work, because -From is an alias of -Path and 
-ReportPath is an alias of -Output and -File is an alias of -FileName. Furthermore, 
since the path names don't contain any space characters, they don't need to be 
enclosed in quotation marks.

.EXAMPLE
Set-ExecutionPolicy remotesigned
This command is altering the Windows PowerShell rights to enable script execution for
the default (LocalMachine) scope. Windows PowerShell has to be run with elevated rights
(run as an administrator) to actually be able to change the script execution properties.
The default value of the default (LocalMachine) scope is "Set-ExecutionPolicy restricted".


    Parameters:

    Restricted      Does not load configuration files or run scripts. Restricted is the default
                    execution policy.

    AllSigned       Requires that all scripts and configuration files be signed by a trusted
                    publisher, including scripts that you write on the local computer.

    RemoteSigned    Requires that all scripts and configuration files downloaded from the Internet
                    be signed by a trusted publisher.

    Unrestricted    Loads all configuration files and runs all scripts. If you run an unsigned
                    script that was downloaded from the Internet, you are prompted for permission
                    before it runs.

    Bypass          Nothing is blocked and there are no warnings or prompts.

    Undefined       Removes the currently assigned execution policy from the current scope.
                    This parameter will not remove an execution policy that is set in a Group
                    Policy scope.


For more information, please type "Get-ExecutionPolicy -List", "help Set-ExecutionPolicy -Full",
"help about_Execution_Policies" or visit https://technet.microsoft.com/en-us/library/hh849812.aspx
or http://go.microsoft.com/fwlink/?LinkID=135170.

.EXAMPLE
New-Item -ItemType File -Path C:\Temp\Remove-EmptyFolders.ps1
Creates an empty ps1-file to the C:\Temp directory. The New-Item cmdlet has an inherent -NoClobber mode
built into it, so that the procedure will halt, if overwriting (replacing the contents) of an existing
file is about to happen. Overwriting a file with the New-Item cmdlet requires using the Force. If the
path name includes space characters, please enclose the path name in quotation marks (single or double):

    New-Item -ItemType File -Path "C:\Folder Name\Remove-EmptyFolders.ps1"

For more information, please type "help New-Item -Full".

.LINK
https://social.technet.microsoft.com/Forums/en-US/4d78bba6-084a-4a41-8d54-6dde2408535f/get-folder-where-access-is-denied?forum=winserverpowershell
http://mikefrobbins.com/2015/03/31/powershell-advanced-functions-can-we-build-them-better-with-parameter-validation-yes-we-can/
https://gist.github.com/nedarb/840f9f0c9a2e6014d38f
https://gist.github.com/Appius/d863ada643c2ee615db9
http://www.brangle.com/wordpress/2009/08/append-text-to-a-file-using-add-content-in-powershell/
https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_functions_advanced_parameters

#>
