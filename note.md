## Install patch

patch -p1 < patch-name.diff

## If crach

1. launch virtual term (ctrl win f2)
2. sudo systemctl restart display-manager (never tested) or sudo service sddm restart
3. check var/sys/syslog and /var/log/Xorg.0.log
