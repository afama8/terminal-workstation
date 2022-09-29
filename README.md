# terminal-workstation

*Turn your terminal into a workstation*

__Target Audience:__ Software Developers

__Goal:__ Provide all basic tools used in a normal workday in the terminal.

__Basic Tools:__ Development Environment (stack), Text Editor (IDE), Email, Calendar, Chat (Slack)

### Application Requirements

Bash script which can be run on:
- Debian, Ubuntu Linux, Raspberry Pi OS (apt)
- Fedora, CentOS, Red Hat Enterprise Linux (dnf)
- openSUSE/SUSE Linux (zypper)

#### Workflow

Provide user with an installation questionnaire about the type of tools they would like to install, and obtain necessary user info for correct configuration of chosen tools (i.e. email, chat).

Once all the information is gathered user can choose to either install the tools on the current system or generate a script which can be run on a different system.

Script will also output an uninstall script which can be used remove all tools and configurations from server.
