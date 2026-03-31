# Heytea Store Skill

Zustand Store 使用规范技能 - 喜茶智能选址平台

## 技能描述

本技能定义了 Zustand Store 在项目中的使用规范，包括：

- 组件中消费 store 状态
- 调用 store 中的方法
- Store 的创建规范（传统模式 和 Slice 模式）
- 使用 subscribeWithSelector 进行订阅

## 使用方法

将 `SKILL.md` 文件复制到你的 Claude Code skills 目录：

```bash
cp SKILL.md ~/.claude/skills/heytea-store/
```

## 核心内容

### 组件中使用 Store 的正确方式

**必须使用 `useShallow` 解构使用**，禁止在组件中直接使用 `getState()` 获取值。

```typescript
import { useCustomLayerStore } from '@/store/models/useCustomLayerStore'
import { useShallow } from 'zustand/shallow'

const { fetchLayerData, layerOptions } = useCustomLayerStore(
  useShallow((state) => ({
    fetchLayerData: state.fetchLayerData,
    layerOptions: state.layerOptions,
  })),
)
```

### 两种 Store 模式

1. **传统单 Store 模式** - 适用于小型项目/简单功能
2. **Slice 模式** - 适用于中大型项目/多模块

### subscribeWithSelector 订阅

用于在非 React 组件场景中订阅特定状态的变化。

## License

Private
