# My dotfiles repo

This is my (new) dotfiles repository. I've set it up since I noticed that after 
installing `i3` I made a lot of customization which I didn't want to lose. The 
pattern I use here follows the one [mentioned here][1]. Basically you setup a 
bare git repository called `.cfg` or whatever you want, and with a convenient
alias add the files you want from `$HOME` to it. If you know what you're
doing, the following commands will suffice:

```sh
git init --bare $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.zshrc
```

Then you can simply `config add <file>`, `config push`, `config status` etc...
For more details look at the link provided above.

[1]: https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
