# 发布说明

Release 由维护者负责。社区贡献者不直接发布正式安装包。

## 版本号

建议 tag 格式：

```text
mobile-vYYYY.MM.DD.N
api-vYYYY.MM.DD.N
prod-vYYYY.MM.DD.N
```

示例：

```text
mobile-v2026.04.20.1
prod-v2026.04.20.1
```

## Android APK

维护者会从私有生产仓库构建正式 APK：

```bash
cd mobile
flutter clean
flutter pub get
flutter build apk --release --dart-define=API_BASE_URL=<production-api-base-url>
```

常见产物路径：

```text
mobile/build/app/outputs/flutter-apk/app-release.apk
```

上传到 GitHub Releases 前，应至少确认：

- API base URL 指向正确环境
- app icon、version name 和 version code 正确
- 登录、首页、课程、邮件、个人页等核心路径通过 smoke test
- APK 中没有编译进开发环境 endpoint
- release notes 写清楚已知问题、兼容性和回滚建议

## 手动上传 GitHub Release

1. 创建或选择 release tag。
2. 手动上传 APK。
3. 条件允许时附 checksum。
4. 写清兼容性、已知问题和回滚说明。
5. 除非存在安全原因，不要移除旧稳定 APK。

## 公开源码与安装包

公开仓库是社区协作子集。正式 APK 可能来自私有生产仓库，并经过额外配置、签名和测试流程。公开源码贡献被合并后，也不代表会立刻进入正式发布版本。
