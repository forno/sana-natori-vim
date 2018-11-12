# sana-natori-vim

Sana Natori say ttene always when I insert newline and escape to normal mode.

## Dependencies

- npm
- play, mplayer, or afplay

## Installation

```bash
mkdir -p ~/.vim/pack/sounds/start
cd ~/.vim/pack/sounds/start
git clone https://github.com/forno/sana-natori-vim.git
cd sana-natori-vim
npm install magicalstick
`npm bin`/magicalstick | grep てねっ[0-9] | xargs -P4 -In1 wget n1 -P voices/
```

## LICENSE

This software is released under the MIT License, see LICENSE.

## Porting

- Emacs [shibafu528/ttene-mode](https://github.com/shibafu528/ttene-mode)
- Zsh [atnanasi/ttene.zsh](https://github.com/atnanasi/ttene.zsh)
- Atom [ueken0307/natorisana-voice](https://github.com/ueken0307/natorisana-voice)
