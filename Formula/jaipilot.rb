class Jaipilot < Formula
  desc "Java testing workflows with a local CLI and MCP server"
  homepage "https://www.jaipilot.com"
  version "1.1.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JAIPilot/jaipilot/releases/download/v1.1.1/jaipilot-aarch64-apple-darwin", using: :nounzip
      sha256 "65eca91962a46df149608489eb9ae8142e4e79ad92320c1973d18931d8309872"
      resource "notices" do
        url "https://github.com/JAIPilot/jaipilot/releases/download/v1.1.1/jaipilot-notices-aarch64-apple-darwin.zip"
        sha256 "133f7477bab9cea57b5e4e5d9545192eb36866f92b0c0d8f397109aa98aa2817"
      end
    else
      url "https://github.com/JAIPilot/jaipilot/releases/download/v1.1.1/jaipilot-x86_64-apple-darwin", using: :nounzip
      sha256 "db6e8dec886e4f370f3ceaab36dd0a337ad44fe6c943b06d243c3c16dd6c6ee1"
      resource "notices" do
        url "https://github.com/JAIPilot/jaipilot/releases/download/v1.1.1/jaipilot-notices-x86_64-apple-darwin.zip"
        sha256 "2e835da31145eab0582bedc361a3d77053b11ed5de04ea63c84983b13f0ebd28"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JAIPilot/jaipilot/releases/download/v1.1.1/jaipilot-aarch64-unknown-linux-gnu", using: :nounzip
      sha256 "5a48ef912b9d18162dbfd03938ec31c8062dd532eac35d8822e64dda093f836b"
      resource "notices" do
        url "https://github.com/JAIPilot/jaipilot/releases/download/v1.1.1/jaipilot-notices-aarch64-unknown-linux-gnu.zip"
        sha256 "9e99bb7c7f8f747fbceb9431705bd1f4e4d801a3d226f42d59fefcdd10862a50"
      end
    else
      url "https://github.com/JAIPilot/jaipilot/releases/download/v1.1.1/jaipilot-x86_64-unknown-linux-gnu", using: :nounzip
      sha256 "60517b6faa031ecdfbfbdfae4b6f3f9e7a7dd56fc5aa5dc073ecb0b814e51d81"
      resource "notices" do
        url "https://github.com/JAIPilot/jaipilot/releases/download/v1.1.1/jaipilot-notices-x86_64-unknown-linux-gnu.zip"
        sha256 "265bdabacbfe36307a0fa694ab84aa8802d4033e1ce63d1a306354e1750a8a05"
      end
    end
  end

  def install
    binary = Dir["jaipilot-*"].first
    chmod 0755, binary
    bin.install binary => "jaipilot"
    resource("notices").stage do
      (share/"jaipilot").install "LICENSE", "THIRD_PARTY_NOTICES.md", "licenses"
    end
  end

  test do
    assert_equal "JAIPilot CLI 1.1.1", shell_output("#{bin}/jaipilot --version").strip
    assert_match "jaipilot run", shell_output("#{bin}/jaipilot --help")
  end
end
