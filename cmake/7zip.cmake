# Copyright (C) 2026 CharOfString <root@charofstring.cc>
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
#this program. If not, see <https://www.gnu.org/licenses/>.
# -----------------------------------------------------------------------------
# Builds the vendored 7-Zip (lib/7zip) as the static library gxde_roller_7zip.
# NOTE: For the non-free RAR handler (with unRAR restrictions), we dropped
#       corresponding source code from 7-zip so that the vendored library is
#       compactiable with our own license.

set(GXDE_ROLLER_7ZIP_DIR "${PROJECT_SOURCE_DIR}/lib/7zip")

set(GXDE_ROLLER_7ZIP_SOURCES
  C/7zBuf2.c
  C/7zCrc.c
  C/7zCrcOpt.c
  C/7zStream.c
  C/Aes.c
  C/AesOpt.c
  C/Alloc.c
  C/Bcj2.c
  C/Bcj2Enc.c
  C/Blake2s.c
  C/Bra.c
  C/Bra86.c
  C/BraIA64.c
  C/BwtSort.c
  C/CpuArch.c
  C/Delta.c
  C/HuffEnc.c
  C/LzFind.c
  C/LzFindMt.c
  C/LzFindOpt.c
  C/Lzma2Dec.c
  C/Lzma2DecMt.c
  C/Lzma2Enc.c
  C/LzmaDec.c
  C/LzmaEnc.c
  C/Md5.c
  C/MtCoder.c
  C/MtDec.c
  C/Ppmd7.c
  C/Ppmd7Dec.c
  C/Ppmd7Enc.c
  C/Ppmd7aDec.c
  C/Ppmd8.c
  C/Ppmd8Dec.c
  C/Ppmd8Enc.c
  C/Sha1.c
  C/Sha1Opt.c
  C/Sha256.c
  C/Sha256Opt.c
  C/Sha3.c
  C/Sha512.c
  C/Sha512Opt.c
  C/Sort.c
  C/SwapBytes.c
  C/Threads.c
  C/Xxh64.c
  C/Xz.c
  C/XzCrc64.c
  C/XzCrc64Opt.c
  C/XzDec.c
  C/XzEnc.c
  C/XzIn.c
  C/ZstdDec.c
  CPP/7zip/Archive/7z/7zCompressionMode.cpp
  CPP/7zip/Archive/7z/7zDecode.cpp
  CPP/7zip/Archive/7z/7zEncode.cpp
  CPP/7zip/Archive/7z/7zExtract.cpp
  CPP/7zip/Archive/7z/7zFolderInStream.cpp
  CPP/7zip/Archive/7z/7zHandler.cpp
  CPP/7zip/Archive/7z/7zHandlerOut.cpp
  CPP/7zip/Archive/7z/7zHeader.cpp
  CPP/7zip/Archive/7z/7zIn.cpp
  CPP/7zip/Archive/7z/7zOut.cpp
  CPP/7zip/Archive/7z/7zProperties.cpp
  CPP/7zip/Archive/7z/7zRegister.cpp
  CPP/7zip/Archive/7z/7zSpecStream.cpp
  CPP/7zip/Archive/7z/7zUpdate.cpp
  CPP/7zip/Archive/ApfsHandler.cpp
  CPP/7zip/Archive/ApmHandler.cpp
  CPP/7zip/Archive/ArHandler.cpp
  CPP/7zip/Archive/ArchiveExports.cpp
  CPP/7zip/Archive/ArjHandler.cpp
  CPP/7zip/Archive/Base64Handler.cpp
  CPP/7zip/Archive/Bz2Handler.cpp
  CPP/7zip/Archive/Cab/CabBlockInStream.cpp
  CPP/7zip/Archive/Cab/CabHandler.cpp
  CPP/7zip/Archive/Cab/CabHeader.cpp
  CPP/7zip/Archive/Cab/CabIn.cpp
  CPP/7zip/Archive/Cab/CabRegister.cpp
  CPP/7zip/Archive/Chm/ChmHandler.cpp
  CPP/7zip/Archive/Chm/ChmIn.cpp
  CPP/7zip/Archive/ComHandler.cpp
  CPP/7zip/Archive/Common/CoderMixer2.cpp
  CPP/7zip/Archive/Common/DummyOutStream.cpp
  CPP/7zip/Archive/Common/FindSignature.cpp
  CPP/7zip/Archive/Common/HandlerOut.cpp
  CPP/7zip/Archive/Common/InStreamWithCRC.cpp
  CPP/7zip/Archive/Common/ItemNameUtils.cpp
  CPP/7zip/Archive/Common/MultiStream.cpp
  CPP/7zip/Archive/Common/OutStreamWithCRC.cpp
  CPP/7zip/Archive/Common/OutStreamWithSha1.cpp
  CPP/7zip/Archive/Common/ParseProperties.cpp
  CPP/7zip/Archive/CpioHandler.cpp
  CPP/7zip/Archive/CramfsHandler.cpp
  CPP/7zip/Archive/DeflateProps.cpp
  CPP/7zip/Archive/DllExports2.cpp
  CPP/7zip/Archive/DmgHandler.cpp
  CPP/7zip/Archive/ElfHandler.cpp
  CPP/7zip/Archive/ExtHandler.cpp
  CPP/7zip/Archive/FatHandler.cpp
  CPP/7zip/Archive/FlvHandler.cpp
  CPP/7zip/Archive/GptHandler.cpp
  CPP/7zip/Archive/GzHandler.cpp
  CPP/7zip/Archive/HandlerCont.cpp
  CPP/7zip/Archive/HfsHandler.cpp
  CPP/7zip/Archive/IhexHandler.cpp
  CPP/7zip/Archive/Iso/IsoHandler.cpp
  CPP/7zip/Archive/Iso/IsoHeader.cpp
  CPP/7zip/Archive/Iso/IsoIn.cpp
  CPP/7zip/Archive/Iso/IsoRegister.cpp
  CPP/7zip/Archive/LpHandler.cpp
  CPP/7zip/Archive/LzhHandler.cpp
  CPP/7zip/Archive/LzmaHandler.cpp
  CPP/7zip/Archive/MachoHandler.cpp
  CPP/7zip/Archive/MbrHandler.cpp
  CPP/7zip/Archive/MslzHandler.cpp
  CPP/7zip/Archive/MubHandler.cpp
  CPP/7zip/Archive/Nsis/NsisDecode.cpp
  CPP/7zip/Archive/Nsis/NsisHandler.cpp
  CPP/7zip/Archive/Nsis/NsisIn.cpp
  CPP/7zip/Archive/Nsis/NsisRegister.cpp
  CPP/7zip/Archive/NtfsHandler.cpp
  CPP/7zip/Archive/PeHandler.cpp
  CPP/7zip/Archive/PpmdHandler.cpp
  CPP/7zip/Archive/QcowHandler.cpp
  CPP/7zip/Archive/Rar/Rar5Handler.cpp
  CPP/7zip/Archive/Rar/RarHandler.cpp
  CPP/7zip/Archive/RpmHandler.cpp
  CPP/7zip/Archive/SparseHandler.cpp
  CPP/7zip/Archive/SplitHandler.cpp
  CPP/7zip/Archive/SquashfsHandler.cpp
  CPP/7zip/Archive/SwfHandler.cpp
  CPP/7zip/Archive/Tar/TarHandler.cpp
  CPP/7zip/Archive/Tar/TarHandlerOut.cpp
  CPP/7zip/Archive/Tar/TarHeader.cpp
  CPP/7zip/Archive/Tar/TarIn.cpp
  CPP/7zip/Archive/Tar/TarOut.cpp
  CPP/7zip/Archive/Tar/TarRegister.cpp
  CPP/7zip/Archive/Tar/TarUpdate.cpp
  CPP/7zip/Archive/Udf/UdfHandler.cpp
  CPP/7zip/Archive/Udf/UdfIn.cpp
  CPP/7zip/Archive/UefiHandler.cpp
  CPP/7zip/Archive/VdiHandler.cpp
  CPP/7zip/Archive/VhdHandler.cpp
  CPP/7zip/Archive/VhdxHandler.cpp
  CPP/7zip/Archive/VmdkHandler.cpp
  CPP/7zip/Archive/Wim/WimHandler.cpp
  CPP/7zip/Archive/Wim/WimHandlerOut.cpp
  CPP/7zip/Archive/Wim/WimIn.cpp
  CPP/7zip/Archive/Wim/WimRegister.cpp
  CPP/7zip/Archive/XarHandler.cpp
  CPP/7zip/Archive/XzHandler.cpp
  CPP/7zip/Archive/ZHandler.cpp
  CPP/7zip/Archive/Zip/ZipAddCommon.cpp
  CPP/7zip/Archive/Zip/ZipHandler.cpp
  CPP/7zip/Archive/Zip/ZipHandlerOut.cpp
  CPP/7zip/Archive/Zip/ZipIn.cpp
  CPP/7zip/Archive/Zip/ZipItem.cpp
  CPP/7zip/Archive/Zip/ZipOut.cpp
  CPP/7zip/Archive/Zip/ZipRegister.cpp
  CPP/7zip/Archive/Zip/ZipUpdate.cpp
  CPP/7zip/Archive/ZstdHandler.cpp
  CPP/7zip/Common/CWrappers.cpp
  CPP/7zip/Common/CreateCoder.cpp
  CPP/7zip/Common/FilterCoder.cpp
  CPP/7zip/Common/InBuffer.cpp
  CPP/7zip/Common/InOutTempBuffer.cpp
  CPP/7zip/Common/LimitedStreams.cpp
  CPP/7zip/Common/LockedStream.cpp
  CPP/7zip/Common/MemBlocks.cpp
  CPP/7zip/Common/MethodId.cpp
  CPP/7zip/Common/MethodProps.cpp
  CPP/7zip/Common/OffsetStream.cpp
  CPP/7zip/Common/OutBuffer.cpp
  CPP/7zip/Common/OutMemStream.cpp
  CPP/7zip/Common/ProgressMt.cpp
  CPP/7zip/Common/ProgressUtils.cpp
  CPP/7zip/Common/PropId.cpp
  CPP/7zip/Common/StreamBinder.cpp
  CPP/7zip/Common/StreamObjects.cpp
  CPP/7zip/Common/StreamUtils.cpp
  CPP/7zip/Common/UniqBlocks.cpp
  CPP/7zip/Common/VirtThread.cpp
  CPP/7zip/Compress/BZip2Crc.cpp
  CPP/7zip/Compress/BZip2Decoder.cpp
  CPP/7zip/Compress/BZip2Encoder.cpp
  CPP/7zip/Compress/BZip2Register.cpp
  CPP/7zip/Compress/Bcj2Coder.cpp
  CPP/7zip/Compress/Bcj2Register.cpp
  CPP/7zip/Compress/BcjCoder.cpp
  CPP/7zip/Compress/BcjRegister.cpp
  CPP/7zip/Compress/BitlDecoder.cpp
  CPP/7zip/Compress/BranchMisc.cpp
  CPP/7zip/Compress/BranchRegister.cpp
  CPP/7zip/Compress/ByteSwap.cpp
  CPP/7zip/Compress/CodecExports.cpp
  CPP/7zip/Compress/CopyCoder.cpp
  CPP/7zip/Compress/CopyRegister.cpp
  CPP/7zip/Compress/Deflate64Register.cpp
  CPP/7zip/Compress/DeflateDecoder.cpp
  CPP/7zip/Compress/DeflateEncoder.cpp
  CPP/7zip/Compress/DeflateRegister.cpp
  CPP/7zip/Compress/DeltaFilter.cpp
  CPP/7zip/Compress/ImplodeDecoder.cpp
  CPP/7zip/Compress/LzOutWindow.cpp
  CPP/7zip/Compress/LzfseDecoder.cpp
  CPP/7zip/Compress/LzhDecoder.cpp
  CPP/7zip/Compress/Lzma2Decoder.cpp
  CPP/7zip/Compress/Lzma2Encoder.cpp
  CPP/7zip/Compress/Lzma2Register.cpp
  CPP/7zip/Compress/LzmaDecoder.cpp
  CPP/7zip/Compress/LzmaEncoder.cpp
  CPP/7zip/Compress/LzmaRegister.cpp
  CPP/7zip/Compress/LzmsDecoder.cpp
  CPP/7zip/Compress/LzxDecoder.cpp
  CPP/7zip/Compress/PpmdDecoder.cpp
  CPP/7zip/Compress/PpmdEncoder.cpp
  CPP/7zip/Compress/PpmdRegister.cpp
  CPP/7zip/Compress/PpmdZip.cpp
  CPP/7zip/Compress/QuantumDecoder.cpp
  CPP/7zip/Compress/ShrinkDecoder.cpp
  CPP/7zip/Compress/XpressDecoder.cpp
  CPP/7zip/Compress/XzDecoder.cpp
  CPP/7zip/Compress/XzEncoder.cpp
  CPP/7zip/Compress/ZDecoder.cpp
  CPP/7zip/Compress/ZlibDecoder.cpp
  CPP/7zip/Compress/ZlibEncoder.cpp
  CPP/7zip/Compress/ZstdDecoder.cpp
  CPP/7zip/Crypto/7zAes.cpp
  CPP/7zip/Crypto/7zAesRegister.cpp
  CPP/7zip/Crypto/HmacSha1.cpp
  CPP/7zip/Crypto/HmacSha256.cpp
  CPP/7zip/Crypto/MyAes.cpp
  CPP/7zip/Crypto/MyAesReg.cpp
  CPP/7zip/Crypto/Pbkdf2HmacSha1.cpp
  CPP/7zip/Crypto/RandGen.cpp
  CPP/7zip/Crypto/Rar20Crypto.cpp
  CPP/7zip/Crypto/Rar5Aes.cpp
  CPP/7zip/Crypto/RarAes.cpp
  CPP/7zip/Crypto/WzAes.cpp
  CPP/7zip/Crypto/ZipCrypto.cpp
  CPP/7zip/Crypto/ZipStrong.cpp
  CPP/Common/CRC.cpp
  CPP/Common/CrcReg.cpp
  CPP/Common/DynLimBuf.cpp
  CPP/Common/IntToString.cpp
  CPP/Common/LzFindPrepare.cpp
  CPP/Common/Md5Reg.cpp
  CPP/Common/MyMap.cpp
  CPP/Common/MyString.cpp
  CPP/Common/MyVector.cpp
  CPP/Common/MyWindows.cpp
  CPP/Common/MyXml.cpp
  CPP/Common/NewHandler.cpp
  CPP/Common/Sha1Prepare.cpp
  CPP/Common/Sha1Reg.cpp
  CPP/Common/Sha256Prepare.cpp
  CPP/Common/Sha256Reg.cpp
  CPP/Common/Sha3Reg.cpp
  CPP/Common/Sha512Prepare.cpp
  CPP/Common/Sha512Reg.cpp
  CPP/Common/StringConvert.cpp
  CPP/Common/StringToInt.cpp
  CPP/Common/UTFConvert.cpp
  CPP/Common/Wildcard.cpp
  CPP/Common/Xxh64Reg.cpp
  CPP/Common/XzCrc64Init.cpp
  CPP/Common/XzCrc64Reg.cpp
  CPP/Windows/FileDir.cpp
  CPP/Windows/FileFind.cpp
  CPP/Windows/FileIO.cpp
  CPP/Windows/FileName.cpp
  CPP/Windows/PropVariant.cpp
  CPP/Windows/PropVariantConv.cpp
  CPP/Windows/PropVariantUtils.cpp
  CPP/Windows/Synchronization.cpp
  CPP/Windows/System.cpp
  CPP/Windows/TimeUtils.cpp
)
list(TRANSFORM GXDE_ROLLER_7ZIP_SOURCES PREPEND "${GXDE_ROLLER_7ZIP_DIR}/")

add_library(gxde_roller_7zip STATIC ${GXDE_ROLLER_7ZIP_SOURCES})
target_include_directories(gxde_roller_7zip
  PUBLIC "${GXDE_ROLLER_7ZIP_DIR}/CPP")
# The flags of 7zip_gcc.mak for Format7zF.
target_compile_definitions(gxde_roller_7zip
  PUBLIC
    _FILE_OFFSET_BITS=64
    _LARGEFILE_SOURCE
    _REENTRANT
    Z7_EXTERNAL_CODECS)
set_target_properties(gxde_roller_7zip PROPERTIES
  POSITION_INDEPENDENT_CODE ON
  CXX_CLANG_TIDY ""
  C_CLANG_TIDY "")
# Vendored code: its warnings are not ours to fix.
target_compile_options(gxde_roller_7zip PRIVATE -w)
find_package(Threads REQUIRED)
target_link_libraries(gxde_roller_7zip PUBLIC Threads::Threads ${CMAKE_DL_LIBS})
