# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

PYTHON_COMPAT=( python2_7 )
inherit eutils autotools-utils python-r1

DESCRIPTION="Compizconfig Python Bindings"
HOMEPAGE="http://www.compiz.org/"
SRC_URI="https://github.com/compiz-reloaded/${PN}/releases/download/v${PV}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
RESTRICT="mirror"

RDEPEND="${PYTHON_DEPS}
	>=dev-libs/glib-2.6
	>=x11-libs/libcompizconfig-${PV}"

DEPEND="${RDEPEND}
	dev-python/pyrex[${PYTHON_USEDEP}]
	virtual/pkgconfig"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_configure() {
	local myeconfargs=(
		--enable-fast-install
		--disable-static
	)
	python_foreach_impl autotools-utils_src_configure
}

src_compile() {
	python_foreach_impl autotools-utils_src_compile
}

src_install() {
	python_foreach_impl autotools-utils_src_install
	prune_libtool_files --modules
}
