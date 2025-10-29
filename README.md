<div align="center">
<img width="720" src="https://doc.embedfire.com/openwrt/user_manal/zh/latest/_images/openwrtlogo.png"/>
<h1 style="font-size:2.5em; color:#32C955; margin-top: 10px;">OpenWrt — 多设备固件云编译</h1>

<!-- 仓库徽章 -->
<img src="https://img.shields.io/github/downloads/oppen321/OpenWrt/total.svg?style=for-the-badge&color=32C955"/>
<img src="https://img.shields.io/github/stars/oppen321/OpenWrt.svg?style=for-the-badge&color=ff9900"/>
<img src="https://img.shields.io/github/forks/oppen321/OpenWrt.svg?style=for-the-badge&color=ff69b4"/>
<img src="https://img.shields.io/github/license/oppen321/OpenWrt.svg?style=for-the-badge&color=6f42c1"/>

<!-- 横向目录 -->
<div style="margin-top:15px; display:flex; flex-wrap:wrap; justify-content:center; gap:10px;">
<a href="#项目说明"><img src="https://img.shields.io/badge/-📝项目说明-32C955.svg"/></a>
<a href="#固件特色"><img src="https://img.shields.io/badge/-✨固件特色-ff9900.svg"/></a>
<a href="#固件下载"><img src="https://img.shields.io/badge/-📦固件下载-6f42c1.svg"/></a>
<a href="#近期更新"><img src="https://img.shields.io/badge/-🆕近期更新-32C955.svg"/></a>
<a href="#插件预览"><img src="https://img.shields.io/badge/-🔌插件预览-ff69b4.svg"/></a>
<a href="#定制固件"><img src="https://img.shields.io/badge/-⚙️定制固件-ff9900.svg"/></a>
<a href="#特别提示"><img src="https://img.shields.io/badge/-⚠️特别提示-ff0000.svg"/></a>
<a href="#鸣谢"><img src="https://img.shields.io/badge/-🙏鸣谢-32C955.svg"/></a>
</div>
</div>

---

## 项目说明
<div style="background:#f7f7f7; border-radius:10px; padding:15px;">
- **固件构成**：
  [![LEDE](https://img.shields.io/badge/LEDE-源码-blueviolet.svg)](https://github.com/coolsnowwolf/lede)
  [![OPPEN321](https://img.shields.io/badge/Build-OPPEN321-32C955.svg)](https://github.com/oppen321/OpenWrt)
- **编译方式**：使用 GitHub Actions 云端自动拉取源码编译
- **默认登录**：管理地址 `10.0.0.1` 用户 `root` 密码 `password`
- **适配平台**：Rockchip 平台、X86_64 软路由
- **固件版本**：
  - 精简版：轻量化，覆盖基础网络
  - 增强版：集成更多插件，支持 Docker、在线更新
- **插件管理**：集成所有 ipk 插件，可在 [Releases](https://github.com/oppen321/OpenWrt/releases) 下载
- **注意事项**：首次使用请全新安装，避免升级失败
</div>

---

## 固件特色
<div style="display:flex; flex-wrap:wrap; gap:15px;">
<div style="flex:1; min-width:250px; background:#ffffff; border-radius:10px; padding:15px; box-shadow:0 4px 10px rgba(0,0,0,0.1);">
1️⃣ 云端自动定时编译<br/>
2️⃣ 集成有线、无线、3G/4G网卡驱动<br/>
3️⃣ 中文版 netdata 实时监控<br/>
4️⃣ iStore 应用商店安装插件
</div>
<div style="flex:1; min-width:250px; background:#ffffff; border-radius:10px; padding:15px; box-shadow:0 4px 10px rgba(0,0,0,0.1);">
5️⃣ 内置 Docker，可部署容器<br/>
6️⃣ 应用过滤：游戏、视频、聊天、下载<br/>
7️⃣ 在线用户监控<br/>
8️⃣ 自动更新固件及内核（增强版）
</div>
</div>

---

## 固件下载
点击下表 [下载链接](https://github.com/oppen321/OpenWrt/releases) 即可跳转：
| 平台+设备 | 编译状态 | 配置文件 | 下载链接 |
| :------: | :------: | :------: | :------: |
| X86_64 | [![状态](https://github.com/oppen321/OpenWrt/actions/workflows/X86_64-OpenWrt.yml/badge.svg)]() | [![配置](https://img.shields.io/badge/编译-配置-orange.svg)]() | [![下载](https://img.shields.io/badge/下载-链接-blueviolet.svg)]() |
| Rockchip | [![状态](https://github.com/oppen321/OpenWrt/actions/workflows/Rockchip-OpenWrt.yml/badge.svg)]() | [![配置](https://img.shields.io/badge/编译-配置-orange.svg)]() | [![下载](https://img.shields.io/badge/下载-链接-blueviolet.svg)]() |

---

## 近期更新
🤣 持续优化中……

---

## 插件预览
<details>
<summary><b>Rockchip 精简/增强版</b></summary>
<br/>
<img width="100%" src="https://cdn.jsdelivr.net/gh/haiibo/OpenWrt/images/mini.png"/>
</details>

<details>
<summary><b>X86_64 软路由</b></summary>
<br/>
<img width="100%" src="https://cdn.jsdelivr.net/gh/haiibo/OpenWrt/images/plus.png"/>
</details>

---

## 定制固件
1. 登录 Github 并 Fork 本项目  
2. 修改 `configs/` 对应配置或上传自定义 `.config`  
3. 调整插件、默认 IP、密码等，可在 `diy-script.sh` 内修改  
4. 编辑或创建 workflow 文件，运行 Actions 开始编译  
5. 编译完成后在 [Releases](https://github.com/oppen321/OpenWrt/releases) 下载  

---

## 特别提示
- 不提供技术支持，不保证完全无 BUG  
- 使用固件风险自负，禁止商业用途  
- 请遵守国家网络法律法规  

---

## 鸣谢
| [LEDE](https://github.com/coolsnowwolf/lede) | [P3TERX](https://github.com/P3TERX) | [Flippy](https://github.com/unifreq/openwrt_packit) | [Haiibo](https://github.com/haiibo/OpenWrt) |
| :-------------: | :-------------: | :-------------: | :-------------: |
| <img width="100" src="https://avatars.githubusercontent.com/u/31687149"/> | <img width="100" src="https://avatars.githubusercontent.com/u/25927179"/> | <img width="100" src="https://avatars.githubusercontent.com/u/39355261"/> | <img width="100" src="https://avatars.githubusercontent.com/u/68696949"/> |

<a href="#readme">
<img src="https://img.shields.io/badge/-返回顶部-FFFFFF.svg" align="right"/>
</a>
