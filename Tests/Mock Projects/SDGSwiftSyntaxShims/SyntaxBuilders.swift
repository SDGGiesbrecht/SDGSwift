
//// Automatically Generated From SyntaxBuilders.swift.gyb.
//// Do Not Edit Directly!
//===------------ SyntaxBuilders.swift - Syntax Builder definitions -------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2017 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//


public struct InOutExprSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.ampersand),
    RawSyntax.missingToken(.identifier("")),
  ]
  internal init() {}

  public mutating func useAmpersand(_ node: TokenSyntax) {
    let idx = InOutExprSyntax.Cursor.ampersand.rawValue
    layout[idx] = node.raw
  }

  public mutating func useIdentifier(_ node: TokenSyntax) {
    let idx = InOutExprSyntax.Cursor.identifier.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.inOutExpr,
                                 layout, .present))
  }
}

extension InOutExprSyntax {
  /// Creates a `InOutExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `InOutExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `InOutExprSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout InOutExprSyntaxBuilder) -> Void) {
    var builder = InOutExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct PoundColumnExprSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.poundColumnKeyword),
  ]
  internal init() {}

  public mutating func usePoundColumn(_ node: TokenSyntax) {
    let idx = PoundColumnExprSyntax.Cursor.poundColumn.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.poundColumnExpr,
                                 layout, .present))
  }
}

extension PoundColumnExprSyntax {
  /// Creates a `PoundColumnExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PoundColumnExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PoundColumnExprSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout PoundColumnExprSyntaxBuilder) -> Void) {
    var builder = PoundColumnExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct TryOperatorSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.tryKeyword),
    RawSyntax.missingToken(.postfixQuestionMark),
  ]
  internal init() {}

  public mutating func useTryKeyword(_ node: TokenSyntax) {
    let idx = TryOperatorSyntax.Cursor.tryKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useQuestionOrExclamationMark(_ node: TokenSyntax) {
    let idx = TryOperatorSyntax.Cursor.questionOrExclamationMark.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.tryOperator,
                                 layout, .present))
  }
}

extension TryOperatorSyntax {
  /// Creates a `TryOperatorSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TryOperatorSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TryOperatorSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout TryOperatorSyntaxBuilder) -> Void) {
    var builder = TryOperatorSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct IdentifierExprSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.identifier("")),
  ]
  internal init() {}

  public mutating func useIdentifier(_ node: TokenSyntax) {
    let idx = IdentifierExprSyntax.Cursor.identifier.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.identifierExpr,
                                 layout, .present))
  }
}

extension IdentifierExprSyntax {
  /// Creates a `IdentifierExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `IdentifierExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `IdentifierExprSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout IdentifierExprSyntaxBuilder) -> Void) {
    var builder = IdentifierExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct NilLiteralExprSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.nilKeyword),
  ]
  internal init() {}

  public mutating func useNilKeyword(_ node: TokenSyntax) {
    let idx = NilLiteralExprSyntax.Cursor.nilKeyword.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.nilLiteralExpr,
                                 layout, .present))
  }
}

extension NilLiteralExprSyntax {
  /// Creates a `NilLiteralExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `NilLiteralExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `NilLiteralExprSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout NilLiteralExprSyntaxBuilder) -> Void) {
    var builder = NilLiteralExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct DiscardAssignmentExprSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.wildcardKeyword),
  ]
  internal init() {}

  public mutating func useWildcard(_ node: TokenSyntax) {
    let idx = DiscardAssignmentExprSyntax.Cursor.wildcard.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.discardAssignmentExpr,
                                 layout, .present))
  }
}

extension DiscardAssignmentExprSyntax {
  /// Creates a `DiscardAssignmentExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DiscardAssignmentExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DiscardAssignmentExprSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout DiscardAssignmentExprSyntaxBuilder) -> Void) {
    var builder = DiscardAssignmentExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct AssignmentExprSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.equal),
  ]
  internal init() {}

  public mutating func useAssignToken(_ node: TokenSyntax) {
    let idx = AssignmentExprSyntax.Cursor.assignToken.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.assignmentExpr,
                                 layout, .present))
  }
}

extension AssignmentExprSyntax {
  /// Creates a `AssignmentExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AssignmentExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AssignmentExprSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout AssignmentExprSyntaxBuilder) -> Void) {
    var builder = AssignmentExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct SequenceExprSyntaxBuilder {
  private var layout = [
    RawSyntax.missing(.exprList),
  ]
  internal init() {}

  public mutating func addExpression(_ elt: ExprSyntax) {
    let idx = SequenceExprSyntax.Cursor.elements.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.sequenceExpr,
                                 layout, .present))
  }
}

extension SequenceExprSyntax {
  /// Creates a `SequenceExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SequenceExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SequenceExprSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout SequenceExprSyntaxBuilder) -> Void) {
    var builder = SequenceExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct PoundLineExprSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.poundLineKeyword),
  ]
  internal init() {}

  public mutating func usePoundLine(_ node: TokenSyntax) {
    let idx = PoundLineExprSyntax.Cursor.poundLine.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.poundLineExpr,
                                 layout, .present))
  }
}

extension PoundLineExprSyntax {
  /// Creates a `PoundLineExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PoundLineExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PoundLineExprSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout PoundLineExprSyntaxBuilder) -> Void) {
    var builder = PoundLineExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct PoundFileExprSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.poundFileKeyword),
  ]
  internal init() {}

  public mutating func usePoundFile(_ node: TokenSyntax) {
    let idx = PoundFileExprSyntax.Cursor.poundFile.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.poundFileExpr,
                                 layout, .present))
  }
}

extension PoundFileExprSyntax {
  /// Creates a `PoundFileExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PoundFileExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PoundFileExprSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout PoundFileExprSyntaxBuilder) -> Void) {
    var builder = PoundFileExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct PoundFunctionExprSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.poundFunctionKeyword),
  ]
  internal init() {}

  public mutating func usePoundFunction(_ node: TokenSyntax) {
    let idx = PoundFunctionExprSyntax.Cursor.poundFunction.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.poundFunctionExpr,
                                 layout, .present))
  }
}

extension PoundFunctionExprSyntax {
  /// Creates a `PoundFunctionExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PoundFunctionExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PoundFunctionExprSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout PoundFunctionExprSyntaxBuilder) -> Void) {
    var builder = PoundFunctionExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct SymbolicReferenceExprSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.identifier("")),
    RawSyntax.missing(.genericArgumentClause),
  ]
  internal init() {}

  public mutating func useIdentifier(_ node: TokenSyntax) {
    let idx = SymbolicReferenceExprSyntax.Cursor.identifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useGenericArgumentClause(_ node: GenericArgumentClauseSyntax) {
    let idx = SymbolicReferenceExprSyntax.Cursor.genericArgumentClause.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.symbolicReferenceExpr,
                                 layout, .present))
  }
}

extension SymbolicReferenceExprSyntax {
  /// Creates a `SymbolicReferenceExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SymbolicReferenceExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SymbolicReferenceExprSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout SymbolicReferenceExprSyntaxBuilder) -> Void) {
    var builder = SymbolicReferenceExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct PrefixOperatorExprSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.prefixOperator("")),
    RawSyntax.missing(.expr),
  ]
  internal init() {}

  public mutating func useOperatorToken(_ node: TokenSyntax) {
    let idx = PrefixOperatorExprSyntax.Cursor.operatorToken.rawValue
    layout[idx] = node.raw
  }

  public mutating func usePostfixExpression(_ node: ExprSyntax) {
    let idx = PrefixOperatorExprSyntax.Cursor.postfixExpression.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.prefixOperatorExpr,
                                 layout, .present))
  }
}

extension PrefixOperatorExprSyntax {
  /// Creates a `PrefixOperatorExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `PrefixOperatorExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `PrefixOperatorExprSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout PrefixOperatorExprSyntaxBuilder) -> Void) {
    var builder = PrefixOperatorExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct BinaryOperatorExprSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.unknown),
  ]
  internal init() {}

  public mutating func useOperatorToken(_ node: TokenSyntax) {
    let idx = BinaryOperatorExprSyntax.Cursor.operatorToken.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.binaryOperatorExpr,
                                 layout, .present))
  }
}

extension BinaryOperatorExprSyntax {
  /// Creates a `BinaryOperatorExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `BinaryOperatorExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `BinaryOperatorExprSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout BinaryOperatorExprSyntaxBuilder) -> Void) {
    var builder = BinaryOperatorExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct FloatLiteralExprSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.floatingLiteral("")),
  ]
  internal init() {}

  public mutating func useFloatingDigits(_ node: TokenSyntax) {
    let idx = FloatLiteralExprSyntax.Cursor.floatingDigits.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.floatLiteralExpr,
                                 layout, .present))
  }
}

extension FloatLiteralExprSyntax {
  /// Creates a `FloatLiteralExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `FloatLiteralExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `FloatLiteralExprSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout FloatLiteralExprSyntaxBuilder) -> Void) {
    var builder = FloatLiteralExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct FunctionCallExprSyntaxBuilder {
  private var layout = [
    RawSyntax.missing(.expr),
    RawSyntax.missingToken(.leftParen),
    RawSyntax.missing(.functionCallArgumentList),
    RawSyntax.missingToken(.rightParen),
  ]
  internal init() {}

  public mutating func useCalledExpression(_ node: ExprSyntax) {
    let idx = FunctionCallExprSyntax.Cursor.calledExpression.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = FunctionCallExprSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func addFunctionCallArgument(_ elt: FunctionCallArgumentSyntax) {
    let idx = FunctionCallExprSyntax.Cursor.argumentList.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = FunctionCallExprSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.functionCallExpr,
                                 layout, .present))
  }
}

extension FunctionCallExprSyntax {
  /// Creates a `FunctionCallExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `FunctionCallExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `FunctionCallExprSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout FunctionCallExprSyntaxBuilder) -> Void) {
    var builder = FunctionCallExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct TupleExprSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.leftParen),
    RawSyntax.missing(.tupleElementList),
    RawSyntax.missingToken(.rightParen),
  ]
  internal init() {}

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = TupleExprSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func addTupleElement(_ elt: TupleElementSyntax) {
    let idx = TupleExprSyntax.Cursor.elementList.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = TupleExprSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.tupleExpr,
                                 layout, .present))
  }
}

extension TupleExprSyntax {
  /// Creates a `TupleExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TupleExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TupleExprSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout TupleExprSyntaxBuilder) -> Void) {
    var builder = TupleExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct ArrayExprSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.unknown),
    RawSyntax.missing(.arrayElementList),
    RawSyntax.missingToken(.unknown),
  ]
  internal init() {}

  public mutating func useLeftSquare(_ node: TokenSyntax) {
    let idx = ArrayExprSyntax.Cursor.leftSquare.rawValue
    layout[idx] = node.raw
  }

  public mutating func addArrayElement(_ elt: ArrayElementSyntax) {
    let idx = ArrayExprSyntax.Cursor.elements.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  public mutating func useRightSquare(_ node: TokenSyntax) {
    let idx = ArrayExprSyntax.Cursor.rightSquare.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.arrayExpr,
                                 layout, .present))
  }
}

