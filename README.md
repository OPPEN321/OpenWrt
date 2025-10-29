<p align="center">
  <img src="https://doc.embedfire.com/openwrt/user_manal/zh/latest/_images/openwrtlogo.png" width="768" alt="OpenWrt Logo">
</p>

<h1 align="center">🌐 OpenWrt — 多设备固件云编译</h1>

<p align="center">
  <strong>一键构建高性能 OpenWrt 固件</strong><br>
  支持 <b>Rockchip</b> 与 <b>x86_64</b> 平台，基于 <b>LEDE</b> 源码，自动化 & 可视化后台。
</p>

<p align="center">
  <a href="http://10.0.0.1"><img src="https://img.shields.io/badge/后台-10.0.0.1-blue.svg" alt="后台"></a>
  <a href="#"><img src="https://img.shields.io/badge/密码-password-red.svg" alt="密码"></a>
  <a href="https://github.com/OPPEN321/OpenWrt/actions/workflows/build.yml"><img src="https://github.com/oppen321/OpenWrt/workflows/Build/badge.svg" alt="Build Status"></a>
  <a href="#"><img src="https://img.shields.io/badge/License-MIT-green.svg" alt="License"></a>
</p>

---

## ✨ 项目简介

**OPPEN321 / OpenWrt** 是一个 **高端在线云编译平台**，利用 **GitHub Actions** 自动化构建 OpenWrt 固件，兼容 **Rockchip** 与 **x86_64** 平台。  
无需本地环境，上传配置即可一键生成定制固件，支持自动集成驱动、LuCI 应用、主题美化与自定义包。

> 💻 后台地址：<b>http://10.0.0.1</b>  
> 🔑 默认密码：<b>password</b>

---

## ⚡ 核心特性

<table>
<tr>
<td align="center">🚀<br><b>自动化构建</b></td>
<td align="center">🧩<br><b>多平台支持</b></td>
<td align="center">🧱<br><b>自定义配置</b></td>
<td align="center">🪶<br><b>驱动齐全</b></td>
<td align="center">💎<br><b>主题美化</b></td>
<td align="center">⚡<br><b>可视化管理</b></td>
</tr>
<tr>
<td>GitHub Actions 云端一键编译，无需本地环境</td>
<td>Rockchip / x86_64 双平台覆盖，兼容主流路由器和服务器</td>
<td>上传 .config 或 files/ 注入系统文件，完全自定义固件</td>
<td>内置常用网络驱动及 LuCI 插件</td>
<td>默认启用 Argon 等精美主题，可替换</td>
<td>Web 后台实时查看日志与状态</td>
</tr>
</table>

---

## 🛠 使用指南

1️⃣ 访问后台: [http://10.0.0.1](http://10.0.0.1)，输入密码 <b>password</b>  
2️⃣ 上传 `.config` 或 `files/` 文件（可选，自定义固件）  
3️⃣ 选择目标平台：Rockchip / x86_64  
4️⃣ 点击 **构建**，触发 GitHub Actions 云端编译  
5️⃣ 实时查看日志，完成后直接下载固件  

---

## 🌐 高级定制

- 🧰 **第三方包源**：在 `feeds.conf.default` 添加自定义仓库  
- 🧩 **自动补丁**：`scripts/patch.sh` 可自动应用自定义补丁  
- 🌀 **缓存加速**：区分 Rockchip / x86_64 编译缓存，提高重复构建速度  
- 🧬 **后处理脚本**：可在 `scripts/` 内添加自动打包、美化逻辑  

---

## ❓ 常见问题

**Q：可以完全自定义固件吗？**  
✅ 通过上传 `.config` 与 `files/` 内容即可。  

**Q：如何添加额外软件包？**  
✅ 将包放入 `package/` 或添加 IPK 仓库地址到 feeds 文件中。  

**Q：如何查看编译日志？**  
✅ 后台提供实时日志，可追踪错误或进度。  

---

## 🤝 贡献指南

欢迎 Issue / PR，提交前请确保：  
- 变更说明清晰（CHANGELOG / PR 描述）  
- 添加包或驱动时注明来源与许可证  

---

## 📜 许可证

本项目默认使用 **MIT License**。自由使用、修改与发布，无额外限制。  

---

<p align="center">
⭐ 如果本项目对你有帮助，请点亮 <b>Star</b> 支持！
</p>

