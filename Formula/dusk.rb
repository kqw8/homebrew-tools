class Dusk < Formula
  desc "Dim the built-in display when an external display is connected"
  homepage "https://github.com/kqw8/Dusk"
  url "https://github.com/kqw8/Dusk/archive/f91c413864fb417b2fdf4fb8ad41ced52be3d2c1.tar.gz"
  version "0.3.0"
  sha256 "97e37456a8275a12b8109ab261fbf66c70cb63acb962ff07fcf80f36122bbbfe"
  license "MIT"

  depends_on macos: :ventura

  def install
    system "swift", "build", "--configuration", "release", "--disable-sandbox"
    bin.install ".build/release/dusk"
  end

  service do
    run [opt_bin/"dusk", "--daemon"]
    keep_alive true
    log_path var/"log/dusk.log"
    error_log_path var/"log/dusk.err.log"
  end

  def caveats
    <<~EOS
      Use `brew services start kqw8/tools/dusk` to enable the background service.
      Use `brew services stop kqw8/tools/dusk` before uninstalling it.
      Do not combine Homebrew services with `dusk install` or `dusk start`.
    EOS
  end

  test do
    assert_equal "dusk #{version}", shell_output("#{bin}/dusk --version").strip
  end
end
