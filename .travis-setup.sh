sudo add-apt-repository -y ppa:pipelight/daily
sudo apt-get -qy update
sudo apt-get install -y wine-staging winbind

#wget http://www.orbitals.com/programs/py.exe
wget https://www.python.org/ftp/python/2.7.9/python-2.7.9.msi
/opt/wine-staging/bin/wine msiexec /i python-2.7.9.msi

wget https://bootstrap.pypa.io/ez_setup.py
sed -i -e "37iimport ssl" -e '37issl.SSLContext._windows_cert_stores = ("ROOT",)' ez_setup.py
/opt/wine-staging/bin/wine 'C:\Python27\Python.exe' ez_setup.py
/opt/wine-staging/bin/wine 'C:\Python27\Scripts\easy_install.exe' pip
