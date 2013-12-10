This is a collection of bash scripts that is supposed to simplify jumping 
between directories using multiple different shells.

My problem was this: suppose I have two terminals open, in the first 
terminal I 'cd' to some project:

in_terminal_A $ cd /home/me/projects/foo/src/main/language/org/very/long/path

Now I want to go to the same path from another terminal. How do I do that?
Defining some global environment variables does not work, the two terminals 
are not in a parent-child relationship. Defining hundred aliases for 
subdirectories of every project is insane, the aliases are so difficult to
remember that I never reuse them.

Bourne-Again-Shell-Portal-Gun to the rescue:

in_terminal_A $ pBlue # creates a blue portal in the dir with loooong path
in_terminal_B $ pOrange # creates an orange portal elsewhere
in_terminal_B $ mv stuff \[orange\] # push stuff through the portal
in_terminal_B $ cd \[orange\] # go through the portal yourself
in_terminal_B $ pClose # close all portals

Now I'm with all my stuff in the directory with very long path.

Notice: you usually only have to type 'pB' 'pO' 'pC' and '[', and then
press tab.

Installation is simple: clone the whole repo, add it to $PATH in your
./bashrc. Play with the ~/.bashrc if you want to have a portal indicator
in your $PS1-prompt (instructions included).

Please notice that each time you use the scripts, they create a 
file ~/.state.portal in your home directory.

Take a few minutes to walk through the testChambers to learn the basic 
usage and caveats (cd to chamber_n, then 'cat instructions.txt').

If you don't find it intuitive, some brain-rewiring might be necessary,
consider using the original "Portal" game for that.
