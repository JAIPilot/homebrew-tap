class Jaipilot < Formula
  desc "Java testing workflows with a local CLI and MCP server"
  homepage "https://www.jaipilot.com"
  version "1.2.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JAIPilot/jaipilot/releases/download/v1.2.1/jaipilot-aarch64-apple-darwin.gz", using: :nounzip
      sha256 "5a7b518ca7be464d0a14e8615fdd52769160cf2ef5d80d6439b01b48610f674d"
      resource "notices" do
        url "https://github.com/JAIPilot/jaipilot/releases/download/v1.2.1/jaipilot-notices-aarch64-apple-darwin.zip"
        sha256 "7b68501effee4ab7139188a1a7ca1c13edf4ab9dd21dd013417fb808103ecc07"
      end
    else
      url "https://github.com/JAIPilot/jaipilot/releases/download/v1.2.1/jaipilot-x86_64-apple-darwin.gz", using: :nounzip
      sha256 "83f303ea825437d79eda0128c24dd4241c53bcc175751ccb39588cecfa002ec9"
      resource "notices" do
        url "https://github.com/JAIPilot/jaipilot/releases/download/v1.2.1/jaipilot-notices-x86_64-apple-darwin.zip"
        sha256 "f20b1cdae51bd27d57c7ade9b5014938ebc718c4e2f3489e90ba2827b9cf9312"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JAIPilot/jaipilot/releases/download/v1.2.1/jaipilot-aarch64-unknown-linux-gnu.gz", using: :nounzip
      sha256 "ad68e7cd3660234346763bee8f83a779f0e1cd9eb882a687346a6460c5384502"
      resource "notices" do
        url "https://github.com/JAIPilot/jaipilot/releases/download/v1.2.1/jaipilot-notices-aarch64-unknown-linux-gnu.zip"
        sha256 "fb7b63ad59fb1cb07595355d389b6f10cc7fc884725e5050db27355ac062ab35"
      end
    else
      url "https://github.com/JAIPilot/jaipilot/releases/download/v1.2.1/jaipilot-x86_64-unknown-linux-gnu.gz", using: :nounzip
      sha256 "122c35278f04b44cc17e67de94375a0e4f81bb2867e934b57e48525887e67627"
      resource "notices" do
        url "https://github.com/JAIPilot/jaipilot/releases/download/v1.2.1/jaipilot-notices-x86_64-unknown-linux-gnu.zip"
        sha256 "be536e1be572145106460484fd6e3f8189c2e99e746fc992638198dbfc47f05b"
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
    assert_equal "JAIPilot CLI 1.2.1", shell_output("#{bin}/jaipilot --version").strip
    assert_match "jaipilot run", shell_output("#{bin}/jaipilot --help")
  end
end
