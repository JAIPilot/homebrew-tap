class Jaipilot < Formula
  desc "Java testing workflows with a local CLI and MCP server"
  homepage "https://www.jaipilot.com"
  version "1.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JAIPilot/jaipilot/releases/download/v1.2.0/jaipilot-aarch64-apple-darwin.gz", using: :nounzip
      sha256 "f59eccb82a7dc7260effffe8bfe2a90049f63b11da3fe63de9f1a90b22b9b02a"
      resource "notices" do
        url "https://github.com/JAIPilot/jaipilot/releases/download/v1.2.0/jaipilot-notices-aarch64-apple-darwin.zip"
        sha256 "00702d7988a4d86757d27614459a7fed736aedaf8c601701e954566bca8718c4"
      end
    else
      url "https://github.com/JAIPilot/jaipilot/releases/download/v1.2.0/jaipilot-x86_64-apple-darwin.gz", using: :nounzip
      sha256 "09d15b0fc5ba0af341d41ea9adb50391c55fc03fa8caa57bfa65b8bbebb7472a"
      resource "notices" do
        url "https://github.com/JAIPilot/jaipilot/releases/download/v1.2.0/jaipilot-notices-x86_64-apple-darwin.zip"
        sha256 "522cfefbe377abff9500a19a44b1a048f6b720b2a359cc8081f645970ab58dc2"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JAIPilot/jaipilot/releases/download/v1.2.0/jaipilot-aarch64-unknown-linux-gnu.gz", using: :nounzip
      sha256 "004da3b05f15c7c952af47e250d52580319f8a7e6966a426bc4c1651997155bc"
      resource "notices" do
        url "https://github.com/JAIPilot/jaipilot/releases/download/v1.2.0/jaipilot-notices-aarch64-unknown-linux-gnu.zip"
        sha256 "3c79e3282076943d91220f19a64e8dc959b3845942705c4cd88641691c715309"
      end
    else
      url "https://github.com/JAIPilot/jaipilot/releases/download/v1.2.0/jaipilot-x86_64-unknown-linux-gnu.gz", using: :nounzip
      sha256 "b0d3f72c25af5c4270717fd8202609ea3dfb90c52b6acc2b201838771f282532"
      resource "notices" do
        url "https://github.com/JAIPilot/jaipilot/releases/download/v1.2.0/jaipilot-notices-x86_64-unknown-linux-gnu.zip"
        sha256 "e21785d348ee897424aece766592093dfa607e129d9976d9a06f509ff4701147"
      end
    end
  end

  def install
    archive = Dir["jaipilot-*.gz"].first
    system "gzip", "-d", archive
    binary = archive.delete_suffix(".gz")
    chmod 0755, binary
    bin.install binary => "jaipilot"
    resource("notices").stage do
      (share/"jaipilot").install "LICENSE", "THIRD_PARTY_NOTICES.md", "licenses"
    end
  end

  test do
    assert_equal "JAIPilot CLI 1.2.0", shell_output("#{bin}/jaipilot --version").strip
    assert_match "jaipilot run", shell_output("#{bin}/jaipilot --help")
  end
end
