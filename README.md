# LLM Skills - Rust Development

A collection of specialized skills for Large Language Models to assist with Rust development tasks.

## Skills Overview

### [rust-general-patterns](rust-general-patterns/)

Comprehensive Rust development patterns covering:

- **Project Setup**: Creating new CLI/TUI applications from scratch, Cargo.toml configuration, module organization
- **Code Patterns**: Trait-based abstractions, error handling (anyhow/thiserror), CLI parsing (clap), structured logging (tracing)
- **System Integration**: Linux device I/O (v4l2), color space conversion, frame timing and performance monitoring
- **Best Practices**: Defensive programming, module organization, testing patterns

#### Files
- `SKILL.md` - Main skill description with quick reference
- `Rust-Project-Setup.md` - Step-by-step project implementation workflow
- `Rust-Patterns.md` - Comprehensive pattern reference and examples

### [rust-async-patterns](rust-async-patterns/)

Production-ready patterns for async Rust programming with Tokio:

- **Async Basics**: Future execution model, tasks, runtime configuration
- **Concurrency**: JoinSet, channels (mpsc, broadcast, oneshot, watch)
- **Error Handling**: anyhow, thiserror, timeout patterns
- **Advanced Topics**: Async traits, streams, graceful shutdown, resource management

#### Files
- `SKILL.md` - Complete async patterns guide with code examples

## Quick Reference

### Error Handling Decision

```
Is this a library?
├─ Yes → Use thiserror for typed errors
└─ No (application) → Use anyhow with .context()
```

### Common Dependencies

| Need | Crate | Notes |
|------|-------|-------|
| Error handling (app) | `anyhow` | Flexible, ergonomic |
| Error handling (lib) | `thiserror` | Typed errors |
| CLI parsing | `clap` v4 | Use derive feature |
| TUI framework | `ratatui` | With crossterm |
| Configuration | `serde` + `toml` | Standard approach |
| Async runtime | `tokio` | Most popular |
| HTTP client | `reqwest` | High-level, async |
| Logging | `tracing` | Structured logging |

### Cargo Commands

```bash
cargo check          # Fast compilation check
cargo build          # Debug build
cargo build --release # Optimized build
cargo test           # Run tests
cargo clippy         # Lint code
cargo fmt            # Format code
cargo doc --open     # Generate docs
```

## Usage

These skills are designed to be used by an LLM assistant when helping with Rust development tasks. Each skill provides:

1. **When to use**: Guidance on when to apply the patterns
2. **Code examples**: Production-ready implementation patterns
3. **Best practices**: Proven approaches for maintainable code
4. **Common pitfalls**: What to avoid and why

## Structure

```
llm-skills/
├── rust-general-patterns/
│   ├── SKILL.md              # Skill metadata and overview
│   ├── Rust-Project-Setup.md # Project implementation guide
│   └── Rust-Patterns.md      # Code patterns reference
└── rust-async-patterns/
    └── SKILL.md              # Async patterns guide
```

## License

MIT
