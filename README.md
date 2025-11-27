# Fabric ZSH Completions Module

Advanced ZSH completions and helper functions for [Fabric](https://github.com/danielmiessler/fabric), the open-source AI framework for augmenting humans.

## Features

### Smart Tab Completions
- **Complete flag coverage**: All 50+ fabric-ai flags with descriptions
- **Dynamic completions** using `--shell-complete-list` for:
  - Patterns (with smart caching)
  - AI Models (cached for performance)
  - Contexts
  - Sessions
  - Strategies
  - Extensions
  - TTS voices
  - Language codes
  - Image generation options
- **Intelligent caching**: 1-hour TTL cache for fast completions
- **Both commands supported**: Works with `fabric` and `fabric-ai`

### Powerful Helper Functions

#### Quick Pattern Execution
```bash
fab            # Pipe-aware fabric wrapper
fabp <pattern> # Quick pattern execution
fabs           # Stream mode
fabc           # Copy to clipboard
```

#### Content Processing
```bash
faby <url>     # YouTube transcript processing
fabu <url>     # Web scraping
```

#### List and Search
```bash
fabls [filter]          # List/search patterns
fablm [filter]          # List/search models
fablc [filter]          # List/search contexts
fabls-session [filter]  # List/search sessions
```

#### Pattern Management
```bash
fabinfo <pattern>  # Preview pattern (uses bat if available)
fabupdate          # Update patterns
fabfzf             # Interactive pattern picker (requires fzf)
```

#### Context and Session Management
```bash
fabctx [context]       # Switch context or list all
fabsession [session]   # Use session or list all
```

#### Utilities
```bash
fabclearcache  # Clear completion cache
fabhelp        # Show help
fabsetup       # Run setup
fabversion     # Show version
```

## Installation

### Prerequisites

1. **Prezto** - [Installation guide](https://github.com/sorin-ionescu/prezto)
2. **Fabric** - Install the latest version:
   ```bash
   pip install fabric-ai
   # or
   go install github.com/danielmiessler/fabric@latest
   ```

### Setup

1. Clone this repository:
   ```bash
   cd ~/.zprezto/contrib
   git clone https://github.com/diffficult/fabric-zsh.git fabric
   ```

2. Add 'fabric' to your modules in `.zpreztorc`:
   ```bash
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
     'fabric'
   ```

3. Reload your shell:
   ```bash
   exec zsh
   ```

## Usage Examples

### Basic Usage
```bash
# Pipe content to fabric with a pattern
echo "analyze this" | fab -p analyze_claims

# Quick pattern execution
cat document.txt | fabp summarize

# Stream the output
echo "write a story" | fabs -p create_story

# Copy result to clipboard
echo "key points" | fabc -p extract_wisdom
```

### YouTube Processing
```bash
# Get transcript and apply pattern
faby "https://youtube.com/watch?v=..." -p extract_wisdom

# Get transcript with timestamps
fabric-ai -y "https://youtube.com/..." --transcript-with-timestamps

# Get comments
fabric-ai -y "https://youtube.com/..." --comments
```

### Web Scraping
```bash
# Scrape and analyze a webpage
fabu "https://example.com" -p analyze_claims

# Search using Jina AI
fabric-ai -q "latest AI news" -p summarize
```

### Model Selection
```bash
# List available models
fablm

# Filter models
fablm claude

# Use specific model
echo "test" | fab -m gpt-4 -p summarize
```

### Pattern Discovery
```bash
# List all patterns
fabls

# Search for specific patterns
fabls wisdom

# Preview a pattern
fabinfo extract_wisdom

# Interactive picker with preview (requires fzf)
cat document.txt | fabfzf
```

### Context Management
```bash
# List contexts
fabctx

# Use a specific context
fabctx work -p summarize < input.txt

# Wipe a context
fabric-ai --wipecontext work
```

### Session Management
```bash
# List sessions
fabsession

# Use a session
fabsession my-research -p analyze_claims

# Print session content
fabric-ai --printsession my-research

# Wipe session
fabric-ai --wipesession my-research
```

### Image Generation
```bash
# Generate image
echo "a serene landscape" | fabric-ai --image-file output.png

# Specify size and quality
echo "abstract art" | fabric-ai --image-file art.png --image-size 1536x1024 --image-quality high
```

### Advanced Features
```bash
# Use variables in patterns
fabric-ai -p custom_pattern -v=#role:expert -v=#points:30

# Web search integration
fabric-ai -p research --search --search-location "America/Los_Angeles"

# Dry run to see what would be sent
fabric-ai -p summarize --dry-run < input.txt

# Multiple options combined
cat article.txt | fab -p extract_wisdom -m claude-3-opus-20240229 -g en -s -c
```

## Configuration

### Environment Variables

```bash
# Set in your .zshrc before loading Prezto
export FABRIC_CONFIG_DIR="$HOME/.config/fabric"
export FABRIC_PATTERNS_DIR="$HOME/.config/fabric/patterns"
export FABRIC_CONTEXTS_DIR="$HOME/.config/fabric/contexts"
export FABRIC_SESSIONS_DIR="$HOME/.config/fabric/sessions"
export FABRIC_CACHE_TTL="3600"  # Cache TTL in seconds (default: 1 hour)
```

### Cache Management

The module caches pattern, model, context, and session lists for performance. Cache is stored in `$TMPDIR/fabric-zsh-cache` with a 1-hour TTL by default.

To clear cache:
```bash
fabclearcache
```

To change cache TTL:
```bash
export FABRIC_CACHE_TTL="7200"  # 2 hours
```

## Completions Reference

### All Supported Flags

The completion system supports all fabric-ai flags:

#### Pattern & Input Options
- `-p, --pattern` - Choose pattern (with tab completion)
- `-v, --variable` - Pattern variables
- `-C, --context` - Choose context (with tab completion)
- `--session` - Choose session (with tab completion)
- `-a, --attachment` - Attachment path or URL

#### Model Parameters
- `-m, --model` - Choose model (with tab completion)
- `-t, --temperature` - Set temperature
- `-T, --topp` - Set top P
- `-P, --presencepenalty` - Set presence penalty
- `-F, --frequencypenalty` - Set frequency penalty
- `-e, --seed` - Set seed
- `-r, --raw` - Use model defaults

#### Output Options
- `-s, --stream` - Stream output
- `-c, --copy` - Copy to clipboard
- `-o, --output` - Output to file
- `--output-session` - Output entire session

#### List Commands
- `-l, --listpatterns` - List patterns
- `-L, --listmodels` - List models
- `-x, --listcontexts` - List contexts
- `-X, --listsessions` - List sessions
- `--liststrategies` - List strategies
- `--listvendors` - List vendors
- `--listextensions` - List extensions
- `--list-gemini-voices` - List Gemini TTS voices

#### YouTube Options
- `-y, --youtube` - YouTube URL
- `--playlist` - Prefer playlist
- `--transcript` - Grab transcript
- `--transcript-with-timestamps` - Transcript with timestamps
- `--comments` - Grab comments
- `--metadata` - Output metadata

#### Web Scraping
- `-u, --scrape_url` - Scrape URL
- `-q, --scrape_question` - Search with Jina AI
- `--readability` - Convert HTML to readable

#### Image Generation
- `--image-file` - Save image to file
- `--image-size` - Image dimensions (1024x1024, 1536x1024, etc.)
- `--image-quality` - Quality (low, medium, high, auto)
- `--image-compression` - Compression level 0-100
- `--image-background` - Background (opaque, transparent)

#### And many more...

## Tips and Tricks

### Combine with Other Tools

```bash
# Use with jq for JSON processing
echo "analyze this data" | fab -p analyze_claims | jq .

# Use with bat for syntax highlighting
fabinfo extract_wisdom

# Use with fzf for interactive selection
fabfzf
```

### Create Custom Aliases

Add to your `.zshrc`:
```bash
# Quick summarization
alias summ='fabp summarize'

# Extract key points
alias wisdom='fabp extract_wisdom'

# Analyze claims with Claude
alias analyze='fab -m claude-3-opus-20240229 -p analyze_claims'
```

### Pipe Chains

```bash
# Multi-stage processing
curl -s https://example.com/article | \
  fabu - -p extract_article | \
  fab -p summarize | \
  fab -p improve_writing
```

## Troubleshooting

### Completions not working

1. Ensure the module is loaded:
   ```bash
   zprezto-list-modules | grep fabric
   ```

2. Check if fabric-ai is in PATH:
   ```bash
   which fabric-ai
   ```

3. Reload completions:
   ```bash
   rm -f ~/.zcompdump
   exec zsh
   ```

### Cache issues

Clear the cache:
```bash
fabclearcache
```

### Performance issues

Increase cache TTL:
```bash
export FABRIC_CACHE_TTL="86400"  # 24 hours
```

## Updates

Keep the module updated:
```bash
cd ~/.zprezto/contrib/fabric
git pull
exec zsh
```

## Contributing

Contributions welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## Related Projects

- [Fabric](https://github.com/danielmiessler/fabric) - The main Fabric project
- [Prezto](https://github.com/sorin-ionescu/prezto) - The ZSH framework

## License

MIT License - See LICENSE file for details

## Acknowledgments

- [Daniel Miessler](https://github.com/danielmiessler) for creating Fabric
- [Sorin Ionescu](https://github.com/sorin-ionescu) for creating Prezto
- All contributors to this module

---

Made for the Fabric community
