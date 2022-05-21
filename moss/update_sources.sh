pu () {
    curl -s -L https://gitlab.com/serpent-os/core/$1/-/archive/main/$1-main.tar.gz -o /tmp/tmp-dwnld
    SUM=$(sha256sum /tmp/tmp-dwnld | cut -f1 -d' ')
    echo "    - https://gitlab.com/serpent-os/core/$1/-/archive/main/$1-main.tar.gz:
        hash: ${SUM}
        stripdirs: 1
        unpackdir: \"$1/\""
}

for i in moss moss-config moss-core moss-db moss-deps moss-fetcher moss-format moss-vendor; do
    pu ${i}
    rm /tmp/tmp-dwnld
done
