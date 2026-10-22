class Inverso < Formula
  desc "Reverse physical mouse-wheel scrolling while preserving trackpad events"
  homepage "https://github.com/kqw8"
  url "file://#{Tap.fetch("kqw8/tools").path}/Binaries/inverso-0.4.0-arm64.tar.gz"
  version "0.4.0"
  sha256 "62399ed0f33938490fbdd3fa32ce73b102a16f0968cce89cf8f64ed2f45c4588"
  license "MIT"

  depends_on arch: :arm64
  depends_on macos: :ventura

  def install
    bin.install "inverso"
    pkgshare.install "BUILD-INFO.json"
  end

  service do
    name macos: "com.kqw8.inverso"
    run [opt_bin/"inverso", "--daemon"]
    keep_alive true
    process_type :interactive
    log_path "#{Dir.home}/Library/Logs/inverso.out.log"
    error_log_path "#{Dir.home}/Library/Logs/inverso.err.log"
  end

  def caveats
    <<~EOS
      Manage the background service with `brew services start/stop/restart kqw8/tools/inverso`.
      Do not combine Homebrew services with `inverso install/start/stop/uninstall`.
      `inverso status` remains available for service and event-tap health checks.
      This local package preserves the working 0.4.0 executable and its signature.
    EOS
  end

  test do
    assert_equal "inverso #{version}", shell_output("#{bin}/inverso --version").strip
  end
end
