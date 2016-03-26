# Debian Stack 

This image provides a 'canned'  Debian, Stack, Vim development environment for Haskell.

# Why?

I wanted to make it easy to share my development environment with other people.

# Requirements

  * [Docker](https://www.docker.com/) 

# Install

```console
docker pull mgreenly/debian-stack
```

# Example

  * Change to the root directory of you project.
  * ```docker rune --rm -i -t -v $PWD:/home/haskell/project mgreenly/debian-stack:latest  /bin/bash```

# Includes 

  * http://www.stephendiehl.com/posts/vim_haskell.html
  * https://github.com/tpope/vim-pathogen
  * https://github.com/tpope/vim-sensible
  * https://github.com/scrooloose/syntastic#installation
  * https://github.com/bitc/vim-hdevtools
  * http://www.mew.org/~kazu/proj/ghc-mod/en/

