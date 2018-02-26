class Libbframe < FPM::Cookery::Recipe
  name     "narc"
  version  ENV["NARC_VERSION"][/([0-9.]+)-([0-9]+)/,1]
  revision ENV["NARC_VERSION"][/([0-9.]+)-([0-9]+)/,2]
  source   "https://github.com/nanopack/narc.git", with: "git", tag: "v${version}"
  # sha256   "bf27e7c0b9c8ac8f4533b86433cb89b0b8060e95e53d29e1fde7b9af34af1b96"

  description "Log relay tool"
  homepage    "https://github.com/nanopack/narc"
  maintainer  "Braxton Huggins <braxton@nanobox.io>"
  license     "MPL 2.0"
  # section     "development"

  build_depends %w(gcc git autoconf libuv1-dev libtool)
  depends %w(libuv1)
  # tmp_root= ::FPM::Cookery::Path.new("/tmp").realpath()
  # pkgdir= ::FPM::Cookery::Path.new("../pkg").realpath()
  # cachedir= ::FPM::Cookery::Path.new("../cache").realpath()

  def build
    safesystem "autoreconf -vfi"
    configure :prefix => prefix
    make
  end

  def install
    make :install, :DESTDIR => destdir
  end
end

