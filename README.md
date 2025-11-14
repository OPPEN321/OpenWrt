# ⚡ OpenWrt-IPQ — 为 IPQ60XX / IPQ807X 打造的满血 NSS 高性能 OpenWrt 固件

![Build Status](https://img.shields.io/github/actions/workflow/status/OPPEN321/OpenWrt-IPQ/build.yml?label=Cloud%20Build&logo=github)
![Downloads](https://img.shields.io/github/downloads/OPPEN321/OpenWrt-IPQ/total?color=brightgreen&label=Total%20Downloads&logo=github)
![OpenWrt](https://img.shields.io/badge/OpenWrt-IPQ%20Optimized-blue?logo=openwrt)
![License](https://img.shields.io/badge/License-MIT-green)

**OpenWrt-IPQ** 是一个基于 **ImmortalWrt（含 NSS 完整加速补丁）** 构建的高性能固件项目，  
专注于 **Qualcomm IPQ60XX 与 IPQ807X 平台**，最大化利用 **NSS 加速引擎**，在高并发环境下依然保持低延迟、高吞吐。

本项目 **完全使用 GitHub Actions 云端编译**，无需本地环境，全自动发布固件。

---

## 🚀 核心特点

### 🔥 全功能 NSS 加速（默认启用）
- NAT / IPv4 / IPv6 / L2 / QoS 全模块启用  
- CPU 占用极低，WAN→LAN 高速转发  
- 千兆、多千兆带宽均可轻松跑满  
- WiFi 与有线同时享受 NSS 性能增益  

---

## 📒 固件信息

| 项目 | 内容 |
|------|-------|
| **💻 平台架构** | qualcommax-ipq807x / qualcommax-ipq60xx |
| **⚽ 固件源码** | https://github.com/QuickWrt/immortalwrt |
| **💝 源码分支** | master |
| **🌐 默认管理地址** | http://10.0.0.1 |
| **🔑 默认密码** | `password` |
| **☁ 编译方式** | GitHub Actions 云端自动构建 |
| **📦 固件下载** | Releases 页面自动发布 |

---

## 🧩 内置插件 & 功能状态

| 插件 | 状态 | 插件 | 状态 |
|-------------|------|-------------|------|
| luci-app-homeproxy | ✅ | luci-app-oaf | ✅ |
| luci-app-sqm | ✅ | luci-proto-wireguard | ✅ |
| luci-app-arpbind | ✅ | luci-app-wolplus | ✅ |
| luci-app-cpufreq | ✅ | luci-app-autoreboot | ✅ |
| luci-app-watchcat | ✅ | luci-app-ttyd | ✅ |
| luci-app-uhttpd | ✅ | luci-app-3cat | ✅ |
| luci-app-ddns | ✅ | luci-app-wechatpush | ✅ |
| luci-app-samba4 | ✅ | luci-app-diskman | ✅ |
| luci-app-usb-printer | ✅ | luci-app-wolplus | ✅ |
| luci-app-argon-config | ✅ | luci-app-adguardhome | ✅ |

✅ 可用  
❌ 不可用  
⏳ 计划中

## 📱 支持设备

| SoC 系列 | 支持情况 | 说明 |
|----------|----------|------|
| **IPQ60XX 系列** | ✔ 完全支持 | NSS 全模块启用 |
| **IPQ807X 系列** | ✔ 完全支持 | 高速 WiFi & 多千兆转发更强 |

---

## ☁ 云端编译说明（GitHub Actions）

本项目 **只提供云编译，不推荐本地编译**。

### 🔘 手动触发
GitHub → Actions → 选择 Workflow → **Run workflow**

### 🔄 提交自动编译
Push 任意 commit → 自动开始构建

### ⏰ 定时构建
根据 CRON 自动执行周期性构建任务

构建完成后固件将自动上传到 **Releases**。

---

## 📦 固件下载

所有固件均在此发布：
👉 https://github.com/OPPEN321/OpenWrt-IPQ/releases

---

## ❤️ 致谢

感谢以下优秀项目：

- LibWrt / ImmortalWrt  
- Qualcomm NSS / ECM 维护者  
- OpenWrt 官方项目  
- 社区所有贡献者  

