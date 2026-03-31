# Agent Skills Collection

这是一个通用的 `agent skills` 仓库，用于集中管理和分发可复用的技能包（skills）。

## 项目

本项目提供一套标准化的 skills 目录结构与安装方式，便于将技能从仓库分发到不同 AI Agent 环境。

## 用法

- 统一维护技能内容与版本
- 支持团队共享与复用
- 支持跨环境安装（以本机 `skills` CLI 支持的 agent 为准）
- 支持通过 GitHub 仓库地址直接安装

## 使用方式

### 1）查看可用 skills

```bash
npx skills add https://github.com/TaueFenCheng/taue-skills --list
```

### 2）安装单个 skill

```bash
npx skills add https://github.com/TaueFenCheng/taue-skills --skill <skill-name>
```

### 3）安装全部 skills

```bash
npx skills add https://github.com/TaueFenCheng/taue-skills --skill "*"
```

### 4）可选参数

- `-a, --agent`：指定目标 agent（可选）
- `-y, --yes`：跳过交互确认（可选）

示例：

```bash
npx skills add https://github.com/TaueFenCheng/taue-skills --skill <skill-name> -a <agent-name> -y
```

## 本地脚本（可选）

项目提供本地安装脚本，适用于离线或本地调试场景：

- `./scripts/install-skill.sh <skill-name|skill-path>`
- `./scripts/install-all.sh`
- `./scripts/uninstall-skill.sh <skill-name>`

可通过环境变量 `SKILLS_TARGET_ROOT` 指定安装目录。