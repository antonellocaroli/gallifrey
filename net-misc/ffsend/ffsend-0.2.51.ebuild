# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# get CRATES cmd line: grep checksum Cargo.lock | awk -F' ' '{print $2"-"$3}'
# get licenses cmd find -name 'Cargo.toml' -exec grep -h license {} + | sort -u
CRATES="
adler32-1.0.3
aho-corasick-0.7.6
ansi_term-0.11.0
approx-0.1.1
arrayref-0.3.5
arrayvec-0.4.11
atty-0.2.13
autocfg-0.1.6
backtrace-0.3.35
backtrace-sys-0.1.31
base64-0.10.1
base64-0.9.3
bitflags-1.1.0
blake2b_simd-0.5.7
block-0.1.6
block-buffer-0.7.3
block-padding-0.1.4
bstr-0.2.7
byte-tools-0.3.1
byteorder-1.3.2
bytes-0.4.12
c2-chacha-0.2.2
cc-1.0.41
cfg-if-0.1.9
cgmath-0.16.1
chbs-0.0.8
checked_int_cast-1.0.0
chrono-0.4.7
clap-2.33.0
clipboard-0.5.0
clipboard-win-2.2.0
cloudabi-0.0.3
colored-1.8.0
constant_time_eq-0.1.4
cookie-0.12.0
cookie_store-0.7.0
core-foundation-0.6.4
core-foundation-sys-0.6.2
crc32fast-1.2.0
crossbeam-deque-0.7.1
crossbeam-epoch-0.7.2
crossbeam-queue-0.1.2
crossbeam-utils-0.6.6
crossterm-0.10.2
crossterm_style-0.4.1
crossterm_utils-0.2.4
crossterm_winapi-0.1.5
crypto-mac-0.7.0
csv-1.1.1
csv-core-0.1.6
darling-0.6.3
darling-0.9.0
darling_core-0.6.3
darling_core-0.9.0
darling_macro-0.6.3
darling_macro-0.9.0
derive_builder-0.6.0
derive_builder-0.7.2
derive_builder_core-0.3.0
derive_builder_core-0.5.0
digest-0.8.1
directories-2.0.2
dirs-1.0.5
dirs-sys-0.3.4
dtoa-0.4.4
either-1.5.2
encode_unicode-0.3.6
encoding_rs-0.8.17
error-chain-0.12.1
failure-0.1.5
failure_derive-0.1.5
fake-simd-0.1.2
ffsend-api-0.3.2
filetime-0.2.7
flate2-1.0.11
fnv-1.0.6
foreign-types-0.3.2
foreign-types-shared-0.1.1
fs2-0.4.3
fuchsia-cprng-0.1.1
fuchsia-zircon-0.3.3
fuchsia-zircon-sys-0.3.3
futures-0.1.28
futures-cpupool-0.1.8
generic-array-0.12.3
getrandom-0.1.11
h2-0.1.26
hkdf-0.7.1
hmac-0.7.1
http-0.1.18
http-body-0.1.0
httparse-1.3.4
hyper-0.10.16
hyper-0.12.33
hyper-tls-0.3.2
ident_case-1.0.1
idna-0.1.5
idna-0.2.0
indexmap-1.1.0
iovec-0.1.2
itoa-0.4.4
kernel32-sys-0.2.2
language-tags-0.2.2
lazy_static-1.4.0
libc-0.2.62
lock_api-0.1.5
log-0.3.9
log-0.4.8
malloc_buf-0.0.6
matches-0.1.8
memchr-2.2.1
memoffset-0.5.1
mime-0.2.6
mime-0.3.13
mime_guess-2.0.1
miniz_oxide-0.3.2
mio-0.6.19
miow-0.2.1
native-tls-0.2.3
net2-0.2.33
nodrop-0.1.13
num-integer-0.1.41
num-traits-0.1.43
num-traits-0.2.8
num_cpus-1.10.1
numtoa-0.1.0
objc-0.2.6
objc-foundation-0.1.1
objc_id-0.1.1
opaque-debug-0.2.3
open-1.3.2
openssl-0.10.24
openssl-probe-0.1.2
openssl-sys-0.9.49
owning_ref-0.4.0
parking_lot-0.7.1
parking_lot_core-0.4.0
pathdiff-0.1.0
pbr-1.0.1
percent-encoding-1.0.1
percent-encoding-2.1.0
pkg-config-0.3.15
ppv-lite86-0.2.5
prettytable-rs-0.8.0
proc-macro2-0.3.8
proc-macro2-0.4.30
proc-macro2-1.0.1
publicsuffix-1.5.3
qr2term-0.1.4
qrcode-0.11.0
quote-0.5.2
quote-0.6.13
quote-1.0.2
rand-0.4.6
rand-0.5.6
rand-0.6.5
rand-0.7.0
rand_chacha-0.1.1
rand_chacha-0.2.1
rand_core-0.3.1
rand_core-0.4.2
rand_core-0.5.1
rand_hc-0.1.0
rand_hc-0.2.0
rand_isaac-0.1.1
rand_jitter-0.1.4
rand_os-0.1.3
rand_pcg-0.1.2
rand_xorshift-0.1.1
rdrand-0.4.0
redox_syscall-0.1.56
redox_termios-0.1.1
redox_users-0.3.1
regex-1.2.1
regex-automata-0.1.8
regex-syntax-0.6.11
remove_dir_all-0.5.2
reqwest-0.9.20
rgb-0.8.14
rpassword-4.0.1
rust-argon2-0.5.1
rustc-demangle-0.1.16
rustc_version-0.2.3
ryu-1.0.0
safemem-0.3.2
schannel-0.1.15
scopeguard-0.3.3
scopeguard-1.0.0
security-framework-0.3.1
security-framework-sys-0.3.1
semver-0.9.0
semver-parser-0.7.0
serde-1.0.99
serde_derive-1.0.99
serde_json-1.0.40
serde_urlencoded-0.5.5
sha1-0.6.0
sha2-0.8.0
slab-0.4.2
smallvec-0.6.10
stable_deref_trait-1.1.1
string-0.2.1
strsim-0.7.0
strsim-0.8.0
subtle-1.0.0
syn-0.13.11
syn-0.15.44
syn-1.0.5
synstructure-0.10.2
tar-0.4.26
tempfile-3.1.0
term-0.5.2
termion-1.5.3
textwrap-0.11.0
thread_local-0.3.6
time-0.1.42
tokio-0.1.22
tokio-buf-0.1.1
tokio-codec-0.1.1
tokio-current-thread-0.1.6
tokio-executor-0.1.8
tokio-io-0.1.12
tokio-reactor-0.1.9
tokio-sync-0.1.6
tokio-tcp-0.1.3
tokio-threadpool-0.1.15
tokio-timer-0.2.11
tokio-tls-0.2.1
toml-0.5.3
traitobject-0.1.0
try-lock-0.2.2
try_from-0.3.2
typeable-0.1.2
typenum-1.11.2
unicase-1.4.2
unicase-2.4.0
unicode-bidi-0.3.4
unicode-normalization-0.1.8
unicode-width-0.1.6
unicode-xid-0.1.0
unicode-xid-0.2.0
url-1.7.2
url-2.1.0
url_serde-0.2.0
urlshortener-2.0.0
uuid-0.7.4
vcpkg-0.2.7
vec_map-0.8.1
version-compare-0.0.6
version-compare-0.0.9
version_check-0.1.5
want-0.2.0
wasi-0.5.0
websocket-0.22.4
which-2.0.1
winapi-0.2.8
winapi-0.3.8
winapi-build-0.1.1
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
winconsole-0.10.0
winreg-0.6.2
ws2_32-sys-0.2.1
x11-clipboard-0.3.3
xattr-0.2.2
xcb-0.8.2
"

inherit bash-completion-r1 cargo

DESCRIPTION="Easily and securely share files from CLI through firefox Send client"
HOMEPAGE="https://github.com/timvisee/ffsend"
SRC_URI="https://github.com/timvisee/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})"

LICENSE="Apache-2.0
	|| ( Apache-2.0 MIT )
	|| ( Apache-2.0 Boost-1.0 )
	Apache-2.0-with-LLVM-exceptions
	BSD-2
	BSD
	ZLIB
	CC0-1.0
	GPL-3
	MIT
	MPL-2.0
	|| ( Unlicense MIT )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libressl"

DEPEND=""
RDEPEND=""
BDEPEND="
	>=virtual/rust-1.32.0
	libressl? ( dev-libs/libressl )
	!libressl? ( dev-libs/openssl )
"

src_install() {
	cargo_src_install --path .

	newbashcomp "contrib/completions/ffsend.bash" ffsend
	if has_version "app-shells/zsh" ; then
		insinto /usr/share/zsh/site-functions
		doins "contrib/completions/_ffsend"
	fi

	einstalldocs
}
