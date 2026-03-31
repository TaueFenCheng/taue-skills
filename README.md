# Agent Skills Collection

这是一个通用的 `agent skills` 仓库，用于集中管理和分发可复用的技能包（skills）。

## 项目

本项目提供一套标准化的 skills 目录结构与安装方式，便于将技能从仓库分发到不同 AI Agent 环境。

## 用法

### 方式一：使用 Makefile（推荐）

项目提供 Makefile 编排常用操作：

```bash
# 查看可用命令
make help

# 列出所有可用的 skills
make list

# 安装所有 skills
make install-all

# 安装单个 skill
make install skill=<skill-name>

# 卸载指定 skill
make uninstall skill=<skill-name>

# 查看安装状态
make status

# 验证 skills 格式
make lint

# 创建新的 skill 模板
make new name=<skill-name>

# 自定义安装目录
make TARGET_ROOT=/custom/path install-all
```

### 方式二：使用 npx skills CLI

通过 GitHub 仓库地址安装：

```bash
# 查看可用 skills
npx skills add https://github.com/TaueFenCheng/taue-skills --list

# 安装单个 skill
npx skills add https://github.com/TaueFenCheng/taue-skills --skill <skill-name>

# 安装全部 skills
npx skills add https://github.com/TaueFenCheng/taue-skills --skill "*"
```

可选参数：

- `-a, --agent`：指定目标 agent（可选）
- `-y, --yes`：跳过交互确认（可选）

示例：

```bash
npx skills add https://github.com/TaueFenCheng/taue-skills --skill <skill-name> -a <agent-name> -y
```

### 方式三：本地脚本（可选）

项目提供本地安装脚本，适用于离线或本地调试场景：

```bash
# 安装所有 skills
./scripts/install-all.sh

# 安装单个 skill
./scripts/install-skill.sh <skill-name>

# 卸载指定 skill
./scripts/uninstall-skill.sh <skill-name>
```

可通过环境变量 `SKILLS_TARGET_ROOT` 指定安装目录：

```bash
SKILLS_TARGET_ROOT=/custom/path ./scripts/install-all.sh
```