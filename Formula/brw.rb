class Brw < Formula
  desc "Semantic browser control for agents"
  homepage "https://brw.donworks.co.uk/"
  version "0.22.1"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/Don-Works/brw/releases/download/v0.22.1/brw_0.22.1_darwin_arm64.tar.gz"
      sha256 "a10cb058669628fc1c265ad919279f4daf6e3f277830b5ac4f337d176fe7fbb2"
    end
    on_intel do
      url "https://github.com/Don-Works/brw/releases/download/v0.22.1/brw_0.22.1_darwin_amd64.tar.gz"
      sha256 "1446730de5b1f2897dffbc1a7ebd03ee5ee8e01357617aef54b60aa0fc404215"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Don-Works/brw/releases/download/v0.22.1/brw_0.22.1_linux_arm64.tar.gz"
      sha256 "0b2669ceba18340b91b68f21c2163cb5f810f711088423cb2ba581b5b5d15bc9"
    end
    on_intel do
      url "https://github.com/Don-Works/brw/releases/download/v0.22.1/brw_0.22.1_linux_amd64.tar.gz"
      sha256 "f29bc0c6fcbc52f12ccc400d832453cf0df00414746bd389754cb808100512fb"
    end
  end

  livecheck do
    url :stable
    strategy :github_latest
  end

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
