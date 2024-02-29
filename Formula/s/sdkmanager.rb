class Sdkmanager < Formula
  desc "Drop-in replacement for sdkmanager from the Android SDK written in Python"
  homepage "https://salsa.debian.org/python-team/packages/sdkmanager"
  url "https://salsa.debian.org/python-team/packages/sdkmanager/-/archive/debian/0.6.6-1/sdkmanager-debian-0.6.6-1.tar.gz"
  sha256 "92ac764d3e89d2ee8b0bb93266551e8f2baaab2f72f5b3185c12b3c2067399f7"
  license "AGPL-3.0-only"
  head "https://salsa.debian.org/python-team/packages/sdkmanager.git", branch: "master"

  depends_on "python-setuptools" => :build
  depends_on "python@3.12"

  conflicts_with cask: "android-sdk", because: "both include an sdkmanager"
  conflicts_with cask: "android-commandlinetools", because: "both include an sdkmanager"

  def python3
    "python3.12"
  end

  def install
    system python3, "-m", "pip", "install", *std_pip_args, "."
  end

  test do
    output = pipe_output(bin/"sdkmanager", "--list")
    assert_match "platform-tools", output
    assert_match "ndk-bundle", output
  end
end
