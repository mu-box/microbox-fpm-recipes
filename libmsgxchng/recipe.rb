class Libmsgxchng < FPM::Cookery::Recipe
  name     "libmsgxchng"
  version  ENV["LIBMSGXCHNG_VERSION"][/([0-9.]+)-([0-9]+)/,1]
  revision ENV["LIBMSGXCHNG_VERSION"][/([0-9.]+)-([0-9]+)/,2]
  source   "https://github.com/nanobox-io/msgxchng-c.git", with: "git", branch: "master"
  # sha256   "bf27e7c0b9c8ac8f4533b86433cb89b0b8060e95e53d29e1fde7b9af34af1b96"

  description "Message Exchange library"
  homepage    "https://github.com/nanobox-io/msgxchng-c"
  maintainer  "Braxton Huggins <braxton@pagodabox.com>"
  license     "MPL 2.0"
  # section     "development"

  build_depends %w(gcc git libmsgpack-dev autoconf libtool)
  depends %w(libmsgpack3)

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

