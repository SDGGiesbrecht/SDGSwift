//===- BuildValue.h ---------------------------------------------*- C++ -*-===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2017 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

#ifndef LLBUILD_BUILDSYSTEM_BUILDVALUE_H
#define LLBUILD_BUILDSYSTEM_BUILDVALUE_H

#include "llbuild/Core/BuildEngine.h"
#include "llbuild/Basic/BinaryCoding.h"
#include "llbuild/Basic/Compiler.h"
#include "llbuild/Basic/FileInfo.h"
#include "llbuild/Basic/Hashing.h"
#include "llbuild/Basic/LLVM.h"
#include "llbuild/Basic/StringList.h"

#include "llvm/ADT/ArrayRef.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/Support/raw_ostream.h"

#include <vector>

namespace llvm {
class raw_ostream;
}

namespace llbuild {
namespace buildsystem {

/// The BuildValue encodes the value space used by the BuildSystem when using
/// the core BuildEngine.
class BuildValue {
  using FileInfo = basic::FileInfo;

  enum class Kind : uint32_t {
    /// An invalid value, for sentinel purposes.
    Invalid = 0,

    /// A value produced by a virtual input.
    VirtualInput,

    /// A value produced by an existing input file.
    ExistingInput,

    /// A value produced by a missing input file.
    MissingInput,

    /// The contents of a directory.
    DirectoryContents,

    /// The signature of a directories contents.
    DirectoryTreeSignature,

    /// The signature of a directories structure.
    DirectoryTreeStructureSignature,

    /// A value produced by stale file removal.
    StaleFileRemoval,

    /// A value produced by a command which succeeded, but whose output was
    /// missing.
    MissingOutput,

    /// A value for a produced output whose command failed or was cancelled.
    FailedInput,

    /// A value produced by a successful command.
    SuccessfulCommand,

    /// A value produced by a failing command.
    FailedCommand,

    /// A value produced by a command which was skipped because one of its
    /// dependencies failed.
    PropagatedFailureCommand,

    /// A value produced by a command which was cancelled.
    CancelledCommand,

    /// A value produced by a command which was skipped.
    SkippedCommand,

    /// Sentinel value representing the result of "building" a top-level target.
    Target,

    /// The filtered contents of a directory.
    FilteredDirectoryContents,

  };
  static StringRef stringForKind(Kind);

  friend struct basic::BinaryCodingTraits<BuildValue::Kind>;

  /// The kind of value.
  Kind kind = Kind::Invalid;

  /// The number of attached output infos.
  uint32_t numOutputInfos = 0;

  /// The command hash, for successful commands.
  basic::CommandSignature commandSignature;

  union {
    /// The file info for the rule output, for existing inputs, successful
    /// commands with a single output, and directory contents.
    FileInfo asOutputInfo;

    /// The file info for successful commands with multiple outputs.
    FileInfo* asOutputInfos;
  } valueData = { {} };

  /// String list storage.
  //
  // FIXME: We are currently paying the cost for carrying this around on every
  // value, which is very wasteful. We need to redesign this type to be
  // customized to each exact value.
  basic::StringList stringValues;

  bool kindHasCommandSignature() const {
    return isSuccessfulCommand() ||
        isDirectoryTreeSignature() || isDirectoryTreeStructureSignature();
  }

  bool kindHasStringList() const {
    return isDirectoryContents() || isFilteredDirectoryContents() || isStaleFileRemoval();
  }

  bool kindHasOutputInfo() const {
    return isExistingInput() || isSuccessfulCommand() || isDirectoryContents();
  }
  
private:
  // Copying is disabled.
  BuildValue(const BuildValue&) LLBUILD_DELETED_FUNCTION;
  void operator=(const BuildValue&) LLBUILD_DELETED_FUNCTION;

  BuildValue() {}
  BuildValue(basic::BinaryDecoder& decoder);
  BuildValue(Kind kind, basic::CommandSignature commandSignature = basic::CommandSignature())
      : kind(kind), commandSignature(commandSignature) { }
  BuildValue(Kind kind, ArrayRef<FileInfo> outputInfos,
             basic::CommandSignature commandSignature = basic::CommandSignature())
      : kind(kind), numOutputInfos(outputInfos.size()),
        commandSignature(commandSignature)
  {
    assert(numOutputInfos >= 1);
    if (numOutputInfos == 1) {
      valueData.asOutputInfo = outputInfos[0];
    } else {
      valueData.asOutputInfos = new FileInfo[numOutputInfos];
      for (uint32_t i = 0; i != numOutputInfos; ++i) {
        valueData.asOutputInfos[i] = outputInfos[i];
      }
    }
  }
  
  /// Create a build value containing directory contents.
  BuildValue(Kind kind, FileInfo directoryInfo, ArrayRef<std::string> values)
      : BuildValue(kind, directoryInfo)
  {
    assert(kindHasStringList());

    stringValues = basic::StringList(values);
  }

