pu () {
    curl -s -L https://github.com/serpent-os/$1/archive/refs/heads/$2.tar.gz -o /tmp/tmp-dwnld
    SUM=$(sha256sum /tmp/tmp-dwnld | cut -f1 -d' ')
    echo "    - https://github.com/serpent-os/$1/archive/refs/heads/$2.tar.gz:
        hash: ${SUM}
        rename: ${1}.tar.gz
        stripdirs: 1
        unpackdir: \"$3/\""
}

for i in moss-container moss-core; do
    pu ${i} main ${i}
    rm /tmp/tmp-dwnld
done
