# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

PYTHON_COMPAT=( python2_7 )
DISTUTILS_IN_SOURCE_BUILD=1
inherit distutils-r1 gnome2-utils

DESCRIPTION="Simplified Compizconfig Settings Manager"
HOMEPAGE="http://www.compiz.org/"
SRC_URI="https://github.com/compiz-reloaded/${PN}/releases/download/v${PV}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="gtk3"
RESTRICT="mirror"

DEPEND="
	dev-util/intltool
	virtual/pkgconfig"
RDEPEND="
	>=dev-python/compizconfig-python-0.8[${PYTHON_USEDEP}]
	<dev-python/compizconfig-python-0.9
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	>=x11-misc/ccsm-0.8[gtk3=,${PYTHON_USEDEP}]
	<x11-misc/ccsm-0.9
"

python_prepare_all() {
	# return error if wrong arguments passed to setup.py
	sed -i -e 's/raise SystemExit/\0(1)/' setup.py || die 'sed on setup.py failed'
	# fix desktop file
	sed -i \
		-e '/Categories/s/Compiz/X-\0/' \
		-e '/Encoding/d' \
		"${PN}".desktop.in || die "sed on ${PN}.desktop.in failed"

	distutils-r1_python_prepare_all
}

python_configure_all() {
	mydistutilsargs=( build --prefix=/usr )
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
