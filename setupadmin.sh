mv /etc/apt/sources.list /etc/apt/sources.list.old

cat > /etc/apt/sources.list << EOF
deb mirror://mirrors.ubuntu.com/mirrors.txt xenial main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt xenial-updates main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt xenial-backports main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt xenial-security main restricted universe multiverse
EOF

apt update

# Disable ipv6
sed -i "\$anet.ipv6.conf.all.disable_ipv6 = 1" /etc/sysctl.conf
sed -i "\$anet.ipv6.conf.default.disable_ipv6 = 1" /etc/sysctl.conf
sed -i "\$anet.ipv6.conf.lo.disable_ipv6 = 1" /etc/sysctl.conf
sysctl -p

# Install basic packages
apt -f -y install ssh rsync wget xmlstarlet openjdk-8-jdk

# # Disable SELinux
# apt -f -y install policycoreutils
#
# if [[ $(sestatus | awk '{ print $3 }') != "disabled" ]]
# then
#   sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/configecho
# fi
