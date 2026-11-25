## 第三方库引入信息

### 7-Zip
- **上游仓库**：https://github.com/ip7z/7zip.git
- **许可证**：混合许可，请参阅 [7-Zip 自带的许可证文件](./7zip/DOC/License.txt)。
- **提交 ID**：`d3296e39e1f1f92c7b41c0c3848e65640428d42d`
- **提交日期**：Sat Nov 7 00:00:00 2026 +0000
- **检出日期**：Wed Nov 25 00:25:02 2026 -0600
- **修改内容**：已移除其中的非自由部分（受 unRAR 许可限制的代码）：
  - 删除了 `CPP/7zip/Compress/Rar1Decoder.*`、`Rar2Decoder.*`、`Rar3Decoder.*`、`Rar3Vm.*`、`Rar5Decoder.*`、`RarCodecsRegister.cpp` 以及 `DOC/unRarLicense.txt`。
  - 从 `CPP/7zip/7zip_gcc.mak`、`CPP/7zip/Bundles/Format7zF/Arc.mak`、`Arc_gcc.mak`（现在始终设置 `DISABLE_RAR_COMPRESS=1`）和 `Format7z.dsp` 中移除了对上述文件的引用。
  - 相应更新了 `DOC/License.txt` 和 `DOC/readme.txt`。
  - 按 GNU LGPL 2.1 第 2(b) 条的要求，在上述每个被修改的文件中加入了带日期的修改说明。
  - 保留了采用 LGPL 许可的 RAR 归档处理代码（`CPP/7zip/Archive/Rar`）和 RAR 加密代码（`CPP/7zip/Crypto/Rar*`），因此仍可识别 RAR 归档并列出其内容，但无法解压。

### libarchive
- **上游仓库**：https://github.com/libarchive/libarchive.git
- **许可证**：主要为 BSD 2-clause 许可证，少数文件采用其他许可证，请参阅 [libarchive 自带的许可证文件](./libarchive/COPYING)。
- **标签**：`v3.8.11`
- **提交 ID**：`03036ffa409a2aa1c5bbad35be2202641a040fda`
- **提交日期**：Fri Oct 30 21:32:39 2026 +0100
- **检出日期**：Wed Nov 25 01:01:51 2026 -0600
- **修改内容**：源代码和文档按原样引入，未作修改。

### Abseil
- **上游仓库**：https://github.com/abseil/abseil-cpp.git
- **许可证**：Apache License 2.0，`absl/time/internal/cctz` 下少数时区文件属于公有领域，请参阅 [Abseil 自带的许可证文件](./abseil-cpp/LICENSE)。
- **标签**：`20260817.0`（LTS）
- **提交 ID**：`2065f4ded0558c6f89fee67c8e5228feb4eb960e`
- **提交日期**：Tue Aug 18 08:53:30 2026 -0400
- **检出日期**：Wed Nov 25 01:19:37 2026 -0600
- **修改内容**：源代码和文档按原样引入，未作修改。
