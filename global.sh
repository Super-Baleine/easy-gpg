#!/usr/bin/env bash
#---------- CHECK THE RELEASE ----------
if [[ -e /etc/debian_version ]]; then
  operating_system="debian_like"
elif [[ -e /etc/centos-release ]]; then
  operating_system="centos"
else
	echo "Sorry, you distribution isn't supported yet.
	Exiting...";exit 0;
fi
#---------- GENERAL ----------
echo "Welcome !";
echo "What do you want to do ?";echo " ";
echo "1) Install GnuPG
2) Gen a public and private key
3) Delete a public and private key
4) Import a public key
5) Export my pubic key
6) Delete a public key
7) Delete a private key
8) Unistall GnuPG
Tape 'exit' to quit !
Anything else will exit the script ! :)";
read -p "> " choice

if [[ $choice = "exit" ]]; then
  echo "Exiting...";
  exit 0;
fi
#---------- FUNCTIONS ----------
delete_keys(){
  gpg --delete-secret-and-public-keys $1
}
import_key(){
  gpg --import $1
}
delete_public_key(){
  gpg --delete-keys $1
}
delete_private_key(){
  gpg --delete-secret-keys $1
}
#---------- CHOICE ----------
case $choice in
  "1")
    if [[ "$EUID" -ne 0 ]]; then
      echo "Sorry, you need to be root to install GnuPG";
      exit 0;
    fi
    if [[ operating_system="debian_like" ]]; then
      echo " ";echo "Installation...";sleep 1s;
      apt-get install gpgv -y;
      sleep 1s;echo "Installation finished !";
    elif [[ operating_system="centos" ]]; then
      yum install gpgv -y || echo "report the bug at : illoxx.jyloxx@openmailbox.org please."
    else
      echo "You're not on Debian or a Debian like or a CentOS."
      echo "report the bug at : illoxx.jyloxx@openmailbox.org";
    fi
  ;;
  "2")
    gpg --gen-key;
    ;;
  "3")
    read -p "Give the name or the email of the pair : " func
    delete_keys $func
    ;;
  "4")
    echo "First, copy and paste the public key in the same path/folder than this script.";
    echo "we're in : ";pwd
    echo "Next, give the name of the file which contain the public key (For example : bob.gpg)";
    read -p "> " func
    import_key $func
    ;;
  "5")
    echo " ";echo Your public key is...
    gpg --export -a
    ;;
  "6")
    read -p "Please, not that you must delete the private key before.
    Give the name or email of the public key : " func
    delete_public_key $func
    ;;
  "7")
    read -p "Give the name or email of the private key : " func
    delete-secret-keys $func
  ;;
  "8")
    echo "GnuPG will be unistall... You have 5 seconds to cancel with CTRL+C...";sleep 5s;
    if [[ operating_system = "debian_like" ]]; then
      apt-get remove gpgv;
    elif [[ operating_system = "centos" ]]; then
      yum remove gpgv
    fi
    echo "Okay ! GnuPG have been unistalled.";
    ;;
  *)
    ./global.sh
    exit 0;
    ;;
esac
#---------- ~ ENDING ~ ----------
read -p "*
*
*
*
Do you want to run the script again ? " end
if [[ $end = "y" ]]; then
  ./global.sh;
  exit 0;
fi
exit 0;
