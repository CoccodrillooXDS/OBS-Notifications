<div align="center"><img src="icon.ico" alt="Project Icon"></img></div>
<h1 align="center">Notifications for OBS Studio</h1>
<h3 align="center">Receive desktop notifications for OBS Studio events</h3>
<h4 align="center">Recording, Streaming and Replay Buffer</h4>
<p></p>
<p align="center">
<a href="https://www.lua.org/"><img src="https://img.shields.io/badge/Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white" alt="Lua">
<a href="https://learn.microsoft.com/en-us/powershell/"><img src="https://img.shields.io/badge/Powershell-2CA5E0?style=for-the-badge&logo=powershell&logoColor=white" alt="PowerShell">
</a></p>

# Overview
This Lua script for OBS Studio will send desktop notifications for recording, streaming and Replay Buffer events.
It is designed for [OBS Studio](https://obsproject.com/) and should also work with [Streamlabs OBS](https://streamlabs.com/).

# Features
- Desktop notifications for these events:
  - Start and stop recording;
  - Start and stop streaming;
  - Save Replay Buffer;
- Cross-platform support for ***Windows***, ***macOS*** and ***Linux***;

# Requirements
- [OBS Studio](https://obsproject.com/) or [Streamlabs OBS](https://streamlabs.com/);
- PowerShell 5.1 or newer (*Windows only*);
- BurntToast PowerShell Module (*Windows only*);
    - It will be installed automatically when you first run the script;
- notify-send (*Linux only*);

# Installation
1. Download the latest version from the [Releases](https://github.com/CoccodrillooXDS/OBS-Notifications/releases) page;
2. Extract the archive to a folder of your choice;
3. Open OBS Studio;
4. Go to `Tools` > `Scripts`;
5. Click on the `+` button;
6. Select the `notifications.lua` file;
7. If you are using Windows, you will be prompted to install the BurntToast PowerShell Module.

## Contributing
You can contribute to the project by creating a pull request or an issue.

To contribute, you can fork the repository and after you made your changes, you can create a pull request.

## License
This project is licensed under the **MIT License**. See the **[LICENSE](LICENSE)** file for more information.