extension ArrayExprSyntax {
  /// Creates a `ArrayExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ArrayExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ArrayExprSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout ArrayExprSyntaxBuilder) -> Void) {
    var builder = ArrayExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct DictionaryExprSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.unknown),
    RawSyntax.missing(.dictionaryElementList),
    RawSyntax.missingToken(.unknown),
  ]
  internal init() {}

  public mutating func useLeftSquare(_ node: TokenSyntax) {
    let idx = DictionaryExprSyntax.Cursor.leftSquare.rawValue
    layout[idx] = node.raw
  }

  public mutating func addDictionaryElement(_ elt: DictionaryElementSyntax) {
    let idx = DictionaryExprSyntax.Cursor.elements.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  public mutating func useRightSquare(_ node: TokenSyntax) {
    let idx = DictionaryExprSyntax.Cursor.rightSquare.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.dictionaryExpr,
                                 layout, .present))
  }
}

extension DictionaryExprSyntax {
  /// Creates a `DictionaryExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DictionaryExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DictionaryExprSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout DictionaryExprSyntaxBuilder) -> Void) {
    var builder = DictionaryExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct FunctionCallArgumentSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.identifier("")),
    RawSyntax.missingToken(.colon),
    RawSyntax.missing(.expr),
    RawSyntax.missingToken(.comma),
  ]
  internal init() {}

  public mutating func useLabel(_ node: TokenSyntax) {
    let idx = FunctionCallArgumentSyntax.Cursor.label.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = FunctionCallArgumentSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useExpression(_ node: ExprSyntax) {
    let idx = FunctionCallArgumentSyntax.Cursor.expression.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = FunctionCallArgumentSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.functionCallArgument,
                                 layout, .present))
  }
}

extension FunctionCallArgumentSyntax {
  /// Creates a `FunctionCallArgumentSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `FunctionCallArgumentSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `FunctionCallArgumentSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout FunctionCallArgumentSyntaxBuilder) -> Void) {
    var builder = FunctionCallArgumentSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct TupleElementSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.identifier("")),
    RawSyntax.missingToken(.colon),
    RawSyntax.missing(.expr),
    RawSyntax.missingToken(.comma),
  ]
  internal init() {}

  public mutating func useLabel(_ node: TokenSyntax) {
    let idx = TupleElementSyntax.Cursor.label.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = TupleElementSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useExpression(_ node: ExprSyntax) {
    let idx = TupleElementSyntax.Cursor.expression.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = TupleElementSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.tupleElement,
                                 layout, .present))
  }
}

extension TupleElementSyntax {
  /// Creates a `TupleElementSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TupleElementSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TupleElementSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout TupleElementSyntaxBuilder) -> Void) {
    var builder = TupleElementSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct ArrayElementSyntaxBuilder {
  private var layout = [
    RawSyntax.missing(.expr),
    RawSyntax.missingToken(.comma),
  ]
  internal init() {}

  public mutating func useExpression(_ node: ExprSyntax) {
    let idx = ArrayElementSyntax.Cursor.expression.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = ArrayElementSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.arrayElement,
                                 layout, .present))
  }
}

extension ArrayElementSyntax {
  /// Creates a `ArrayElementSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ArrayElementSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ArrayElementSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout ArrayElementSyntaxBuilder) -> Void) {
    var builder = ArrayElementSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct DictionaryElementSyntaxBuilder {
  private var layout = [
    RawSyntax.missing(.expr),
    RawSyntax.missingToken(.colon),
    RawSyntax.missing(.expr),
    RawSyntax.missingToken(.comma),
  ]
  internal init() {}

  public mutating func useKeyExpression(_ node: ExprSyntax) {
    let idx = DictionaryElementSyntax.Cursor.keyExpression.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = DictionaryElementSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useValueExpression(_ node: ExprSyntax) {
    let idx = DictionaryElementSyntax.Cursor.valueExpression.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = DictionaryElementSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.dictionaryElement,
                                 layout, .present))
  }
}

extension DictionaryElementSyntax {
  /// Creates a `DictionaryElementSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DictionaryElementSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DictionaryElementSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout DictionaryElementSyntaxBuilder) -> Void) {
    var builder = DictionaryElementSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct IntegerLiteralExprSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.integerLiteral("")),
  ]
  internal init() {}

  public mutating func useDigits(_ node: TokenSyntax) {
    let idx = IntegerLiteralExprSyntax.Cursor.digits.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.integerLiteralExpr,
                                 layout, .present))
  }
}

extension IntegerLiteralExprSyntax {
  /// Creates a `IntegerLiteralExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `IntegerLiteralExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `IntegerLiteralExprSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout IntegerLiteralExprSyntaxBuilder) -> Void) {
    var builder = IntegerLiteralExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct StringLiteralExprSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.stringLiteral("")),
  ]
  internal init() {}

  public mutating func useStringLiteral(_ node: TokenSyntax) {
    let idx = StringLiteralExprSyntax.Cursor.stringLiteral.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.stringLiteralExpr,
                                 layout, .present))
  }
}

extension StringLiteralExprSyntax {
  /// Creates a `StringLiteralExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `StringLiteralExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `StringLiteralExprSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout StringLiteralExprSyntaxBuilder) -> Void) {
    var builder = StringLiteralExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct BooleanLiteralExprSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.trueKeyword),
  ]
  internal init() {}

  public mutating func useBooleanLiteral(_ node: TokenSyntax) {
    let idx = BooleanLiteralExprSyntax.Cursor.booleanLiteral.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.booleanLiteralExpr,
                                 layout, .present))
  }
}

extension BooleanLiteralExprSyntax {
  /// Creates a `BooleanLiteralExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `BooleanLiteralExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `BooleanLiteralExprSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout BooleanLiteralExprSyntaxBuilder) -> Void) {
    var builder = BooleanLiteralExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct TernaryExprSyntaxBuilder {
  private var layout = [
    RawSyntax.missing(.expr),
    RawSyntax.missingToken(.infixQuestionMark),
    RawSyntax.missing(.expr),
    RawSyntax.missingToken(.colon),
    RawSyntax.missing(.expr),
  ]
  internal init() {}

  public mutating func useConditionExpression(_ node: ExprSyntax) {
    let idx = TernaryExprSyntax.Cursor.conditionExpression.rawValue
    layout[idx] = node.raw
  }

  public mutating func useQuestionMark(_ node: TokenSyntax) {
    let idx = TernaryExprSyntax.Cursor.questionMark.rawValue
    layout[idx] = node.raw
  }

  public mutating func useFirstChoice(_ node: ExprSyntax) {
    let idx = TernaryExprSyntax.Cursor.firstChoice.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColonMark(_ node: TokenSyntax) {
    let idx = TernaryExprSyntax.Cursor.colonMark.rawValue
    layout[idx] = node.raw
  }

  public mutating func useSecondChoice(_ node: ExprSyntax) {
    let idx = TernaryExprSyntax.Cursor.secondChoice.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.ternaryExpr,
                                 layout, .present))
  }
}

extension TernaryExprSyntax {
  /// Creates a `TernaryExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TernaryExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TernaryExprSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout TernaryExprSyntaxBuilder) -> Void) {
    var builder = TernaryExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct MemberAccessExprSyntaxBuilder {
  private var layout = [
    RawSyntax.missing(.expr),
    RawSyntax.missingToken(.period),
    RawSyntax.missingToken(.unknown),
  ]
  internal init() {}

  public mutating func useBase(_ node: ExprSyntax) {
    let idx = MemberAccessExprSyntax.Cursor.base.rawValue
    layout[idx] = node.raw
  }

  public mutating func useDot(_ node: TokenSyntax) {
    let idx = MemberAccessExprSyntax.Cursor.dot.rawValue
    layout[idx] = node.raw
  }

  public mutating func useName(_ node: TokenSyntax) {
    let idx = MemberAccessExprSyntax.Cursor.name.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.memberAccessExpr,
                                 layout, .present))
  }
}

extension MemberAccessExprSyntax {
  /// Creates a `MemberAccessExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `MemberAccessExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `MemberAccessExprSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout MemberAccessExprSyntaxBuilder) -> Void) {
    var builder = MemberAccessExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct IsExprSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.isKeyword),
    RawSyntax.missing(.type),
  ]
  internal init() {}

  public mutating func useIsTok(_ node: TokenSyntax) {
    let idx = IsExprSyntax.Cursor.isTok.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTypeName(_ node: TypeSyntax) {
    let idx = IsExprSyntax.Cursor.typeName.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.isExpr,
                                 layout, .present))
  }
}

extension IsExprSyntax {
  /// Creates a `IsExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `IsExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `IsExprSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout IsExprSyntaxBuilder) -> Void) {
    var builder = IsExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct AsExprSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.asKeyword),
    RawSyntax.missingToken(.postfixQuestionMark),
    RawSyntax.missing(.type),
  ]
  internal init() {}

  public mutating func useAsTok(_ node: TokenSyntax) {
    let idx = AsExprSyntax.Cursor.asTok.rawValue
    layout[idx] = node.raw
  }

  public mutating func useQuestionOrExclamationMark(_ node: TokenSyntax) {
    let idx = AsExprSyntax.Cursor.questionOrExclamationMark.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTypeName(_ node: TypeSyntax) {
    let idx = AsExprSyntax.Cursor.typeName.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.asExpr,
                                 layout, .present))
  }
}

extension AsExprSyntax {
  /// Creates a `AsExprSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AsExprSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AsExprSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout AsExprSyntaxBuilder) -> Void) {
    var builder = AsExprSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct TypealiasDeclSyntaxBuilder {
  private var layout = [
    RawSyntax.missing(.attributeList),
    RawSyntax.missing(.accessLevelModifier),
    RawSyntax.missingToken(.typealiasKeyword),
    RawSyntax.missingToken(.identifier("")),
    RawSyntax.missing(.genericParameterClause),
    RawSyntax.missingToken(.equal),
    RawSyntax.missing(.type),
  ]
  internal init() {}

  public mutating func addAttribute(_ elt: AttributeSyntax) {
    let idx = TypealiasDeclSyntax.Cursor.attributes.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  public mutating func useAccessLevelModifier(_ node: AccessLevelModifierSyntax) {
    let idx = TypealiasDeclSyntax.Cursor.accessLevelModifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTypealiasKeyword(_ node: TokenSyntax) {
    let idx = TypealiasDeclSyntax.Cursor.typealiasKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useIdentifier(_ node: TokenSyntax) {
    let idx = TypealiasDeclSyntax.Cursor.identifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useGenericParameterClause(_ node: GenericParameterClauseSyntax) {
    let idx = TypealiasDeclSyntax.Cursor.genericParameterClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useEquals(_ node: TokenSyntax) {
    let idx = TypealiasDeclSyntax.Cursor.equals.rawValue
    layout[idx] = node.raw
  }

  public mutating func useType(_ node: TypeSyntax) {
    let idx = TypealiasDeclSyntax.Cursor.type.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.typealiasDecl,
                                 layout, .present))
  }
}

extension TypealiasDeclSyntax {
  /// Creates a `TypealiasDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TypealiasDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TypealiasDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout TypealiasDeclSyntaxBuilder) -> Void) {
    var builder = TypealiasDeclSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct FunctionSignatureSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.leftParen),
    RawSyntax.missing(.functionParameterList),
    RawSyntax.missingToken(.rightParen),
    RawSyntax.missingToken(.throwsKeyword),
    RawSyntax.missingToken(.arrow),
    RawSyntax.missing(.attributeList),
    RawSyntax.missing(.type),
  ]
  internal init() {}

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = FunctionSignatureSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func addFunctionParameter(_ elt: FunctionParameterSyntax) {
    let idx = FunctionSignatureSyntax.Cursor.parameterList.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = FunctionSignatureSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func useThrowsOrRethrowsKeyword(_ node: TokenSyntax) {
    let idx = FunctionSignatureSyntax.Cursor.throwsOrRethrowsKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useArrow(_ node: TokenSyntax) {
    let idx = FunctionSignatureSyntax.Cursor.arrow.rawValue
    layout[idx] = node.raw
  }

  public mutating func addAttribute(_ elt: AttributeSyntax) {
    let idx = FunctionSignatureSyntax.Cursor.returnTypeAttributes.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  public mutating func useReturnType(_ node: TypeSyntax) {
    let idx = FunctionSignatureSyntax.Cursor.returnType.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.functionSignature,
                                 layout, .present))
  }
}

extension FunctionSignatureSyntax {
  /// Creates a `FunctionSignatureSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `FunctionSignatureSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `FunctionSignatureSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout FunctionSignatureSyntaxBuilder) -> Void) {
    var builder = FunctionSignatureSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct ElseifDirectiveClauseSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.poundElseifKeyword),
    RawSyntax.missing(.expr),
    RawSyntax.missing(.stmtList),
  ]
  internal init() {}

  public mutating func usePoundElseif(_ node: TokenSyntax) {
    let idx = ElseifDirectiveClauseSyntax.Cursor.poundElseif.rawValue
    layout[idx] = node.raw
  }

  public mutating func useCondition(_ node: ExprSyntax) {
    let idx = ElseifDirectiveClauseSyntax.Cursor.condition.rawValue
    layout[idx] = node.raw
  }

  public mutating func addStmt(_ elt: StmtSyntax) {
    let idx = ElseifDirectiveClauseSyntax.Cursor.body.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.elseifDirectiveClause,
                                 layout, .present))
  }
}

