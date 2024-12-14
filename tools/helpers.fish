#!/usr/bin/env fish
function __serpent_repo_dir
    realpath (dirname (readlink (status -f)))/../
end

function __serpent_toplevel
    git rev-parse --show-toplevel
end

function cpesearch -d "Search for known CPE entries for a program or library"
    if test "$argv[1]" = "--help"; or test "$argv[1]" = "-h"; or test (count $argv) -ne 1
        echo "usage: cpesearch <package-name>"
    else
        curl -s -X POST https://cpe-guesser.cve-search.org/search -d "{\"query\": [\"$argv[1]\"]}" | jq .
        
        echo "Verify successful hits by visiting https://cve.circl.lu/search/\$VENDOR/\$PRODUCT"
        echo "- CPE entries for software applications have the form 'cpe:2.3:a:\$VENDOR:\$PRODUCT"        
    end
end

function gotoserpentrepo -d "Go to the root of the Serpent recipes repository"
    cd (__serpent_repo_dir)
end

function goroot -d "Go to the root of the current Git repository"
    cd (__serpent_toplevel)
end

function chpkg -a package -d "Go to a package directory"
    cd (__serpent_toplevel)/*/$package
end

complete -c gotoserpentrepo -f
complete -c goroot -f
complete -c chpkg -f
complete -c chpkg -a "(path basename (__serpent_toplevel)/*/*)"

