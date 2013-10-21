nemith dotfiles
===============
This is my public repository (castle) of dotfiles to be used with [Homesick](https://github.com/technicalpickles/homesick)


.bashrc and .bashrc.d
---------------------
.bashrc has been split out into a number of directories under .bashrc.d and gets executed in the following order

 * General pre-scripts:  All executable scripts under .bashrc.d/pre/*.bash (sorted alphabetically)
 * OS Specific scripts: The script under .bashrc.d/os/$OSNAME.bash where OSNAME is equal to the lower case version of `uname`
 * Host Specific scripts" The script under .bashrc.d/host/$HOSTNAME.bash where HOSTNAME is equal to the lower case version of `hostname -s`
 * General post-scripts: All executable scripts under .bashrc.d/post/*.bash (sorted alphabetically)