sudo add-apt-repository -y ppa:pipelight/daily
sudo apt-get -qy update
sudo apt-get install -y wine-staging winbind

#wget http://www.orbitals.com/programs/py.exe
wget https://www.python.org/ftp/python/2.7.9/python-2.7.9.msi
/opt/wine-staging/bin/wine msiexec /i python-2.7.9.msi

sed -i 's/_windows_cert_stores = .*/_windows_cert_stores = ("ROOT",)/' "$HOME/.wine/drive_c/Python27/Lib/ssl.py"

wget http://download.microsoft.com/download/7/9/6/796EF2E4-801B-4FC4-AB28-B59FBF6D907B/VCForPython27.msi
/opt/wine-staging/bin/wine msiexec /i VCForPython27.msi

wget https://bootstrap.pypa.io/ez_setup.py -O - | /opt/wine-staging/bin/wine 'C:\Python27\Python.exe'
/opt/wine-staging/bin/wine 'C:\Python27\Scripts\easy_install.exe' pip