extension ElseifDirectiveClauseSyntax {
  /// Creates a `ElseifDirectiveClauseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ElseifDirectiveClauseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ElseifDirectiveClauseSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout ElseifDirectiveClauseSyntaxBuilder) -> Void) {
    var builder = ElseifDirectiveClauseSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct IfConfigDeclSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.poundIfKeyword),
    RawSyntax.missing(.expr),
    RawSyntax.missing(.stmtList),
    RawSyntax.missing(.elseifDirectiveClauseList),
    RawSyntax.missing(.elseDirectiveClause),
    RawSyntax.missingToken(.poundEndifKeyword),
  ]
  internal init() {}

  public mutating func usePoundIf(_ node: TokenSyntax) {
    let idx = IfConfigDeclSyntax.Cursor.poundIf.rawValue
    layout[idx] = node.raw
  }

  public mutating func useCondition(_ node: ExprSyntax) {
    let idx = IfConfigDeclSyntax.Cursor.condition.rawValue
    layout[idx] = node.raw
  }

  public mutating func addStmt(_ elt: StmtSyntax) {
    let idx = IfConfigDeclSyntax.Cursor.body.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  public mutating func addElseifDirectiveClause(_ elt: ElseifDirectiveClauseSyntax) {
    let idx = IfConfigDeclSyntax.Cursor.elseifDirectiveClauses.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  public mutating func useElseClause(_ node: ElseDirectiveClauseSyntax) {
    let idx = IfConfigDeclSyntax.Cursor.elseClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func usePoundEndif(_ node: TokenSyntax) {
    let idx = IfConfigDeclSyntax.Cursor.poundEndif.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.ifConfigDecl,
                                 layout, .present))
  }
}

extension IfConfigDeclSyntax {
  /// Creates a `IfConfigDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `IfConfigDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `IfConfigDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout IfConfigDeclSyntaxBuilder) -> Void) {
    var builder = IfConfigDeclSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct DeclModifierSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.unknown),
    RawSyntax.missingToken(.unknown),
  ]
  internal init() {}

  public mutating func useName(_ node: TokenSyntax) {
    let idx = DeclModifierSyntax.Cursor.name.rawValue
    layout[idx] = node.raw
  }

  public mutating func addToken(_ elt: TokenSyntax) {
    let idx = DeclModifierSyntax.Cursor.detail.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.declModifier,
                                 layout, .present))
  }
}

extension DeclModifierSyntax {
  /// Creates a `DeclModifierSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DeclModifierSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DeclModifierSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout DeclModifierSyntaxBuilder) -> Void) {
    var builder = DeclModifierSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct TypeInheritanceClauseSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.colon),
    RawSyntax.missing(.type),
  ]
  internal init() {}

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = TypeInheritanceClauseSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useInheritedType(_ node: TypeSyntax) {
    let idx = TypeInheritanceClauseSyntax.Cursor.inheritedType.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.typeInheritanceClause,
                                 layout, .present))
  }
}

extension TypeInheritanceClauseSyntax {
  /// Creates a `TypeInheritanceClauseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TypeInheritanceClauseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TypeInheritanceClauseSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout TypeInheritanceClauseSyntaxBuilder) -> Void) {
    var builder = TypeInheritanceClauseSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct StructDeclSyntaxBuilder {
  private var layout = [
    RawSyntax.missing(.attributeList),
    RawSyntax.missing(.accessLevelModifier),
    RawSyntax.missingToken(.structKeyword),
    RawSyntax.missingToken(.identifier("")),
    RawSyntax.missing(.genericParameterClause),
    RawSyntax.missing(.typeInheritanceClause),
    RawSyntax.missing(.genericWhereClause),
    RawSyntax.missing(.memberDeclBlock),
  ]
  internal init() {}

  public mutating func addAttribute(_ elt: AttributeSyntax) {
    let idx = StructDeclSyntax.Cursor.attributes.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  public mutating func useAccessLevelModifier(_ node: AccessLevelModifierSyntax) {
    let idx = StructDeclSyntax.Cursor.accessLevelModifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useStructKeyword(_ node: TokenSyntax) {
    let idx = StructDeclSyntax.Cursor.structKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useIdentifier(_ node: TokenSyntax) {
    let idx = StructDeclSyntax.Cursor.identifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useGenericParameterClause(_ node: GenericParameterClauseSyntax) {
    let idx = StructDeclSyntax.Cursor.genericParameterClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useInheritanceClause(_ node: TypeInheritanceClauseSyntax) {
    let idx = StructDeclSyntax.Cursor.inheritanceClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useGenericWhereClause(_ node: GenericWhereClauseSyntax) {
    let idx = StructDeclSyntax.Cursor.genericWhereClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useMembers(_ node: MemberDeclBlockSyntax) {
    let idx = StructDeclSyntax.Cursor.members.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.structDecl,
                                 layout, .present))
  }
}

extension StructDeclSyntax {
  /// Creates a `StructDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `StructDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `StructDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout StructDeclSyntaxBuilder) -> Void) {
    var builder = StructDeclSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct MemberDeclBlockSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.leftBrace),
    RawSyntax.missing(.declList),
    RawSyntax.missingToken(.rightBrace),
  ]
  internal init() {}

  public mutating func useLeftBrace(_ node: TokenSyntax) {
    let idx = MemberDeclBlockSyntax.Cursor.leftBrace.rawValue
    layout[idx] = node.raw
  }

  public mutating func addDecl(_ elt: DeclSyntax) {
    let idx = MemberDeclBlockSyntax.Cursor.members.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  public mutating func useRightBrace(_ node: TokenSyntax) {
    let idx = MemberDeclBlockSyntax.Cursor.rightBrace.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.memberDeclBlock,
                                 layout, .present))
  }
}

extension MemberDeclBlockSyntax {
  /// Creates a `MemberDeclBlockSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `MemberDeclBlockSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `MemberDeclBlockSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout MemberDeclBlockSyntaxBuilder) -> Void) {
    var builder = MemberDeclBlockSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct SourceFileSyntaxBuilder {
  private var layout = [
    RawSyntax.missing(.declList),
    RawSyntax.missingToken(.unknown),
  ]
  internal init() {}

  public mutating func addDecl(_ elt: DeclSyntax) {
    let idx = SourceFileSyntax.Cursor.topLevelDecls.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  public mutating func useEOFToken(_ node: TokenSyntax) {
    let idx = SourceFileSyntax.Cursor.eofToken.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.sourceFile,
                                 layout, .present))
  }
}

extension SourceFileSyntax {
  /// Creates a `SourceFileSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SourceFileSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SourceFileSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout SourceFileSyntaxBuilder) -> Void) {
    var builder = SourceFileSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct TopLevelCodeDeclSyntaxBuilder {
  private var layout = [
    RawSyntax.missing(.stmtList),
  ]
  internal init() {}

  public mutating func addStmt(_ elt: StmtSyntax) {
    let idx = TopLevelCodeDeclSyntax.Cursor.body.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.topLevelCodeDecl,
                                 layout, .present))
  }
}

extension TopLevelCodeDeclSyntax {
  /// Creates a `TopLevelCodeDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TopLevelCodeDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TopLevelCodeDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout TopLevelCodeDeclSyntaxBuilder) -> Void) {
    var builder = TopLevelCodeDeclSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct FunctionParameterSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.identifier("")),
    RawSyntax.missingToken(.identifier("")),
    RawSyntax.missingToken(.colon),
    RawSyntax.missing(.typeAnnotation),
    RawSyntax.missingToken(.unknown),
    RawSyntax.missingToken(.equal),
    RawSyntax.missing(.expr),
    RawSyntax.missingToken(.comma),
  ]
  internal init() {}

  public mutating func useExternalName(_ node: TokenSyntax) {
    let idx = FunctionParameterSyntax.Cursor.externalName.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLocalName(_ node: TokenSyntax) {
    let idx = FunctionParameterSyntax.Cursor.localName.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = FunctionParameterSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTypeAnnotation(_ node: TypeAnnotationSyntax) {
    let idx = FunctionParameterSyntax.Cursor.typeAnnotation.rawValue
    layout[idx] = node.raw
  }

  public mutating func useEllipsis(_ node: TokenSyntax) {
    let idx = FunctionParameterSyntax.Cursor.ellipsis.rawValue
    layout[idx] = node.raw
  }

  public mutating func useDefaultEquals(_ node: TokenSyntax) {
    let idx = FunctionParameterSyntax.Cursor.defaultEquals.rawValue
    layout[idx] = node.raw
  }

  public mutating func useDefaultValue(_ node: ExprSyntax) {
    let idx = FunctionParameterSyntax.Cursor.defaultValue.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = FunctionParameterSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.functionParameter,
                                 layout, .present))
  }
}

