#!/bin/bash

# 修改默认IP
sed -i '/lan) ipad=${ipaddr:-/s/"[^"]*"/"10.0.0.1"/' package/base-files/files/bin/config_generate

# 修改主机名
sed -i "s/hostname='.*'/hostname='ZeroWrt'/g" package/base-files/files/bin/config_generate

# 修改固件名称
sed -i 's/\(VERSION_DIST:.*,\)[^)]*)/\1ZeroWrt)/' include/version.mk
sed -i 's/\(VERSION_MANUFACTURER:.*,\)[^)]*)/\1ZeroWrt)/' include/version.mk

# 修改 WIFI 名称
sed -i "s/ssid='.*'/ssid='ZeroWrt'/g" package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc

# 修改 WIFI 密码
sed -i "s/key='.*'/key='12345678'/g" package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc

# 修改 WIFI 加密
sed -i "s/encryption='.*'/encryption='psk2+ccmp'/g" package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc

# 修改 WIFI 地区
sed -i "s/country='.*'/country='CN'/g" package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc

# OpenWrt 默认的启动横幅文件
cp -f $GITHUB_WORKSPACE/files/banner package/base-files/files/etc/banner

# 修复 Rust 错误
sed -i 's/ci-llvm=true/ci-llvm=false/g' feeds/packages/lang/rust/Makefile

# 网络诊断
sed -i "s/openwrt.org/www.qq.com/g" feeds/luci/modules/luci-mod-network/htdocs/luci-static/resources/view/network/diagnostics.js

# 移除在线值守更新
sed -i "/luci-app-attendedsysupgrade/d" feeds/luci/collections/luci/Makefile
sed -i "s/^\(\s*+luci-app-package-manager\) \\\\/\1/" feeds/luci/collections/luci/Makefile
sed -i "/+luci-app-attendedsysupgrade \\\/d" feeds/luci/collections/luci-nginx/Makefile

# NTP
sed -i 's/0.openwrt.pool.ntp.org/ntp1.aliyun.com/g' package/base-files/files/bin/config_generate
sed -i 's/1.openwrt.pool.ntp.org/ntp2.aliyun.com/g' package/base-files/files/bin/config_generate
sed -i 's/2.openwrt.pool.ntp.org/time1.cloud.tencent.com/g' package/base-files/files/bin/config_generate
sed -i 's/3.openwrt.pool.ntp.org/time2.cloud.tencent.com/g' package/base-files/files/bin/config_generate

# TTYD
sed -i 's/services/system/g' feeds/luci/applications/luci-app-ttyd/root/usr/share/luci/menu.d/luci-app-ttyd.json
sed -i '3 a\\t\t"order": 50,' feeds/luci/applications/luci-app-ttyd/root/usr/share/luci/menu.d/luci-app-ttyd.json
sed -i 's/procd_set_param stdout 1/procd_set_param stdout 0/g' feeds/packages/utils/ttyd/files/ttyd.init
sed -i 's/procd_set_param stderr 1/procd_set_param stderr 0/g' feeds/packages/utils/ttyd/files/ttyd.init

# luci-theme-bootstrap
sed -i 's/font-size: 13px/font-size: 14px/g' feeds/luci/themes/luci-theme-bootstrap/htdocs/luci-static/bootstrap/cascade.css
sed -i 's/9.75px/10.75px/g' feeds/luci/themes/luci-theme-bootstrap/htdocs/luci-static/bootstrap/cascade.css

