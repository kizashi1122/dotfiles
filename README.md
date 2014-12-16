
#### the following files only for now

* .emacs.d/*
* .vimrc
* .bashrc

### Usage

```sh
$ cd 
$ git clone git@github.com:kizashi1122/dotfiles.git
$ cd dotfiles
$ git submodule status
-8d637168fec4d0d73b2b82685a1015ada088d75c public_repos/git-modes
-bf9a86c64a6c2672b2835613297c2a61b6df99a6 public_repos/magit
-dea0ae2d52ccd3a92b9e932f258ed7eddfd9b58d public_repos/markdown-mode
-67297ce096a30e44b4954e5e26fa85ae61b08450 public_repos/php-mode
-a6d71b38a3db867ccf82999c99805db1a3a33c33 public_repos/rhtml
-76892992a9bcb80192a6603992987b880b37b243 public_repos/rinari
-94af467fe690f71343c16b31c1fed0f95943a44e public_repos/scss-mode
$ git submodule init
Submodule '.emacs.d/public_repos/git-modes' (git@github.com:magit/git-modes.git) registered for path 'public_repos/git-modes'
Submodule '.emacs.d/public_repos/magit' (git@github.com:magit/magit.git) registered for path 'public_repos/magit'
Submodule '.emacs.d/public_repos/markdown-mode' (git://jblevins.org/git/markdown-mode.git) registered for path 'public_repos/markdown-mode'
Submodule '.emacs.d/public_repos/php-mode' (git@github.com:ejmr/php-mode.git) registered for path 'public_repos/php-mode'
Submodule '.emacs.d/public_repos/rhtml' (git@github.com:eschulte/rhtml.git) registered for path 'public_repos/rhtml'
Submodule '.emacs.d/public_repos/rinari' (git@github.com:eschulte/rinari.git) registered for path 'public_repos/rinari'
Submodule '.emacs.d/public_repos/scss-mode' (git@github.com:antonj/scss-mode.git) registered for path 'public_repos/scss-mode'
$ git submodule update
Cloning into '.emacs.d/public_repos/git-modes'...
Warning: Permanently added the RSA host key for IP address '192.30.252.130' to the list of known hosts.
remote: Counting objects: 1806, done.
remote: Compressing objects: 100% (9/9), done.
remote: Total 1806 (delta 4), reused 0 (delta 0)
Receiving objects: 100% (1806/1806), 477.49 KiB | 162.00 KiB/s, done.
Resolving deltas: 100% (966/966), done.
Checking connectivity... done.
Submodule path 'public_repos/git-modes': checked out '8d637168fec4d0d73b2b82685a1015ada088d75c'
Cloning into '.emacs.d/public_repos/magit'...
remote: Counting objects: 16389, done.
remote: Compressing objects: 100% (6166/6166), done.
remote: Total 16389 (delta 10188), reused 16317 (delta 10144)
Receiving objects: 100% (16389/16389), 8.46 MiB | 1.27 MiB/s, done.
Resolving deltas: 100% (10188/10188), done.
Checking connectivity... done.

:

$ cd 
$ ln -s dotfiles/.emacs.d .
$ ln -s dotfiles/.bashrc .
$ ln -s dotfiles/.vimrc .
```
