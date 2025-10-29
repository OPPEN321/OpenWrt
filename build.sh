#!/bin/bash

# 定义颜色
RESET='\033[0m'
BOLD='\033[1m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
MAGENTA='\033[1;35m'
WHITE='\033[1;37m'

CPU_CORES=$(nproc)

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

# ───── 执行自定义脚本组 ─────
CUSTOM_SCRIPTS=(
    "$GITHUB_WORKSPACE/scripts/preset-clash-core.sh $CLASH_KERNEL"
    "$GITHUB_WORKSPACE/scripts/preset-terminal-tools.sh"
    "$GITHUB_WORKSPACE/scripts/preset-adguard-core.sh $CLASH_KERNEL"
)

for script_cmd in "${CUSTOM_SCRIPTS[@]}"; do
    # 提取脚本文件名作为显示
    script_name=$(echo $script_cmd | awk '{print $1}' | xargs basename)

    if [ -f "$GITHUB_WORKSPACE/$script_name" ] || [[ "$script_name" == *.sh ]]; then
        echo -e "${BOLD}${YELLOW}📝 正在执行脚本: $script_name ...${RESET}"
        eval "$script_cmd"
        if [ $? -eq 0 ]; then
            echo -e "${BOLD}${GREEN}✅ $script_name 执行完成${RESET}"
        else
            echo -e "${BOLD}${RED}❌ $script_name 执行失败${RESET}"
            exit 1
        fi
        echo ""
    else
        echo -e "${BOLD}${RED}⚠️  脚本 $script_name 不存在，跳过执行${RESET}"
        echo ""
    fi
done

# ───── 开始构建提示 ─────
echo -e "${BOLD}${GREEN}✨ 开始编译 ZeroWrt 固件，请耐心等待...${RESET}"
echo ""
