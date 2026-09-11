class Brw < Formula
  desc "Semantic browser control for agents"
  homepage "https://brw.donworks.co.uk/"
  version "0.11.0"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/Don-Works/brw/releases/download/v0.11.0/brw_0.11.0_darwin_arm64.tar.gz"
      sha256 "197922e03c89e3ca0edaff2e78ef82dca2698c9c8c449ee66cc3c259f4ef1ddf"
    end
    on_intel do
      url "https://github.com/Don-Works/brw/releases/download/v0.11.0/brw_0.11.0_darwin_amd64.tar.gz"
      sha256 "a4241683454d1981e01365d9ce7789c291fd24471dbc341b2b88de9194e76122"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Don-Works/brw/releases/download/v0.11.0/brw_0.11.0_linux_arm64.tar.gz"
      sha256 "5a9085af22760977338704a3f4b94ff3cbd01dd3f5989b639743697521fe5d39"
    end
    on_intel do
      url "https://github.com/Don-Works/brw/releases/download/v0.11.0/brw_0.11.0_linux_amd64.tar.gz"
      sha256 "c22535a66312fd8c440e630d8be872c1ac5ddd72cb281ef7846777b24d9c60bb"
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
      Finish setup (writes ~/.config/brw/browser-profiles.json and registers the
      MCP server; nothing here needs sudo):
        brwctl setup

      This formula's app dir is the Homebrew prefix, so point doctor at it:
        brwctl doctor --app-dir "#{opt_prefix}" --workspace brw

      The Chrome extension ships at:
        #{opt_prefix}/extension
    EOS
  end

  test do
    assert_match "brwctl", shell_output("#{bin}/brwctl 2>&1", 2)
  end
end
