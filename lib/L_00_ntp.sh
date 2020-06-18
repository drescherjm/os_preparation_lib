L_NTP_DATETIME() {
  #-----------------------------------------------------------------------------------------
  # NTP update date time and hwclock to prevent mariadb cause systemd warning
  #-----------------------------------------------------------------------------------------
  echo "---------------------------------------------------"
  echo "NTP(chrony) ---> pool.ntp.org"
  echo "---------------------------------------------------"
  rpm --quiet -q chrony || $REPO_EXEC_CMD install -y chrony
  # make sure chronyd stop first , before syncing time using chronyd command!
  systemctl stop chronyd
  systemctl disable chronyd

  echo "RUN: chronyd -q 'pool pool.ntp.org iburst'"
  chronyd -q 'pool pool.ntp.org iburst'

  echo "RUN: hwclock -w"
  hwclock -w

  echo "---------------------------------------------------"
  echo ""

}
