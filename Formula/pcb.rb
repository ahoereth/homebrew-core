class Pcb < Formula
  desc "Interactive printed circuit board editor"
  homepage "http://pcb.geda-project.org/"
  url "https://downloads.sourceforge.net/project/pcb/pcb/pcb-4.2.1/pcb-4.2.1.tar.gz"
  sha256 "981532c0a1efd09e3ab6aa690992a4338d0970736ad709c51397bf0d24db3fc5"
  version_scheme 1

  bottle do
    sha256 "d43af459fe1d262e950a073894903ffb599531f710424c753b3c2779cbdb7771" => :catalina
    sha256 "3f910571af474058db83eac46cc6672a8492b1c5b594594752d2cf3c077a6e33" => :mojave
    sha256 "c2014db727633acb06b633247d3e9e809a76cb9a88daa7deb9b7bc1609670f39" => :high_sierra
    sha256 "0a71157a119d5206fb3b908fd8c25a4072b0e832aa466f13cbd04d998af39817" => :sierra
  end

  head do
    url "git://git.geda-project.org/pcb.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  depends_on "intltool" => :build
  depends_on "pkg-config" => :build
  depends_on "dbus"
  depends_on "gd"
  depends_on "gettext"
  depends_on "glib"
  depends_on "gtk+"
  depends_on "gtkglext"

  conflicts_with "gts", :because => "both install a `gts.h` header"

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--prefix=#{prefix}",
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-update-desktop-database",
                          "--disable-update-mime-database",
                          "--disable-gl",
                          "--without-x"
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pcb --version")
  end
end
