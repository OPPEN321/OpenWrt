#!/bin/bash

# 修改默认IP
sed -i '/lan) ipad=${ipaddr:-/s/"[^"]*"/"10.0.0.1"/' package/base-files/files/bin/config_generate

# 修改主机名
sed -i "s/hostname='.*'/hostname='ZeroWrt'/g" package/base-files/files/bin/config_generate

# 修改固件名称
sed -i '/^VERSION_DIST:=$(if /c\VERSION_DIST:=$(if $(VERSION_DIST),$(VERSION_DIST),ZeroWrt)' include/version.mk
sed -i '/^VERSION_MANUFACTURER:=$(if /c\VERSION_MANUFACTURER:=$(if $(VERSION_MANUFACTURER),$(VERSION_MANUFACTURER),ZeroWrt)' include/version.mk

# 修改 WIFI 名称
sed -i "s/ssid='.*'/ssid='ZeroWrt'/g" package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc

# 修改 WIFI 密码
sed -i "s/key='.*'/key='12345678'/g" package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc

# 修改 WIFI 加密
sed -i "s/encryption='.*'/encryption='psk2+ccmp'/g" package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc

# 修改 WIFI 地区
sed -i "s/country='.*'/country='CN'/g" package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc

# 设置默认密码
default_password=$(openssl passwd -5 password)
sed -i "s|^root:[^:]*:|root:${default_password}:|" package/base-files/files/etc/shadow

# OpenWrt 默认的启动横幅文件
cp -f $GITHUB_WORKSPACE/scripts/banner package/base-files/files/etc/banner

# 修复 Rust 错误
sed -i 's/ci-llvm=true/ci-llvm=false/g' feeds/packages/lang/rust/Makefile

# 网络诊断
sed -i "s/openwrt.org/www.qq.com/g" feeds/luci/modules/luci-mod-network/htdocs/luci-static/resources/view/network/diagnostics.js

# 必要的补丁
pushd feeds/luci
    curl -s https://openwrt.kejizero.xyz/openwrt/patch/luci/0001-luci-mod-system-add-modal-overlay-dialog-to-reboot.patch | patch -p1
    curl -s https://openwrt.kejizero.xyz/openwrt/patch/luci/0002-luci-mod-status-displays-actual-process-memory-usage.patch | patch -p1
    curl -s https://openwrt.kejizero.xyz/openwrt/patch/luci/0003-luci-mod-status-storage-index-applicable-only-to-val.patch | patch -p1
    curl -s https://openwrt.kejizero.xyz/openwrt/patch/luci/0004-luci-mod-status-firewall-disable-legacy-firewall-rul.patch | patch -p1
    curl -s https://openwrt.kejizero.xyz/openwrt/patch/luci/0005-luci-mod-system-add-refresh-interval-setting.patch | patch -p1
    curl -s https://openwrt.kejizero.xyz/openwrt/patch/luci/0006-luci-mod-system-mounts-add-docker-directory-mount-po.patch | patch -p1
    curl -s https://openwrt.kejizero.xyz/openwrt/patch/luci/0007-luci-mod-system-add-ucitrack-luci-mod-system-zram.js.patch | patch -p1
popd

# 移除在线值守更新
sed -i "/luci-app-attendedsysupgrade/d" feeds/luci/collections/luci/Makefile
sed -i "s/^\(\s*+luci-app-package-manager\) \\\\/\1/" feeds/luci/collections/luci/Makefile
sed -i "/+luci-app-attendedsysupgrade \\\/d" feeds/luci/collections/luci-nginx/Makefile

### samba4 - bump version ###
rm -rf feeds/packages/net/samba4
git clone https://github.com/sbwml/feeds_packages_net_samba4 feeds/packages/net/samba4
# enable multi-channel
sed -i '/workgroup/a \\n\t## enable multi-channel' feeds/packages/net/samba4/files/smb.conf.template
sed -i '/enable multi-channel/a \\tserver multi channel support = yes' feeds/packages/net/samba4/files/smb.conf.template
# default config
sed -i 's/#aio read size = 0/aio read size = 0/g' feeds/packages/net/samba4/files/smb.conf.template
sed -i 's/#aio write size = 0/aio write size = 0/g' feeds/packages/net/samba4/files/smb.conf.template
sed -i 's/invalid users = root/#invalid users = root/g' feeds/packages/net/samba4/files/smb.conf.template
sed -i 's/bind interfaces only = yes/bind interfaces only = no/g' feeds/packages/net/samba4/files/smb.conf.template
sed -i 's/#create mask/create mask/g' feeds/packages/net/samba4/files/smb.conf.template
sed -i 's/#directory mask/directory mask/g' feeds/packages/net/samba4/files/smb.conf.template
sed -i 's/0666/0644/g;s/0744/0755/g;s/0777/0755/g' feeds/luci/applications/luci-app-samba4/htdocs/luci-static/resources/view/samba4.js
sed -i 's/0666/0644/g;s/0777/0755/g' feeds/packages/net/samba4/files/samba.config
sed -i 's/0666/0644/g;s/0777/0755/g' feeds/packages/net/samba4/files/smb.conf.template

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
rm -rf feeds/luci/applications/luci-app-argon-config
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/packages/net/open-app-filter
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

# Go 1.25
git clone --depth=1 https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang

# OpenList 
git clone --depth=1 https://github.com/sbwml/luci-app-openlist2 package/openlist

# Mosdns
git clone --depth=1 -b v5 https://github.com/sbwml/luci-app-mosdns package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

# Adguardhome
git clone --depth=1 https://github.com/sirpdboy/luci-app-adguardhome package/luci-app-adguardhome

# 挂载插件
git clone --depth=1 https://github.com/sirpdboy/luci-app-partexp.git package/luci-app-partexp

# 一键唤醒
git_sparse_clone main https://github.com/sbwml/openwrt_pkgs luci-app-wolplus

# Lucky
git clone --depth=1 https://github.com/gdy666/luci-app-lucky package/luci-app-lucky

# OpenAppFilter
git clone --depth=1 https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter

# 集客无线AC控制器
git clone --depth=1 https://github.com/lwb1978/openwrt-gecoosac package/openwrt-gecoosac

# 雅典娜LED控制
git clone --depth=1 https://github.com/NONGFAH/luci-app-athena-led package/luci-app-athena-led
chmod +x package/luci-app-athena-led/root/etc/init.d/athena_led package/luci-app-athena-led/root/usr/sbin/athena-led
sed -i "/^config athena_led/,/^config / s/^\(\s*option value\s*'\).*\('.*\)/\1ZWRT\2/" package/luci-app-athena-led/root/etc/config/athena_led
sed -i "s/option option 'date timeBlink'/option option 'date timeBlink temp string'/" package/luci-app-athena-led/root/etc/config/athena_led

# Argon 主题
git clone --depth=1 https://github.com/QuickWrt/luci-theme-argon package/luci-theme-argon

# luci-app-bandix
git clone https://github.com/timsaya/luci-app-bandix package/new/luci-app-bandix

# openwrt-bandix
git clone https://github.com/timsaya/openwrt-bandix package/new/openwrt-bandix

./scripts/feeds update -a
./scripts/feeds install -a
