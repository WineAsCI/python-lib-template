#!/bin/bash
sudo add-apt-repository -y ppa:pipelight/daily
sudo apt-get -qy update
sudo apt-get install -y wine-staging winbind

case "$WINEENV" in
    py26)
        VERSION=2.6.6
        INSTALLER_URL="https://www.python.org/ftp/python/$VERSION/python-$VERSION.msi"
        INSTALL_COMMAND="wine msiexec /i python-$VERSION.msi"
        EXECDIR="$HOME/.wine/drive_c/Python26"
        ;;
    py27)
        VERSION=2.7.9
        INSTALLER_URL="https://www.python.org/ftp/python/$VERSION/python-$VERSION.msi"
        INSTALL_COMMAND="wine msiexec /i python-$VERSION.msi"
        EXECDIR="$HOME/.wine/drive_c/Python27"
        MORE_COMMANDS='wget http://download.microsoft.com/download/7/9/6/796EF2E4-801B-4FC4-AB28-B59FBF6D907B/VCForPython27.msi; wine msiexec /i VCForPython27.msi'
        ;;
    py33)
        VERSION=3.3.5
        INSTALLER_URL="https://www.python.org/ftp/python/$VERSION/python-$VERSION.msi"
        INSTALL_COMMAND="wine msiexec /i python-$VERSION.msi"
        EXECDIR="$HOME/.wine/drive_c/Python33"
        ;;
    py34)
        VERSION=3.4.2
        INSTALLER_URL="https://www.python.org/ftp/python/$VERSION/python-$VERSION.msi"
        INSTALL_COMMAND="wine msiexec /i python-$VERSION.msi"
        EXECDIR="$HOME/.wine/drive_c/Python34"
        ;;
    pypy)
        VERSION=2.5.0
        INSTALLER_URL="https://bitbucket.org/pypy/pypy/downloads/pypy-$VERSION-win32.zip"
        INSTALL_COMMAND="unzip pypy-$VERSION-win32.zip"
        EXECDIR="$PWD/pypy-$VERSION-win32"
        PYTHON="$EXECDIR/pypy.exe"
        ;;
    *)
        echo "WINEENV $WINEENV not supported."
        exit 1
esac

[[ -z "$PYTHON" ]] && PYTHON="$EXECDIR/python.exe"
[[ -z "$PIP" ]] && PIP="$EXECDIR/Scripts/pip.exe"

export PATH="/opt/wine-staging/bin:$PATH"

#wget http://www.orbitals.com/programs/py.exe
wget $INSTALLER_URL
WINEARCH=win32 wineboot
$INSTALL_COMMAND

sed -i 's/_windows_cert_stores = .*/_windows_cert_stores = ("ROOT",)/' "$EXECDIR/Lib/ssl.py"

$MORE_COMMANDS

echo "/opt/wine-staging/bin/wine $PYTHON" '$@' > _python
echo "/opt/wine-staging/bin/wine $PIP" '$@' > _pip
chmod +x _python _pip

wget https://bootstrap.pypa.io/ez_setup.py -O - | ./_python
wine "$EXECDIR/Scripts/easy_install.exe" pip
