#!/usr/bin/env bash

set -e

show_usage() {
  echo "Usage: $(basename $0) takes exactly 1 argument (install | uninstall)"
}

if [ $# -ne 1 ]
then
  show_usage
  exit 1
fi

check_env() {
  if [[ -z "${RALPM_TMP_DIR}" ]]; then
    echo "RALPM_TMP_DIR is not set"
    exit 1
  
  elif [[ -z "${RALPM_PKG_INSTALL_DIR}" ]]; then
    echo "RALPM_PKG_INSTALL_DIR is not set"
    exit 1
  
  elif [[ -z "${RALPM_PKG_BIN_DIR}" ]]; then
    echo "RALPM_PKG_BIN_DIR is not set"
    exit 1
  fi
}

install() {
  wget https://github.com/arduino/arduino-ide/releases/download/2.0.0-rc9.2/arduino-ide_2.0.0-rc9.2_Linux_64bit.AppImage -O $RALPM_TMP_DIR/arduino-ide_2.0.0-rc9.2_Linux_64bit.AppImage
  mv $RALPM_TMP_DIR/arduino-ide_2.0.0-rc9.2_Linux_64bit.AppImage $RALPM_PKG_INSTALL_DIR/arduino-ide_2.0.0-rc9.2_Linux_64bit.AppImage
  chmod +x $RALPM_PKG_INSTALL_DIR/arduino-ide_2.0.0-rc9.2_Linux_64bit.AppImage
  ln -s $RALPM_PKG_INSTALL_DIR/arduino-ide_2.0.0-rc9.2_Linux_64bit.AppImage $RALPM_PKG_BIN_DIR/arduino-ide
}

uninstall() {
  rm $RALPM_PKG_INSTALL_DIR/arduino-ide_2.0.0-rc9.2_Linux_64bit.AppImage
  rm $RALPM_PKG_BIN_DIR/arduino-ide
}

run() {
  if [[ "$1" == "install" ]]; then 
    install
  elif [[ "$1" == "uninstall" ]]; then 
    uninstall
  else
    show_usage
  fi
}

check_env
run $1