  BuildValue(Kind kind, ArrayRef<std::string> values)
      : kind(kind), stringValues(values) {
    assert(kindHasStringList());
  }

  std::vector<StringRef> getStringListValues() const {
    assert(kindHasStringList());
    return stringValues.getValues();
  }

  FileInfo& getNthOutputInfo(unsigned n) {
    assert(kindHasOutputInfo() && "invalid call for value kind");
    assert(n < getNumOutputs());
    if (hasMultipleOutputs()) {
      return valueData.asOutputInfos[n];
    } else {
      assert(n == 0);
      return valueData.asOutputInfo;
    }
  }

public:
  // BuildValues can only be moved, not copied.
  BuildValue(BuildValue&& rhs) : numOutputInfos(rhs.numOutputInfos) {
    kind = rhs.kind;
    numOutputInfos = rhs.numOutputInfos;
    commandSignature = rhs.commandSignature;
    if (rhs.hasMultipleOutputs()) {
      valueData.asOutputInfos = rhs.valueData.asOutputInfos;
      rhs.valueData.asOutputInfos = nullptr;
    } else {
      valueData.asOutputInfo = rhs.valueData.asOutputInfo;
    }
    if (rhs.kindHasStringList()) {
      stringValues = std::move(rhs.stringValues);
    }
  }
  BuildValue& operator=(BuildValue&& rhs) {
    if (this != &rhs) {
      // Release our resources.
      if (hasMultipleOutputs())
        delete[] valueData.asOutputInfos;

      // Move the data.
      kind = rhs.kind;
      numOutputInfos = rhs.numOutputInfos;
      commandSignature = rhs.commandSignature;
      if (rhs.hasMultipleOutputs()) {
        valueData.asOutputInfos = rhs.valueData.asOutputInfos;
        rhs.valueData.asOutputInfos = nullptr;
      } else {
        valueData.asOutputInfo = rhs.valueData.asOutputInfo;
      }
      if (rhs.kindHasStringList()) {
        stringValues = std::move(rhs.stringValues);
      }
    }
    return *this;
  }
  ~BuildValue() {
    if (hasMultipleOutputs()) {
      delete[] valueData.asOutputInfos;
    }
  }

  /// @name Construction Functions
  /// @{

  static BuildValue makeInvalid() {
    return BuildValue(Kind::Invalid);
  }
  static BuildValue makeVirtualInput() {
    return BuildValue(Kind::VirtualInput);
  }
  static BuildValue makeExistingInput(FileInfo outputInfo) {
    assert(!outputInfo.isMissing());
    return BuildValue(Kind::ExistingInput, outputInfo);
  }
  static BuildValue makeMissingInput() {
    return BuildValue(Kind::MissingInput);
  }
  static BuildValue makeDirectoryContents(FileInfo directoryInfo,
                                          ArrayRef<std::string> values) {
    return BuildValue(Kind::DirectoryContents, directoryInfo, values);
  }
  static BuildValue makeDirectoryTreeSignature(basic::CommandSignature signature) {
    return BuildValue(Kind::DirectoryTreeSignature, signature);
  }
  static BuildValue makeDirectoryTreeStructureSignature(basic::CommandSignature signature) {
    return BuildValue(Kind::DirectoryTreeStructureSignature, signature);
  }
  static BuildValue makeMissingOutput() {
    return BuildValue(Kind::MissingOutput);
  }
  static BuildValue makeFailedInput() {
    return BuildValue(Kind::FailedInput);
  }
  static BuildValue makeSuccessfulCommand(
      ArrayRef<FileInfo> outputInfos, basic::CommandSignature commandSignature) {
    return BuildValue(Kind::SuccessfulCommand, outputInfos, commandSignature);
  }
  static BuildValue makeFailedCommand() {
    return BuildValue(Kind::FailedCommand);
  }
  static BuildValue makePropagatedFailureCommand() {
    return BuildValue(Kind::PropagatedFailureCommand);
  }
  static BuildValue makeCancelledCommand() {
    return BuildValue(Kind::CancelledCommand);
  }
  static BuildValue makeSkippedCommand() {
    return BuildValue(Kind::SkippedCommand);
  }
  static BuildValue makeTarget() {
    return BuildValue(Kind::Target);
  }
  static BuildValue makeStaleFileRemoval(ArrayRef<std::string> values) {
    return BuildValue(Kind::StaleFileRemoval, values);
  }
  static BuildValue makeFilteredDirectoryContents(ArrayRef<std::string> values) {
    return BuildValue(Kind::FilteredDirectoryContents, values);
  }

  /// @}

  /// @name Accessors
  /// @{

  bool isInvalid() const { return kind == Kind::Invalid; }
  bool isVirtualInput() const { return kind == Kind::VirtualInput; }
  bool isExistingInput() const { return kind == Kind::ExistingInput; }
  bool isMissingInput() const { return kind == Kind::MissingInput; }

