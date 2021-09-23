#!/usr/bin/env bash

getOs() {
    WIN=( "msys" "cygwin" "win32" )
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        echo "linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macOS"
    elif [[ " ${WIN[@]} " =~ " $OSTYPE " ]]; then
        echo "windows"
    elif [[ "$OSTYPE" == "freebsd"* ]]; then
        echo "freebsd"
    elif [[ "$OSTYPE" == "openbsd"* ]]; then
        echo "openbsd"
    else
        echo "Unsupported platform!"
        exit 1
    fi
}

getPlatform() {
    # This assumes amd64 or 386 only. It needs to be updated to support ARM as well!
    if [[ `getconf LONG_BIT` = "64" ]]; then
        arch="amd64"
    else
        arch="386"
    fi
    echo "$(getOs)_${arch}"
}

queryLatestReleases() {
    releases_path=https://api.github.com/repos/lc/gau/releases
    cmd="curl -sS"
    if [[ -n "${GITHUB_API_TOKEN}" ]]; then
        cmd="${cmd} -H 'Authorization: token ${GITHUB_API_TOKEN}'"
    fi
    eval "${cmd} ${releases_path}"
}

queryReleaseTag() {
    releases_path=https://api.github.com/repos/lc/gau/releases/tags/${ASDF_INSTALL_VERSION}
    cmd="curl -sS"
    if [[ -n "${GITHUB_API_TOKEN}" ]]; then
        cmd="${cmd} -H 'Authorization: token ${GITHUB_API_TOKEN}'"
    fi
    eval "${cmd} ${releases_path}"
}