# Status page enhancement: add social and firmware links
cat << 'EOF' >> feeds/luci/modules/luci-mod-status/ucode/template/admin_status/index.ut
<script>
function addLinks() {
    var section = document.querySelector(".cbi-section");
    if (section) {
        // 创建表格容器
        var table = document.createElement('div');
        table.className = 'table';
        
        // 创建行
        var row = document.createElement('div');
        row.className = 'tr';
        
        // 左列：帮助与反馈
        var leftCell = document.createElement('div');
        leftCell.className = 'td left';
        leftCell.style.width = '33%';
        leftCell.textContent = '帮助与反馈';
        
        // 右列：三个按钮
        var rightCell = document.createElement('div');
        rightCell.className = 'td left';
        
        // 创建QQ交流群按钮
        var qqLink = document.createElement('a');
        qqLink.href = 'https://qm.qq.com/q/JbBVnkjzKa';
        qqLink.target = '_blank';
        qqLink.className = 'cbi-button';
        qqLink.style.marginRight = '10px';
        qqLink.textContent = 'QQ交流群';
        
        // 创建TG交流群按钮
        var tgLink = document.createElement('a');
        tgLink.href = 'https://t.me/kejizero';
        tgLink.target = '_blank';
        tgLink.className = 'cbi-button';
        tgLink.style.marginRight = '10px';
        tgLink.textContent = 'TG交流群';
        
        // 创建固件地址按钮
        var firmwareLink = document.createElement('a');
        firmwareLink.href = 'https://openwrt.kejizero.online';
        firmwareLink.target = '_blank';
        firmwareLink.className = 'cbi-button';
        firmwareLink.textContent = '固件地址';
        
        // 组装元素
        rightCell.appendChild(qqLink);
        rightCell.appendChild(tgLink);
        rightCell.appendChild(firmwareLink);
        
        row.appendChild(leftCell);
        row.appendChild(rightCell);
        table.appendChild(row);
        section.appendChild(table);
    } else {
        setTimeout(addLinks, 100);
    }
}

document.addEventListener("DOMContentLoaded", addLinks);
</script>
EOF

# Custom firmware version and author metadata
sed -i "s/DISTRIB_DESCRIPTION='*.*'/DISTRIB_DESCRIPTION='ZeroWrt-$(date +%Y%m%d)'/g"  package/base-files/files/etc/openwrt_release
sed -i "s/DISTRIB_REVISION='*.*'/DISTRIB_REVISION=' By OPPEN321'/g" package/base-files/files/etc/openwrt_release
sed -i "s|^OPENWRT_RELEASE=\".*\"|OPENWRT_RELEASE=\"ZeroWrt 标准版 @R$(date +%Y%m%d) BY OPPEN321\"|" package/base-files/files/usr/lib/os-release

# 移除要替换的包
rm -rf feeds/luci/applications/luci-app-appfilter
rm -rf feeds/luci/applications/luci-app-frpc
rm -rf feeds/luci/applications/luci-app-frps
rm -rf feeds/luci/applications/luci-app-argon-config
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/packages/net/open-app-filter
rm -rf feeds/packages/net/ariang
rm -rf feeds/packages/net/frp
rm -rf feeds/packages/lang/golang

# Git稀疏克隆，只克隆指定目录到本地
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}

# Go & OpenList & ariang & frp & AdGuardHome & WolPlus & Lucky & wechatpush & OpenAppFilter & 集客无线AC控制器 & 雅典娜LED控制 & Argon 主题
git clone --depth=1 https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang
git clone --depth=1 https://github.com/sbwml/luci-app-openlist2 package/openlist
git_sparse_clone ariang https://github.com/laipeng668/packages net/ariang
git_sparse_clone frp https://github.com/laipeng668/packages net/frp
mv -f package/frp feeds/packages/net/frp
git_sparse_clone frp https://github.com/laipeng668/luci applications/luci-app-frpc applications/luci-app-frps
mv -f package/luci-app-frpc feeds/luci/applications/luci-app-frpc
mv -f package/luci-app-frps feeds/luci/applications/luci-app-frps
git clone --depth=1 https://github.com/sirpdboy/luci-app-adguardhome package/luci-app-adguardhome
sed -i "s/\(option enabled '\)1'/\10'/" package/luci-app-adguardhome/luci-app-adguardhome/root/etc/config/AdGuardHome
git_sparse_clone main https://github.com/VIKINGYFY/packages luci-app-wolplus
git clone --depth=1 https://github.com/gdy666/luci-app-lucky package/luci-app-lucky
git clone --depth=1 https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
git clone --depth=1 https://github.com/lwb1978/openwrt-gecoosac package/openwrt-gecoosac
git clone --depth=1 https://github.com/NONGFAH/luci-app-athena-led package/luci-app-athena-led
chmod +x package/luci-app-athena-led/root/etc/init.d/athena_led package/luci-app-athena-led/root/usr/sbin/athena-led
sed -i "/^config athena_led/,/^config / s/^\(\s*option value\s*'\).*\('.*\)/\1ZWRT\2/" package/luci-app-athena-led/root/etc/config/athena_led
sed -i "s/option option 'date timeBlink'/option option 'date timeBlink temp string'/" package/luci-app-athena-led/root/etc/config/athena_led
git clone --depth=1 https://github.com/QuickWrt/luci-theme-argon package/luci-theme-argon

./scripts/feeds update -a
./scripts/feeds install -a
