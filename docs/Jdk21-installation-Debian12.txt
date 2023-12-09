#### wget https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb
#### sudo dpkg -i jdk-21_linux-x64_bin.deb
#### java --version
#### sudo nano /etc/profile.d/jdk21.sh
#### export JAVA_HOME=/usr/lib/jvm/jdk-21.0.1
#### export PATH=$PATH:$JAVA_HOME/bin
#### Save file
#### source /etc/profile.d/jdk21.sh
#### java --version