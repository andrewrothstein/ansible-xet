#!/usr/bin/env sh
set -e
DIR=~/Downloads

MIRROR=https://github.com/xetdata/xet-tools/releases/download

dl() {
    local ver=$1
    local os=$2
    local arch=$3
    local archive_type=${4:-tar.gz}
    local platform="${os}-${arch}"
    # https://github.com/xetdata/xet-tools/releases/download/v0.12.7/xet-linux-x86_64.tar.gz
    local url=$MIRROR/v${ver}/xet-${platform}.${archive_type}
    local lfile=$DIR/xet-${platform}-${ver}.${archive_type}
    if [ ! -e $lfile ];
    then
        curl -sSLf -o $lfile $url
    fi

    printf "    # %s\n" $url
    printf "    '%s': sha256:%s\n" $platform $(sha256sum $lfile | awk '{print $1}')
}

dl_ver() {
    local ver=$1
    printf "  '%s':\n" $ver
    dl $ver linux x86_64
}

dl_ver ${1:-0.12.7}
