#!/bin/bash

releases=$(curl -s https://api.github.com/repos/mudler/linuxbundles/releases)

declare -A distro_logos=( 
    ["alpine"]="https://fatduck.org/images/dl/alpine.png"
    ["ubuntu"]="https://fatduck.org/images/dl/ubuntu.png" 
    ["debian"]="https://fatduck.org/images/dl/debian.png"
    ["archlinux"]="https://fatduck.org/images/dl/arch.png"
    ["fedora"]="https://fatduck.org/images/dl/fedora.png"
    ["gentoo"]="https://fatduck.org/images/dl/gentoo.png"
    ["leap"]="https://fatduck.org/images/dl/opensuse.png"
    ["centos"]="https://fatduck.org/images/dl/centos.png"
)

declare -A distro_link=( 
    ["ubuntu"]="https://ubuntu.com/" 
    ["debian"]="https://www.debian.org/"
    ["alpine"]="https://alpinelinux.org/"
    ["fedora"]="https://getfedora.org/it/"
    ["leap"]="https://www.opensuse.org/"
    ["centos"]="https://www.centos.org/"
    ["gentoo"]="https://www.gentoo.org"
    ["archlinux"]="https://archlinux.org/"
)

template=$(cat <<EOF
<div class="element box is-info px-1 m-3">
    <center><a href="%LINK%" target=_blank><img src="%LOGO%" width=52></a></center>
    <p>%NAME%</p>
    <small>%CREATED%</small>
    <p><strong>%SIZE%</strong></p>

    <p>
        <a class="button is-link" href="%URL%" _target="blank" >
            <span class="icon">
                <i class="fas fa-download"></i> 
            </span>
            <span> Download </span>
        </a>
        <a class="button is-secondary" href="%URL%.sha256" _target="blank" >
            <span class="icon">
                <i class="fas fa-download"></i> 
            </span>
            <span> SHA </span>
        </a>
    </p>
</div>
EOF
)

TILES=
for i in $(echo $releases | jq '.[0].assets[] | select( .browser_download_url | contains("sha256") | not )' -cr); do

    name=$(echo "$i" | jq -r ".name")
    size=$(numfmt --to=iec-i <<< $(echo "$i" | jq -r ".size"))
    created_at=$(echo "$i" | jq -r ".created_at")
    url=$(echo "$i" | jq -r ".browser_download_url")

    link=
    logo=

    for distro in "${!distro_logos[@]}"; do 
   # echo "$distro - ${distro_logos[$distro]}"; 
        if [[ $name =~ $distro* ]]; then
            logo=${distro_logos[$distro]}
        fi
    done
    for distro in "${!distro_link[@]}"; do 
        if [[ $name =~ $distro* ]]; then
            link=${distro_link[$distro]}
        fi
    done


    echo "[${created_at}] Asset $name ($size): $url. Logo $logo link $link"

    TILES=${TILES}$(echo $template | \
        sed "s/\%NAME\%/$name/g" | \
        sed "s|\%LINK\%|$link|g" | \
        sed "s|\%LOGO\%|$logo|g" | \
        sed "s/\%SIZE\%/$size/g" | \
        sed "s/\%CREATED\%/$created_at/g" | \
        sed "s|\%URL\%|$url|g")
done

cat gallery.html.tmpl | sed "s|%TILES%|$TILES|g" > gallery.html