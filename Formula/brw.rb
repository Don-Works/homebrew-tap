class Brw < Formula
  desc "Semantic browser control for agents"
  homepage "https://brw.donworks.co.uk/"
  version "0.12.1"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/Don-Works/brw/releases/download/v0.12.1/brw_0.12.1_darwin_arm64.tar.gz"
      sha256 "60e45dd98977d37997ea8b098c651219e3a7702150bb88272fd56e74cd784e3c"
    end
    on_intel do
      url "https://github.com/Don-Works/brw/releases/download/v0.12.1/brw_0.12.1_darwin_amd64.tar.gz"
      sha256 "7cd13c9c72242b20ffebc77afc8029e4b29bfd6a781e7a81d3cadcacfb8b9420"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Don-Works/brw/releases/download/v0.12.1/brw_0.12.1_linux_arm64.tar.gz"
      sha256 "4c8aaf900e4d849687df01e6068606274d96dd5753ac0f6d1f4adbf737859cba"
    end
    on_intel do
      url "https://github.com/Don-Works/brw/releases/download/v0.12.1/brw_0.12.1_linux_amd64.tar.gz"
      sha256 "75f5a51af7e6de1c33c44074ebb02443c28641190ad936072c98d8d3e338b460"
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
  end
end
