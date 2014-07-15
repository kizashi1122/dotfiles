
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
-4ce90c3c599aa33ae781d8c19a9e8a4c42b58016 .emacs.d/public_repos/php-mode
-a6d71b38a3db867ccf82999c99805db1a3a33c33 .emacs.d/public_repos/rhtml
-e2ed2fa55ac3435a86b1cf6a4f2d29aebc309135 .emacs.d/public_repos/rinari
-94af467fe690f71343c16b31c1fed0f95943a44e .emacs.d/public_repos/scss-mode
$ git submodule init
$ git submodule update
$ cd 
$ ln -s dotfiles/.emacs.d .
$ ln -s dotfiles/.bashrc .
$ ln -s dotfiles/.vimrc .
```