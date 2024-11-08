# 🧵 Fabric ZSH Completions Module

This module provides ZSH completions for [Fabric](https://github.com/danielmiessler/fabric), an open-source framework for augmenting humans using AI.

## 🚀 Features

- Tab completion for all Fabric commands and flags
- Smart autocompletion for:
  - 📂 Pattern selection from your local patterns directory
  - 🤖 AI model selection with provider information
  - 🌐 Language code selection with descriptions
  - 🎥 YouTube URL template completion
- Cached model listings for improved performance
- Support for both short (-p) and long (--pattern) flag formats

## ⚡ Installation

### Prerequisites

1. [Prezto](https://github.com/sorin-ionescu/prezto) must be installed
2. [Fabric](https://github.com/danielmiessler/fabric) must be installed and accessible in your PATH

### Setup Steps

1. Clone this repository:
```bash
git clone https://github.com/diffficult/fabric-zsh.git
```

2. Create the contrib directory in your Prezto installation if it doesn't exist:
```bash
mkdir -p ${ZDOTDIR:-$HOME}/.zprezto/contrib
```

3. Symlink the module to your Prezto contrib directory:
```bash
ln -s /path/to/cloned/fabric-zsh ${ZDOTDIR:-$HOME}/.zprezto/contrib/fabric
```

4. Add 'fabric' to your modules list in `.zpreztorc`:
```bash
# Find the modules section and add 'fabric' to the list
zstyle ':prezto:load' pmodule \
  'environment' \
  'terminal' \
  'editor' \
  'history' \
  'directory' \
  'spectrum' \
  'utility' \
  'completion' \
  'prompt' \
  'fabric'  # Add this line
```

5. Restart your shell or reload your configuration:
```bash
source ${ZDOTDIR:-$HOME}/.zpreztorc
```

## 🎮 Usage

After installation, you can use tab completion with Fabric commands:

- `fabric [TAB]` - Show all available flags
- `fabric -y [TAB]` - Get YouTube URL template
- `fabric -p [TAB]` - List available patterns
- `fabric -m [TAB]` - List available AI models
- `fabric -g [TAB]` - List available language codes

## 🔄 Updates

To update the module, pull the latest changes from the repository:

```bash
cd /path/to/cloned/fabric-zsh
git pull
```

Your symlinked module will automatically reflect the updates.

## 🤝 Contributing

Feel free to submit issues and enhancement requests! Please check for existing issues before submitting new ones.

## 📜 License

MIT License - See LICENSE file for details

## 👏 Acknowledgments

- [Daniel Miessler](https://github.com/danielmiessler) for creating Fabric
- [Sorin Ionescu](https://github.com/sorin-ionescu) for creating Prezto
- All contributors to this module

---
Made with ❤️ by the Fabric community