extension FunctionParameterSyntax {
  /// Creates a `FunctionParameterSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `FunctionParameterSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `FunctionParameterSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout FunctionParameterSyntaxBuilder) -> Void) {
    var builder = FunctionParameterSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct FunctionDeclSyntaxBuilder {
  private var layout = [
    RawSyntax.missing(.attributeList),
    RawSyntax.missing(.modifierList),
    RawSyntax.missingToken(.funcKeyword),
    RawSyntax.missingToken(.identifier("")),
    RawSyntax.missing(.genericParameterClause),
    RawSyntax.missing(.functionSignature),
    RawSyntax.missing(.genericWhereClause),
    RawSyntax.missing(.codeBlock),
  ]
  internal init() {}

  public mutating func addAttribute(_ elt: AttributeSyntax) {
    let idx = FunctionDeclSyntax.Cursor.attributes.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  public mutating func addModifier(_ elt: Syntax) {
    let idx = FunctionDeclSyntax.Cursor.modifiers.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  public mutating func useFuncKeyword(_ node: TokenSyntax) {
    let idx = FunctionDeclSyntax.Cursor.funcKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useIdentifier(_ node: TokenSyntax) {
    let idx = FunctionDeclSyntax.Cursor.identifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useGenericParameterClause(_ node: GenericParameterClauseSyntax) {
    let idx = FunctionDeclSyntax.Cursor.genericParameterClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useSignature(_ node: FunctionSignatureSyntax) {
    let idx = FunctionDeclSyntax.Cursor.signature.rawValue
    layout[idx] = node.raw
  }

  public mutating func useGenericWhereClause(_ node: GenericWhereClauseSyntax) {
    let idx = FunctionDeclSyntax.Cursor.genericWhereClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useBody(_ node: CodeBlockSyntax) {
    let idx = FunctionDeclSyntax.Cursor.body.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.functionDecl,
                                 layout, .present))
  }
}

extension FunctionDeclSyntax {
  /// Creates a `FunctionDeclSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `FunctionDeclSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `FunctionDeclSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout FunctionDeclSyntaxBuilder) -> Void) {
    var builder = FunctionDeclSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct ElseDirectiveClauseSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.poundElseKeyword),
    RawSyntax.missing(.stmtList),
  ]
  internal init() {}

  public mutating func usePoundElse(_ node: TokenSyntax) {
    let idx = ElseDirectiveClauseSyntax.Cursor.poundElse.rawValue
    layout[idx] = node.raw
  }

  public mutating func addStmt(_ elt: StmtSyntax) {
    let idx = ElseDirectiveClauseSyntax.Cursor.body.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.elseDirectiveClause,
                                 layout, .present))
  }
}

extension ElseDirectiveClauseSyntax {
  /// Creates a `ElseDirectiveClauseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ElseDirectiveClauseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ElseDirectiveClauseSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout ElseDirectiveClauseSyntaxBuilder) -> Void) {
    var builder = ElseDirectiveClauseSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct AccessLevelModifierSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.identifier("")),
    RawSyntax.missingToken(.leftParen),
    RawSyntax.missingToken(.identifier("")),
    RawSyntax.missingToken(.rightParen),
  ]
  internal init() {}

  public mutating func useName(_ node: TokenSyntax) {
    let idx = AccessLevelModifierSyntax.Cursor.name.rawValue
    layout[idx] = node.raw
  }

  public mutating func useOpenParen(_ node: TokenSyntax) {
    let idx = AccessLevelModifierSyntax.Cursor.openParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func useModifier(_ node: TokenSyntax) {
    let idx = AccessLevelModifierSyntax.Cursor.modifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useCloseParen(_ node: TokenSyntax) {
    let idx = AccessLevelModifierSyntax.Cursor.closeParen.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.accessLevelModifier,
                                 layout, .present))
  }
}

extension AccessLevelModifierSyntax {
  /// Creates a `AccessLevelModifierSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AccessLevelModifierSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AccessLevelModifierSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout AccessLevelModifierSyntaxBuilder) -> Void) {
    var builder = AccessLevelModifierSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct AttributeSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.atSign),
    RawSyntax.missingToken(.unknown),
    RawSyntax.missingToken(.unknown),
  ]
  internal init() {}

  public mutating func useAtSignToken(_ node: TokenSyntax) {
    let idx = AttributeSyntax.Cursor.atSignToken.rawValue
    layout[idx] = node.raw
  }

  public mutating func useAttributeName(_ node: TokenSyntax) {
    let idx = AttributeSyntax.Cursor.attributeName.rawValue
    layout[idx] = node.raw
  }

  public mutating func addToken(_ elt: TokenSyntax) {
    let idx = AttributeSyntax.Cursor.balancedTokens.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.attribute,
                                 layout, .present))
  }
}

extension AttributeSyntax {
  /// Creates a `AttributeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AttributeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AttributeSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout AttributeSyntaxBuilder) -> Void) {
    var builder = AttributeSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct ContinueStmtSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.continueKeyword),
    RawSyntax.missingToken(.identifier("")),
    RawSyntax.missingToken(.semicolon),
  ]
  internal init() {}

  public mutating func useContinueKeyword(_ node: TokenSyntax) {
    let idx = ContinueStmtSyntax.Cursor.continueKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLabel(_ node: TokenSyntax) {
    let idx = ContinueStmtSyntax.Cursor.label.rawValue
    layout[idx] = node.raw
  }

  public mutating func useSemicolon(_ node: TokenSyntax) {
    let idx = ContinueStmtSyntax.Cursor.semicolon.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.continueStmt,
                                 layout, .present))
  }
}

extension ContinueStmtSyntax {
  /// Creates a `ContinueStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ContinueStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ContinueStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout ContinueStmtSyntaxBuilder) -> Void) {
    var builder = ContinueStmtSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct WhileStmtSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.identifier("")),
    RawSyntax.missingToken(.colon),
    RawSyntax.missingToken(.whileKeyword),
    RawSyntax.missing(.conditionList),
    RawSyntax.missing(.codeBlock),
    RawSyntax.missingToken(.semicolon),
  ]
  internal init() {}

  public mutating func useLabelName(_ node: TokenSyntax) {
    let idx = WhileStmtSyntax.Cursor.labelName.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLabelColon(_ node: TokenSyntax) {
    let idx = WhileStmtSyntax.Cursor.labelColon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useWhileKeyword(_ node: TokenSyntax) {
    let idx = WhileStmtSyntax.Cursor.whileKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func addCondition(_ elt: ConditionSyntax) {
    let idx = WhileStmtSyntax.Cursor.conditions.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  public mutating func useBody(_ node: CodeBlockSyntax) {
    let idx = WhileStmtSyntax.Cursor.body.rawValue
    layout[idx] = node.raw
  }

  public mutating func useSemicolon(_ node: TokenSyntax) {
    let idx = WhileStmtSyntax.Cursor.semicolon.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.whileStmt,
                                 layout, .present))
  }
}

extension WhileStmtSyntax {
  /// Creates a `WhileStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `WhileStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `WhileStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout WhileStmtSyntaxBuilder) -> Void) {
    var builder = WhileStmtSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct DeferStmtSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.deferKeyword),
    RawSyntax.missing(.codeBlock),
    RawSyntax.missingToken(.semicolon),
  ]
  internal init() {}

  public mutating func useDeferKeyword(_ node: TokenSyntax) {
    let idx = DeferStmtSyntax.Cursor.deferKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useBody(_ node: CodeBlockSyntax) {
    let idx = DeferStmtSyntax.Cursor.body.rawValue
    layout[idx] = node.raw
  }

  public mutating func useSemicolon(_ node: TokenSyntax) {
    let idx = DeferStmtSyntax.Cursor.semicolon.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.deferStmt,
                                 layout, .present))
  }
}

extension DeferStmtSyntax {
  /// Creates a `DeferStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DeferStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DeferStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout DeferStmtSyntaxBuilder) -> Void) {
    var builder = DeferStmtSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct ExpressionStmtSyntaxBuilder {
  private var layout = [
    RawSyntax.missing(.expr),
    RawSyntax.missingToken(.semicolon),
  ]
  internal init() {}

  public mutating func useExpression(_ node: ExprSyntax) {
    let idx = ExpressionStmtSyntax.Cursor.expression.rawValue
    layout[idx] = node.raw
  }

  public mutating func useSemicolon(_ node: TokenSyntax) {
    let idx = ExpressionStmtSyntax.Cursor.semicolon.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.expressionStmt,
                                 layout, .present))
  }
}

extension ExpressionStmtSyntax {
  /// Creates a `ExpressionStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ExpressionStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ExpressionStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout ExpressionStmtSyntaxBuilder) -> Void) {
    var builder = ExpressionStmtSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct RepeatWhileStmtSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.identifier("")),
    RawSyntax.missingToken(.colon),
    RawSyntax.missingToken(.repeatKeyword),
    RawSyntax.missing(.codeBlock),
    RawSyntax.missingToken(.whileKeyword),
    RawSyntax.missing(.expr),
    RawSyntax.missingToken(.semicolon),
  ]
  internal init() {}

  public mutating func useLabelName(_ node: TokenSyntax) {
    let idx = RepeatWhileStmtSyntax.Cursor.labelName.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLabelColon(_ node: TokenSyntax) {
    let idx = RepeatWhileStmtSyntax.Cursor.labelColon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useRepeatKeyword(_ node: TokenSyntax) {
    let idx = RepeatWhileStmtSyntax.Cursor.repeatKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useBody(_ node: CodeBlockSyntax) {
    let idx = RepeatWhileStmtSyntax.Cursor.body.rawValue
    layout[idx] = node.raw
  }

  public mutating func useWhileKeyword(_ node: TokenSyntax) {
    let idx = RepeatWhileStmtSyntax.Cursor.whileKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useCondition(_ node: ExprSyntax) {
    let idx = RepeatWhileStmtSyntax.Cursor.condition.rawValue
    layout[idx] = node.raw
  }

  public mutating func useSemicolon(_ node: TokenSyntax) {
    let idx = RepeatWhileStmtSyntax.Cursor.semicolon.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.repeatWhileStmt,
                                 layout, .present))
  }
}

extension RepeatWhileStmtSyntax {
  /// Creates a `RepeatWhileStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `RepeatWhileStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `RepeatWhileStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout RepeatWhileStmtSyntaxBuilder) -> Void) {
    var builder = RepeatWhileStmtSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct GuardStmtSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.guardKeyword),
    RawSyntax.missing(.conditionList),
    RawSyntax.missingToken(.elseKeyword),
    RawSyntax.missing(.codeBlock),
    RawSyntax.missingToken(.semicolon),
  ]
  internal init() {}

  public mutating func useGuardKeyword(_ node: TokenSyntax) {
    let idx = GuardStmtSyntax.Cursor.guardKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func addCondition(_ elt: ConditionSyntax) {
    let idx = GuardStmtSyntax.Cursor.conditions.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  public mutating func useElseKeyword(_ node: TokenSyntax) {
    let idx = GuardStmtSyntax.Cursor.elseKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useBody(_ node: CodeBlockSyntax) {
    let idx = GuardStmtSyntax.Cursor.body.rawValue
    layout[idx] = node.raw
  }

  public mutating func useSemicolon(_ node: TokenSyntax) {
    let idx = GuardStmtSyntax.Cursor.semicolon.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.guardStmt,
                                 layout, .present))
  }
}

extension GuardStmtSyntax {
  /// Creates a `GuardStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `GuardStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `GuardStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout GuardStmtSyntaxBuilder) -> Void) {
    var builder = GuardStmtSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct WhereClauseSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.whereKeyword),
    RawSyntax.missing(.exprList),
  ]
  internal init() {}

  public mutating func useWhereKeyword(_ node: TokenSyntax) {
    let idx = WhereClauseSyntax.Cursor.whereKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func addExpression(_ elt: ExprSyntax) {
    let idx = WhereClauseSyntax.Cursor.expressions.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.whereClause,
                                 layout, .present))
  }
}

