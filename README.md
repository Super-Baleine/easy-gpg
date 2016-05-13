# easy-gpg
A script to facilitate the utilization of GnuPG

### RUN THE SCRIPT
To run it, you can do :
bash global.sh
or :
chmod +x;./global.sh

### Encryption
To encrypt a file you can do :
``` Shell
gpg -r email(or name) -e -a file
```
### Decryption
To decrypt a file :
gpg --decrypt file
