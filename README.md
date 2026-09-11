# Don Works Homebrew tap

```sh
brew install don-works/tap/brw
```

## brw

[brw](https://github.com/Don-Works/brw) gives AI agents control of Chrome and
Chromium: one namespace per real browser profile, semantic element refs, and a
local daemon that never leaves loopback.

`Formula/brw.rb` is written by brw's release workflow, which renders
`packaging/homebrew/render-formula.sh` against the published release archives
and their checksums. Do not hand-edit it; the next release overwrites it.

The formula installs the whole brw tree into the formula prefix, so that prefix
is the app directory:

```sh
brwctl doctor --app-dir "$(brew --prefix brw)"
```

The alternative install paths are the one-line installer
(`curl -fsSL https://brw.donworks.co.uk/install.sh | sh`) and the platform
packages on the [releases page](https://github.com/Don-Works/brw/releases).
