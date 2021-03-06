# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Display and control your Android device"
HOMEPAGE="https://github.com/Genymobile/scrcpy"
SRC_URI="https://github.com/Genymobile/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://tmp.rom1v.com/scrcpy/issue921/2/${PN}-server.jar -> ${PN}-server-${PV}.jar"
# Cause bug can't get server from default link, see https://github.com/Genymobile/scrcpy/issues/921#issuecomment-552100939
#	https://github.com/Genymobile/${PN}/releases/download/v${PV}/${PN}-server-v${PV} -> ${PN}-server-${PV}.jar"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	media-libs/libsdl2
	media-video/ffmpeg
"
RDEPEND="${DEPEND}"

src_configure() {
	local emesonargs=(
		-D prebuilt_server=/usr/share/${PN}/${PN}-server.jar
	)

	meson_src_configure
}

src_install() {
	meson_src_install

	insinto /usr/share/${PN}
	newins "${DISTDIR}"/${PN}-server-${PV}.jar ${PN}-server.jar
}
