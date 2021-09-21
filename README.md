# dotfiles

## YADM

I manage with [YADM](https://yadm.io).

For Apple Silicon, set `yadm config local.class AppleSilicon`. Since hombrew
uses a different root path for Apple Silicon (`/opt/homebrew` instead of
`/usr/local`), this setting ensures the files pick up the correct path.
