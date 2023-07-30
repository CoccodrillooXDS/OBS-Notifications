# PowerShell script
# Made for OBS Studio and Windows 10/11
# Made by: @CoccodrillooXDS
# Version: 1.0.0

# Create variables for title, message, icon, appID and the required module
$title = ""
$message = ""
$icon = "icon.ico"
$appId = "{6D809377-6AF0-444B-8957-A3773F02200E}\obs-studio\bin\64bit\obs64.exe"
$module = "BurntToast"
$why = "show notifications on Windows"

# Set the current directory to the script's directory to make sure the icon is found
Set-Location $PSScriptRoot

# If the first argument is "setup", continue the script, otherwise check if -Title and -Message parameters are set
if ($args[0] -eq "setup") {
    # Continue the script
} elseif ($args[0] -eq "-Title" -and $args[2] -eq "-Message") {
    # Set the title and the message of the notification
    $title = $args[1]
    $message = $args[3]
    # Try to import the module, if it fails, show an error message and exit the script
    try {
        Import-Module BurntToast
    } catch {
        Write-Host "The BurntToast module is not installed. Reload the script or restart OBS Studio to install it."
        Start-Sleep -s 2
        exit 1
    }
    # Send the notification
    New-BurntToastNotification -Text "$title","$message" -AppLogo $icon -AppId $appId
} else {
    Write-Host "Invalid arguments. Use -Title and -Message parameters to set the title and the message of the notification."
    Start-Sleep -s 2
    exit 1
}
# Set the title of the window
$host.UI.RawUI.WindowTitle = "PowerShell Add-On for OBS Studio's Lua script - Notifications for Windows"

# Import the ShowWindowAsync function from user32.dll
Add-Type @"
    using System;
    using System.Runtime.InteropServices;
    public class WinAPI {
        [DllImport("user32.dll")]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
    }
"@

# Get the handle of the current console window
$hwnd = (Get-Process -Id $pid).MainWindowHandle

# Hide the console window
[void][WinAPI]::ShowWindowAsync($hwnd, 0)

# Check if the module is installed
function IsModuleInstalled($moduleName) {
    # Get the number of installed modules with the same name as the one specified
    $installed = Get-Module -ListAvailable $moduleName | Measure-Object | Select-Object -ExpandProperty Count
    # If the module is not installed (0 results), return false, otherwise return true
    if ($installed -eq 0) {
        return $false
    } else {
        return $true
    }
}

# If the module is not installed, ask the user if they want to install it
if (-not (IsModuleInstalled($module))) {
    # Make the window visible again
    [void][WinAPI]::ShowWindowAsync($hwnd, 1)
    # Set the title and the message of the yes/no prompt
    $title = "OBS Studio - Lua script installation"
    $message = "The $module module is required to $why. Do you want to install it? This requires admin privileges."
    $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Installs the $module module."
    $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", "Aborts the installation."
    $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)
    $result = $host.ui.PromptForChoice($title, $message, $options, 0)
    # If the user chooses "Yes", install the module user-wide so that it doesn't require admin privileges
    if ($result -eq 0) {
        # Try to install the module
        try {
            Write-Host "Installing module... Please wait."
            # Install the module
            Install-Module -Name $module -Force -Scope CurrentUser
        } catch {
            Write-Host "Installation canceled by user."
            # Sleep for 1 second to make sure the user sees the message
            Start-Sleep -s 1
            exit 1
        }
    }
    # Check if the module is installed correctly and send a test notification if it is
    if (IsModuleInstalled($module)) {
        Import-Module $module
        
        # Set the notification title and message
        $title = "Test notification"
        $message = "If you see this message, the module has been installed correctly!"
        
        # Set the notification icon
        $icon = "icon.ico"
        
        # Set the notification app ID
        $appId = "{6D809377-6AF0-444B-8957-A3773F02200E}\obs-studio\bin\64bit\obs64.exe"
        
        # Send the notification
        New-BurntToastNotification -Text $title,$message -AppLogo $icon -AppId $appId
        Write-Host "Installation completed successfully!"
    } else {
        Write-Host "Something went wrong during the installation of PowerShell module. Reload the script or restart OBS Studio to try again."
        # Sleep for 2 seconds to make sure the user sees the message
        Start-Sleep -s 2
        exit 1
    }
}