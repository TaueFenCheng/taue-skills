# Taue Skills Makefile
# 用于编排 skills 相关操作

SHELL := /bin/bash
SKILLS_DIR := $(shell pwd)/skills
TARGET_ROOT ?= $(HOME)/.claude/skills

# 彩色输出
COLOR_RESET := \033[0m
COLOR_GREEN := \033[32m
COLOR_BLUE  := \033[34m
COLOR_YELLOW := \033[33m

# 默认目标
.DEFAULT_GOAL := help

# 显示帮助信息
.PHONY: help
help:
	@echo "$(COLOR_BLUE)Taue Skills Makefile$(COLOR_RESET)"
	@echo ""
	@echo "$(COLOR_YELLOW)用法:$(COLOR_RESET)"
	@echo "  make <target> [args]"
	@echo ""
	@echo "$(COLOR_YELLOW)可用命令:$(COLOR_RESET)"
	@echo "  install-all           安装所有 skills"
	@echo "  install skill=<name>  安装指定 skill"
	@echo "  uninstall skill=<name> 卸载指定 skill"
	@echo "  list                  列出所有可用的 skills"
	@echo "  clean                 清理所有已安装的 skills"
	@echo "  status                查看已安装的 skills 状态"
	@echo "  watch                 监听 skills 变化并自动同步"
	@echo "  help                  显示帮助信息"
	@echo ""
	@echo "$(COLOR_YELLOW)示例:$(COLOR_RESET)"
	@echo "  make install-all"
	@echo "  make install skill=fetch-request-taue-practices"
	@echo "  make uninstall skill=fetch-request-taue-practices"
	@echo "  make TARGET_ROOT=/custom/path install-all"

# 安装所有 skills
.PHONY: install-all
install-all:
	@echo "$(COLOR_BLUE)正在安装所有 skills...$(COLOR_RESET)"
	@bash scripts/install-all.sh
	@echo "$(COLOR_GREEN)完成!$(COLOR_RESET)"

# 安装指定 skill
.PHONY: install
install:
ifndef skill
	@echo "$(COLOR_YELLOW)用法:make install skill=<skill-name>$(COLOR_RESET)"
	@echo "$(COLOR_BLUE)可用的 skills:$(COLOR_RESET)"
	@ls -1 $(SKILLS_DIR)
	@exit 1
endif
	@echo "$(COLOR_BLUE)正在安装 skill: $(skill)$(COLOR_RESET)"
	@bash scripts/install-skill.sh $(skill)
	@echo "$(COLOR_GREEN)完成!$(COLOR_RESET)"

# 卸载指定 skill
.PHONY: uninstall
uninstall:
ifndef skill
	@echo "$(COLOR_YELLOW)用法:make uninstall skill=<skill-name>$(COLOR_RESET)"
	@exit 1
endif
	@echo "$(COLOR_BLUE)正在卸载 skill: $(skill)$(COLOR_RESET)"
	@bash scripts/uninstall-skill.sh $(skill)
	@echo "$(COLOR_GREEN)完成!$(COLOR_RESET)"

# 列出所有可用的 skills
.PHONY: list
list:
	@echo "$(COLOR_BLUE)可用的 skills:$(COLOR_RESET)"
	@ls -1 $(SKILLS_DIR) | while read name; do \
		if [[ -f "$(SKILLS_DIR)/$$name/SKILL.md" ]]; then \
			desc=$$(grep -m1 "^description:" "$(SKILLS_DIR)/$$name/SKILL.md" 2>/dev/null | cut -d':' -f2- | xargs); \
			echo "  $(COLOR_GREEN)$$name$(COLOR_RESET)$$([[ -n "$$desc" ]] && echo " - $$desc")"; \
		fi; \
	done

# 清理所有已安装的 skills
.PHONY: clean
clean:
	@echo "$(COLOR_YELLOW)正在清理所有已安装的 skills...$(COLOR_RESET)"
	@rm -rf $(TARGET_ROOT)/*
	@echo "$(COLOR_GREEN)清理完成!$(COLOR_RESET)"

# 查看已安装的 skills 状态
.PHONY: status
status:
	@echo "$(COLOR_BLUE)已安装的 skills:$(COLOR_RESET)"
	@if [[ -d "$(TARGET_ROOT)" ]]; then \
		ls -1 $(TARGET_ROOT) 2>/dev/null | while read name; do \
			echo "  $(COLOR_GREEN)$$name$(COLOR_RESET)"; \
		done || echo "  (无)"; \
	else \
		echo "  (目录不存在：$(TARGET_ROOT))"; \
	fi
	@echo ""
	@echo "$(COLOR_BLUE)本地 skills:$(COLOR_RESET)"
	@ls -1 $(SKILLS_DIR) | wc -l | xargs -I {} echo "  共 {} 个"

# 监听 skills 变化并自动同步 (需要 fswatch)
.PHONY: watch
watch:
	@echo "$(COLOR_BLUE)开始监听 skills 目录变化...$(COLOR_RESET)"
	@command -v fswatch >/dev/null 2>&1 || { \
		echo "$(COLOR_YELLOW)需要安装 fswatch: brew install fswatch (macOS) 或 apt-get install fswatch (Linux)$(COLOR_RESET)"; \
		exit 1; \
	}
	@fswatch -r $(SKILLS_DIR) | while read event; do \
		echo "$(COLOR_BLUE)检测到变化，重新安装所有 skills...$(COLOR_RESET)"; \
		bash scripts/install-all.sh; \
	done

# 验证所有 skills 格式
.PHONY: lint
lint:
	@echo "$(COLOR_BLUE)验证 skills 格式...$(COLOR_RESET)"
	@error=0; \
	for dir in $(SKILLS_DIR)/*; do \
		if [[ -d "$$dir" ]]; then \
			if [[ ! -f "$$dir/SKILL.md" ]]; then \
				echo "$(COLOR_YELLOW)警告：$$dir 缺少 SKILL.md$(COLOR_RESET)"; \
				error=1; \
			fi; \
		fi; \
	done; \
	if [[ $$error -eq 0 ]]; then \
		echo "$(COLOR_GREEN)所有 skills 格式正确!$(COLOR_RESET)"; \
	fi

# 创建新的 skill 模板
.PHONY: new
new:
ifndef name
	@echo "$(COLOR_YELLOW)用法:make new name=<skill-name>$(COLOR_RESET)"
	@exit 1
endif
	@mkdir -p $(SKILLS_DIR)/$(name)
	@echo '---' > $(SKILLS_DIR)/$(name)/SKILL.md
	@echo 'name: $(name)' >> $(SKILLS_DIR)/$(name)/SKILL.md
	@echo 'description: <skill 描述>' >> $(SKILLS_DIR)/$(name)/SKILL.md
	@echo '---' >> $(SKILLS_DIR)/$(name)/SKILL.md
	@echo '' >> $(SKILLS_DIR)/$(name)/SKILL.md
	@echo '# $(name) 使用规范' >> $(SKILLS_DIR)/$(name)/SKILL.md
	@echo '' >> $(SKILLS_DIR)/$(name)/SKILL.md
	@echo '## 适用范围' >> $(SKILLS_DIR)/$(name)/SKILL.md
	@echo '' >> $(SKILLS_DIR)/$(name)/SKILL.md
	@echo '## 核心原则' >> $(SKILLS_DIR)/$(name)/SKILL.md
	@echo '' >> $(SKILLS_DIR)/$(name)/SKILL.md
	@echo '## 最佳实践' >> $(SKILLS_DIR)/$(name)/SKILL.md
	@echo "$(COLOR_GREEN)已创建 skill 模板：$(SKILLS_DIR)/$(name)/SKILL.md$(COLOR_RESET)"
	@echo "$(COLOR_BLUE)编辑文件并开始开发!$(COLOR_RESET)"
