# Ethan's Assorted Dotfiles

These are my configs I need to get a new system up and running quickly.

## Requirements

While you can simply grab an individual file, I use `stow` to manage my dots.
It's available on pretty much any \*nix OS, and it's swell for handling a bunch
of modular directories like this. Install it using your package manager of
choice.

## Installation

Clone this repository somewhere in your home directory, then install the dots
for a given application using `stow`. Example:

```
$ stow neovim
```

