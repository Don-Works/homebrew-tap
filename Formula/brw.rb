class Brw < Formula
  desc "Semantic browser control for agents"
  homepage "https://brw.donworks.co.uk/"
  version "0.20.1"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/Don-Works/brw/releases/download/v0.20.1/brw_0.20.1_darwin_arm64.tar.gz"
      sha256 "4b1b65c48c49155d7c178d87f19cebe5dfa58148709dd2bc21b4867e94dfacaa"
    end
    on_intel do
      url "https://github.com/Don-Works/brw/releases/download/v0.20.1/brw_0.20.1_darwin_amd64.tar.gz"
      sha256 "7cbb6287624d793e249f145b5ea00d2b5de7e6b1bc34d21676c7a88fed0c4571"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Don-Works/brw/releases/download/v0.20.1/brw_0.20.1_linux_arm64.tar.gz"
      sha256 "d3a906a3d6fca277cdf18bdeab1efff1fae96cd60c73378d52d5f2127e2605e0"
    end
    on_intel do
      url "https://github.com/Don-Works/brw/releases/download/v0.20.1/brw_0.20.1_linux_amd64.tar.gz"
      sha256 "943a054f31277175d5ac242643a4f5d4c703b6cd078efd28970a4818f1d3faa5"
    end
  end

  livecheck do
    url :stable
    strategy :github_latest
  end

  # The archive is laid out exactly as brwctl expects an app dir to be laid out
  # (bin/, extension/, tests/, skills/, doc/), so installing it verbatim makes
  # opt_prefix a valid --app-dir and Homebrew still links bin/* onto PATH.
  def install
    prefix.install Dir["*"]
  end

  def caveats
    <<~EOS
      Finish setup (writes a profile policy under the platform user config
      directory and registers the MCP server; nothing here needs sudo):
        brwctl setup

      This formula's app dir is the Homebrew prefix, so point doctor at it:
        brwctl doctor --app-dir "#{opt_prefix}"

      The Chrome extension ships at:
        #{opt_prefix}/extension
    EOS
  end

  test do
    assert_match "brwctl", shell_output("#{bin}/brwctl 2>&1", 2)
    assert_match "brw <verb>", shell_output("#{bin}/brw 2>&1", 2)
  end
end
