## Vendored Third Party Library Info

### 7-Zip
- **Upstream**: https://github.com/ip7z/7zip.git
- **License**: Mixed, please refer to [7Zip's own license file](./7zip/DOC/License.txt).
- **Commit ID**: `d3296e39e1f1f92c7b41c0c3848e65640428d42d`
- **Commit date**: Sat Nov 7 00:00:00 2026 +0000
- **Checkout date**: Wed Nov 25 00:25:02 2026 -0600
- **Modification**: The non-free parts (code under the unRAR license restriction) have been removed:
  - Deleted `CPP/7zip/Compress/Rar1Decoder.*`, `Rar2Decoder.*`, `Rar3Decoder.*`, `Rar3Vm.*`, `Rar5Decoder.*`, `RarCodecsRegister.cpp` and `DOC/unRarLicense.txt`.
  - Removed references to them from `CPP/7zip/7zip_gcc.mak`, `CPP/7zip/Bundles/Format7zF/Arc.mak`, `Arc_gcc.mak` (now always sets `DISABLE_RAR_COMPRESS=1`) and `Format7z.dsp`.
  - Updated `DOC/License.txt` and `DOC/readme.txt` accordingly.
  - The LGPL RAR archive handlers (`CPP/7zip/Archive/Rar`) and RAR crypto code (`CPP/7zip/Crypto/Rar*`) are kept, so RAR archives can still be detected and listed, but not extracted.

### libarchive
- **Upstream**: https://github.com/libarchive/libarchive.git
- **License**: Mainly the BSD 2-clause License, with a few files under other licenses, please refer to [libarchive's own license file](./libarchive/COPYING).
- **Tag**: `v3.8.11`
- **Commit ID**: `03036ffa409a2aa1c5bbad35be2202641a040fda`
- **Commit date**: Fri Oct 30 21:32:39 2026 +0100
- **Checkout date**: Wed Nov 25 01:01:51 2026 -0600
- **Modification**: The source code and documentations are vendored as-is.
