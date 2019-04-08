# What is Bash Portal Gun?

The Bash Portal Gun is a collection of bash scripts that is 
supposed to simplify jumping between directories and moving files 
between directories using multiple different shells.

It allows you to open portals in two different directories, and then to jump 
or to move files between these two directories using the portals, without 
having to type long paths as arguments to `mv` or `cd`.

![bashPortalGun screenshot](./bash_Portal_Gun_screenshot.png)

# Available commands

* `$ pOrange <relativePath>` creates an orange portal
* `$ pBlue <relativePath>` creates a blue portal
* `$ pWhere` shows current positions of portals
* `$ pClose` closes both portals
* `$ pDestroy` finds and removes "zombie portals" 
   (broken symlinks that arise whenever you move the containing directories)

# An example problem
Suppose you have two terminals open.
In the first terminal, you `cd` to a directory `a`:

```bash
in_terminal_A $ cd /home/me/very/long/path/a
```

In the second terminal, you `cd` to another directory `b`:

```bash
in_terminal_B $ cd /home/me/another/very/long/path/b
```

Now you want to move file `f` from `a` to `b`.
Usually, you would have to type something like:

```bash
in_terminal_B $ mv f /home/me/very/long/path/a/
```

If you are selectively moving multiple files from `a` to `b`, this 
quickly becomes annoying. Bash Portal Gun to the rescue!

```bash
in_terminal_A $ pBlue # creates a blue portal in the directory `a`
in_terminal_B $ pOrange # creates an orange portal in `b`
in_terminal_B $ mv stuff \[orange\] # push stuff through the portal
in_terminal_B $ cd \[orange\] # go through the portal yourself
in_terminal_B $ pClose # close all portals
```

Now you are with all your files in the directory `a`.

# Usability

Notice that you usually only have to type 'pB' 'pO' 'pC' and '[', and then
press tab.
There is a possibility to modify your shell prompt so that it 
shows the portals that are open in the current directory.

# Installation

Installation is simple: clone the whole repository (or download bashPortalGun as .zip 
and unpack it somewhere). 
Then `cd` to the bashPortalGun directory.
In the most cases, it should be enough to run 

```bash
$ ./installBashPortalGun
```

This script will add the `bashPortalGun` scripts to your `PATH`,
and modify your shell prompt in the `~/.bashrc`.
It will also modify the behavior of `cd` such that it handles 
symlinks slightly differently (make sure you want this, remove 
the alias otherwise).
Since the installation script modifies your `~/.bashrc`, it
creates a backup copy: remove this copy after the installation, if
you think that everything went smoothly. 

If something goes wrong, restore you original .bashrc as follows:

```bash
$ mv ~/.bashrc_BACKUP_BY_BASH_PORTAL_GUN ~/.bashrc
```

You can also take a look at the installation script, and run only
those steps that you really want. It has only a few lines, and
is really straight forward.

Please notice that each time you use the scripts, they create a 
file `~/.state.portal` in your home directory.

# Test chambers

Take a few minutes to walk through the test chambers to learn the basic 
usage and caveats (`cd` to `chamber_n`, then `cat instructions.txt`).

# Disclaimer

These scripts obviously do not share any code or other data
with the "Portal" game (Valve) or the portal-plugin for Vim
(however, we have decided to follow the same color convention).
Use at your own risk.
