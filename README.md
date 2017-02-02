<!-- Visual Studio Code: For a more comfortable reading experience, use the key combination Ctrl + Shift + V
     Visual Studio Code: To crop the tailing end space characters out, please use the key combination Ctrl + A Ctrl + K Ctrl + X (Formerly Ctrl + Shift + X)
     Visual Studio Code: To improve the formatting of HTML code, press Shift + Alt + F and the selected area will be reformatted in a html file.
     Visual Studio Code shortcuts: http://code.visualstudio.com/docs/customization/keybindings (or https://aka.ms/vscodekeybindings)
     Visual Studio Code shortcut PDF (Windows): https://code.visualstudio.com/shortcuts/keyboard-shortcuts-windows.pdf


  _____                                      ______                 _         ______    _     _
 |  __ \                                    |  ____|               | |       |  ____|  | |   | |
 | |__) |___ _ __ ___   _____   _____ ______| |__   _ __ ___  _ __ | |_ _   _| |__ ___ | | __| | ___ _ __ ___
 |  _  // _ \ '_ ` _ \ / _ \ \ / / _ \______|  __| | '_ ` _ \| '_ \| __| | | |  __/ _ \| |/ _` |/ _ \ '__/ __|
 | | \ \  __/ | | | | | (_) \ V /  __/      | |____| | | | | | |_) | |_| |_| | | | (_) | | (_| |  __/ |  \__ \
 |_|  \_\___|_| |_| |_|\___/ \_/ \___|      |______|_| |_| |_| .__/ \__|\__, |_|  \___/|_|\__,_|\___|_|  |___/
                                                             | |         __/ |
                                                             |_|        |___/                                                    -->


## Remove-EmptyFolders.ps1

<table>
   <tr>
      <td style="padding:6px"><strong>OS:</strong></td>
      <td style="padding:6px">Windows</td>
   </tr>
   <tr>
      <td style="padding:6px"><strong>Type:</strong></td>
      <td style="padding:6px">A Windows PowerShell script</td>
   </tr>
   <tr>
      <td style="padding:6px"><strong>Language:</strong></td>
      <td style="padding:6px">Windows PowerShell</td>
   </tr>
   <tr>
      <td style="padding:6px"><strong>Description:</strong></td>
      <td style="padding:6px">Remove-EmptyFolders searches for empty folders from a directory specified with the <code>-Path</code> parameter. By default the search is limited to the first directory level (i.e. the search and removal of the empty folders is done non-recursively), but if a <code>-Recurse</code> parameter is added to the launching command, Remove-EmptyFolders will remove empty folders from the subdirectories as well (i.e. the search and removal is done recursively). If no <code>-Path</code> parameter is provided, Remove-EmptyFolders will search for empty folders from the current temporary file location (<code>$env:temp</code>).
      <br />
      <br />If deletions are made, a log-file (<code>deleted_folders.txt</code> by default) is created to <code>$env:temp</code>, which points to the current temporary file location and is set in the system (– for more information about <code>$env:temp</code>, please see the Notes section). The filename of the log-file can be set with the <code>-FileName</code> parameter (a filename with a <code>.txt</code> ending is recommended) and the default output destination folder may be changed with the <code>-Output</code> parameter. During the possibly invoked log-file creation procedure Remove-EmptyFolders tries to preserve any pre-existing content rather than overwrite the specified file, so if the <code>-FileName</code> parameter points to an existing file, new log-info data is appended to the end of that file.
      <br />
      <br />If the <code>-Audio</code> parareter has been used, an audible beep will be emitted after Remove-EmptyFolders has deleted one or more folders. Please note that if any of the parameter values (after the parameter name itself) includes space characters, the value should be enclosed in quotation marks (single or double) so that PowerShell can interpret the command correctly.</td>
   </tr>
   <tr>
      <td style="padding:6px"><strong>Homepage:</strong></td>
      <td style="padding:6px"><a href="https://github.com/auberginehill/remove-empty-folders">https://github.com/auberginehill/remove-empty-folders</a>
      <br />Short URL: <a href="http://tinyurl.com/zbug5ep">http://tinyurl.com/zbug5ep</a></td>
   </tr>
   <tr>
      <td style="padding:6px"><strong>Version:</strong></td>
      <td style="padding:6px">1.0</td>
   </tr>
   <tr>
        <td style="padding:6px"><strong>Sources:</strong></td>
        <td style="padding:6px">
            <table>
                <tr>
                    <td style="padding:6px">Emojis:</td>
                    <td style="padding:6px"><a href="https://github.com/auberginehill/emoji-table">Emoji Table</a></td>
                </tr>
                <tr>
                    <td style="padding:6px">Mekac:</td>
                    <td style="padding:6px"><a href="https://social.technet.microsoft.com/Forums/en-US/4d78bba6-084a-4a41-8d54-6dde2408535f/get-folder-where-access-is-denied?forum=winserverpowershell">Get folder where Access is denied</a></td>
                </tr>
                <tr>
                    <td style="padding:6px">Mike F Robbins:</td>
                    <td style="padding:6px"><a href="http://mikefrobbins.com/2015/03/31/powershell-advanced-functions-can-we-build-them-better-with-parameter-validation-yes-we-can/">PowerShell Advanced Functions: Can we build them better?</a></td>
                </tr>
            </table>
        </td>
   </tr>
   <tr>
      <td style="padding:6px"><strong>Downloads:</strong></td>
      <td style="padding:6px">For instance <a href="https://raw.githubusercontent.com/auberginehill/remove-empty-folders/master/Remove-EmptyFolders.ps1">Remove-EmptyFolders.ps1</a>. Or <a href="https://github.com/auberginehill/remove-empty-folders/archive/master.zip">everything as a .zip-file</a>.</td>
   </tr>
</table>




### Screenshot

<img class="screenshot" title="screenshot" alt="screenshot" height="100%" width="100%" src="https://raw.githubusercontent.com/auberginehill/remove-empty-folders/master/Remove-EmptyFolders.png">




### Parameters

<table>
    <tr>
        <th>:triangular_ruler:</th>
        <td style="padding:6px">
            <ul>
                <li>
                    <h5>Parameter <code>-Path</code></h5>
                    <p>with aliases <code>-Start</code>, <code>-Begin</code>, <code>-Folder</code>, and <code>-From</code>. The <code>-Path</code> parameter determines the starting point of the empty folder analyzation. The <code>-Path</code> parameter also accepts a collection of path names (separated by a comma). It's not mandatory to write <code>-Path</code> in the remove empty folders command to invoke the <code>-Path</code> parameter, as is shown in the Examples below, since Remove-EmptyFolders is trying to decipher the inputted queries as good as it is machinely possible within a 30 KB size limit.</p>
                    <p>The paths should be valid file system paths to a directory (a full path name of a directory (i.e. folder path such as <code>C:\Windows</code>)). In case the path name includes space characters, please enclose the path name in quotation marks (single or double). If a collection of path names is defined for the <code>-Path</code> parameter, please separate the individual path names with a comma. The <code>-Path</code> parameter also takes an array of strings for paths and objects could be piped to this parameter, too. If no path is defined in the command launching Remove-EmptyFolders <code>$env:temp</code> gets searched for empty folders (and the found empty folders under <code>$env:temp</code> would be deleted). How deeply the filesystem structure is analysed (and how deeply buried empty folders are deleted) is toggled with the <code>-Recurse</code> parameter.</p>
                </li>
            </ul>
        </td>
    </tr>
    <tr>
        <th></th>
        <td style="padding:6px">
            <ul>
                <p>
                    <li>
                        <h5>Parameter <code>-Output</code></h5>
                        <p>with an alias <code>-ReportPath</code>. Specifies where the log-file (<code>deleted_folders.txt</code> by default, which is created or updated when deletions are made) is to be saved. The default save location is <code>$env:temp</code>, which points to the current temporary file location, which is set in the system. The default <code>-Output</code> save location is defined at line 14 with the <code>$Output</code> variable. In case the path name includes space characters, please enclose the path name in quotation marks (single or double). For usage, please see the Examples below and for more information about <code>$env:temp</code>, please see the Notes section below.</p>
                    </li>
                </p>
                <p>
                    <li>
                        <h5>Parameter <code>-FileName</code></h5>
                        <p>with an alias <code>-File</code>. The filename of the log-file can be set with the <code>-FileName</code> parameter (a filename with a <code>.txt</code> ending is recommended, the default filename is <code>deleted_folders.txt</code>). During the possibly invoked log-file creation procedure Remove-EmptyFolders tries to preserve any pre-existing content rather than overwrite the specified file, so if the <code>-FileName</code> parameter points to an existing file, new log-info data is appended to the end of that file. If the filename includes space characters, please enclose the filename in quotation marks (single or double).</p>
                    </li>
                </p>
                <p>
                    <li>
                        <h5>Parameter <code>-Recurse</code></h5>
                        <p>If the <code>-Recurse</code> parameter is added to the command launching Remove-EmptyFolders, also each and every sub-folder in any level, no matter how deep in the directory structure or behind how many sub-folders, is searched for empty folders and all found empty folders regardless of the sub-level are deleted. For best results against nested empty folders, it is recommended to run Remove-EmptyFolders iteratively with the <code>-Recurse</code> parameter until no empty folders are found.</p>
                        <p>If the <code>-Recurse</code> parameter is not used, the search is limited to the first directory level (i.e. the search is done non-recursively) and only empty folders from the first level (as indicated with the <code>-Path</code> parameter with the common command " <code>dir</code>", for example) are deleted.</p>
                    </li>
                </p>
                <p>
                    <li>
                        <h5>Parameter <code>-Audio</code></h5>
                        <p>If this parameter is used in the remove empty folders command, an audible beep will occur, if any deletions are made by Remove-EmptyFolders.</p>
                    </li>
                </p>                
            </ul>
        </td>
    </tr>
</table>




### Outputs

<table>
    <tr>
        <th>:arrow_right:</th>
        <td style="padding:6px">
            <ul>
                <li>Deletes empty folders.</li>
            </ul>
        </td>
    </tr>
    <tr>
        <th></th>
        <td style="padding:6px">
            <ul>
                <p>
                    <li>Displays results about deleting empty folders in console, and if any deletions were made, writes or updates a logfile (<code>deleted_folders.txt</code>) at <code>$env:temp</code>. The filename of the log-file can be set with the <code>-FileName</code> parameter (a filename with a <code>.txt</code> ending is recommended) and the default output destination folder may be changed with the <code>-Output</code> parameter.</li>
                </p>            
                <p>
                    <li>Default values (the log-file creation/updating procedure only occurs if deletion(s) is/are made by Remove-EmptyFolders):</li>
                </p>
                <ol>
                    <p>
                        <table>
                            <tr>
                                <td style="padding:6px"><strong>Path</strong></td>
                                <td style="padding:6px"><strong>Type</strong></td>
                                <td style="padding:6px"><strong>Name</strong></td>
                            </tr>
                            <tr>
                                <td style="padding:6px"><code>$env:temp\deleted_folders.txt</code></td>
                                <td style="padding:6px">TXT-file</td>
                                <td style="padding:6px"><code>deleted_folders.txt</code></td>
                            </tr>
                        </table>
                    </p>
                </ol>
            </ul>
        </td>
    </tr>
</table>




### Notes

<table>
    <tr>
        <th>:warning:</th>
        <td style="padding:6px">
            <ul>
                <li>Please note that all the parameters can be used in one remove empty folders command and that each of the parameters can be "tab completed" before typing them fully (by pressing the <code>[tab]</code> key).</li>
            </ul>
        </td>
    </tr>
    <tr>
        <th></th>
        <td style="padding:6px">
            <ul>
                <p>
                    <li>Please note that the default starting point location (the '<code>-Path</code>' variable value) is defined at line 12 for the <code>-Path</code> parameter with the <code>$Path</code> variable.</li>
                    <li>Please also note that the possibly generated log-file is created in a directory, which is end-user settable in each remove empty folders command with the <code>-Output</code> parameter. The default save location is defined with the <code>$Output</code> variable (at line 14). The <code>$env:temp</code> variable points to the current temp folder. The default value of the <code>$env:temp</code> variable is <code>C:\Users\&lt;username&gt;\AppData\Local\Temp</code> (i.e. each user account has their own separate temp folder at path <code>%USERPROFILE%\AppData\Local\Temp</code>). To see the current temp path, for instance a command
                    <br />
                    <br /><code>[System.IO.Path]::GetTempPath()</code>
                    <br />
                    <br />may be used at the PowerShell prompt window <code>[PS>]</code>. To change the temp folder for instance to <code>C:\Temp</code>, please, for example, follow the instructions at <a href="http://www.eightforums.com/tutorials/23500-temporary-files-folder-change-location-windows.html">Temporary Files Folder - Change Location in Windows</a>, which in essence are something along the lines:
                        <ol>
                           <li>Right click on Computer and click on Properties (or select Start → Control Panel → System). In the resulting window with the basic information about the computer...</li>
                           <li>Click on Advanced system settings on the left panel and select Advanced tab on the resulting pop-up window.</li>
                           <li>Click on the button near the bottom labeled Environment Variables.</li>
                           <li>In the topmost section labeled User variables both TMP and TEMP may be seen. Each different login account is assigned its own temporary locations. These values can be changed by double clicking a value or by highlighting a value and selecting Edit. The specified path will be used by Windows and many other programs for temporary files. It's advisable to set the same value (a directory path) for both TMP and TEMP.</li>
                           <li>Any running programs need to be restarted for the new values to take effect. In fact, probably also Windows itself needs to be restarted for it to begin using the new values for its own temporary files.</li>
                        </ol>
                    </li>
                </p>
            </ul>
        </td>
    </tr>
</table>





### Examples

<table>
    <tr>
        <th>:book:</th>
        <td style="padding:6px">To open this code in Windows PowerShell, for instance:</td>
   </tr>
   <tr>
        <th></th>
        <td style="padding:6px">
            <ol>
                <p>
                    <li><code>./Remove-EmptyFolders</code><br />
                    Run the script. Please notice to insert <code>./</code> or <code>.\</code> before the script name. Uses the default location (<code>$env:temp</code>) as the starting point for 'removing the empty folders' and for storing the generated log-file(, if any deletions were made). Searches for empty folders at the first level of <code>$env:temp</code> (i.e. search is done non-recursively, similarly to a common command "<code>dir</code>", for example). During the possibly invoked log-file creation procedure Remove-EmptyFolders tries to preserve any pre-existing content rather than overwrite the file, so if the default log-file (<code>deleted_folders.txt</code>) already exists, new log-info data is appended to the end of that file.</li>
                </p>
                <p>
                    <li><code>help ./Remove-EmptyFolders -Full</code><br />
                    Display the help file.</li>
                </p>    
                <p>
                    <li><code>./Remove-EmptyFolders -Path "E:\chiore" -Output "C:\Scripts"</code><br />
                    Run the script and remove all empty folders from the first level of <code>E:\chiore</code> (i.e. those empty folders, which would be listed with the "<code>dir E:\chiore</code>" command, and if any deletions were made, save the log-file to <code>C:\Scripts</code> with the default filename (<code>deleted_folders.txt</code>). Please note, that <code>-Path</code> can be omitted in this example, because
                    <br />
                    <br /><code>./Remove-EmptyFolders "E:\chiore" -Output "C:\Scripts"</code>
                    <br />
                    <br />will result in the exact same outcome.
                </p>
                <p>
                    <li><code>./Remove-EmptyFolders -Path "C:\Users\Dropbox" -Recurse</code><br />
                    Will delete all empty folders from <code>C:\Users\Dropbox</code> and also from all sub-directories of the sub-directories of the sub-directories and their sub-directories as well (the search is done recursively). If any deletions were made, the log-file is saved to the default location (<code>$env:temp</code>) with the default filename (<code>deleted_folders.txt</code>). The <code>-Path</code> variable value is case-insensitive (as is most of the PowerShell), and since the path name doesn't contain any space characters, it doesn't need to be enveloped with quotation marks. Actually the <code>-Path</code> parameter may be left out from the command, too, since, for example,
                    <br />
                    <br /><code>./Remove-EmptyFolders c:\users\dROPBOx -Recurse</code>
                    <br />
                    <br />is the exact same command in nature.</li>
                </p>
                <p>
                    <li><code>.\Remove-EmptyFolders.ps1 -From C:\dc01 -ReportPath C:\Scripts -File log.txt -Recurse -Audio</code><br />
                    Run the script and search recursively for empty folders from <code>C:\dc01</code> and delete all recursively found empty folders under <code>C:\dc01</code>. If any deletions were made, the log-file would be saved to <code>C:\Scripts</code> with the filename <code>log.txt</code> and an audible beep would occur. This command will work, because <code>-From</code> is an alias of <code>-Path</code> and <code>-ReportPath</code> is an alias of <code>-Output</code> and <code>-File</code> is an alias of <code>-FileName</code>. Furthermore, since the path names don't contain any space characters, they don't need to be enclosed in quotation marks.</li>
                </p>
                <p>
                    <li><p><code>Set-ExecutionPolicy remotesigned</code><br />
                    This command is altering the Windows PowerShell rights to enable script execution for the default (LocalMachine) scope. Windows PowerShell has to be run with elevated rights (run as an administrator) to actually be able to change the script execution properties. The default value of the default (LocalMachine) scope is "<code>Set-ExecutionPolicy restricted</code>".</p>
                        <p>Parameters:
                                <ol>
                                    <table>
                                        <tr>
                                            <td style="padding:6px"><code>Restricted</code></td>
                                            <td style="padding:6px">Does not load configuration files or run scripts. Restricted is the default execution policy.</td>
                                        </tr>
                                        <tr>
                                            <td style="padding:6px"><code>AllSigned</code></td>
                                            <td style="padding:6px">Requires that all scripts and configuration files be signed by a trusted publisher, including scripts that you write on the local computer.</td>
                                        </tr>
                                        <tr>
                                            <td style="padding:6px"><code>RemoteSigned</code></td>
                                            <td style="padding:6px">Requires that all scripts and configuration files downloaded from the Internet be signed by a trusted publisher.</td>
                                        </tr>
                                        <tr>
                                            <td style="padding:6px"><code>Unrestricted</code></td>
                                            <td style="padding:6px">Loads all configuration files and runs all scripts. If you run an unsigned script that was downloaded from the Internet, you are prompted for permission before it runs.</td>
                                        </tr>
                                        <tr>
                                            <td style="padding:6px"><code>Bypass</code></td>
                                            <td style="padding:6px">Nothing is blocked and there are no warnings or prompts.</td>
                                        </tr>
                                        <tr>
                                            <td style="padding:6px"><code>Undefined</code></td>
                                            <td style="padding:6px">Removes the currently assigned execution policy from the current scope. This parameter will not remove an execution policy that is set in a Group Policy scope.</td>
                                        </tr>
                                    </table>
                                </ol>
                        </p>
                    <p>For more information, please type "<code>Get-ExecutionPolicy -List</code>", "<code>help Set-ExecutionPolicy -Full</code>", "<code>help about_Execution_Policies</code>" or visit <a href="https://technet.microsoft.com/en-us/library/hh849812.aspx">Set-ExecutionPolicy</a> or <a href="http://go.microsoft.com/fwlink/?LinkID=135170.">about_Execution_Policies</a>.</p>
                    </li>
                </p>
                <p>
                    <li><code>New-Item -ItemType File -Path C:\Temp\Remove-EmptyFolders.ps1</code><br />
                    Creates an empty ps1-file to the <code>C:\Temp</code> directory. The <code>New-Item</code> cmdlet has an inherent <code>-NoClobber</code> mode built into it, so that the procedure will halt, if overwriting (replacing the contents) of an existing file is about to happen. Overwriting a file with the <code>New-Item</code> cmdlet requires using the <code>Force</code>. If the path name includes space characters, please enclose the path name in quotation marks (single or double):
                        <ol>
                            <br /><code>New-Item -ItemType File -Path "C:\Folder Name\Remove-EmptyFolders.ps1"</code>
                        </ol>
                    <br />For more information, please type "<code>help New-Item -Full</code>".</li>
                </p>
            </ol>
        </td>
    </tr>
</table>




### Contributing

<p>Find a bug? Have a feature request? Here is how you can contribute to this project:</p>

 <table>
   <tr>
      <th><img class="emoji" title="contributing" alt="contributing" height="28" width="28" align="absmiddle" src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f33f.png"></th>
      <td style="padding:6px"><strong>Bugs:</strong></td>
      <td style="padding:6px"><a href="https://github.com/auberginehill/remove-empty-folders/issues">Submit bugs</a> and help us verify fixes.</td>
   </tr>
   <tr>
      <th rowspan="2"></th>
      <td style="padding:6px"><strong>Feature Requests:</strong></td>
      <td style="padding:6px">Feature request can be submitted by <a href="https://github.com/auberginehill/remove-empty-folders/issues">creating an Issue</a>.</td>
   </tr>
   <tr>
      <td style="padding:6px"><strong>Edit Source Files:</strong></td>
      <td style="padding:6px"><a href="https://github.com/auberginehill/remove-empty-folders/pulls">Submit pull requests</a> for bug fixes and features and discuss existing proposals.</td>
   </tr>
 </table>




### www

<table>
    <tr>
        <th><img class="emoji" title="www" alt="www" height="28" width="28" align="absmiddle" src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f310.png"></th>
        <td style="padding:6px"><a href="https://github.com/auberginehill/remove-empty-folders">Script Homepage</a></td>
    </tr>
    <tr>
        <th rowspan="7"></th>
        <td style="padding:6px">Mekac: <a href="https://social.technet.microsoft.com/Forums/en-US/4d78bba6-084a-4a41-8d54-6dde2408535f/get-folder-where-access-is-denied?forum=winserverpowershell">Get folder where Access is denied</a></td>
    </tr>
    <tr>
        <td style="padding:6px">Mike F Robbins: <a href="http://mikefrobbins.com/2015/03/31/powershell-advanced-functions-can-we-build-them-better-with-parameter-validation-yes-we-can/">PowerShell Advanced Functions: Can we build them better?</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://gist.github.com/nedarb/840f9f0c9a2e6014d38f">RemoveEmptyFolders.ps1</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://gist.github.com/Appius/d863ada643c2ee615db9">Remove all empty folders.ps1</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="http://www.brangle.com/wordpress/2009/08/append-text-to-a-file-using-add-content-in-powershell/">Append Text to a File Using Add-Content in PowerShell</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_functions_advanced_parameters">About Functions Advanced Parameters</a></td>
    </tr>
    <tr>
        <td style="padding:6px">ASCII Art: <a href="http://www.figlet.org/">http://www.figlet.org/</a> and <a href="http://www.network-science.de/ascii/">ASCII Art Text Generator</a></td>
    </tr>
</table>




### Related scripts

 <table>
    <tr>
        <th><img class="emoji" title="www" alt="www" height="28" width="28" align="absmiddle" src="https://assets-cdn.github.com/images/icons/emoji/unicode/0023-20e3.png"></th>
        <td style="padding:6px"><a href="https://gist.github.com/auberginehill/aa812bfa79fa19fbd880b97bdc22e2c1">Disable-Defrag</a></td>
    </tr>
    <tr>
        <th rowspan="22"></th>
        <td style="padding:6px"><a href="https://github.com/auberginehill/firefox-customization-files">Firefox Customization Files</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-ascii-table">Get-AsciiTable</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-battery-info">Get-BatteryInfo</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-computer-info">Get-ComputerInfo</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-culture-tables">Get-CultureTables</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-directory-size">Get-DirectorySize</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-installed-programs">Get-InstalledPrograms</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-installed-windows-updates">Get-InstalledWindowsUpdates</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-powershell-aliases-table">Get-PowerShellAliasesTable</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://gist.github.com/auberginehill/9c2f26146a0c9d3d1f30ef0395b6e6f5">Get-PowerShellSpecialFolders</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-ram-info">Get-RAMInfo</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://gist.github.com/auberginehill/eb07d0c781c09ea868123bf519374ee8">Get-TimeDifference</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-time-zone-table">Get-TimeZoneTable</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-unused-drive-letters">Get-UnusedDriveLetters</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/emoji-table">Emoji Table</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/java-update">Java-Update</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://gist.github.com/auberginehill/13bb9f56dc0882bf5e85a8f88ccd4610">Remove-EmptyFoldersLite</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://gist.github.com/auberginehill/176774de38ebb3234b633c5fbc6f9e41">Rename-Files</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/rock-paper-scissors">Rock-Paper-Scissors</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/toss-a-coin">Toss-a-Coin</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/update-adobe-flash-player">Update-AdobeFlashPlayer</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/update-mozilla-firefox">Update-MozillaFirefox</a></td>
    </tr>
</table>
