{ stdenv, fetchFromGitHub, pkgconfig, cmake, gtk2, wxGTK30, libpulseaudio, curl,
  gettext, glib, portaudio }:

stdenv.mkDerivation rec {
  name = "opencpn-${version}";
  version = "4.8.4";

  src = fetchFromGitHub {
    owner = "OpenCPN";
    repo = "OpenCPN";
    rev = "v${version}";
    sha256 = "0v4klprzddmpq7w8h2pm69sgbshirdmjrlzhz62b606gbr58fazf";
  };

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ cmake gtk2 wxGTK30 libpulseaudio curl gettext
                  glib portaudio ];

  cmakeFlags = [
    "-DGTK2_GDKCONFIG_INCLUDE_DIR=${gtk2.out}/lib/gtk-2.0/include"
    "-DGTK2_GLIBCONFIG_INCLUDE_DIR=${glib.out}/lib/glib-2.0/include"
  ];

  enableParallelBuilding = true;

  meta = {
    description = "A concise ChartPlotter/Navigator";
    maintainers = [ stdenv.lib.maintainers.kragniz ];
    platforms = stdenv.lib.platforms.all;
    license = stdenv.lib.licenses.gpl2;
    homepage = https://opencpn.org/;
  };
}
