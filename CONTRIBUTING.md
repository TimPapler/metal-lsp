# Contributing to Metal LSP

Thank you for your interest in contributing to Metal LSP! This document provides guidelines and instructions for contributing.

## Getting Started

### Prerequisites

- macOS 13 or later
- Xcode Command Line Tools (`xcode-select --install`)
- Swift 5.9 or later
- Git

### Setting Up Development Environment

1. Fork the repository on GitHub
2. Clone your fork:
   ```bash
   git clone https://github.com/YOUR_USERNAME/metal-lsp.git
   cd metal-lsp
   ```

3. Add the upstream remote:
   ```bash
   git remote add upstream https://github.com/TimPapler/metal-lsp.git
   ```

4. Build the project:
   ```bash
   swift build
   ```

5. Run tests:
   ```bash
   swift test
   ```

## Development Workflow

### Creating a Branch

Create a feature branch from `main`:

```bash
git checkout main
git pull upstream main
git checkout -b feature/your-feature-name
```

Branch naming conventions:
- `feature/description` - New features
- `fix/description` - Bug fixes
- `docs/description` - Documentation updates
- `refactor/description` - Code refactoring
- `test/description` - Test additions/updates

### Making Changes

1. Make your changes in your feature branch
2. Follow the Swift style guidelines (see below)
3. Write or update tests as needed
4. Update documentation if necessary

### Running Tests

```bash
# Run all tests
swift test

# Run tests with verbose output
swift test -v

# Run specific test
swift test --filter MetalLSPTests.testDocumentManager
```

### Building

```bash
# Debug build
swift build

# Release build
swift build -c release

# Clean build
swift package clean
swift build
```

### Testing the LSP Server

1. Build the server:
   ```bash
   swift build
   ```

2. Test with a Metal file:
   ```bash
   # The server expects LSP protocol over stdin/stdout
   # You can test with a real editor or LSP test tools
   ```

3. Enable verbose logging:
   ```bash
   .build/debug/metal-lsp --verbose --log-messages 2> /tmp/metal-lsp.log
   ```

## Code Style Guidelines

### Swift Style

- Use 4 spaces for indentation (no tabs)
- Maximum line length: 120 characters
- Use descriptive variable and function names
- Add documentation comments for public APIs
- Follow Swift naming conventions:
  - Types: `PascalCase`
  - Functions/variables: `camelCase`
  - Constants: `camelCase`
  - Enums: `PascalCase` with `camelCase` cases

### Documentation

- Add doc comments for public types, functions, and properties:
  ```swift
  /// Represents a Metal diagnostic from the compiler
  public struct MetalDiagnostic {
      /// The line number (0-based)
      public let line: Int

      /// The column number (0-based)
      public let column: Int
  }
  ```

### Testing

- Write tests for new features
- Maintain or improve test coverage
- Use descriptive test names:
  ```swift
  func testDocumentManagerOpensAndClosesDocuments() {
      // Test implementation
  }
  ```

## Commit Guidelines

### Commit Messages

Follow the conventional commit format:

```
type(scope): brief description

Detailed explanation if needed.

- Additional details
- More context
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, no logic change)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Build process or auxiliary tool changes

**Examples:**
```
feat(completion): add signature help support

Implements signature help for function parameters using LSP
signatureHelp request.

fix(compiler): handle multi-line error messages correctly

The Metal compiler sometimes outputs errors spanning multiple
lines. Updated the regex parser to handle these cases.

docs(readme): add troubleshooting section for Neovim setup
```

### Commit Best Practices

- Make atomic commits (one logical change per commit)
- Write clear, descriptive commit messages
- Reference issues when applicable: `fixes #123`

## Submitting a Pull Request

1. Ensure all tests pass:
   ```bash
   swift test
   ```

2. Ensure release build works:
   ```bash
   swift build -c release
   ```

3. Update documentation if needed

4. Push your branch to your fork:
   ```bash
   git push origin feature/your-feature-name
   ```

5. Create a Pull Request on GitHub:
   - Provide a clear description of changes
   - Reference any related issues
   - Fill out the PR template

6. Address review feedback:
   ```bash
   # Make changes based on feedback
   git add .
   git commit -m "address review feedback"
   git push origin feature/your-feature-name
   ```

## Project Structure

```
metal-lsp/
├── Sources/
│   ├── MetalLSP/              # CLI executable
│   ├── MetalLanguageServer/   # LSP protocol implementation
│   └── MetalCore/             # Metal-specific logic
├── Tests/
│   └── MetalLSPTests/         # Unit tests
├── .github/
│   └── workflows/             # CI/CD workflows
├── examples/                   # Example Metal shaders
└── README.md
```

### Module Responsibilities

- **MetalLSP**: Entry point, CLI argument parsing
- **MetalLanguageServer**: LSP protocol, JSON-RPC, document management
- **MetalCore**: Metal compiler integration, built-ins database

## Areas for Contribution

Here are some areas where contributions are especially welcome:

### Features
- [ ] Hover information for symbols
- [ ] Go to definition support (requires parsing)
- [ ] Find references
- [ ] Signature help
- [ ] Document symbols / outline
- [ ] Code formatting
- [ ] Rename refactoring
- [ ] Semantic tokens for enhanced highlighting
- [ ] Context-aware completion (scope filtering)

### Improvements
- [ ] Incremental compilation for performance
- [ ] Better error message parsing
- [ ] Support for Metal standard library documentation
- [ ] Workspace symbol search
- [ ] Code actions and quick fixes
- [ ] Performance optimization

### Documentation
- [ ] Video tutorial for setup
- [ ] More example shaders
- [ ] API documentation
- [ ] Editor integration guides (Vim, Emacs, etc.)

### Testing
- [ ] Integration tests
- [ ] LSP protocol compliance tests
- [ ] Performance benchmarks

## Getting Help

- Open an issue for bugs or feature requests
- Start a discussion for questions or ideas
- Check existing issues and PRs for similar work

## Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Focus on the code, not the person
- Help others learn and grow

## License

By contributing, you agree that your contributions will be licensed under the Apache License 2.0.

---

Thank you for contributing to Metal LSP! 🎉
