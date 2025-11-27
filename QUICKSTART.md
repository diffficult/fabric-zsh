# Quick Start Guide

## Immediate Installation (If Already Using Prezto)

```bash
# 1. Clone to Prezto contrib directory
cd ~/.zprezto/contrib
git clone https://github.com/diffficult/fabric-zsh.git fabric

# 2. Add to .zpreztorc
# Find the line with "zstyle ':prezto:load' pmodule" and add 'fabric' to the list

# 3. Reload
exec zsh
```

## Most Useful Commands

### Daily Usage
```bash
# Pipe anything to fabric with pattern completion
echo "text" | fab -p <TAB>

# Quick pattern execution
fabp summarize < document.txt

# Interactive pattern picker (needs fzf)
cat file.txt | fabfzf

# Stream output
fabs -p create_story

# Copy to clipboard
fabc -p extract_wisdom
```

### Discovery
```bash
fabls              # List all patterns
fabls wisdom       # Search patterns
fabinfo <pattern>  # Preview pattern content
fablm              # List models
fablm claude       # Search models
```

### YouTube & Web
```bash
faby "youtube-url" -p extract_wisdom
fabu "https://site.com" -p summarize
```

### Context & Sessions
```bash
fabctx             # List contexts
fabctx work        # Use context
fabsession         # List sessions
```

## Tab Completion Examples

Press TAB after:
- `fabric-ai -p <TAB>` → See all patterns
- `fabric-ai -m <TAB>` → See all models
- `fabric-ai -g <TAB>` → See language codes
- `fabric-ai --image-size <TAB>` → See size options
- `fabric-ai --voice <TAB>` → See TTS voices

## Cache Management

```bash
fabclearcache      # Clear if completions seem stale
```

## Pro Tips

1. **Combine helper functions:**
   ```bash
   faby "url" | fabp extract_wisdom | fabc
   ```

2. **Use with clipboard:**
   ```bash
   pbpaste | fabp summarize | pbcopy  # macOS
   xclip -o | fabp summarize | xclip  # Linux
   ```

3. **Create personal aliases in .zshrc:**
   ```bash
   alias summ='fabp summarize'
   alias wisdom='fabp extract_wisdom'
   ```

4. **Use variables:**
   ```bash
   fabric-ai -p custom -v=#role:expert -v=#length:short
   ```

## Troubleshooting

**Completions not working?**
```bash
# Reload completions
rm -f ~/.zcompdump && exec zsh
```

**Functions not found?**
```bash
# Check if module is loaded
zprezto-list-modules | grep fabric
```

**Slow completions?**
```bash
# Cache is working but you can adjust TTL
export FABRIC_CACHE_TTL="7200"  # 2 hours (default is 3600)
```
