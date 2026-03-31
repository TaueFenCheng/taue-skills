# 🤖 Agent Skills Collection

<div align="center">

![GitHub](https://img.shields.io/github/license/TaueFenCheng/taue-skills?label=MIT)
![GitHub stars](https://img.shields.io/github/stars/TaueFenCheng/taue-skills?style=flat)
![GitHub issues](https://img.shields.io/github/issues/TaueFenCheng/taue-skills)
![GitHub last commit](https://img.shields.io/github/last-commit/TaueFenCheng/taue-skills)

这是一个通用的 **agent skills** 仓库，用于集中管理和分发可复用的技能包（skills）。

</div>

---

## 📖 简介

本项目提供一套标准化的 skills 目录结构与安装方式，便于将技能从仓库分发到不同 AI Agent 环境。

✨ **特性：**
- 📦 统一维护技能内容与版本
- 🔄 支持团队共享与复用
- 🌍 支持跨环境安装
- 🚀 支持通过 GitHub 仓库地址直接安装

---

## 🚀 用法

### 方式一：使用 Makefile（推荐）

项目提供 Makefile 编排常用操作：

| 命令 | 说明 | 图标 |
|:-----|:-----|:-----:|
| `make help` | 查看可用命令 | 📋 |
| `make list` | 列出所有可用的 skills | 📚 |
| `make install-all` | 安装所有 skills | 📥 |
| `make install skill=<name>` | 安装单个 skill | ➕ |
| `make uninstall skill=<name>` | 卸载指定 skill | ➖ |
| `make status` | 查看安装状态 | 📊 |
| `make lint` | 验证 skills 格式 | ✅ |
| `make new name=<name>` | 创建新的 skill 模板 | 🆕 |
| `make clean` | 清理所有已安装的 skills | 🧹 |

```bash
# 自定义安装目录
make TARGET_ROOT=/custom/path install-all
```

---

### 方式二：使用 npx skills CLI

通过 GitHub 仓库地址安装：

```bash
# 📋 查看可用 skills
npx skills add https://github.com/TaueFenCheng/taue-skills --list

# ➕ 安装单个 skill
npx skills add https://github.com/TaueFenCheng/taue-skills --skill <skill-name>

# 📥 安装全部 skills
npx skills add https://github.com/TaueFenCheng/taue-skills --skill "*"
```

**可选参数：**

| 参数 | 说明 |
|:-----|:-----|
| `-a, --agent` | 指定目标 agent（可选） |
| `-y, --yes` | 跳过交互确认（可选） |

```bash
# 💡 示例：静默安装到指定 agent
npx skills add https://github.com/TaueFenCheng/taue-skills --skill <skill-name> -a <agent-name> -y
```

---

### 方式三：本地脚本（可选）

项目提供本地安装脚本，适用于离线或本地调试场景：

```bash
# 📥 安装所有 skills
./scripts/install-all.sh

# ➕ 安装单个 skill
./scripts/install-skill.sh <skill-name>

# ➖ 卸载指定 skill
./scripts/uninstall-skill.sh <skill-name>
```

可通过环境变量 `SKILLS_TARGET_ROOT` 指定安装目录：

```bash
SKILLS_TARGET_ROOT=/custom/path ./scripts/install-all.sh
```

---

## 📁 目录结构

```
taue-skills/
├── 📂 skills/                  # Skills 目录
│   ├── 📂 fetch-request-taue-practices/
│   │   └── 📄 SKILL.md
│   └── 📂 zustand-store-taue-practices/
│       └── 📄 SKILL.md
├── 📂 scripts/                 # 安装脚本
│   ├── install-all.sh
│   ├── install-skill.sh
│   └── uninstall-skill.sh
├── 📄 Makefile                 # Makefile 编排
└── 📄 README.md                # 项目文档
```

---

## 📝 许可证

<div align="center">

[MIT License](LICENSE) © 2026 TaueFenCheng

</div>
