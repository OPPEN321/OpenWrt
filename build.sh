#!/bin/bash

# =============================================================================
# 颜色和样式配置
# =============================================================================
RESET='\033[0m'
BOLD='\033[1m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
MAGENTA='\033[1;35m'
WHITE='\033[1;37m'
RED='\033[1;31m'

# =============================================================================
# 全局变量
# =============================================================================
CPU_CORES=$(nproc)
HTTP_BASE="http://127.0.0.1:8080/scripts"

# =============================================================================
# 主程序开始 - 信息显示部分
# =============================================================================

# ───── 构建标题 ─────
echo -e "${BOLD}${MAGENTA}════════════════════════════════════════════════════════════════${RESET}"
echo -e "${BOLD}${CYAN}🚀 ZeroWrt OpenWrt 编译环境初始化${RESET}"
echo -e "${BOLD}${MAGENTA}════════════════════════════════════════════════════════════════${RESET}"
echo ""

# ───── 项目信息 ─────
echo -e "${BOLD}${BLUE}🛠️  开发者:    ${GREEN}OPPEN321${RESET}"
echo -e "${BOLD}${BLUE}🌐 博客:      ${GREEN}www.kejizero.online${RESET}"
echo -e "${BOLD}${BLUE}💡 理念:      ${GREEN}开源 · 定制化 · 高性能${RESET}"
echo -e "${BOLD}${BLUE}📦 版本:      ${GREEN}2.0.0${RESET}"
echo ""

# ───── 系统信息 ─────
echo -e "${BOLD}${MAGENTA}────────────────────────────────────────────────────────────────${RESET}"
echo -e "${BOLD}${CYAN}🔧 构建开始:   ${YELLOW}$(date '+%Y-%m-%d %H:%M:%S')${RESET}"
echo -e "${BOLD}${CYAN}⚡ 处理器核心: ${YELLOW}$CPU_CORES 个${RESET}"
echo -e "${BOLD}${CYAN}🐧 系统用户:   ${YELLOW}$(whoami)${RESET}"
echo -e "${BOLD}${MAGENTA}────────────────────────────────────────────────────────────────${RESET}"
echo ""

# =============================================================================
# 函数定义
# =============================================================================

# 错误处理函数
handle_error() {
    echo -e "${RED}❌ 错误: $1${RESET}"
    exit 1
}

# 下载并执行脚本函数
download_and_execute_script() {
    local script_name=$1
    local script_url="$HTTP_BASE/$script_name"
    local local_path="/tmp/$script_name"
    
    echo -e "${CYAN}📥 下载脚本: $script_name${RESET}"
    
    # 下载脚本
    if ! wget -q "$script_url" -O "$local_path"; then
        handle_error "下载脚本失败: $script_url"
    fi
    
    # 赋予执行权限
    chmod +x "$local_path"
    
    echo -e "${GREEN}🚀 执行脚本: $script_name${RESET}"
    echo -e "${MAGENTA}────────────────────────────────────────────────────────────────${RESET}"
    
    # 执行脚本
    if ! bash "$local_path"; then
        handle_error "脚本执行失败: $script_name"
    fi
    
    echo -e "${MAGENTA}────────────────────────────────────────────────────────────────${RESET}"
    echo -e "${GREEN}✅ 脚本完成: $script_name${RESET}"
    echo ""
    
    # 清理临时文件
    rm -f "$local_path"
}

# =============================================================================
# 脚本执行部分
# =============================================================================

# ───── 脚本执行提示 ─────
echo -e "${BOLD}${MAGENTA}════════════════════════════════════════════════════════════════${RESET}"
echo -e "${BOLD}${CYAN}📜 开始执行预设脚本组${RESET}"
echo -e "${BOLD}${MAGENTA}════════════════════════════════════════════════════════════════${RESET}"
echo ""

# 定义要执行的脚本列表
SCRIPTS=(
    "preset-setup.sh"
    "preset-terminal-tools.sh" 
    "preset-clash-core.sh"
    "preset-adguard-core.sh"
)

# 依次执行每个脚本
for script in "${SCRIPTS[@]}"; do
    echo -e "${BOLD}${YELLOW}▶ 处理脚本: $script${RESET}"
    download_and_execute_script "$script"
done

# ───── 完成信息 ─────
echo -e "${BOLD}${MAGENTA}════════════════════════════════════════════════════════════════${RESET}"
echo -e "${BOLD}${GREEN}🎉 所有预设脚本执行完成！${RESET}"
echo -e "${BOLD}${CYAN}✅ 编译环境初始化成功${RESET}"
echo -e "${BOLD}${MAGENTA}════════════════════════════════════════════════════════════════${RESET}"
echo ""
echo -e "${BOLD}${BLUE}📋 执行完成脚本:${RESET}"
for script in "${SCRIPTS[@]}"; do
    echo -e "  ${GREEN}✓${RESET} $script"
done
echo ""
echo -e "${BOLD}${YELLOW}🕐 完成时间: $(date '+%Y-%m-%d %H:%M:%S')${RESET}"
echo ""

