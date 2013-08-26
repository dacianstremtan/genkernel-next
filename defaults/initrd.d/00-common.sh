#!/bin/sh

is_livecd() {
    [ "${CDROOT}" = "1" ] && return 0
    return 1
}

is_nfs() {
    [ "${REAL_ROOT}" = "/dev/nfs" ] && return 0
    return 1
}

is_aufs() {
    [ "${USE_AUFS}" = "1" ] && return 0
    return 1
}

good_msg() {
    [ -n "${QUIET}" ] && [ -z "${DEBUG}" ] && return 0

    msg_string=$1
    msg_string="${msg_string:-...}"
    [ "$2" != 1 ] && \
        echo -e "${GOOD}>>${NORMAL}${BOLD} ${msg_string} ${NORMAL}"
}

warn_msg() {
    msg_string=$1
    msg_string="${msg_string:-...}"
    [ "$2" != 1 ] && \
        echo -e "${WARN}**${NORMAL}${BOLD} ${msg_string} ${NORMAL}"
}

bad_msg() {
    msg_string=$1
    msg_string="${msg_string:-...}"
    if [ "$2" != 1 ]; then
        # TODO(lxnay): fix circular dep with 00-splash.sh
        splashcmd verbose
        echo -e "${BAD}!!${NORMAL}${BOLD} ${msg_string} ${NORMAL}"
    fi
}