extension WhereClauseSyntax {
  /// Creates a `WhereClauseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `WhereClauseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `WhereClauseSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout WhereClauseSyntaxBuilder) -> Void) {
    var builder = WhereClauseSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct ForInStmtSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.identifier("")),
    RawSyntax.missingToken(.colon),
    RawSyntax.missingToken(.forKeyword),
    RawSyntax.missingToken(.caseKeyword),
    RawSyntax.missing(.pattern),
    RawSyntax.missingToken(.inKeyword),
    RawSyntax.missing(.expr),
    RawSyntax.missing(.whereClause),
    RawSyntax.missing(.codeBlock),
    RawSyntax.missingToken(.semicolon),
  ]
  internal init() {}

  public mutating func useLabelName(_ node: TokenSyntax) {
    let idx = ForInStmtSyntax.Cursor.labelName.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLabelColon(_ node: TokenSyntax) {
    let idx = ForInStmtSyntax.Cursor.labelColon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useForKeyword(_ node: TokenSyntax) {
    let idx = ForInStmtSyntax.Cursor.forKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useCaseKeyword(_ node: TokenSyntax) {
    let idx = ForInStmtSyntax.Cursor.caseKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useItemPattern(_ node: PatternSyntax) {
    let idx = ForInStmtSyntax.Cursor.itemPattern.rawValue
    layout[idx] = node.raw
  }

  public mutating func useInKeyword(_ node: TokenSyntax) {
    let idx = ForInStmtSyntax.Cursor.inKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useCollectionExpr(_ node: ExprSyntax) {
    let idx = ForInStmtSyntax.Cursor.collectionExpr.rawValue
    layout[idx] = node.raw
  }

  public mutating func useWhereClause(_ node: WhereClauseSyntax) {
    let idx = ForInStmtSyntax.Cursor.whereClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useBody(_ node: CodeBlockSyntax) {
    let idx = ForInStmtSyntax.Cursor.body.rawValue
    layout[idx] = node.raw
  }

  public mutating func useSemicolon(_ node: TokenSyntax) {
    let idx = ForInStmtSyntax.Cursor.semicolon.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.forInStmt,
                                 layout, .present))
  }
}

extension ForInStmtSyntax {
  /// Creates a `ForInStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ForInStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ForInStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout ForInStmtSyntaxBuilder) -> Void) {
    var builder = ForInStmtSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct SwitchStmtSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.identifier("")),
    RawSyntax.missingToken(.colon),
    RawSyntax.missingToken(.switchKeyword),
    RawSyntax.missing(.expr),
    RawSyntax.missingToken(.leftBrace),
    RawSyntax.missing(.switchCaseList),
    RawSyntax.missingToken(.rightBrace),
    RawSyntax.missingToken(.semicolon),
  ]
  internal init() {}

  public mutating func useLabelName(_ node: TokenSyntax) {
    let idx = SwitchStmtSyntax.Cursor.labelName.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLabelColon(_ node: TokenSyntax) {
    let idx = SwitchStmtSyntax.Cursor.labelColon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useSwitchKeyword(_ node: TokenSyntax) {
    let idx = SwitchStmtSyntax.Cursor.switchKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useExpression(_ node: ExprSyntax) {
    let idx = SwitchStmtSyntax.Cursor.expression.rawValue
    layout[idx] = node.raw
  }

  public mutating func useOpenBrace(_ node: TokenSyntax) {
    let idx = SwitchStmtSyntax.Cursor.openBrace.rawValue
    layout[idx] = node.raw
  }

  public mutating func addSwitchCase(_ elt: SwitchCaseSyntax) {
    let idx = SwitchStmtSyntax.Cursor.cases.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  public mutating func useCloseBrace(_ node: TokenSyntax) {
    let idx = SwitchStmtSyntax.Cursor.closeBrace.rawValue
    layout[idx] = node.raw
  }

  public mutating func useSemicolon(_ node: TokenSyntax) {
    let idx = SwitchStmtSyntax.Cursor.semicolon.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.switchStmt,
                                 layout, .present))
  }
}

extension SwitchStmtSyntax {
  /// Creates a `SwitchStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SwitchStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SwitchStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout SwitchStmtSyntaxBuilder) -> Void) {
    var builder = SwitchStmtSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct DoStmtSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.identifier("")),
    RawSyntax.missingToken(.colon),
    RawSyntax.missingToken(.doKeyword),
    RawSyntax.missing(.codeBlock),
    RawSyntax.missing(.catchClauseList),
    RawSyntax.missingToken(.semicolon),
  ]
  internal init() {}

  public mutating func useLabelName(_ node: TokenSyntax) {
    let idx = DoStmtSyntax.Cursor.labelName.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLabelColon(_ node: TokenSyntax) {
    let idx = DoStmtSyntax.Cursor.labelColon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useDoKeyword(_ node: TokenSyntax) {
    let idx = DoStmtSyntax.Cursor.doKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useBody(_ node: CodeBlockSyntax) {
    let idx = DoStmtSyntax.Cursor.body.rawValue
    layout[idx] = node.raw
  }

  public mutating func addCatchClause(_ elt: CatchClauseSyntax) {
    let idx = DoStmtSyntax.Cursor.catchClauses.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  public mutating func useSemicolon(_ node: TokenSyntax) {
    let idx = DoStmtSyntax.Cursor.semicolon.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.doStmt,
                                 layout, .present))
  }
}

extension DoStmtSyntax {
  /// Creates a `DoStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DoStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DoStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout DoStmtSyntaxBuilder) -> Void) {
    var builder = DoStmtSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct ReturnStmtSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.returnKeyword),
    RawSyntax.missing(.expr),
    RawSyntax.missingToken(.semicolon),
  ]
  internal init() {}

  public mutating func useReturnKeyword(_ node: TokenSyntax) {
    let idx = ReturnStmtSyntax.Cursor.returnKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useExpression(_ node: ExprSyntax) {
    let idx = ReturnStmtSyntax.Cursor.expression.rawValue
    layout[idx] = node.raw
  }

  public mutating func useSemicolon(_ node: TokenSyntax) {
    let idx = ReturnStmtSyntax.Cursor.semicolon.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.returnStmt,
                                 layout, .present))
  }
}

extension ReturnStmtSyntax {
  /// Creates a `ReturnStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ReturnStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ReturnStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout ReturnStmtSyntaxBuilder) -> Void) {
    var builder = ReturnStmtSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct FallthroughStmtSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.fallthroughKeyword),
    RawSyntax.missingToken(.semicolon),
  ]
  internal init() {}

  public mutating func useFallthroughKeyword(_ node: TokenSyntax) {
    let idx = FallthroughStmtSyntax.Cursor.fallthroughKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useSemicolon(_ node: TokenSyntax) {
    let idx = FallthroughStmtSyntax.Cursor.semicolon.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.fallthroughStmt,
                                 layout, .present))
  }
}

extension FallthroughStmtSyntax {
  /// Creates a `FallthroughStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `FallthroughStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `FallthroughStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout FallthroughStmtSyntaxBuilder) -> Void) {
    var builder = FallthroughStmtSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct BreakStmtSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.breakKeyword),
    RawSyntax.missingToken(.identifier("")),
    RawSyntax.missingToken(.semicolon),
  ]
  internal init() {}

  public mutating func useBreakKeyword(_ node: TokenSyntax) {
    let idx = BreakStmtSyntax.Cursor.breakKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLabel(_ node: TokenSyntax) {
    let idx = BreakStmtSyntax.Cursor.label.rawValue
    layout[idx] = node.raw
  }

  public mutating func useSemicolon(_ node: TokenSyntax) {
    let idx = BreakStmtSyntax.Cursor.semicolon.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.breakStmt,
                                 layout, .present))
  }
}

extension BreakStmtSyntax {
  /// Creates a `BreakStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `BreakStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `BreakStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout BreakStmtSyntaxBuilder) -> Void) {
    var builder = BreakStmtSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct CodeBlockSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.leftBrace),
    RawSyntax.missing(.stmtList),
    RawSyntax.missingToken(.rightBrace),
  ]
  internal init() {}

  public mutating func useOpenBrace(_ node: TokenSyntax) {
    let idx = CodeBlockSyntax.Cursor.openBrace.rawValue
    layout[idx] = node.raw
  }

  public mutating func addStmt(_ elt: StmtSyntax) {
    let idx = CodeBlockSyntax.Cursor.statments.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  public mutating func useCloseBrace(_ node: TokenSyntax) {
    let idx = CodeBlockSyntax.Cursor.closeBrace.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.codeBlock,
                                 layout, .present))
  }
}

extension CodeBlockSyntax {
  /// Creates a `CodeBlockSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `CodeBlockSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `CodeBlockSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout CodeBlockSyntaxBuilder) -> Void) {
    var builder = CodeBlockSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct ConditionSyntaxBuilder {
  private var layout = [
    RawSyntax.missing(.unknown),
    RawSyntax.missingToken(.comma),
  ]
  internal init() {}

  public mutating func useCondition(_ node: Syntax) {
    let idx = ConditionSyntax.Cursor.condition.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = ConditionSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.condition,
                                 layout, .present))
  }
}

extension ConditionSyntax {
  /// Creates a `ConditionSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ConditionSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ConditionSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout ConditionSyntaxBuilder) -> Void) {
    var builder = ConditionSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct DeclarationStmtSyntaxBuilder {
  private var layout = [
    RawSyntax.missing(.decl),
    RawSyntax.missingToken(.semicolon),
  ]
  internal init() {}

  public mutating func useDeclaration(_ node: DeclSyntax) {
    let idx = DeclarationStmtSyntax.Cursor.declaration.rawValue
    layout[idx] = node.raw
  }

  public mutating func useSemicolon(_ node: TokenSyntax) {
    let idx = DeclarationStmtSyntax.Cursor.semicolon.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.declarationStmt,
                                 layout, .present))
  }
}

extension DeclarationStmtSyntax {
  /// Creates a `DeclarationStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DeclarationStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DeclarationStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout DeclarationStmtSyntaxBuilder) -> Void) {
    var builder = DeclarationStmtSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct ThrowStmtSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.throwKeyword),
    RawSyntax.missing(.expr),
    RawSyntax.missingToken(.semicolon),
  ]
  internal init() {}

  public mutating func useThrowKeyword(_ node: TokenSyntax) {
    let idx = ThrowStmtSyntax.Cursor.throwKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useExpression(_ node: ExprSyntax) {
    let idx = ThrowStmtSyntax.Cursor.expression.rawValue
    layout[idx] = node.raw
  }

  public mutating func useSemicolon(_ node: TokenSyntax) {
    let idx = ThrowStmtSyntax.Cursor.semicolon.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.throwStmt,
                                 layout, .present))
  }
}

extension ThrowStmtSyntax {
  /// Creates a `ThrowStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ThrowStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ThrowStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout ThrowStmtSyntaxBuilder) -> Void) {
    var builder = ThrowStmtSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct IfStmtSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.identifier("")),
    RawSyntax.missingToken(.colon),
    RawSyntax.missingToken(.ifKeyword),
    RawSyntax.missing(.conditionList),
    RawSyntax.missing(.codeBlock),
    RawSyntax.missing(.unknown),
    RawSyntax.missingToken(.semicolon),
  ]
  internal init() {}

  public mutating func useLabelName(_ node: TokenSyntax) {
    let idx = IfStmtSyntax.Cursor.labelName.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLabelColon(_ node: TokenSyntax) {
    let idx = IfStmtSyntax.Cursor.labelColon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useIfKeyword(_ node: TokenSyntax) {
    let idx = IfStmtSyntax.Cursor.ifKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func addCondition(_ elt: ConditionSyntax) {
    let idx = IfStmtSyntax.Cursor.conditions.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  public mutating func useBody(_ node: CodeBlockSyntax) {
    let idx = IfStmtSyntax.Cursor.body.rawValue
    layout[idx] = node.raw
  }

  public mutating func useElseClause(_ node: Syntax) {
    let idx = IfStmtSyntax.Cursor.elseClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useSemicolon(_ node: TokenSyntax) {
    let idx = IfStmtSyntax.Cursor.semicolon.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.ifStmt,
                                 layout, .present))
  }
}

extension IfStmtSyntax {
  /// Creates a `IfStmtSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `IfStmtSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `IfStmtSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout IfStmtSyntaxBuilder) -> Void) {
    var builder = IfStmtSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct ElseIfContinuationSyntaxBuilder {
  private var layout = [
    RawSyntax.missing(.ifStmt),
  ]
  internal init() {}

  public mutating func useIfStatement(_ node: IfStmtSyntax) {
    let idx = ElseIfContinuationSyntax.Cursor.ifStatement.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.elseIfContinuation,
                                 layout, .present))
  }
}

extension ElseIfContinuationSyntax {
  /// Creates a `ElseIfContinuationSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ElseIfContinuationSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ElseIfContinuationSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout ElseIfContinuationSyntaxBuilder) -> Void) {
    var builder = ElseIfContinuationSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct ElseBlockSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.elseKeyword),
    RawSyntax.missing(.codeBlock),
    RawSyntax.missingToken(.semicolon),
  ]
  internal init() {}

  public mutating func useElseKeyword(_ node: TokenSyntax) {
    let idx = ElseBlockSyntax.Cursor.elseKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useBody(_ node: CodeBlockSyntax) {
    let idx = ElseBlockSyntax.Cursor.body.rawValue
    layout[idx] = node.raw
  }

  public mutating func useSemicolon(_ node: TokenSyntax) {
    let idx = ElseBlockSyntax.Cursor.semicolon.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.elseBlock,
                                 layout, .present))
  }
}

