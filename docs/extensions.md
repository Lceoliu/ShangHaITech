# Extension Contract

为了支持后续开放接口和社区贡献，仓库预留了 `extensions/` 目录。

目标：

- 贡献者能在不侵入核心骨架的前提下添加功能
- 平台可以在审核后选择启用某个扩展
- 扩展的 UI、API、任务类型都通过 manifest 暴露

## 目录约定

```text
extensions/
  your_extension/
    extension.json
    README.md
```

## Manifest 字段

```json
{
  "key": "hello-world",
  "name": "Hello World",
  "description": "Example extension manifest",
  "version": "0.1.0",
  "enabled": false,
  "required_role": "user",
  "web": {
    "entry_path": "/extensions/hello-world"
  },
  "api": {
    "base_path": "/api/v1/extensions/hello-world"
  },
  "jobs": ["hello.run"],
  "owner": "community"
}
```

## 当前阶段实现

- API 会扫描 `extensions/*/extension.json`
- 提供扩展发现接口，供前端和未来的管理后台读取
- Manifest 暂不执行动态 Python 代码，也不自动挂载 router

## 后续建议

1. 为 manifest 增加 JSON Schema 校验
2. 为扩展接入签名、审核和启用流程
3. 将扩展任务映射到受控的沙箱执行器
4. 提供 SDK，约束前端卡片、后端 router、任务 handler 的导出格式
