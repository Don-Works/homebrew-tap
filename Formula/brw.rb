class Brw < Formula
  desc "Semantic browser control for agents"
  homepage "https://brw.donworks.co.uk/"
  version "0.18.1"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/Don-Works/brw/releases/download/v0.18.1/brw_0.18.1_darwin_arm64.tar.gz"
      sha256 "152a6cc766ccce522659cddc039977b8dff7cb9162ace4dd3a07ae521531dece"
    end
    on_intel do
      url "https://github.com/Don-Works/brw/releases/download/v0.18.1/brw_0.18.1_darwin_amd64.tar.gz"
      sha256 "4e53257222735b97654a42ff6710ebaccd72a9085b2941a4b13c7f37d08fa2f0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Don-Works/brw/releases/download/v0.18.1/brw_0.18.1_linux_arm64.tar.gz"
      sha256 "63560b9cf8ab4c67e202783beab3f1a71518c4e16741fc19f6a95279528aefee"
    end
    on_intel do
      url "https://github.com/Don-Works/brw/releases/download/v0.18.1/brw_0.18.1_linux_amd64.tar.gz"
      sha256 "4552b5259755d6f61e4d84c411f7d84f2a782e35f2d4e3ee672b8c476ceac869"
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
