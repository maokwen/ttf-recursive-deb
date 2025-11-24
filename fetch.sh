#!/bin/sh

pkgname=ttf-recursive
pkgver=1.085
maintainer="Mao Kwen <maokwen@live.com>"
arch=all
url="https://github.com/arrowtype/recursive"
desc="A variable type family built for better code & UI"
section="fonts"
priority="optional"
src="${url}/releases/download/v${pkgver}/ArrowType-Recursive-${pkgver}.zip"

dist=${pkgname}/usr/share/fonts/truetype/Recursive

curl -L -o src.zip ${src}
mkdir -p ${dist}
unzip -j -o src.zip -d tmp
mv -f tmp/*.ttf ${dist}/

mkdir -p ${pkgname}/DEBIAN
cat > ${pkgname}/DEBIAN/control <<EOF
Package: ${pkgname}
Version: ${pkgver}
Section: ${section}
Priority: ${priority}
Architecture: ${arch}
Maintainer: ${maintainer}
Description: ${desc}
EOF

cat > ${pkgname}/DEBIAN/postinst <<EOF
#!/bin/sh
fc-cache -rf ${dist}
EOF
chmod +x ${pkgname}/DEBIAN/postinst

echo ${pkgname}
dpkg-deb --root-owner-group --build ${pkgname} ${pkgname}_${pkgver}.deb

