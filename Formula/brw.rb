class Brw < Formula
  desc "Semantic browser control for agents"
  homepage "https://brw.donworks.co.uk/"
  version "0.19.0"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/Don-Works/brw/releases/download/v0.19.0/brw_0.19.0_darwin_arm64.tar.gz"
      sha256 "0e1b187a79c13b812dc7d84eafcf3cef628caa27a232aa8cb2b8c0267b1cb6e7"
    end
    on_intel do
      url "https://github.com/Don-Works/brw/releases/download/v0.19.0/brw_0.19.0_darwin_amd64.tar.gz"
      sha256 "9cd86205b9a72ddb3f2ba0ef4201f3fa564953f8e50e1132dbddd0089239a4be"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Don-Works/brw/releases/download/v0.19.0/brw_0.19.0_linux_arm64.tar.gz"
      sha256 "a2bbf48c658b140fcc8cefe5a2c65f3f19f5b254dedcc6715f319254a8d8f326"
    end
    on_intel do
      url "https://github.com/Don-Works/brw/releases/download/v0.19.0/brw_0.19.0_linux_amd64.tar.gz"
      sha256 "53923279a1485bffbeac02edbd3487473199494a40f14f12a62c6ff67f2b07d1"
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
