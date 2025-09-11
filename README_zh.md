# iOS 二维码生成器

基于 SwiftUI 的 iOS 应用程序，用于生成可自定义的二维码，具有高级功能。

## 功能特性

- 从文本或 URL 生成二维码
- 向二维码添加图片覆盖层
- 调整覆盖层大小和位置
- 控制二维码分辨率（1x 到 30x）
- 全屏预览模式
- 以 PNG 格式保存二维码
- 与其他应用分享二维码

## 截图

![二维码生成器](screenshots/QRCode.png)

![iosdevlog](screenshots/iosdevlog.png)

## 安装

1. 克隆仓库：
   ```bash
   git clone https://github.com/buld-your-own-x-with-ai/QRCode
   ```

2. 在 Xcode 中打开 `QrCode_iOS.xcodeproj`

3. 构建并运行项目

## 系统要求

- iOS 14.0+
- Xcode 12.0+
- Swift 5.0+

## 使用方法

1. 在输入框中输入文本或 URL
2. （可选）点击"选择图片"添加覆盖图像
3. 使用滑块调整覆盖层大小
4. 使用分辨率滑块设置所需的分辨率
5. 点击"生成二维码"创建二维码
6. 点击二维码可在全屏模式下查看
7. 使用"保存"将二维码保存到照片库（保存为 PNG 格式）
8. 使用"分享"将二维码分享给其他应用

## 自定义选项

### 覆盖图像
- 点击"选择图片"从照片库中选择图像
- 使用滑块调整覆盖层大小（占二维码大小的 5% 到 50%）
- 点击"移除"清除选定的覆盖图像

### 分辨率控制
- 使用分辨率滑块控制生成二维码的质量
- 值范围从 1x（较低质量）到 30x（较高质量）
- 更高的分辨率值会创建更大、更详细的二维码

## 技术细节

### 架构
应用采用模块化结构，包含以下组件：
- `QRCodeGenerator.swift`：使用 CoreImage 处理二维码生成
- `ContentView.swift`：包含所有 UI 元素的主 SwiftUI 视图
- `QRCodeView.swift`：专门用于显示二维码的视图

### 二维码生成
- 使用 CoreImage 的 `CIQRCodeGenerator` 滤镜
- 支持可自定义的错误纠正级别
- 生成无损 PNG 图像

### 图像覆盖
- 使用 UIGraphicsImageRenderer 将基础二维码与覆盖图像组合
- 保持覆盖图像的宽高比
- 将覆盖图像定位在二维码中心

## 贡献

1. Fork 仓库
2. 创建功能分支
3. 提交更改
4. 推送到分支
5. 创建拉取请求

## 许可证

该项目采用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件了解详情。

## 远程仓库

项目托管地址：https://github.com/buld-your-own-x-with-ai/QRCode