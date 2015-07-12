function have_sudo {
    groups | grep sudo > /dev/null 2>&1
    if [ $? == 0 ]; then
        return 0
    else
        return 1
    fi
}

function have_apt {
    if which apt-get > /dev/null
    then
        return 0
    else
        return 1
    fi
}

function install_package {
    local PKG=$1
    dpkg-query -s $PKG > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        if [ have_sudo ] && [ have_apt ]; then
            sudo apt-get install $PKG
        fi
    else
        return
    fi
}
