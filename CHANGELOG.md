# Changelog

## Version 2.0.0 - Complete Overhaul (2025-11-27)

### Breaking Changes
- Updated to support `fabric-ai` command (fabric's new name)
- Maintains backward compatibility with `fabric` command if still present

### New Features

#### Comprehensive Completions
- **50+ flags** now supported (previously only 4)
- All fabric-ai options now have tab completion
- Smart context-aware completions for:
  - Patterns
  - Models
  - Contexts
  - Sessions
  - Strategies
  - Extensions
  - TTS voices
  - Language codes
  - Image generation options

#### Intelligent Caching System
- Automatic caching of expensive operations (patterns, models, contexts, sessions)
- Configurable TTL (default 1 hour)
- Uses `--shell-complete-list` for optimal performance
- Cache stored in `$TMPDIR/fabric-zsh-cache`

#### 15+ Helper Functions
Added powerful helper functions:
- `fab` - Pipe-aware fabric wrapper
- `fabp` - Quick pattern execution
- `fabs` - Stream mode shortcut
- `fabc` - Copy to clipboard
- `faby` - YouTube processing
- `fabu` - URL scraping
- `fabls` - List/search patterns
- `fablm` - List/search models
- `fablc` - List/search contexts
- `fabls-session` - List/search sessions
- `fabinfo` - Preview pattern content
- `fabupdate` - Update patterns
- `fabfzf` - Interactive pattern picker (requires fzf)
- `fabctx` - Context management
- `fabsession` - Session management
- `fabclearcache` - Clear cache

#### New Aliases
- `fabhelp` - Show help
- `fabsetup` - Run setup
- `fabversion` - Show version
- `fabric` → `fabric-ai` (if fabric-ai exists but fabric doesn't)

#### Enhanced Environment Variables
```bash
FABRIC_CONFIG_DIR      # Config directory
FABRIC_PATTERNS_DIR    # Patterns directory
FABRIC_CONTEXTS_DIR    # Contexts directory
FABRIC_SESSIONS_DIR    # Sessions directory
FABRIC_CACHE_DIR       # Cache location
FABRIC_CACHE_TTL       # Cache TTL in seconds
FABRIC_CMD             # Active command (fabric or fabric-ai)
```

### Improvements

#### Completion Enhancements
- Now uses `--shell-complete-list` flag for raw output
- Faster and more reliable than parsing formatted output
- Better error handling when commands fail
- Graceful fallbacks for missing data

#### Code Quality
- Better error messages
- Improved cache validation
- More robust platform detection (macOS/Linux)
- Cleaner code structure

#### Documentation
- Comprehensive README with examples
- Quick start guide
- This changelog
- Extensive usage examples

### Migration from v1.x

No action needed! The module automatically detects whether you have `fabric` or `fabric-ai` and adapts accordingly.

If you have custom aliases using `fabric`, they'll continue to work. The module creates a `fabric` alias pointing to `fabric-ai` if needed.

### Old vs New Comparison

#### Before (v1.x)
```bash
# Only 4 flags supported
-y, --youtube
-p, --pattern
-m, --model
-g, --language

# Manual pattern listing from filesystem
# Basic model caching
# No helper functions
# No context/session support
```

#### After (v2.0)
```bash
# 50+ flags with completions
# All fabric-ai features supported
# Intelligent caching using native flags
# 15+ helper functions
# Full context/session support
# Image generation support
# TTS voice support
# Web search integration
# Strategy and extension support
```

### Performance

- **Cache hit**: Instant completions
- **Cache miss**: ~100-500ms (depending on network/system)
- **TTL**: 1 hour (configurable)

### Compatibility

- **ZSH**: 5.0+
- **Prezto**: Any recent version
- **Fabric**: Works with both `fabric` and `fabric-ai` commands
- **Platforms**: macOS, Linux

### Known Issues

None currently. Please report issues on GitHub.

### Credits

Thanks to Daniel Miessler for creating Fabric and implementing the `--shell-complete-list` flag which made this much cleaner.

---

## Version 1.0.0 - Initial Release

- Basic completions for fabric command
- Pattern, model, language code completions
- Simple model caching
- Basic aliases
