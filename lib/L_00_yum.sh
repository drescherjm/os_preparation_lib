#-----------------------------------------------------------------------------------------
# Before everything clean all yum / dnf cache
#-----------------------------------------------------------------------------------------
OS_RELEASE_VER="$(cat /etc/centos-release |grep 'release 8')"

if [[ -n "${OS_RELEASE_VER}" ]]; then
  dnf clean all >/dev/null 2>/dev/null
else
  yum clean all >/dev/null 2>/dev/null
fi
