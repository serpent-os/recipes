pu () {
    curl -s -L https://github.com/serpent-os/$1/archive/refs/heads/$2.tar.gz -o /tmp/tmp-dwnld
    SUM=$(sha256sum /tmp/tmp-dwnld | cut -f1 -d' ')
    echo "    - https://github.com/serpent-os/$1/archive/refs/heads/$2.tar.gz:
        hash: ${SUM}
        rename: ${1}.tar.gz
        stripdirs: 1
        unpackdir: \"$3/\""
}

for i in moss moss-config moss-core moss-db moss-deps moss-fetcher moss-format moss-vendor; do
    pu ${i} main ${i}
    rm /tmp/tmp-dwnld
done

pu elf-d dynamiclinking moss-vendor/vendor/elf/elf-d; rm /tmp/tmp-dwnld
pu lmdb-d main moss-vendor/subprojects/lmdb-d; rm /tmp/tmp-dwnld
pu xxhash-d main moss-vendor/subprojects/xxhash-d; rm /tmp/tmp-dwnld
pu zstdoubledee main moss-vendor/subprojects/zstdoubledee; rm /tmp/tmp-dwnld
