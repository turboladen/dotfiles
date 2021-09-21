# dotfiles

## YADM

I manage all these files with [YADM](https://yadm.io).

After pulling the repo:

1. Install YADM.
2. Set any YADM classes for your environment.
3. Run `yadm alt` to generate any files that are based on templates.
4. Run `yadm bootstrap` to set up all the things.

### Classes

- `AppleSilicon`: For Apple Silicon, set `yadm config local.class AppleSilicon`. Since homebrew
  uses a different root path for Apple Silicon (`/opt/homebrew` instead of
  `/usr/local`), this setting ensures the files pick up the correct path.
- `Work`
