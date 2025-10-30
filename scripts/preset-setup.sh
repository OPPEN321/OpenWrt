#!/bin/bash

# 修改默认IP
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/luci/bin/config_generate

# 修改默认默认主机名
sed -i 's/LEDE/ZeroWrt/' package/base-files/files/bin/config_generate
sed -i 's/LEDE/ZeroWrt/' package/base-files/luci/bin/config_generate

# 更改默认 Shell 为 zsh
sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd

# 修改内核版本
# sed -i 's/6.12/6.6/' target/linux/rockchip/Makefile

# 更新固件名称
date_version=$(date +%y%m%d)
sed -i "s/^CONFIG_VERSION_NUMBER=\"\"/CONFIG_VERSION_NUMBER=\"plus-$date_version\"/" .config

# OpenWrt 默认的启动横幅文件
curl -s http://127.0.0.1:8080/scripts/banner > package/base-files/files/etc/banner

# 加入作者外链
curl -s http://127.0.0.1:8080/scripts/index.htm > feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm

# 移除要替换的包
rm -rf feeds/packages/net/{mosdns,msd_lite,open-app-filter,libxcrypt}
rm -rf feeds/luci/themes/{luci-theme-argon,luci-theme-netgear}
rm -rf feeds/luci/applications/luci-app-mosdns,luci-app-netdata}
rm -rf feeds/packages/lang/golang
rm -rf package/libs/mbedtls

# Git 参数设置
git_clone_path() {
    local commit_hash=$1
    local repo=$2
    shift 2
    for path in "$@"; do
        echo -e "\n📦 从 ${repo} (提交 ${commit_hash}) 克隆 ${path} ..."
        git clone --no-checkout --filter=blob:none --sparse "$repo" temp_clone || exit 1
        cd temp_clone || exit 1
        git fetch origin || exit 1
        git checkout "$commit_hash" || exit 1
        git sparse-checkout set "$path" || exit 1
        mkdir -p "../$(dirname "$path")"
        cp -rf "$path" "../$path"
        cd ..
        rm -rf temp_clone
        echo "✅ 已成功复制 $path"
    done
}

# 克隆 4bb635d 提交的 mbedtls
git_clone_path 4bb635d https://github.com/coolsnowwolf/lede package/libs/mbedtls

# Git稀疏克隆，只克隆指定目录到本地
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}

# 安装 Go（Golang 1.25 版本）
git clone https://github.com/sbwml/packages_lang_golang -b 25.x feeds/packages/lang/golang

# 添加额外插件
git clone --depth=1 https://github.com/kongfl888/luci-app-adguardhome package/luci-app-adguardhome
git clone --depth=1 https://github.com/ilxp/luci-app-ikoolproxy package/luci-app-ikoolproxy
git clone --depth=1 https://github.com/esirplayground/luci-app-poweroff package/luci-app-poweroff
git clone --depth=1 https://github.com/destan19/OpenAppFilter package/OpenAppFilter
git clone --depth=1 https://github.com/Jason6111/luci-app-netdata package/luci-app-netdata
git_sparse_clone main https://github.com/Lienol/openwrt-package luci-app-filebrowser luci-app-ssr-mudb-server
git_sparse_clone openwrt-18.06 https://github.com/immortalwrt/luci applications/luci-app-eqos

# 科学上网插件
git clone --depth=1 -b master https://github.com/fw876/helloworld package/luci-app-ssr-plus
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall package/luci-app-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall2 package/luci-app-passwall2
git_sparse_clone master https://github.com/vernesong/OpenClash luci-app-openclash

# 主题
git clone --depth=1 -b 18.06 https://github.com/kiddin9/luci-theme-edge package/luci-theme-edge
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config
git clone --depth=1 https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom package/luci-theme-infinityfreedom
git_sparse_clone main https://github.com/haiibo/packages luci-theme-atmaterial luci-theme-opentomcat luci-theme-netgear

# 更改 Argon 主题背景
curl -s http://127.0.0.1:8080/images/bg1.jpg > package/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg

# msd_lite
git clone --depth=1 https://github.com/ximiTech/luci-app-msd_lite package/luci-app-msd_lite
git clone --depth=1 https://github.com/ximiTech/msd_lite package/msd_lite

# MosDNS
git clone --depth=1 -b v5-lua https://github.com/sbwml/luci-app-mosdns package/luci-app-mosdns

# 在线用户
git_sparse_clone main https://github.com/haiibo/packages luci-app-onliner
sed -i '$i uci set nlbwmon.@nlbwmon[0].refresh_interval=2s' package/lean/default-settings/files/zzz-default-settings
sed -i '$i uci commit nlbwmon' package/lean/default-settings/files/zzz-default-settings
chmod 755 package/luci-app-onliner/root/usr/share/onliner/setnlbw.sh

# x86 型号只显示 CPU 型号
sed -i 's/${g}.*/${a}${b}${c}${d}${e}${f}${hydrid}/g' package/lean/autocore/files/x86/autocore

# 修复 Rust 错误
sed -i 's/ci-llvm=true/ci-llvm=false/g' feeds/packages/lang/rust/Makefile

# 修改版本为编译日期
date_version=$(date +"R%y.%m.%d")
sed -i "s|echo \"DISTRIB_REVISION='R25.10.10'\"|echo \"DISTRIB_REVISION='$date_version'\"|" package/lean/default-settings/files/zzz-default-settings
sed -i "s|echo \"DISTRIB_DESCRIPTION='LEDE '\"|echo \"DISTRIB_DESCRIPTION='ZeroWrt 标准版 @ $date_version BY OPPEN321'\"|" package/lean/default-settings/files/zzz-default-settings
sed -i "s|^echo 'OPENWRT_RELEASE=.*' >> /usr/lib/os-release|echo 'OPENWRT_RELEASE=\"ZeroWrt 标准版 @ $date_version BY OPPEN321\"' >> /usr/lib/os-release|" package/lean/default-settings/files/zzz-default-settings

# 取消主题默认设置
find package/luci-theme-*/* -type f -name '*luci-theme-*' -print -exec sed -i '/set luci.main.mediaurlbase/d' {} \;
