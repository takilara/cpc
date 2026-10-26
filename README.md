# CPC
Mudlet Cross Profile Communication package

## Description

This package allows you to control several profiles from one profile. It currently supports the following commands:

| Command                             | API (commands to use in an alias/trigger) | Description                   |
|-------------------------------------|------------------------------------|-------------------------------|
| #HELP                               | cpc:showHelp()                     | Show Helpfile(s)              |
| #VERSION                            | cpc:showVersion()                  | Show version(s)               |
| #ALL &lt;arguments&gt;              | cpc:handleCommand("all","say hi")  | Send command to all profiles  |
| #DO &lt;arguments&gt;               | cpc:handleCommand("do","bow")      | send command to all other profiles |
| #BID &lt;profile> &lt;arguments&gt; | cpc:handleCommand("bid","gandalf cast light at demon") | send command to one character (immediate execution) |
| #ECHO &lt;text&gt;                  | cpc:handleCommand("echo","Im Dying!!!") | show something in all terminals |
| #TELL &lt;profile&gt;               | cpc:handleCommand("tell","boromir DIE!!") | show something in one particular terminal |

The #&lt;COMMAND&gt; commands are meant to be used from within the game. To use these mechanics in scripts or aliases, use the API commands - for example in your alias, instead of doing `send("hi")` you'd do `cpc:handleCommand("bid", "hi")`.

Profile names with hyphens and spaces are now supported, but in the case of profile names with spaces, you will need to quote
the name. Both double and single quotes are supported though in the cpc:commands you will need to use single quotes. 

Examples:

* `#BID "mage gandalf" cast cone of ice at balrog`
* `#BID 'mage saruman' cast cone of ice at balrog`
* `cpc:handleCommand("bid","'rogue jimmy the hand' backstab target1")`

Abbreviations of profile names are also supported, meaning that you can send commands to multiple profiles if these start with the same characters. E.g. if you have profiles such as "Mage-Saruman" and "Mage-Gandalf", you can send a command to both of 
them by using '#BID mage cast fireball at target'

With `cpc.strictTargets` set to `true` (see Settings) a `#BID` or `#TELL` target reaches at most
one profile instead: an exact profile name (any case) wins, otherwise the target must be a part
of exactly one open profile's name. `#BID mage ...` with both Mage profiles open then reaches
nobody and the sending profile lists the profiles it matched; a target no profile matches says
so in the sender; the other profiles stay silent. Use `#ALL` or `#DO` to reach several.

## Settings

Set these in a script of your own that loads before CPC (or at any time from the command line
with `lua`); CPC keeps a value that is already set:

| Setting | Default | Effect |
|---|---|---|
| `cpc.debug` | `false` | Log what CPC does |
| `cpc.localEcho` | `true` | Echo CPC's own notices in this profile |
| `cpc.strictTargets` | `false` | A `#BID` or `#TELL` target reaches at most one profile (above) |

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


