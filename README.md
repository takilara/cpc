# CPC
Mudlet Cross Profile Communication package

## Description

This package allows you to control several profiles from one profile. It currently supports the following commands:
* #HELP                        - Show Helpfile(s)
* #VERSION                     - Show version(s)
* #ALL &lt;arguments&gt;             - send command to all profiles
* #DO &lt;arguments&gt;              - send command to all other profiles
* #BID &lt;profile> &lt;arguments&gt;   - send command to one character (immediate execution)
* #ECHO &lt;text&gt;                 - show something in all terminals
* #TELL &lt;profile&gt;              - show something in one particular terminal

## Installation

The package can be installed in multiple ways. Use your preferred method.

### Standard install

The preferred method for most people

* Download the cpc.mpackage from releases
* In your Mudlet profile, click Toolbox -> Package manager
* Click the 'Install' button, and browse to the downloaded cpc.mpackage

### Module install for code changes

If you want to contribute with code changes back to the repository, or make code changes that you will be using in multiple profiles, then this is the preferred method.
Note! when installed like this, the scripts and aliases will be organized under 'cpc' rather than 'Cross Profile Communications'

* Git clone this repository
* In your Mudlet profile, click Toolbox -> Module manager
* Click the 'Install' button, and browse to the git clone of the repository
* Select the file cpc.xml
* Check the 'Sync' checkbox if you want your changes to be stored back to the checkout folder (e.g. for commits back to the repository, or for use on multiple profiles)

## References

* https://github.com/Mudlet/Mudlet/issues/4783
* https://forums.mudlet.org/viewtopic.php?f=6&t=23023


