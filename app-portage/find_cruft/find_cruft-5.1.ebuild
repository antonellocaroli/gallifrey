# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

RESTRICT="mirror"

DESCRIPTION="find cruft files not managed by portage"
HOMEPAGE="https://github.com/vaeth/find_cruft/"
SRC_URI="https://github.com/vaeth/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-lang/perl-5.8"
#	|| ( >=dev-lang/perl-5.9.4 >=virtual/perl-File-Spec-3.0 )
#	|| ( >=dev-lang/perl-5.6.1 >=virtual/perl-Getopt-Long-2.24 )

src_prepare() {
	default
	use prefix || sed -i \
		-e '1s"^#!/usr/bin/env perl$"#!'"${EPREFIX}/usr/bin/perl"'"' \
		-- bin/* || die
}

src_install() {
	dobin bin/*
	dodoc README.md
	insinto /etc
	doins -r etc/*
	insinto /usr/share/zsh/site-functions
	doins zsh/_*
}

pkg_postinst() {
	optfeature "faster execution" 'app-portage/eix'
}
