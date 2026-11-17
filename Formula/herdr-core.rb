class HerdrCore < Formula
  desc "Terminal runtime for coding agents (hc)"
  homepage "https://github.com/herdrdev/herdr-core"
  url "https://github.com/Fjx-dylanZ/herdr-core.git",
      tag:      "v0.1.21",
      revision: "1b0393f80c35b1dae34f37934d33d0144a8fc8d7"
  license "Apache-2.0"
  head "https://github.com/Fjx-dylanZ/herdr-core.git", branch: "master"

  # Git checkout: vendor/ghostty is a submodule missing from release tarballs.

  depends_on "rust" => :build
  depends_on "zig@0.16" => :build

  def install
    ENV.prepend_path "PATH", formula_opt_bin("zig@0.16")
    system "cargo", "install", *std_cargo_args(path: "crates/herdr-core")
    bin.install_symlink "herdr-core" => "hc"
  end

  def caveats
    "Update with `brew upgrade herdr-core`; `hc update` refuses Homebrew installs."
  end

  test do
    assert_match "hc #{version}", shell_output("#{bin}/hc --version")
  end
end