extension ElseBlockSyntax {
  /// Creates a `ElseBlockSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ElseBlockSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ElseBlockSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout ElseBlockSyntaxBuilder) -> Void) {
    var builder = ElseBlockSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct SwitchCaseSyntaxBuilder {
  private var layout = [
    RawSyntax.missing(.unknown),
    RawSyntax.missing(.stmtList),
  ]
  internal init() {}

  public mutating func useLabel(_ node: Syntax) {
    let idx = SwitchCaseSyntax.Cursor.label.rawValue
    layout[idx] = node.raw
  }

  public mutating func addStmt(_ elt: StmtSyntax) {
    let idx = SwitchCaseSyntax.Cursor.body.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.switchCase,
                                 layout, .present))
  }
}

extension SwitchCaseSyntax {
  /// Creates a `SwitchCaseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SwitchCaseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SwitchCaseSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout SwitchCaseSyntaxBuilder) -> Void) {
    var builder = SwitchCaseSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct SwitchDefaultLabelSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.defaultKeyword),
    RawSyntax.missingToken(.colon),
  ]
  internal init() {}

  public mutating func useDefaultKeyword(_ node: TokenSyntax) {
    let idx = SwitchDefaultLabelSyntax.Cursor.defaultKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = SwitchDefaultLabelSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.switchDefaultLabel,
                                 layout, .present))
  }
}

extension SwitchDefaultLabelSyntax {
  /// Creates a `SwitchDefaultLabelSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SwitchDefaultLabelSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SwitchDefaultLabelSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout SwitchDefaultLabelSyntaxBuilder) -> Void) {
    var builder = SwitchDefaultLabelSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct CaseItemSyntaxBuilder {
  private var layout = [
    RawSyntax.missing(.pattern),
    RawSyntax.missing(.whereClause),
    RawSyntax.missingToken(.comma),
  ]
  internal init() {}

  public mutating func usePattern(_ node: PatternSyntax) {
    let idx = CaseItemSyntax.Cursor.pattern.rawValue
    layout[idx] = node.raw
  }

  public mutating func useWhereClause(_ node: WhereClauseSyntax) {
    let idx = CaseItemSyntax.Cursor.whereClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useComma(_ node: TokenSyntax) {
    let idx = CaseItemSyntax.Cursor.comma.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.caseItem,
                                 layout, .present))
  }
}

extension CaseItemSyntax {
  /// Creates a `CaseItemSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `CaseItemSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `CaseItemSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout CaseItemSyntaxBuilder) -> Void) {
    var builder = CaseItemSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct SwitchCaseLabelSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.caseKeyword),
    RawSyntax.missing(.caseItemList),
    RawSyntax.missingToken(.colon),
  ]
  internal init() {}

  public mutating func useCaseKeyword(_ node: TokenSyntax) {
    let idx = SwitchCaseLabelSyntax.Cursor.caseKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func addCaseItem(_ elt: CaseItemSyntax) {
    let idx = SwitchCaseLabelSyntax.Cursor.caseItems.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = SwitchCaseLabelSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.switchCaseLabel,
                                 layout, .present))
  }
}

extension SwitchCaseLabelSyntax {
  /// Creates a `SwitchCaseLabelSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SwitchCaseLabelSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SwitchCaseLabelSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout SwitchCaseLabelSyntaxBuilder) -> Void) {
    var builder = SwitchCaseLabelSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct CatchClauseSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.catchKeyword),
    RawSyntax.missing(.pattern),
    RawSyntax.missing(.whereClause),
    RawSyntax.missing(.codeBlock),
  ]
  internal init() {}

  public mutating func useCatchKeyword(_ node: TokenSyntax) {
    let idx = CatchClauseSyntax.Cursor.catchKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func usePattern(_ node: PatternSyntax) {
    let idx = CatchClauseSyntax.Cursor.pattern.rawValue
    layout[idx] = node.raw
  }

  public mutating func useWhereClause(_ node: WhereClauseSyntax) {
    let idx = CatchClauseSyntax.Cursor.whereClause.rawValue
    layout[idx] = node.raw
  }

  public mutating func useBody(_ node: CodeBlockSyntax) {
    let idx = CatchClauseSyntax.Cursor.body.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.catchClause,
                                 layout, .present))
  }
}

extension CatchClauseSyntax {
  /// Creates a `CatchClauseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `CatchClauseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `CatchClauseSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout CatchClauseSyntaxBuilder) -> Void) {
    var builder = CatchClauseSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct GenericWhereClauseSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.whereKeyword),
    RawSyntax.missing(.genericRequirementList),
  ]
  internal init() {}

  public mutating func useWhereKeyword(_ node: TokenSyntax) {
    let idx = GenericWhereClauseSyntax.Cursor.whereKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func addGenericRequirement(_ elt: Syntax) {
    let idx = GenericWhereClauseSyntax.Cursor.requirementList.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.genericWhereClause,
                                 layout, .present))
  }
}

extension GenericWhereClauseSyntax {
  /// Creates a `GenericWhereClauseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `GenericWhereClauseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `GenericWhereClauseSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout GenericWhereClauseSyntaxBuilder) -> Void) {
    var builder = GenericWhereClauseSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct SameTypeRequirementSyntaxBuilder {
  private var layout = [
    RawSyntax.missing(.type),
    RawSyntax.missingToken(.spacedBinaryOperator("")),
    RawSyntax.missing(.type),
    RawSyntax.missingToken(.comma),
  ]
  internal init() {}

  public mutating func useLeftTypeIdentifier(_ node: TypeSyntax) {
    let idx = SameTypeRequirementSyntax.Cursor.leftTypeIdentifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useEqualityToken(_ node: TokenSyntax) {
    let idx = SameTypeRequirementSyntax.Cursor.equalityToken.rawValue
    layout[idx] = node.raw
  }

  public mutating func useRightTypeIdentifier(_ node: TypeSyntax) {
    let idx = SameTypeRequirementSyntax.Cursor.rightTypeIdentifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = SameTypeRequirementSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.sameTypeRequirement,
                                 layout, .present))
  }
}

extension SameTypeRequirementSyntax {
  /// Creates a `SameTypeRequirementSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SameTypeRequirementSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SameTypeRequirementSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout SameTypeRequirementSyntaxBuilder) -> Void) {
    var builder = SameTypeRequirementSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct GenericParameterSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.identifier("")),
    RawSyntax.missingToken(.colon),
    RawSyntax.missing(.type),
    RawSyntax.missingToken(.comma),
  ]
  internal init() {}

  public mutating func useName(_ node: TokenSyntax) {
    let idx = GenericParameterSyntax.Cursor.name.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = GenericParameterSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useInheritedType(_ node: TypeSyntax) {
    let idx = GenericParameterSyntax.Cursor.inheritedType.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = GenericParameterSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.genericParameter,
                                 layout, .present))
  }
}

extension GenericParameterSyntax {
  /// Creates a `GenericParameterSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `GenericParameterSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `GenericParameterSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout GenericParameterSyntaxBuilder) -> Void) {
    var builder = GenericParameterSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct GenericParameterClauseSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.leftAngle),
    RawSyntax.missing(.genericParameterList),
    RawSyntax.missingToken(.rightAngle),
  ]
  internal init() {}

  public mutating func useLeftAngleBracket(_ node: TokenSyntax) {
    let idx = GenericParameterClauseSyntax.Cursor.leftAngleBracket.rawValue
    layout[idx] = node.raw
  }

  public mutating func addGenericParameter(_ elt: GenericParameterSyntax) {
    let idx = GenericParameterClauseSyntax.Cursor.genericParameterList.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  public mutating func useRightAngleBracket(_ node: TokenSyntax) {
    let idx = GenericParameterClauseSyntax.Cursor.rightAngleBracket.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.genericParameterClause,
                                 layout, .present))
  }
}

extension GenericParameterClauseSyntax {
  /// Creates a `GenericParameterClauseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `GenericParameterClauseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `GenericParameterClauseSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout GenericParameterClauseSyntaxBuilder) -> Void) {
    var builder = GenericParameterClauseSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct ConformanceRequirementSyntaxBuilder {
  private var layout = [
    RawSyntax.missing(.type),
    RawSyntax.missingToken(.colon),
    RawSyntax.missing(.type),
    RawSyntax.missingToken(.comma),
  ]
  internal init() {}

  public mutating func useLeftTypeIdentifier(_ node: TypeSyntax) {
    let idx = ConformanceRequirementSyntax.Cursor.leftTypeIdentifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = ConformanceRequirementSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useRightTypeIdentifier(_ node: TypeSyntax) {
    let idx = ConformanceRequirementSyntax.Cursor.rightTypeIdentifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = ConformanceRequirementSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.conformanceRequirement,
                                 layout, .present))
  }
}

extension ConformanceRequirementSyntax {
  /// Creates a `ConformanceRequirementSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ConformanceRequirementSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ConformanceRequirementSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout ConformanceRequirementSyntaxBuilder) -> Void) {
    var builder = ConformanceRequirementSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct SimpleTypeIdentifierSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.identifier("")),
    RawSyntax.missing(.genericArgumentClause),
  ]
  internal init() {}

  public mutating func useName(_ node: TokenSyntax) {
    let idx = SimpleTypeIdentifierSyntax.Cursor.name.rawValue
    layout[idx] = node.raw
  }

  public mutating func useGenericArgumentClause(_ node: GenericArgumentClauseSyntax) {
    let idx = SimpleTypeIdentifierSyntax.Cursor.genericArgumentClause.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.simpleTypeIdentifier,
                                 layout, .present))
  }
}

extension SimpleTypeIdentifierSyntax {
  /// Creates a `SimpleTypeIdentifierSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `SimpleTypeIdentifierSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `SimpleTypeIdentifierSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout SimpleTypeIdentifierSyntaxBuilder) -> Void) {
    var builder = SimpleTypeIdentifierSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct MemberTypeIdentifierSyntaxBuilder {
  private var layout = [
    RawSyntax.missing(.type),
    RawSyntax.missingToken(.period),
    RawSyntax.missingToken(.identifier("")),
    RawSyntax.missing(.genericArgumentClause),
  ]
  internal init() {}

  public mutating func useBaseType(_ node: TypeSyntax) {
    let idx = MemberTypeIdentifierSyntax.Cursor.baseType.rawValue
    layout[idx] = node.raw
  }

  public mutating func usePeriod(_ node: TokenSyntax) {
    let idx = MemberTypeIdentifierSyntax.Cursor.period.rawValue
    layout[idx] = node.raw
  }

  public mutating func useName(_ node: TokenSyntax) {
    let idx = MemberTypeIdentifierSyntax.Cursor.name.rawValue
    layout[idx] = node.raw
  }

  public mutating func useGenericArgumentClause(_ node: GenericArgumentClauseSyntax) {
    let idx = MemberTypeIdentifierSyntax.Cursor.genericArgumentClause.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.memberTypeIdentifier,
                                 layout, .present))
  }
}

