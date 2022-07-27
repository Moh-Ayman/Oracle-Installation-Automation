su -
grep MemTotal /proc/meminfo


array=( "binutils" "compat-libcap1" "compat-libstdc++-33.i686" "compat-libstdc++-33.x86_64" "gcc" "gcc-c++" "glibc*" "glibc-devel.i686" "glibc-static.i686" "libaio*" "libgcc*" "libstdc++-*" "libXi.*" "libXtst.i686" "libXtst.x86_64"  "make" "sysstat" "elfutils-libelf-devel.i686" "elfutils-libelf-devel-static.i686" "elfutils-libelf-devel.x86_64" "elfutils-libelf-devel-static.x86_64" "kernel-headers" "glibc-headers" "glibc-devel" "libstdc++-devel" "libgomp.i686" "libaio-devel" "unixODBC*" "unixODBC-devel*" )
#download and install pdksh 
groupadd oinstall
groupadd dba
useradd -g oinstall -G dba -s /bin/bash -d /home/oracle oracle
passwd oracle

cat /etc/hosts
echo "`ip -4 addr show ens2f1 | sed -nr 's|.*inet ([^ ]+)/.*|\1|p'`       `hostname`" >> /etc/hosts
cat /etc/hosts


mkdir -p /opt/u01/app/oracle
chown -R oracle:oinstall /opt/u01/app/oracle
chmod -R 775 /opt/u01/app/oracle


mkdir -p /u01/app/oracle
mkdir -p /u01/app/oraInventory
chown -R oracle:oinstall /u01/app/
chmod -R 775 /u01/app/
# mkdir -p /mount_point/app/
# chown -R oracle:oinstall /mount_point/app/
# chmod -R 775 /mount_point/app/


umask 

export DISPLAY=local_host:0.0
xhost + fully_qualified_remote_host_name
df -h /tmp
su - oracle
ORACLE_BASE=/u01/app/oracle
ORACLE_SID=sales
export ORACLE_BASE ORACLE_SID


unset ORACLE_HOME
unset TNS_ADMIN


cp /etc/sysctl.conf /etc/sysctl.conf.bkp
shmall=`cat /proc/sys/kernel/shmall`
echo "kernel.shmall = $((shmall*40/100))" >> /etc/sysctl.conf
shammax=`cat /proc/sys/kernel/shmmax`
echo "kernel.shmmax = $((shmmax/2))" >> /etc/sysctl.conf
shemmni=`cat /proc/sys/kernel/shmmni`
echo "kernel.shmmni = $shemmni" >> /etc/sysctl.conf
sem=`cat /proc/sys/kernel/sem`
echo "kernel.sem = $sem" >> /etc/sysctl.conf
filemax=`cat /proc/sys/fs/file-max`
echo "fs.file-max = $filemax" >> /etc/sysctl.conf
aiomaxnr=`cat /proc/sys/fs/aio-max-nr`
echo "fs.aio-max-nr = $aiomaxnr" >> /etc/sysctl.conf
net=`cat /proc/sys/net/ipv4/ip_local_port_range`
echo "net.ipv4.ip_local_port_range = $net" >> /etc/sysctl.conf
rmemdefault=`cat /proc/sys/net/core/rmem_default`
echo "net.core.rmem_default = $rmemdefault" >> /etc/sysctl.conf
rmemmax=`cat /proc/sys/net/core/rmem_max`
echo "net.core.rmem_max = $rmemmax" >> /etc/sysctl.conf
wmemdefault=`cat /proc/sys/net/core/wmem_default`
echo "net.core.wmem_default = $wmemdefault" >> /etc/sysctl.conf
wmemmax=`cat /proc/sys/net/core/wmem_max`
echo "net.core.wmem_max = $wmemmax" >> /etc/sysctl.conf
sysctl -p

cp /etc/security/limits.conf /etc/security/limits.conf.bkp
echo "oracle soft nproc 2047" >> /etc/security/limits.conf
echo "oracle hard nproc 16384" >> /etc/security/limits.conf
echo "oracle soft nofile 1024" >> /etc/security/limits.conf
echo "oracle hard nofile 65536" >> /etc/security/limits.conf

cp /etc/pam.d/login /etc/pam.d/login.bkp
echo "session required pam_limits.so" >> /etc/pam.d/login
cp /etc/profile /etc/profile.bkp
 echo "if [ \$USER = \"oracle\" ]; then" >> /etc/profile
echo "       if [ \$SHELL = \"/bin/ksh\" ]; then" >> /etc/profile
echo "           ulimit -u 16384" >> /etc/profile
echo "           ulimit -n 65536" >> /etc/profile
echo "       else" >> /etc/profile
echo "           ulimit -u 16384 -n 65536" >> /etc/profile
echo "       fi" >> /etc/profile
echo "fi" >> /etc/profile


in $ORACLE_HOME/sysman/lib/ins_emagent.mk
Search for the line: $(MK_EMAGENT_NMECTL)
Change it to: $(MK_EMAGENT_NMECTL) -lnnz11

cp .bash_profile .bash_profile.old
echo "export ORACLE_HOME=/u01/app/oracle/product/11.2.0/dbhome_1" >> .bash_profile
echo "export ORACLE_SID=orcl" >> .bash_profile
echo "export PATH=\$PATH:\$ORACLE_HOME/bin" >> .bash_profile

export DISPLAY=192.168.65.1:0.0
xhost + 192.168.65.1

cp /etc/sysctl.conf /etc/sysctl.conf.bkp
echo "kernel.shmall = 268435456" >> /etc/sysctl.conf
echo "kernel.shmmax = 4294967295" >> /etc/sysctl.conf
echo "kernel.shmmni = 4096" >> /etc/sysctl.conf
echo "kernel.sem = 250 32000 100 128" >> /etc/sysctl.conf
echo "fs.file-max = 6815744" >> /etc/sysctl.conf
echo "fs.aio-max-nr = 1048576" >> /etc/sysctl.conf
echo "net.ipv4.ip_local_port_range = 9000 65500" >> /etc/sysctl.conf
echo "net.core.rmem_default = 262144" >> /etc/sysctl.conf
echo "net.core.rmem_max = 4194304" >> /etc/sysctl.conf
echo "net.core.wmem_default = 262144" >> /etc/sysctl.conf
echo "net.core.wmem_max = 1048576" >> /etc/sysctl.conf
sysctl -p
