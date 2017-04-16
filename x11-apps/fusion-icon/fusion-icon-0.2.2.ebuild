# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 eutils gnome2-utils

DESCRIPTION="Compiz Fusion Tray Icon and Manager"
HOMEPAGE="http://compiz.org"
SRC_URI="https://github.com/compiz-reloaded/${PN}/releases/download/v${PV}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+gtk qt4"
RESTRICT="mirror"

REQUIRED_USE="|| ( gtk qt4 )"

RDEPEND="
	>=dev-python/compizconfig-python-0.8.12
	>=x11-wm/compiz-0.8.12
	x11-apps/xvinfo
	gtk? ( >=dev-python/pygtk-2.10:2[${PYTHON_USEDEP}] )
	qt4? ( dev-python/PyQt4[X,${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}"/${P}-qt4-interface-subprocess-call.patch )

python_install() {
	distutils-r1_python_install
	use gtk || rm -r "${D}$(python_get_sitedir)/FusionIcon/interface_gtk" || die
	use qt4 || rm -r "${D}$(python_get_sitedir)/FusionIcon/interface_qt4" || die
}

pkg_postinst() {
	use gtk && gnome2_icon_cache_update
}

pkg_postrm() {
	use gtk && gnome2_icon_cache_update
}