  bool isDirectoryContents() const { return kind == Kind::DirectoryContents; }
  bool isDirectoryTreeSignature() const {
    return kind == Kind::DirectoryTreeSignature;
  }
  bool isDirectoryTreeStructureSignature() const {
    return kind == Kind::DirectoryTreeStructureSignature;
  }
  bool isStaleFileRemoval() const { return kind == Kind::StaleFileRemoval; }
  
  bool isMissingOutput() const { return kind == Kind::MissingOutput; }
  bool isFailedInput() const { return kind == Kind::FailedInput; }
  bool isSuccessfulCommand() const {return kind == Kind::SuccessfulCommand; }
  bool isFailedCommand() const { return kind == Kind::FailedCommand; }
  bool isPropagatedFailureCommand() const {
    return kind == Kind::PropagatedFailureCommand;
  }
  bool isCancelledCommand() const { return kind == Kind::CancelledCommand; }
  bool isSkippedCommand() const { return kind == Kind::SkippedCommand; }
  bool isTarget() const { return kind == Kind::Target; }
  bool isFilteredDirectoryContents() const {
    return kind == Kind::FilteredDirectoryContents;
  }

  std::vector<StringRef> getDirectoryContents() const {
    assert((isDirectoryContents() || isFilteredDirectoryContents()) && "invalid call for value kind");
    return getStringListValues();
  }

  std::vector<StringRef> getStaleFileList() const {
    assert(isStaleFileRemoval() && "invalid call for value kind");
    return getStringListValues();
  }
  
  basic::CommandSignature getDirectoryTreeSignature() const {
    assert(isDirectoryTreeSignature() && "invalid call for value kind");
    return commandSignature;
  }
  
  basic::CommandSignature getDirectoryTreeStructureSignature() const {
    assert(isDirectoryTreeStructureSignature() &&
           "invalid call for value kind");
    return commandSignature;
  }

  bool hasMultipleOutputs() const {
    return numOutputInfos > 1;
  }

  unsigned getNumOutputs() const {
    assert(kindHasOutputInfo() && "invalid call for value kind");
    return numOutputInfos;
  }

  const FileInfo& getOutputInfo() const {
    assert(kindHasOutputInfo() && "invalid call for value kind");
    assert(!hasMultipleOutputs() &&
           "invalid call on result with multiple outputs");
    return valueData.asOutputInfo;
  }

  const FileInfo& getNthOutputInfo(unsigned n) const {
    assert(kindHasOutputInfo() && "invalid call for value kind");
    assert(n < getNumOutputs());
    if (hasMultipleOutputs()) {
      return valueData.asOutputInfos[n];
    } else {
      assert(n == 0);
      return valueData.asOutputInfo;
    }
  }

  basic::CommandSignature getCommandSignature() const {
    assert(isSuccessfulCommand() && "invalid call for value kind");
    return commandSignature;
  }

  /// @}

  /// @name Conversion to core ValueType.
  /// @{

  static BuildValue fromData(const core::ValueType& value) {
    basic::BinaryDecoder decoder(StringRef((char*)value.data(), value.size()));
    return BuildValue(decoder);
  }
  core::ValueType toData() const;

  /// @}

  /// @name Debug Support
  /// @{

  void dump(raw_ostream& OS) const;

  /// @}
};

}

template<>
struct basic::BinaryCodingTraits<buildsystem::BuildValue::Kind> {
  typedef buildsystem::BuildValue::Kind Kind;
  
  static inline void encode(const Kind& value, BinaryEncoder& coder) {
    uint8_t tmp = uint8_t(value);
    assert(value == Kind(tmp));
    coder.write(tmp);
  }
  static inline void decode(Kind& value, BinaryDecoder& coder) {
    uint8_t tmp;
    coder.read(tmp);
    value = Kind(tmp);
  }
};

inline buildsystem::BuildValue::BuildValue(basic::BinaryDecoder& coder) {
  // Handle empty decode requests.
  if (coder.isEmpty()) {
    kind = BuildValue::Kind::Invalid;
    return;
  }
  
  coder.read(kind);
  if (kindHasCommandSignature())
    coder.read(commandSignature);
  if (kindHasOutputInfo()) {
    coder.read(numOutputInfos);
    if (numOutputInfos > 1) {
      valueData.asOutputInfos = new FileInfo[numOutputInfos];
    }
    for (uint32_t i = 0; i != numOutputInfos; ++i) {
      coder.read(getNthOutputInfo(i));
    }
  }
  if (kindHasStringList()) {
    stringValues = basic::StringList(coder);
  }
  coder.finish();
}

inline core::ValueType buildsystem::BuildValue::toData() const {
  basic::BinaryEncoder coder;
  coder.write(kind);
  if (kindHasCommandSignature())
    coder.write(commandSignature);
  if (kindHasOutputInfo()) {
    coder.write(numOutputInfos);
    for (uint32_t i = 0; i != numOutputInfos; ++i) {
      coder.write(getNthOutputInfo(i));
    }
  }
  if (kindHasStringList()) {
    stringValues.encode(coder);
  }
  return coder.contents();
}

}

#endif
