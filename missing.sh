#!/bin/bash
#
# In order to get Summit up and running we need functioning x86_64
# manifest files. Older files were just moss stubs, basically only
# the header. Many are simply *missing*.
#
# Rebuilds should only commit *manifests* until the new live collection
# is up and running

totalWorking=0
totalBroken=0

function pushBroken()
{
    echo "Broken: $*"
    totalBroken=$((totalBroken+1))
}

function pushWorking()
{
    totalWorking=$((totalWorking+1))
}

for item in `find . -name stone.yml` ; do
    itemDir=$(dirname ${item})
    manifestPath="${itemDir}/manifest.x86_64.bin"
    if [[ ! -e "${manifestPath}" ]]; then
        pushBroken "${item}"
        continue
    fi
    usage=`du -s --bytes "${manifestPath}" | cut  -f 1`
    if [[ "${usage}" -le "32" ]]; then
        pushBroken "${item}" "size"
    fi
    pushWorking "${item}"
done

echo "Broken manifests: ${totalBroken}"
echo "Functioning manifests: ${totalWorking}"
