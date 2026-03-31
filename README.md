# Agent Skills Collection

可复用的通用 `agent skills` 仓库，支持通过 `npx skills add` 安装到不同 AI Agent 环境（如 Claude Code、Cursor、Codex、Gemini，具体以本机 `skills` CLI 支持的 agent 名称为准）。

## 当前包含

- `zustand-store-best-practices`：Zustand Store 使用规范（`useShallow`、`getState` 边界、传统模式与 Slice 模式、`subscribeWithSelector`）

## 目录结构

```text
skills/
  zustand-store-best-practices/
    SKILL.md
scripts/
  install-skill.sh
  uninstall-skill.sh
  install-all.sh
```

## 推荐安装方式（npx）

仓库地址：`https://github.com/TaueFenCheng/taue-skills`

### 查看可用 skills

```bash
npx skills add https://github.com/TaueFenCheng/taue-skills --list
```

### 安装单个 skill（通用）

```bash
npx skills add https://github.com/TaueFenCheng/taue-skills --skill zustand-store-best-practices
```

### 安装全部 skills（通用）

```bash
npx skills add https://github.com/TaueFenCheng/taue-skills --skill "*"
```

## 参数说明

- `-a, --agent`：可选。指定安装目标 agent。仅在你需要明确目标时传入。  
  示例（按本机支持名称调整）：

```bash
npx skills add https://github.com/TaueFenCheng/taue-skills --skill zustand-store-best-practices -a claude-code
npx skills add https://github.com/TaueFenCheng/taue-skills --skill zustand-store-best-practices -a cursor
npx skills add https://github.com/TaueFenCheng/taue-skills --skill zustand-store-best-practices -a codex
npx skills add https://github.com/TaueFenCheng/taue-skills --skill zustand-store-best-practices -a gemini
```

- `-y, --yes`：可选。跳过交互确认，适合 CI 或批量安装。

## 本地脚本安装（可选）

本地脚本默认安装到 `~/.claude/skills`，也支持通过环境变量 `SKILLS_TARGET_ROOT` 指定任意目标目录。

### 安装单个 skill

```bash
cd /Users/heytea/code/taue-skills
./scripts/install-skill.sh zustand-store-best-practices
```

### 安装全部 skills

```bash
cd /Users/heytea/code/taue-skills
./scripts/install-all.sh
```

### 指定目标目录安装（示例）

```bash
cd /Users/heytea/code/taue-skills
SKILLS_TARGET_ROOT=~/.cursor/skills ./scripts/install-skill.sh zustand-store-best-practices
```

## 卸载

```bash
cd /Users/heytea/code/taue-skills
./scripts/uninstall-skill.sh zustand-store-best-practices
```

## 分发给他人

1. 保持仓库公开。
2. 告知使用者执行 `npx skills add https://github.com/TaueFenCheng/taue-skills --skill <name>`。
3. 更新 skill 后，使用者重新执行安装命令即可覆盖升级。