extension MemberTypeIdentifierSyntax {
  /// Creates a `MemberTypeIdentifierSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `MemberTypeIdentifierSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `MemberTypeIdentifierSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout MemberTypeIdentifierSyntaxBuilder) -> Void) {
    var builder = MemberTypeIdentifierSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct ArrayTypeSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.leftSquareBracket),
    RawSyntax.missing(.type),
    RawSyntax.missingToken(.rightSquareBracket),
  ]
  internal init() {}

  public mutating func useLeftSquareBracket(_ node: TokenSyntax) {
    let idx = ArrayTypeSyntax.Cursor.leftSquareBracket.rawValue
    layout[idx] = node.raw
  }

  public mutating func useElementType(_ node: TypeSyntax) {
    let idx = ArrayTypeSyntax.Cursor.elementType.rawValue
    layout[idx] = node.raw
  }

  public mutating func useRightSquareBracket(_ node: TokenSyntax) {
    let idx = ArrayTypeSyntax.Cursor.rightSquareBracket.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.arrayType,
                                 layout, .present))
  }
}

extension ArrayTypeSyntax {
  /// Creates a `ArrayTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ArrayTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ArrayTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout ArrayTypeSyntaxBuilder) -> Void) {
    var builder = ArrayTypeSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct DictionaryTypeSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.leftSquareBracket),
    RawSyntax.missing(.type),
    RawSyntax.missingToken(.colon),
    RawSyntax.missing(.type),
    RawSyntax.missingToken(.rightSquareBracket),
  ]
  internal init() {}

  public mutating func useLeftSquareBracket(_ node: TokenSyntax) {
    let idx = DictionaryTypeSyntax.Cursor.leftSquareBracket.rawValue
    layout[idx] = node.raw
  }

  public mutating func useKeyType(_ node: TypeSyntax) {
    let idx = DictionaryTypeSyntax.Cursor.keyType.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = DictionaryTypeSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useValueType(_ node: TypeSyntax) {
    let idx = DictionaryTypeSyntax.Cursor.valueType.rawValue
    layout[idx] = node.raw
  }

  public mutating func useRightSquareBracket(_ node: TokenSyntax) {
    let idx = DictionaryTypeSyntax.Cursor.rightSquareBracket.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.dictionaryType,
                                 layout, .present))
  }
}

extension DictionaryTypeSyntax {
  /// Creates a `DictionaryTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `DictionaryTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `DictionaryTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout DictionaryTypeSyntaxBuilder) -> Void) {
    var builder = DictionaryTypeSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct MetatypeTypeSyntaxBuilder {
  private var layout = [
    RawSyntax.missing(.type),
    RawSyntax.missingToken(.period),
    RawSyntax.missingToken(.identifier("")),
  ]
  internal init() {}

  public mutating func useBaseType(_ node: TypeSyntax) {
    let idx = MetatypeTypeSyntax.Cursor.baseType.rawValue
    layout[idx] = node.raw
  }

  public mutating func usePeriod(_ node: TokenSyntax) {
    let idx = MetatypeTypeSyntax.Cursor.period.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTypeOrProtocol(_ node: TokenSyntax) {
    let idx = MetatypeTypeSyntax.Cursor.typeOrProtocol.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.metatypeType,
                                 layout, .present))
  }
}

extension MetatypeTypeSyntax {
  /// Creates a `MetatypeTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `MetatypeTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `MetatypeTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout MetatypeTypeSyntaxBuilder) -> Void) {
    var builder = MetatypeTypeSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct OptionalTypeSyntaxBuilder {
  private var layout = [
    RawSyntax.missing(.type),
    RawSyntax.missingToken(.postfixQuestionMark),
  ]
  internal init() {}

  public mutating func useWrappedType(_ node: TypeSyntax) {
    let idx = OptionalTypeSyntax.Cursor.wrappedType.rawValue
    layout[idx] = node.raw
  }

  public mutating func useQuestionMark(_ node: TokenSyntax) {
    let idx = OptionalTypeSyntax.Cursor.questionMark.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.optionalType,
                                 layout, .present))
  }
}

extension OptionalTypeSyntax {
  /// Creates a `OptionalTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `OptionalTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `OptionalTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout OptionalTypeSyntaxBuilder) -> Void) {
    var builder = OptionalTypeSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct ImplicitlyUnwrappedOptionalTypeSyntaxBuilder {
  private var layout = [
    RawSyntax.missing(.type),
    RawSyntax.missingToken(.exclamationMark),
  ]
  internal init() {}

  public mutating func useWrappedType(_ node: TypeSyntax) {
    let idx = ImplicitlyUnwrappedOptionalTypeSyntax.Cursor.wrappedType.rawValue
    layout[idx] = node.raw
  }

  public mutating func useExclamationMark(_ node: TokenSyntax) {
    let idx = ImplicitlyUnwrappedOptionalTypeSyntax.Cursor.exclamationMark.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.implicitlyUnwrappedOptionalType,
                                 layout, .present))
  }
}

extension ImplicitlyUnwrappedOptionalTypeSyntax {
  /// Creates a `ImplicitlyUnwrappedOptionalTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ImplicitlyUnwrappedOptionalTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ImplicitlyUnwrappedOptionalTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout ImplicitlyUnwrappedOptionalTypeSyntaxBuilder) -> Void) {
    var builder = ImplicitlyUnwrappedOptionalTypeSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct FunctionTypeSyntaxBuilder {
  private var layout = [
    RawSyntax.missing(.attributeList),
    RawSyntax.missingToken(.leftParen),
    RawSyntax.missing(.functionTypeArgumentList),
    RawSyntax.missingToken(.rightParen),
    RawSyntax.missingToken(.throwsKeyword),
    RawSyntax.missingToken(.arrow),
    RawSyntax.missing(.type),
  ]
  internal init() {}

  public mutating func addAttribute(_ elt: AttributeSyntax) {
    let idx = FunctionTypeSyntax.Cursor.typeAttributes.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = FunctionTypeSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func addFunctionTypeArgument(_ elt: FunctionTypeArgumentSyntax) {
    let idx = FunctionTypeSyntax.Cursor.argumentList.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = FunctionTypeSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func useThrowsOrRethrowsKeyword(_ node: TokenSyntax) {
    let idx = FunctionTypeSyntax.Cursor.throwsOrRethrowsKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useArrow(_ node: TokenSyntax) {
    let idx = FunctionTypeSyntax.Cursor.arrow.rawValue
    layout[idx] = node.raw
  }

  public mutating func useReturnType(_ node: TypeSyntax) {
    let idx = FunctionTypeSyntax.Cursor.returnType.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.functionType,
                                 layout, .present))
  }
}

extension FunctionTypeSyntax {
  /// Creates a `FunctionTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `FunctionTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `FunctionTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout FunctionTypeSyntaxBuilder) -> Void) {
    var builder = FunctionTypeSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct TupleTypeSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.leftParen),
    RawSyntax.missing(.tupleTypeElementList),
    RawSyntax.missingToken(.rightParen),
  ]
  internal init() {}

  public mutating func useLeftParen(_ node: TokenSyntax) {
    let idx = TupleTypeSyntax.Cursor.leftParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func addTupleTypeElement(_ elt: TupleTypeElementSyntax) {
    let idx = TupleTypeSyntax.Cursor.elements.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  public mutating func useRightParen(_ node: TokenSyntax) {
    let idx = TupleTypeSyntax.Cursor.rightParen.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.tupleType,
                                 layout, .present))
  }
}

extension TupleTypeSyntax {
  /// Creates a `TupleTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TupleTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TupleTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout TupleTypeSyntaxBuilder) -> Void) {
    var builder = TupleTypeSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct TupleTypeElementSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.identifier("")),
    RawSyntax.missingToken(.colon),
    RawSyntax.missing(.typeAnnotation),
    RawSyntax.missingToken(.comma),
  ]
  internal init() {}

  public mutating func useLabel(_ node: TokenSyntax) {
    let idx = TupleTypeElementSyntax.Cursor.label.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = TupleTypeElementSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTypeAnnotation(_ node: TypeAnnotationSyntax) {
    let idx = TupleTypeElementSyntax.Cursor.typeAnnotation.rawValue
    layout[idx] = node.raw
  }

  public mutating func useComma(_ node: TokenSyntax) {
    let idx = TupleTypeElementSyntax.Cursor.comma.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.tupleTypeElement,
                                 layout, .present))
  }
}

extension TupleTypeElementSyntax {
  /// Creates a `TupleTypeElementSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TupleTypeElementSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TupleTypeElementSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout TupleTypeElementSyntaxBuilder) -> Void) {
    var builder = TupleTypeElementSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct TypeAnnotationSyntaxBuilder {
  private var layout = [
    RawSyntax.missing(.attributeList),
    RawSyntax.missingToken(.inoutKeyword),
    RawSyntax.missing(.type),
  ]
  internal init() {}

  public mutating func addAttribute(_ elt: AttributeSyntax) {
    let idx = TypeAnnotationSyntax.Cursor.attributes.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  public mutating func useInOutKeyword(_ node: TokenSyntax) {
    let idx = TypeAnnotationSyntax.Cursor.inOutKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useType(_ node: TypeSyntax) {
    let idx = TypeAnnotationSyntax.Cursor.type.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.typeAnnotation,
                                 layout, .present))
  }
}

extension TypeAnnotationSyntax {
  /// Creates a `TypeAnnotationSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TypeAnnotationSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TypeAnnotationSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout TypeAnnotationSyntaxBuilder) -> Void) {
    var builder = TypeAnnotationSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct ProtocolCompositionElementSyntaxBuilder {
  private var layout = [
    RawSyntax.missing(.type),
    RawSyntax.missingToken(.ampersand),
  ]
  internal init() {}

  public mutating func useProtocolType(_ node: TypeSyntax) {
    let idx = ProtocolCompositionElementSyntax.Cursor.protocolType.rawValue
    layout[idx] = node.raw
  }

  public mutating func useAmpersand(_ node: TokenSyntax) {
    let idx = ProtocolCompositionElementSyntax.Cursor.ampersand.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.protocolCompositionElement,
                                 layout, .present))
  }
}

extension ProtocolCompositionElementSyntax {
  /// Creates a `ProtocolCompositionElementSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ProtocolCompositionElementSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ProtocolCompositionElementSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout ProtocolCompositionElementSyntaxBuilder) -> Void) {
    var builder = ProtocolCompositionElementSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct GenericArgumentSyntaxBuilder {
  private var layout = [
    RawSyntax.missing(.type),
    RawSyntax.missingToken(.comma),
  ]
  internal init() {}

  public mutating func useArgumentType(_ node: TypeSyntax) {
    let idx = GenericArgumentSyntax.Cursor.argumentType.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = GenericArgumentSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.genericArgument,
                                 layout, .present))
  }
}

extension GenericArgumentSyntax {
  /// Creates a `GenericArgumentSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `GenericArgumentSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `GenericArgumentSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout GenericArgumentSyntaxBuilder) -> Void) {
    var builder = GenericArgumentSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct GenericArgumentClauseSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.leftAngle),
    RawSyntax.missing(.genericArgumentList),
    RawSyntax.missingToken(.rightAngle),
  ]
  internal init() {}

  public mutating func useLeftAngleBracket(_ node: TokenSyntax) {
    let idx = GenericArgumentClauseSyntax.Cursor.leftAngleBracket.rawValue
    layout[idx] = node.raw
  }

  public mutating func addGenericArgument(_ elt: GenericArgumentSyntax) {
    let idx = GenericArgumentClauseSyntax.Cursor.arguments.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  public mutating func useRightAngleBracket(_ node: TokenSyntax) {
    let idx = GenericArgumentClauseSyntax.Cursor.rightAngleBracket.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.genericArgumentClause,
                                 layout, .present))
  }
}

extension GenericArgumentClauseSyntax {
  /// Creates a `GenericArgumentClauseSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `GenericArgumentClauseSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `GenericArgumentClauseSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout GenericArgumentClauseSyntaxBuilder) -> Void) {
    var builder = GenericArgumentClauseSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct FunctionTypeArgumentSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.identifier("")),
    RawSyntax.missingToken(.identifier("")),
    RawSyntax.missingToken(.colon),
    RawSyntax.missing(.typeAnnotation),
    RawSyntax.missingToken(.comma),
  ]
  internal init() {}

  public mutating func useExternalName(_ node: TokenSyntax) {
    let idx = FunctionTypeArgumentSyntax.Cursor.externalName.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLocalName(_ node: TokenSyntax) {
    let idx = FunctionTypeArgumentSyntax.Cursor.localName.rawValue
    layout[idx] = node.raw
  }

  public mutating func useColon(_ node: TokenSyntax) {
    let idx = FunctionTypeArgumentSyntax.Cursor.colon.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTypeAnnotation(_ node: TypeAnnotationSyntax) {
    let idx = FunctionTypeArgumentSyntax.Cursor.typeAnnotation.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTrailingComma(_ node: TokenSyntax) {
    let idx = FunctionTypeArgumentSyntax.Cursor.trailingComma.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.functionTypeArgument,
                                 layout, .present))
  }
}

extension FunctionTypeArgumentSyntax {
  /// Creates a `FunctionTypeArgumentSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `FunctionTypeArgumentSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `FunctionTypeArgumentSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout FunctionTypeArgumentSyntaxBuilder) -> Void) {
    var builder = FunctionTypeArgumentSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct ProtocolCompositionTypeSyntaxBuilder {
  private var layout = [
    RawSyntax.missing(.protocolCompositionElementList),
  ]
  internal init() {}

  public mutating func addProtocolCompositionElement(_ elt: ProtocolCompositionElementSyntax) {
    let idx = ProtocolCompositionTypeSyntax.Cursor.elements.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.protocolCompositionType,
                                 layout, .present))
  }
}

extension ProtocolCompositionTypeSyntax {
  /// Creates a `ProtocolCompositionTypeSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ProtocolCompositionTypeSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ProtocolCompositionTypeSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout ProtocolCompositionTypeSyntaxBuilder) -> Void) {
    var builder = ProtocolCompositionTypeSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct EnumCasePatternSyntaxBuilder {
  private var layout = [
    RawSyntax.missing(.type),
    RawSyntax.missingToken(.period),
    RawSyntax.missingToken(.identifier("")),
    RawSyntax.missing(.tuplePattern),
  ]
  internal init() {}

  public mutating func useType(_ node: TypeSyntax) {
    let idx = EnumCasePatternSyntax.Cursor.type.rawValue
    layout[idx] = node.raw
  }

  public mutating func usePeriod(_ node: TokenSyntax) {
    let idx = EnumCasePatternSyntax.Cursor.period.rawValue
    layout[idx] = node.raw
  }

  public mutating func useCaseName(_ node: TokenSyntax) {
    let idx = EnumCasePatternSyntax.Cursor.caseName.rawValue
    layout[idx] = node.raw
  }

  public mutating func useAssociatedTuple(_ node: TuplePatternSyntax) {
    let idx = EnumCasePatternSyntax.Cursor.associatedTuple.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.enumCasePattern,
                                 layout, .present))
  }
}

extension EnumCasePatternSyntax {
  /// Creates a `EnumCasePatternSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `EnumCasePatternSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `EnumCasePatternSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout EnumCasePatternSyntaxBuilder) -> Void) {
    var builder = EnumCasePatternSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct IsTypePatternSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.isKeyword),
    RawSyntax.missing(.type),
  ]
  internal init() {}

  public mutating func useIsKeyword(_ node: TokenSyntax) {
    let idx = IsTypePatternSyntax.Cursor.isKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useType(_ node: TypeSyntax) {
    let idx = IsTypePatternSyntax.Cursor.type.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.isTypePattern,
                                 layout, .present))
  }
}

extension IsTypePatternSyntax {
  /// Creates a `IsTypePatternSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `IsTypePatternSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `IsTypePatternSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout IsTypePatternSyntaxBuilder) -> Void) {
    var builder = IsTypePatternSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct OptionalPatternSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.identifier("")),
    RawSyntax.missingToken(.postfixQuestionMark),
  ]
  internal init() {}

  public mutating func useIdentifier(_ node: TokenSyntax) {
    let idx = OptionalPatternSyntax.Cursor.identifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useQuestionMark(_ node: TokenSyntax) {
    let idx = OptionalPatternSyntax.Cursor.questionMark.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.optionalPattern,
                                 layout, .present))
  }
}

extension OptionalPatternSyntax {
  /// Creates a `OptionalPatternSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `OptionalPatternSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `OptionalPatternSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout OptionalPatternSyntaxBuilder) -> Void) {
    var builder = OptionalPatternSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct IdentifierPatternSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.identifier("")),
    RawSyntax.missing(.typeAnnotation),
  ]
  internal init() {}

  public mutating func useIdentifier(_ node: TokenSyntax) {
    let idx = IdentifierPatternSyntax.Cursor.identifier.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTypeAnnotation(_ node: TypeAnnotationSyntax) {
    let idx = IdentifierPatternSyntax.Cursor.typeAnnotation.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.identifierPattern,
                                 layout, .present))
  }
}

extension IdentifierPatternSyntax {
  /// Creates a `IdentifierPatternSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `IdentifierPatternSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `IdentifierPatternSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout IdentifierPatternSyntaxBuilder) -> Void) {
    var builder = IdentifierPatternSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct AsTypePatternSyntaxBuilder {
  private var layout = [
    RawSyntax.missing(.pattern),
    RawSyntax.missingToken(.asKeyword),
    RawSyntax.missing(.type),
  ]
  internal init() {}

  public mutating func usePattern(_ node: PatternSyntax) {
    let idx = AsTypePatternSyntax.Cursor.pattern.rawValue
    layout[idx] = node.raw
  }

  public mutating func useAsKeyword(_ node: TokenSyntax) {
    let idx = AsTypePatternSyntax.Cursor.asKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useType(_ node: TypeSyntax) {
    let idx = AsTypePatternSyntax.Cursor.type.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.asTypePattern,
                                 layout, .present))
  }
}

extension AsTypePatternSyntax {
  /// Creates a `AsTypePatternSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `AsTypePatternSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `AsTypePatternSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout AsTypePatternSyntaxBuilder) -> Void) {
    var builder = AsTypePatternSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct TuplePatternSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.leftParen),
    RawSyntax.missing(.tuplePatternElementList),
    RawSyntax.missingToken(.rightParen),
    RawSyntax.missing(.typeAnnotation),
  ]
  internal init() {}

  public mutating func useOpenParen(_ node: TokenSyntax) {
    let idx = TuplePatternSyntax.Cursor.openParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func addTuplePatternElement(_ elt: TuplePatternElementSyntax) {
    let idx = TuplePatternSyntax.Cursor.elements.rawValue
    layout[idx] = layout[idx].appending(elt.raw)
  }

  public mutating func useCloseParen(_ node: TokenSyntax) {
    let idx = TuplePatternSyntax.Cursor.closeParen.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTypeAnnotation(_ node: TypeAnnotationSyntax) {
    let idx = TuplePatternSyntax.Cursor.typeAnnotation.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.tuplePattern,
                                 layout, .present))
  }
}

extension TuplePatternSyntax {
  /// Creates a `TuplePatternSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TuplePatternSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TuplePatternSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout TuplePatternSyntaxBuilder) -> Void) {
    var builder = TuplePatternSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct WildcardPatternSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.wildcardKeyword),
    RawSyntax.missing(.typeAnnotation),
  ]
  internal init() {}

  public mutating func useWildcard(_ node: TokenSyntax) {
    let idx = WildcardPatternSyntax.Cursor.wildcard.rawValue
    layout[idx] = node.raw
  }

  public mutating func useTypeAnnotation(_ node: TypeAnnotationSyntax) {
    let idx = WildcardPatternSyntax.Cursor.typeAnnotation.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.wildcardPattern,
                                 layout, .present))
  }
}

extension WildcardPatternSyntax {
  /// Creates a `WildcardPatternSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `WildcardPatternSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `WildcardPatternSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout WildcardPatternSyntaxBuilder) -> Void) {
    var builder = WildcardPatternSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct TuplePatternElementSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.identifier("")),
    RawSyntax.missingToken(.colon),
    RawSyntax.missing(.pattern),
    RawSyntax.missingToken(.comma),
  ]
  internal init() {}

  public mutating func useLabelName(_ node: TokenSyntax) {
    let idx = TuplePatternElementSyntax.Cursor.labelName.rawValue
    layout[idx] = node.raw
  }

  public mutating func useLabelColon(_ node: TokenSyntax) {
    let idx = TuplePatternElementSyntax.Cursor.labelColon.rawValue
    layout[idx] = node.raw
  }

  public mutating func usePattern(_ node: PatternSyntax) {
    let idx = TuplePatternElementSyntax.Cursor.pattern.rawValue
    layout[idx] = node.raw
  }

  public mutating func useComma(_ node: TokenSyntax) {
    let idx = TuplePatternElementSyntax.Cursor.comma.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.tuplePatternElement,
                                 layout, .present))
  }
}

extension TuplePatternElementSyntax {
  /// Creates a `TuplePatternElementSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `TuplePatternElementSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `TuplePatternElementSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout TuplePatternElementSyntaxBuilder) -> Void) {
    var builder = TuplePatternElementSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct ExpressionPatternSyntaxBuilder {
  private var layout = [
    RawSyntax.missing(.expr),
  ]
  internal init() {}

  public mutating func useExpression(_ node: ExprSyntax) {
    let idx = ExpressionPatternSyntax.Cursor.expression.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.expressionPattern,
                                 layout, .present))
  }
}

extension ExpressionPatternSyntax {
  /// Creates a `ExpressionPatternSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ExpressionPatternSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ExpressionPatternSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout ExpressionPatternSyntaxBuilder) -> Void) {
    var builder = ExpressionPatternSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

public struct ValueBindingPatternSyntaxBuilder {
  private var layout = [
    RawSyntax.missingToken(.letKeyword),
    RawSyntax.missing(.pattern),
  ]
  internal init() {}

  public mutating func useLetOrVarKeyword(_ node: TokenSyntax) {
    let idx = ValueBindingPatternSyntax.Cursor.letOrVarKeyword.rawValue
    layout[idx] = node.raw
  }

  public mutating func useValuePattern(_ node: PatternSyntax) {
    let idx = ValueBindingPatternSyntax.Cursor.valuePattern.rawValue
    layout[idx] = node.raw
  }

  internal func buildData() -> SyntaxData {
    return SyntaxData(raw: .node(.valueBindingPattern,
                                 layout, .present))
  }
}

extension ValueBindingPatternSyntax {
  /// Creates a `ValueBindingPatternSyntax` using the provided build function.
  /// - Parameter:
  ///   - build: A closure that wil be invoked in order to initialize
  ///            the fields of the syntax node.
  ///            This closure is passed a `ValueBindingPatternSyntaxBuilder` which you can use to
  ///            incrementally build the structure of the node.
  /// - Returns: A `ValueBindingPatternSyntax` with all the fields populated in the builder
  ///            closure.
  public convenience init(_ build: (inout ValueBindingPatternSyntaxBuilder) -> Void) {
    var builder = ValueBindingPatternSyntaxBuilder()
    build(&builder)
    let data = builder.buildData()
    self.init(root: data, data: data)
  }
}

