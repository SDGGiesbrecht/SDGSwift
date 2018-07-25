//// Automatically Generated From SyntaxNodes.swift.gyb.
//// Do Not Edit Directly!
//===------------ SyntaxNodes.swift - Syntax Node definitions -------------===//
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


public class DeclSyntax: Syntax {

}
public class UnknownDeclSyntax: DeclSyntax {

}
public class ExprSyntax: Syntax {

}
public class UnknownExprSyntax: ExprSyntax {

}
public class StmtSyntax: Syntax {

}
public class UnknownStmtSyntax: StmtSyntax {

}
public class TypeSyntax: Syntax {

}
public class UnknownTypeSyntax: TypeSyntax {

}
public class PatternSyntax: Syntax {

}
public class UnknownPatternSyntax: PatternSyntax {

}
public class InOutExprSyntax: ExprSyntax {
  enum Cursor: Int {
    case ampersand
    case identifier
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 2)
    let _ampersand = raw[Cursor.ampersandToken]
    guard let _ampersandTokenKind = _ampersand.tokenKind else {
      fatalError("expected token child, got \(_ampersand.kind)")
    }
    precondition([.ampersand].contains(_ampersandTokenKind),
      "expected one of [.ampersand] for 'ampersand' " + 
      "in node of kind inOutExpr")
    let _identifier = raw[Cursor.identifierToken]
    guard let _identifierTokenKind = _identifier.tokenKind else {
      fatalError("expected token child, got \(_identifier.kind)")
    }
    precondition([.identifier].contains(_identifierTokenKind),
      "expected one of [.identifier] for 'identifier' " + 
      "in node of kind inOutExpr")
  }
#endif

  public var ampersand: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.ampersand))
  }

  public func withAmpersand(
    _ newTokenSyntax: TokenSyntax?) -> InOutExprSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.ampersand)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.ampersand)
    return InOutExprSyntax(root: root, data: newData)
  }

  public var identifier: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.identifier))
  }

  public func withIdentifier(
    _ newTokenSyntax: TokenSyntax?) -> InOutExprSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.identifier(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.identifier)
    return InOutExprSyntax(root: root, data: newData)
  }
}
public class PoundColumnExprSyntax: ExprSyntax {
  enum Cursor: Int {
    case poundColumn
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 1)
    let _poundColumn = raw[Cursor.poundColumnToken]
    guard let _poundColumnTokenKind = _poundColumn.tokenKind else {
      fatalError("expected token child, got \(_poundColumn.kind)")
    }
    precondition([.poundColumnKeyword].contains(_poundColumnTokenKind),
      "expected one of [.poundColumnKeyword] for 'poundColumn' " + 
      "in node of kind poundColumnExpr")
  }
#endif

  public var poundColumn: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.poundColumn))
  }

  public func withPoundColumn(
    _ newTokenSyntax: TokenSyntax?) -> PoundColumnExprSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.poundColumnKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.poundColumn)
    return PoundColumnExprSyntax(root: root, data: newData)
  }
}
public typealias FunctionCallArgumentListSyntax = SyntaxCollection<FunctionCallArgumentSyntax>
public typealias TupleElementListSyntax = SyntaxCollection<TupleElementSyntax>
public typealias ArrayElementListSyntax = SyntaxCollection<ArrayElementSyntax>
public typealias DictionaryElementListSyntax = SyntaxCollection<DictionaryElementSyntax>
public class TryOperatorSyntax: Syntax {
  enum Cursor: Int {
    case tryKeyword
    case questionOrExclamationMark
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 2)
    let _tryKeyword = raw[Cursor.tryToken]
    guard let _tryKeywordTokenKind = _tryKeyword.tokenKind else {
      fatalError("expected token child, got \(_tryKeyword.kind)")
    }
    precondition([.tryKeyword].contains(_tryKeywordTokenKind),
      "expected one of [.tryKeyword] for 'tryKeyword' " + 
      "in node of kind tryOperator")
    let _questionOrExclamationMark = raw[Cursor.token]
    guard let _questionOrExclamationMarkTokenKind = _questionOrExclamationMark.tokenKind else {
      fatalError("expected token child, got \(_questionOrExclamationMark.kind)")
    }
    precondition([.postfixQuestionMark, .exclamationMark].contains(_questionOrExclamationMarkTokenKind),
      "expected one of [.postfixQuestionMark, .exclamationMark] for 'questionOrExclamationMark' " + 
      "in node of kind tryOperator")
  }
#endif

  public var tryKeyword: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.tryKeyword))
  }

  public func withTryKeyword(
    _ newTokenSyntax: TokenSyntax?) -> TryOperatorSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.tryKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.tryKeyword)
    return TryOperatorSyntax(root: root, data: newData)
  }

  public var questionOrExclamationMark: TokenSyntax? {
    guard raw[Cursor.questionOrExclamationMark].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.questionOrExclamationMark))
  }

  public func withQuestionOrExclamationMark(
    _ newTokenSyntax: TokenSyntax?) -> TryOperatorSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.postfixQuestionMark)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.questionOrExclamationMark)
    return TryOperatorSyntax(root: root, data: newData)
  }
}
public class IdentifierExprSyntax: ExprSyntax {
  enum Cursor: Int {
    case identifier
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 1)
    let _identifier = raw[Cursor.identifierToken]
    guard let _identifierTokenKind = _identifier.tokenKind else {
      fatalError("expected token child, got \(_identifier.kind)")
    }
    precondition([.identifier].contains(_identifierTokenKind),
      "expected one of [.identifier] for 'identifier' " + 
      "in node of kind identifierExpr")
  }
#endif

  public var identifier: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.identifier))
  }

  public func withIdentifier(
    _ newTokenSyntax: TokenSyntax?) -> IdentifierExprSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.identifier(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.identifier)
    return IdentifierExprSyntax(root: root, data: newData)
  }
}
public class NilLiteralExprSyntax: ExprSyntax {
  enum Cursor: Int {
    case nilKeyword
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 1)
    let _nilKeyword = raw[Cursor.nilToken]
    guard let _nilKeywordTokenKind = _nilKeyword.tokenKind else {
      fatalError("expected token child, got \(_nilKeyword.kind)")
    }
    precondition([.nilKeyword].contains(_nilKeywordTokenKind),
      "expected one of [.nilKeyword] for 'nilKeyword' " + 
      "in node of kind nilLiteralExpr")
  }
#endif

  public var nilKeyword: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.nilKeyword))
  }

  public func withNilKeyword(
    _ newTokenSyntax: TokenSyntax?) -> NilLiteralExprSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.nilKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.nilKeyword)
    return NilLiteralExprSyntax(root: root, data: newData)
  }
}
public class DiscardAssignmentExprSyntax: ExprSyntax {
  enum Cursor: Int {
    case wildcard
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 1)
    let _wildcard = raw[Cursor.wildcardToken]
    guard let _wildcardTokenKind = _wildcard.tokenKind else {
      fatalError("expected token child, got \(_wildcard.kind)")
    }
    precondition([.wildcardKeyword].contains(_wildcardTokenKind),
      "expected one of [.wildcardKeyword] for 'wildcard' " + 
      "in node of kind discardAssignmentExpr")
  }
#endif

  public var wildcard: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.wildcard))
  }

  public func withWildcard(
    _ newTokenSyntax: TokenSyntax?) -> DiscardAssignmentExprSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.wildcardKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.wildcard)
    return DiscardAssignmentExprSyntax(root: root, data: newData)
  }
}
public class AssignmentExprSyntax: ExprSyntax {
  enum Cursor: Int {
    case assignToken
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 1)
    let _assignToken = raw[Cursor.equalToken]
    guard let _assignTokenTokenKind = _assignToken.tokenKind else {
      fatalError("expected token child, got \(_assignToken.kind)")
    }
    precondition([.equal].contains(_assignTokenTokenKind),
      "expected one of [.equal] for 'assignToken' " + 
      "in node of kind assignmentExpr")
  }
#endif

  public var assignToken: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.assignToken))
  }

  public func withAssignToken(
    _ newTokenSyntax: TokenSyntax?) -> AssignmentExprSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.equal)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.assignToken)
    return AssignmentExprSyntax(root: root, data: newData)
  }
}
public class SequenceExprSyntax: ExprSyntax {
  enum Cursor: Int {
    case elements
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 1)
    let _elements = raw[Cursor.exprList]
    precondition(_elements.kind == .exprList,
                 "expected child of kind .exprList, " +
                 "got \(_elements.kind)")
  }
#endif

  public var elements: ExprListSyntax {
    return ExprListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.elements))
  }

  public func addExpression(_ elt: ExprSyntax) -> SequenceExprSyntax {
    let childRaw = raw[Cursor.elements].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.elements)
    return SequenceExprSyntax(root: root, data: newData)
  }

  public func withElements(
    _ newExprListSyntax: ExprListSyntax?) -> SequenceExprSyntax {
    let raw = newExprListSyntax?.raw ?? RawSyntax.missing(.exprList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.elements)
    return SequenceExprSyntax(root: root, data: newData)
  }
}
public class PoundLineExprSyntax: ExprSyntax {
  enum Cursor: Int {
    case poundLine
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 1)
    let _poundLine = raw[Cursor.poundLineToken]
    guard let _poundLineTokenKind = _poundLine.tokenKind else {
      fatalError("expected token child, got \(_poundLine.kind)")
    }
    precondition([.poundLineKeyword].contains(_poundLineTokenKind),
      "expected one of [.poundLineKeyword] for 'poundLine' " + 
      "in node of kind poundLineExpr")
  }
#endif

  public var poundLine: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.poundLine))
  }

  public func withPoundLine(
    _ newTokenSyntax: TokenSyntax?) -> PoundLineExprSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.poundLineKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.poundLine)
    return PoundLineExprSyntax(root: root, data: newData)
  }
}
public class PoundFileExprSyntax: ExprSyntax {
  enum Cursor: Int {
    case poundFile
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 1)
    let _poundFile = raw[Cursor.poundFileToken]
    guard let _poundFileTokenKind = _poundFile.tokenKind else {
      fatalError("expected token child, got \(_poundFile.kind)")
    }
    precondition([.poundFileKeyword].contains(_poundFileTokenKind),
      "expected one of [.poundFileKeyword] for 'poundFile' " + 
      "in node of kind poundFileExpr")
  }
#endif

  public var poundFile: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.poundFile))
  }

  public func withPoundFile(
    _ newTokenSyntax: TokenSyntax?) -> PoundFileExprSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.poundFileKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.poundFile)
    return PoundFileExprSyntax(root: root, data: newData)
  }
}
public class PoundFunctionExprSyntax: ExprSyntax {
  enum Cursor: Int {
    case poundFunction
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 1)
    let _poundFunction = raw[Cursor.poundFunctionToken]
    guard let _poundFunctionTokenKind = _poundFunction.tokenKind else {
      fatalError("expected token child, got \(_poundFunction.kind)")
    }
    precondition([.poundFunctionKeyword].contains(_poundFunctionTokenKind),
      "expected one of [.poundFunctionKeyword] for 'poundFunction' " + 
      "in node of kind poundFunctionExpr")
  }
#endif

  public var poundFunction: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.poundFunction))
  }

  public func withPoundFunction(
    _ newTokenSyntax: TokenSyntax?) -> PoundFunctionExprSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.poundFunctionKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.poundFunction)
    return PoundFunctionExprSyntax(root: root, data: newData)
  }
}
public class SymbolicReferenceExprSyntax: ExprSyntax {
  enum Cursor: Int {
    case identifier
    case genericArgumentClause
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 2)
    let _identifier = raw[Cursor.identifierToken]
    guard let _identifierTokenKind = _identifier.tokenKind else {
      fatalError("expected token child, got \(_identifier.kind)")
    }
    precondition([.identifier].contains(_identifierTokenKind),
      "expected one of [.identifier] for 'identifier' " + 
      "in node of kind symbolicReferenceExpr")
    let _genericArgumentClause = raw[Cursor.genericArgumentClause]
    precondition(_genericArgumentClause.kind == .genericArgumentClause,
                 "expected child of kind .genericArgumentClause, " +
                 "got \(_genericArgumentClause.kind)")
  }
#endif

  public var identifier: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.identifier))
  }

  public func withIdentifier(
    _ newTokenSyntax: TokenSyntax?) -> SymbolicReferenceExprSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.identifier(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.identifier)
    return SymbolicReferenceExprSyntax(root: root, data: newData)
  }

  public var genericArgumentClause: GenericArgumentClauseSyntax? {
    guard raw[Cursor.genericArgumentClause].isPresent else { return nil }
    return GenericArgumentClauseSyntax(root: _root,
      data: data.cachedChild(at: Cursor.genericArgumentClause))
  }

  public func withGenericArgumentClause(
    _ newGenericArgumentClauseSyntax: GenericArgumentClauseSyntax?) -> SymbolicReferenceExprSyntax {
    let raw = newGenericArgumentClauseSyntax?.raw ?? RawSyntax.missing(.genericArgumentClause)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.genericArgumentClause)
    return SymbolicReferenceExprSyntax(root: root, data: newData)
  }
}
public class PrefixOperatorExprSyntax: ExprSyntax {
  enum Cursor: Int {
    case operatorToken
    case postfixExpression
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 2)
    let _operatorToken = raw[Cursor.prefixOperatorToken]
    guard let _operatorTokenTokenKind = _operatorToken.tokenKind else {
      fatalError("expected token child, got \(_operatorToken.kind)")
    }
    precondition([.prefixOperator].contains(_operatorTokenTokenKind),
      "expected one of [.prefixOperator] for 'operatorToken' " + 
      "in node of kind prefixOperatorExpr")
    let _postfixExpression = raw[Cursor.expr]
    precondition(_postfixExpression.kind == .expr,
                 "expected child of kind .expr, " +
                 "got \(_postfixExpression.kind)")
  }
#endif

  public var operatorToken: TokenSyntax? {
    guard raw[Cursor.operatorToken].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.operatorToken))
  }

  public func withOperatorToken(
    _ newTokenSyntax: TokenSyntax?) -> PrefixOperatorExprSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.prefixOperator(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.operatorToken)
    return PrefixOperatorExprSyntax(root: root, data: newData)
  }

  public var postfixExpression: ExprSyntax {
    return ExprSyntax(root: _root,
      data: data.cachedChild(at: Cursor.postfixExpression))
  }

  public func withPostfixExpression(
    _ newExprSyntax: ExprSyntax?) -> PrefixOperatorExprSyntax {
    let raw = newExprSyntax?.raw ?? RawSyntax.missing(.expr)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.postfixExpression)
    return PrefixOperatorExprSyntax(root: root, data: newData)
  }
}
public class BinaryOperatorExprSyntax: ExprSyntax {
  enum Cursor: Int {
    case operatorToken
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 1)
    let _operatorToken = raw[Cursor.binaryOperatorToken]
    precondition(_operatorToken.kind == .binaryOperatorToken,
                 "expected child of kind .binaryOperatorToken, " +
                 "got \(_operatorToken.kind)")
  }
#endif

  public var operatorToken: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.operatorToken))
  }

  public func withOperatorToken(
    _ newTokenSyntax: TokenSyntax?) -> BinaryOperatorExprSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.unknown)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.operatorToken)
    return BinaryOperatorExprSyntax(root: root, data: newData)
  }
}
public class FloatLiteralExprSyntax: ExprSyntax {
  enum Cursor: Int {
    case floatingDigits
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 1)
    let _floatingDigits = raw[Cursor.floatingLiteralToken]
    guard let _floatingDigitsTokenKind = _floatingDigits.tokenKind else {
      fatalError("expected token child, got \(_floatingDigits.kind)")
    }
    precondition([.floatingLiteral].contains(_floatingDigitsTokenKind),
      "expected one of [.floatingLiteral] for 'floatingDigits' " + 
      "in node of kind floatLiteralExpr")
  }
#endif

  public var floatingDigits: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.floatingDigits))
  }

  public func withFloatingDigits(
    _ newTokenSyntax: TokenSyntax?) -> FloatLiteralExprSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.floatingLiteral(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.floatingDigits)
    return FloatLiteralExprSyntax(root: root, data: newData)
  }
}
public class FunctionCallExprSyntax: ExprSyntax {
  enum Cursor: Int {
    case calledExpression
    case leftParen
    case argumentList
    case rightParen
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 4)
    let _calledExpression = raw[Cursor.expr]
    precondition(_calledExpression.kind == .expr,
                 "expected child of kind .expr, " +
                 "got \(_calledExpression.kind)")
    let _leftParen = raw[Cursor.leftParenToken]
    guard let _leftParenTokenKind = _leftParen.tokenKind else {
      fatalError("expected token child, got \(_leftParen.kind)")
    }
    precondition([.leftParen].contains(_leftParenTokenKind),
      "expected one of [.leftParen] for 'leftParen' " + 
      "in node of kind functionCallExpr")
    let _argumentList = raw[Cursor.functionCallArgumentList]
    precondition(_argumentList.kind == .functionCallArgumentList,
                 "expected child of kind .functionCallArgumentList, " +
                 "got \(_argumentList.kind)")
    let _rightParen = raw[Cursor.rightParenToken]
    guard let _rightParenTokenKind = _rightParen.tokenKind else {
      fatalError("expected token child, got \(_rightParen.kind)")
    }
    precondition([.rightParen].contains(_rightParenTokenKind),
      "expected one of [.rightParen] for 'rightParen' " + 
      "in node of kind functionCallExpr")
  }
#endif

  public var calledExpression: ExprSyntax {
    return ExprSyntax(root: _root,
      data: data.cachedChild(at: Cursor.calledExpression))
  }

  public func withCalledExpression(
    _ newExprSyntax: ExprSyntax?) -> FunctionCallExprSyntax {
    let raw = newExprSyntax?.raw ?? RawSyntax.missing(.expr)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.calledExpression)
    return FunctionCallExprSyntax(root: root, data: newData)
  }

  public var leftParen: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.leftParen))
  }

  public func withLeftParen(
    _ newTokenSyntax: TokenSyntax?) -> FunctionCallExprSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.leftParen)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.leftParen)
    return FunctionCallExprSyntax(root: root, data: newData)
  }

  public var argumentList: FunctionCallArgumentListSyntax {
    return FunctionCallArgumentListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.argumentList))
  }

  public func addFunctionCallArgument(_ elt: FunctionCallArgumentSyntax) -> FunctionCallExprSyntax {
    let childRaw = raw[Cursor.argumentList].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.argumentList)
    return FunctionCallExprSyntax(root: root, data: newData)
  }

  public func withArgumentList(
    _ newFunctionCallArgumentListSyntax: FunctionCallArgumentListSyntax?) -> FunctionCallExprSyntax {
    let raw = newFunctionCallArgumentListSyntax?.raw ?? RawSyntax.missing(.functionCallArgumentList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.argumentList)
    return FunctionCallExprSyntax(root: root, data: newData)
  }

  public var rightParen: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.rightParen))
  }

  public func withRightParen(
    _ newTokenSyntax: TokenSyntax?) -> FunctionCallExprSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.rightParen)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.rightParen)
    return FunctionCallExprSyntax(root: root, data: newData)
  }
}
public class TupleExprSyntax: ExprSyntax {
  enum Cursor: Int {
    case leftParen
    case elementList
    case rightParen
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 3)
    let _leftParen = raw[Cursor.leftParenToken]
    guard let _leftParenTokenKind = _leftParen.tokenKind else {
      fatalError("expected token child, got \(_leftParen.kind)")
    }
    precondition([.leftParen].contains(_leftParenTokenKind),
      "expected one of [.leftParen] for 'leftParen' " + 
      "in node of kind tupleExpr")
    let _elementList = raw[Cursor.tupleElementList]
    precondition(_elementList.kind == .tupleElementList,
                 "expected child of kind .tupleElementList, " +
                 "got \(_elementList.kind)")
    let _rightParen = raw[Cursor.rightParenToken]
    guard let _rightParenTokenKind = _rightParen.tokenKind else {
      fatalError("expected token child, got \(_rightParen.kind)")
    }
    precondition([.rightParen].contains(_rightParenTokenKind),
      "expected one of [.rightParen] for 'rightParen' " + 
      "in node of kind tupleExpr")
  }
#endif

  public var leftParen: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.leftParen))
  }

  public func withLeftParen(
    _ newTokenSyntax: TokenSyntax?) -> TupleExprSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.leftParen)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.leftParen)
    return TupleExprSyntax(root: root, data: newData)
  }

  public var elementList: TupleElementListSyntax {
    return TupleElementListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.elementList))
  }

  public func addTupleElement(_ elt: TupleElementSyntax) -> TupleExprSyntax {
    let childRaw = raw[Cursor.elementList].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.elementList)
    return TupleExprSyntax(root: root, data: newData)
  }

  public func withElementList(
    _ newTupleElementListSyntax: TupleElementListSyntax?) -> TupleExprSyntax {
    let raw = newTupleElementListSyntax?.raw ?? RawSyntax.missing(.tupleElementList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.elementList)
    return TupleExprSyntax(root: root, data: newData)
  }

  public var rightParen: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.rightParen))
  }

  public func withRightParen(
    _ newTokenSyntax: TokenSyntax?) -> TupleExprSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.rightParen)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.rightParen)
    return TupleExprSyntax(root: root, data: newData)
  }
}
public class ArrayExprSyntax: ExprSyntax {
  enum Cursor: Int {
    case leftSquare
    case elements
    case rightSquare
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 3)
    let _leftSquare = raw[Cursor.leftSquareToken]
    precondition(_leftSquare.kind == .leftSquareToken,
                 "expected child of kind .leftSquareToken, " +
                 "got \(_leftSquare.kind)")
    let _elements = raw[Cursor.arrayElementList]
    precondition(_elements.kind == .arrayElementList,
                 "expected child of kind .arrayElementList, " +
                 "got \(_elements.kind)")
    let _rightSquare = raw[Cursor.rightSquareToken]
    precondition(_rightSquare.kind == .rightSquareToken,
                 "expected child of kind .rightSquareToken, " +
                 "got \(_rightSquare.kind)")
  }
#endif

  public var leftSquare: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.leftSquare))
  }

  public func withLeftSquare(
    _ newTokenSyntax: TokenSyntax?) -> ArrayExprSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.unknown)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.leftSquare)
    return ArrayExprSyntax(root: root, data: newData)
  }

  public var elements: ArrayElementListSyntax {
    return ArrayElementListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.elements))
  }

  public func addArrayElement(_ elt: ArrayElementSyntax) -> ArrayExprSyntax {
    let childRaw = raw[Cursor.elements].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.elements)
    return ArrayExprSyntax(root: root, data: newData)
  }

  public func withElements(
    _ newArrayElementListSyntax: ArrayElementListSyntax?) -> ArrayExprSyntax {
    let raw = newArrayElementListSyntax?.raw ?? RawSyntax.missing(.arrayElementList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.elements)
    return ArrayExprSyntax(root: root, data: newData)
  }

  public var rightSquare: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.rightSquare))
  }

  public func withRightSquare(
    _ newTokenSyntax: TokenSyntax?) -> ArrayExprSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.unknown)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.rightSquare)
    return ArrayExprSyntax(root: root, data: newData)
  }
}
public class DictionaryExprSyntax: ExprSyntax {
  enum Cursor: Int {
    case leftSquare
    case elements
    case rightSquare
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 3)
    let _leftSquare = raw[Cursor.leftSquareToken]
    precondition(_leftSquare.kind == .leftSquareToken,
                 "expected child of kind .leftSquareToken, " +
                 "got \(_leftSquare.kind)")
    let _elements = raw[Cursor.dictionaryElementList]
    precondition(_elements.kind == .dictionaryElementList,
                 "expected child of kind .dictionaryElementList, " +
                 "got \(_elements.kind)")
    let _rightSquare = raw[Cursor.rightSquareToken]
    precondition(_rightSquare.kind == .rightSquareToken,
                 "expected child of kind .rightSquareToken, " +
                 "got \(_rightSquare.kind)")
  }
#endif

  public var leftSquare: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.leftSquare))
  }

  public func withLeftSquare(
    _ newTokenSyntax: TokenSyntax?) -> DictionaryExprSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.unknown)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.leftSquare)
    return DictionaryExprSyntax(root: root, data: newData)
  }

  public var elements: DictionaryElementListSyntax {
    return DictionaryElementListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.elements))
  }

  public func addDictionaryElement(_ elt: DictionaryElementSyntax) -> DictionaryExprSyntax {
    let childRaw = raw[Cursor.elements].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.elements)
    return DictionaryExprSyntax(root: root, data: newData)
  }

  public func withElements(
    _ newDictionaryElementListSyntax: DictionaryElementListSyntax?) -> DictionaryExprSyntax {
    let raw = newDictionaryElementListSyntax?.raw ?? RawSyntax.missing(.dictionaryElementList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.elements)
    return DictionaryExprSyntax(root: root, data: newData)
  }

  public var rightSquare: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.rightSquare))
  }

  public func withRightSquare(
    _ newTokenSyntax: TokenSyntax?) -> DictionaryExprSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.unknown)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.rightSquare)
    return DictionaryExprSyntax(root: root, data: newData)
  }
}
public class FunctionCallArgumentSyntax: Syntax {
  enum Cursor: Int {
    case label
    case colon
    case expression
    case trailingComma
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 4)
    let _label = raw[Cursor.identifierToken]
    guard let _labelTokenKind = _label.tokenKind else {
      fatalError("expected token child, got \(_label.kind)")
    }
    precondition([.identifier].contains(_labelTokenKind),
      "expected one of [.identifier] for 'label' " + 
      "in node of kind functionCallArgument")
    let _colon = raw[Cursor.colonToken]
    guard let _colonTokenKind = _colon.tokenKind else {
      fatalError("expected token child, got \(_colon.kind)")
    }
    precondition([.colon].contains(_colonTokenKind),
      "expected one of [.colon] for 'colon' " + 
      "in node of kind functionCallArgument")
    let _expression = raw[Cursor.expr]
    precondition(_expression.kind == .expr,
                 "expected child of kind .expr, " +
                 "got \(_expression.kind)")
    let _trailingComma = raw[Cursor.commaToken]
    guard let _trailingCommaTokenKind = _trailingComma.tokenKind else {
      fatalError("expected token child, got \(_trailingComma.kind)")
    }
    precondition([.comma].contains(_trailingCommaTokenKind),
      "expected one of [.comma] for 'trailingComma' " + 
      "in node of kind functionCallArgument")
  }
#endif

  public var label: TokenSyntax? {
    guard raw[Cursor.label].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.label))
  }

  public func withLabel(
    _ newTokenSyntax: TokenSyntax?) -> FunctionCallArgumentSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.identifier(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.label)
    return FunctionCallArgumentSyntax(root: root, data: newData)
  }

  public var colon: TokenSyntax? {
    guard raw[Cursor.colon].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.colon))
  }

  public func withColon(
    _ newTokenSyntax: TokenSyntax?) -> FunctionCallArgumentSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.colon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.colon)
    return FunctionCallArgumentSyntax(root: root, data: newData)
  }

  public var expression: ExprSyntax {
    return ExprSyntax(root: _root,
      data: data.cachedChild(at: Cursor.expression))
  }

  public func withExpression(
    _ newExprSyntax: ExprSyntax?) -> FunctionCallArgumentSyntax {
    let raw = newExprSyntax?.raw ?? RawSyntax.missing(.expr)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.expression)
    return FunctionCallArgumentSyntax(root: root, data: newData)
  }

  public var trailingComma: TokenSyntax? {
    guard raw[Cursor.trailingComma].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.trailingComma))
  }

  public func withTrailingComma(
    _ newTokenSyntax: TokenSyntax?) -> FunctionCallArgumentSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.comma)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.trailingComma)
    return FunctionCallArgumentSyntax(root: root, data: newData)
  }
}
public class TupleElementSyntax: Syntax {
  enum Cursor: Int {
    case label
    case colon
    case expression
    case trailingComma
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 4)
    let _label = raw[Cursor.identifierToken]
    guard let _labelTokenKind = _label.tokenKind else {
      fatalError("expected token child, got \(_label.kind)")
    }
    precondition([.identifier].contains(_labelTokenKind),
      "expected one of [.identifier] for 'label' " + 
      "in node of kind tupleElement")
    let _colon = raw[Cursor.colonToken]
    guard let _colonTokenKind = _colon.tokenKind else {
      fatalError("expected token child, got \(_colon.kind)")
    }
    precondition([.colon].contains(_colonTokenKind),
      "expected one of [.colon] for 'colon' " + 
      "in node of kind tupleElement")
    let _expression = raw[Cursor.expr]
    precondition(_expression.kind == .expr,
                 "expected child of kind .expr, " +
                 "got \(_expression.kind)")
    let _trailingComma = raw[Cursor.commaToken]
    guard let _trailingCommaTokenKind = _trailingComma.tokenKind else {
      fatalError("expected token child, got \(_trailingComma.kind)")
    }
    precondition([.comma].contains(_trailingCommaTokenKind),
      "expected one of [.comma] for 'trailingComma' " + 
      "in node of kind tupleElement")
  }
#endif

  public var label: TokenSyntax? {
    guard raw[Cursor.label].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.label))
  }

  public func withLabel(
    _ newTokenSyntax: TokenSyntax?) -> TupleElementSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.identifier(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.label)
    return TupleElementSyntax(root: root, data: newData)
  }

  public var colon: TokenSyntax? {
    guard raw[Cursor.colon].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.colon))
  }

  public func withColon(
    _ newTokenSyntax: TokenSyntax?) -> TupleElementSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.colon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.colon)
    return TupleElementSyntax(root: root, data: newData)
  }

  public var expression: ExprSyntax {
    return ExprSyntax(root: _root,
      data: data.cachedChild(at: Cursor.expression))
  }

  public func withExpression(
    _ newExprSyntax: ExprSyntax?) -> TupleElementSyntax {
    let raw = newExprSyntax?.raw ?? RawSyntax.missing(.expr)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.expression)
    return TupleElementSyntax(root: root, data: newData)
  }

  public var trailingComma: TokenSyntax? {
    guard raw[Cursor.trailingComma].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.trailingComma))
  }

  public func withTrailingComma(
    _ newTokenSyntax: TokenSyntax?) -> TupleElementSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.comma)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.trailingComma)
    return TupleElementSyntax(root: root, data: newData)
  }
}
public class ArrayElementSyntax: Syntax {
  enum Cursor: Int {
    case expression
    case trailingComma
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 2)
    let _expression = raw[Cursor.expr]
    precondition(_expression.kind == .expr,
                 "expected child of kind .expr, " +
                 "got \(_expression.kind)")
    let _trailingComma = raw[Cursor.commaToken]
    guard let _trailingCommaTokenKind = _trailingComma.tokenKind else {
      fatalError("expected token child, got \(_trailingComma.kind)")
    }
    precondition([.comma].contains(_trailingCommaTokenKind),
      "expected one of [.comma] for 'trailingComma' " + 
      "in node of kind arrayElement")
  }
#endif

  public var expression: ExprSyntax {
    return ExprSyntax(root: _root,
      data: data.cachedChild(at: Cursor.expression))
  }

  public func withExpression(
    _ newExprSyntax: ExprSyntax?) -> ArrayElementSyntax {
    let raw = newExprSyntax?.raw ?? RawSyntax.missing(.expr)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.expression)
    return ArrayElementSyntax(root: root, data: newData)
  }

  public var trailingComma: TokenSyntax? {
    guard raw[Cursor.trailingComma].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.trailingComma))
  }

  public func withTrailingComma(
    _ newTokenSyntax: TokenSyntax?) -> ArrayElementSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.comma)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.trailingComma)
    return ArrayElementSyntax(root: root, data: newData)
  }
}
public class DictionaryElementSyntax: Syntax {
  enum Cursor: Int {
    case keyExpression
    case colon
    case valueExpression
    case trailingComma
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 4)
    let _keyExpression = raw[Cursor.expr]
    precondition(_keyExpression.kind == .expr,
                 "expected child of kind .expr, " +
                 "got \(_keyExpression.kind)")
    let _colon = raw[Cursor.colonToken]
    guard let _colonTokenKind = _colon.tokenKind else {
      fatalError("expected token child, got \(_colon.kind)")
    }
    precondition([.colon].contains(_colonTokenKind),
      "expected one of [.colon] for 'colon' " + 
      "in node of kind dictionaryElement")
    let _valueExpression = raw[Cursor.expr]
    precondition(_valueExpression.kind == .expr,
                 "expected child of kind .expr, " +
                 "got \(_valueExpression.kind)")
    let _trailingComma = raw[Cursor.commaToken]
    guard let _trailingCommaTokenKind = _trailingComma.tokenKind else {
      fatalError("expected token child, got \(_trailingComma.kind)")
    }
    precondition([.comma].contains(_trailingCommaTokenKind),
      "expected one of [.comma] for 'trailingComma' " + 
      "in node of kind dictionaryElement")
  }
#endif

  public var keyExpression: ExprSyntax {
    return ExprSyntax(root: _root,
      data: data.cachedChild(at: Cursor.keyExpression))
  }

  public func withKeyExpression(
    _ newExprSyntax: ExprSyntax?) -> DictionaryElementSyntax {
    let raw = newExprSyntax?.raw ?? RawSyntax.missing(.expr)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.keyExpression)
    return DictionaryElementSyntax(root: root, data: newData)
  }

  public var colon: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.colon))
  }

  public func withColon(
    _ newTokenSyntax: TokenSyntax?) -> DictionaryElementSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.colon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.colon)
    return DictionaryElementSyntax(root: root, data: newData)
  }

  public var valueExpression: ExprSyntax {
    return ExprSyntax(root: _root,
      data: data.cachedChild(at: Cursor.valueExpression))
  }

  public func withValueExpression(
    _ newExprSyntax: ExprSyntax?) -> DictionaryElementSyntax {
    let raw = newExprSyntax?.raw ?? RawSyntax.missing(.expr)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.valueExpression)
    return DictionaryElementSyntax(root: root, data: newData)
  }

  public var trailingComma: TokenSyntax? {
    guard raw[Cursor.trailingComma].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.trailingComma))
  }

  public func withTrailingComma(
    _ newTokenSyntax: TokenSyntax?) -> DictionaryElementSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.comma)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.trailingComma)
    return DictionaryElementSyntax(root: root, data: newData)
  }
}
public class IntegerLiteralExprSyntax: ExprSyntax {
  enum Cursor: Int {
    case digits
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 1)
    let _digits = raw[Cursor.integerLiteralToken]
    guard let _digitsTokenKind = _digits.tokenKind else {
      fatalError("expected token child, got \(_digits.kind)")
    }
    precondition([.integerLiteral].contains(_digitsTokenKind),
      "expected one of [.integerLiteral] for 'digits' " + 
      "in node of kind integerLiteralExpr")
  }
#endif

  public var digits: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.digits))
  }

  public func withDigits(
    _ newTokenSyntax: TokenSyntax?) -> IntegerLiteralExprSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.integerLiteral(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.digits)
    return IntegerLiteralExprSyntax(root: root, data: newData)
  }
}
public class StringLiteralExprSyntax: ExprSyntax {
  enum Cursor: Int {
    case stringLiteral
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 1)
    let _stringLiteral = raw[Cursor.stringLiteralToken]
    guard let _stringLiteralTokenKind = _stringLiteral.tokenKind else {
      fatalError("expected token child, got \(_stringLiteral.kind)")
    }
    precondition([.stringLiteral].contains(_stringLiteralTokenKind),
      "expected one of [.stringLiteral] for 'stringLiteral' " + 
      "in node of kind stringLiteralExpr")
  }
#endif

  public var stringLiteral: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.stringLiteral))
  }

  public func withStringLiteral(
    _ newTokenSyntax: TokenSyntax?) -> StringLiteralExprSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.stringLiteral(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.stringLiteral)
    return StringLiteralExprSyntax(root: root, data: newData)
  }
}
public class BooleanLiteralExprSyntax: ExprSyntax {
  enum Cursor: Int {
    case booleanLiteral
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 1)
    let _booleanLiteral = raw[Cursor.token]
    guard let _booleanLiteralTokenKind = _booleanLiteral.tokenKind else {
      fatalError("expected token child, got \(_booleanLiteral.kind)")
    }
    precondition([.trueKeyword, .falseKeyword].contains(_booleanLiteralTokenKind),
      "expected one of [.trueKeyword, .falseKeyword] for 'booleanLiteral' " + 
      "in node of kind booleanLiteralExpr")
  }
#endif

  public var booleanLiteral: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.booleanLiteral))
  }

  public func withBooleanLiteral(
    _ newTokenSyntax: TokenSyntax?) -> BooleanLiteralExprSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.trueKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.booleanLiteral)
    return BooleanLiteralExprSyntax(root: root, data: newData)
  }
}
public class TernaryExprSyntax: ExprSyntax {
  enum Cursor: Int {
    case conditionExpression
    case questionMark
    case firstChoice
    case colonMark
    case secondChoice
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 5)
    let _conditionExpression = raw[Cursor.expr]
    precondition(_conditionExpression.kind == .expr,
                 "expected child of kind .expr, " +
                 "got \(_conditionExpression.kind)")
    let _questionMark = raw[Cursor.infixQuestionMarkToken]
    guard let _questionMarkTokenKind = _questionMark.tokenKind else {
      fatalError("expected token child, got \(_questionMark.kind)")
    }
    precondition([.infixQuestionMark].contains(_questionMarkTokenKind),
      "expected one of [.infixQuestionMark] for 'questionMark' " + 
      "in node of kind ternaryExpr")
    let _firstChoice = raw[Cursor.expr]
    precondition(_firstChoice.kind == .expr,
                 "expected child of kind .expr, " +
                 "got \(_firstChoice.kind)")
    let _colonMark = raw[Cursor.colonToken]
    guard let _colonMarkTokenKind = _colonMark.tokenKind else {
      fatalError("expected token child, got \(_colonMark.kind)")
    }
    precondition([.colon].contains(_colonMarkTokenKind),
      "expected one of [.colon] for 'colonMark' " + 
      "in node of kind ternaryExpr")
    let _secondChoice = raw[Cursor.expr]
    precondition(_secondChoice.kind == .expr,
                 "expected child of kind .expr, " +
                 "got \(_secondChoice.kind)")
  }
#endif

  public var conditionExpression: ExprSyntax {
    return ExprSyntax(root: _root,
      data: data.cachedChild(at: Cursor.conditionExpression))
  }

  public func withConditionExpression(
    _ newExprSyntax: ExprSyntax?) -> TernaryExprSyntax {
    let raw = newExprSyntax?.raw ?? RawSyntax.missing(.expr)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.conditionExpression)
    return TernaryExprSyntax(root: root, data: newData)
  }

  public var questionMark: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.questionMark))
  }

  public func withQuestionMark(
    _ newTokenSyntax: TokenSyntax?) -> TernaryExprSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.infixQuestionMark)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.questionMark)
    return TernaryExprSyntax(root: root, data: newData)
  }

  public var firstChoice: ExprSyntax {
    return ExprSyntax(root: _root,
      data: data.cachedChild(at: Cursor.firstChoice))
  }

  public func withFirstChoice(
    _ newExprSyntax: ExprSyntax?) -> TernaryExprSyntax {
    let raw = newExprSyntax?.raw ?? RawSyntax.missing(.expr)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.firstChoice)
    return TernaryExprSyntax(root: root, data: newData)
  }

  public var colonMark: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.colonMark))
  }

  public func withColonMark(
    _ newTokenSyntax: TokenSyntax?) -> TernaryExprSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.colon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.colonMark)
    return TernaryExprSyntax(root: root, data: newData)
  }

  public var secondChoice: ExprSyntax {
    return ExprSyntax(root: _root,
      data: data.cachedChild(at: Cursor.secondChoice))
  }

  public func withSecondChoice(
    _ newExprSyntax: ExprSyntax?) -> TernaryExprSyntax {
    let raw = newExprSyntax?.raw ?? RawSyntax.missing(.expr)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.secondChoice)
    return TernaryExprSyntax(root: root, data: newData)
  }
}
public class MemberAccessExprSyntax: ExprSyntax {
  enum Cursor: Int {
    case base
    case dot
    case name
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 3)
    let _base = raw[Cursor.expr]
    precondition(_base.kind == .expr,
                 "expected child of kind .expr, " +
                 "got \(_base.kind)")
    let _dot = raw[Cursor.periodToken]
    guard let _dotTokenKind = _dot.tokenKind else {
      fatalError("expected token child, got \(_dot.kind)")
    }
    precondition([.period].contains(_dotTokenKind),
      "expected one of [.period] for 'dot' " + 
      "in node of kind memberAccessExpr")
    let _name = raw[Cursor.token]
    precondition(_name.kind == .token,
                 "expected child of kind .token, " +
                 "got \(_name.kind)")
  }
#endif

  public var base: ExprSyntax {
    return ExprSyntax(root: _root,
      data: data.cachedChild(at: Cursor.base))
  }

  public func withBase(
    _ newExprSyntax: ExprSyntax?) -> MemberAccessExprSyntax {
    let raw = newExprSyntax?.raw ?? RawSyntax.missing(.expr)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.base)
    return MemberAccessExprSyntax(root: root, data: newData)
  }

  public var dot: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.dot))
  }

  public func withDot(
    _ newTokenSyntax: TokenSyntax?) -> MemberAccessExprSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.period)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.dot)
    return MemberAccessExprSyntax(root: root, data: newData)
  }

  public var name: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.name))
  }

  public func withName(
    _ newTokenSyntax: TokenSyntax?) -> MemberAccessExprSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.unknown)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.name)
    return MemberAccessExprSyntax(root: root, data: newData)
  }
}
public class IsExprSyntax: ExprSyntax {
  enum Cursor: Int {
    case isTok
    case typeName
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 2)
    let _isTok = raw[Cursor.isToken]
    guard let _isTokTokenKind = _isTok.tokenKind else {
      fatalError("expected token child, got \(_isTok.kind)")
    }
    precondition([.isKeyword].contains(_isTokTokenKind),
      "expected one of [.isKeyword] for 'isTok' " + 
      "in node of kind isExpr")
    let _typeName = raw[Cursor.type]
    precondition(_typeName.kind == .type,
                 "expected child of kind .type, " +
                 "got \(_typeName.kind)")
  }
#endif

  public var isTok: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.isTok))
  }

  public func withIsTok(
    _ newTokenSyntax: TokenSyntax?) -> IsExprSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.isKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.isTok)
    return IsExprSyntax(root: root, data: newData)
  }

  public var typeName: TypeSyntax {
    return TypeSyntax(root: _root,
      data: data.cachedChild(at: Cursor.typeName))
  }

  public func withTypeName(
    _ newTypeSyntax: TypeSyntax?) -> IsExprSyntax {
    let raw = newTypeSyntax?.raw ?? RawSyntax.missing(.type)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.typeName)
    return IsExprSyntax(root: root, data: newData)
  }
}
public class AsExprSyntax: ExprSyntax {
  enum Cursor: Int {
    case asTok
    case questionOrExclamationMark
    case typeName
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 3)
    let _asTok = raw[Cursor.asToken]
    guard let _asTokTokenKind = _asTok.tokenKind else {
      fatalError("expected token child, got \(_asTok.kind)")
    }
    precondition([.asKeyword].contains(_asTokTokenKind),
      "expected one of [.asKeyword] for 'asTok' " + 
      "in node of kind asExpr")
    let _questionOrExclamationMark = raw[Cursor.token]
    guard let _questionOrExclamationMarkTokenKind = _questionOrExclamationMark.tokenKind else {
      fatalError("expected token child, got \(_questionOrExclamationMark.kind)")
    }
    precondition([.postfixQuestionMark, .exclamationMark].contains(_questionOrExclamationMarkTokenKind),
      "expected one of [.postfixQuestionMark, .exclamationMark] for 'questionOrExclamationMark' " + 
      "in node of kind asExpr")
    let _typeName = raw[Cursor.type]
    precondition(_typeName.kind == .type,
                 "expected child of kind .type, " +
                 "got \(_typeName.kind)")
  }
#endif

  public var asTok: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.asTok))
  }

  public func withAsTok(
    _ newTokenSyntax: TokenSyntax?) -> AsExprSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.asKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.asTok)
    return AsExprSyntax(root: root, data: newData)
  }

  public var questionOrExclamationMark: TokenSyntax? {
    guard raw[Cursor.questionOrExclamationMark].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.questionOrExclamationMark))
  }

  public func withQuestionOrExclamationMark(
    _ newTokenSyntax: TokenSyntax?) -> AsExprSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.postfixQuestionMark)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.questionOrExclamationMark)
    return AsExprSyntax(root: root, data: newData)
  }

  public var typeName: TypeSyntax {
    return TypeSyntax(root: _root,
      data: data.cachedChild(at: Cursor.typeName))
  }

  public func withTypeName(
    _ newTypeSyntax: TypeSyntax?) -> AsExprSyntax {
    let raw = newTypeSyntax?.raw ?? RawSyntax.missing(.type)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.typeName)
    return AsExprSyntax(root: root, data: newData)
  }
}
public class TypealiasDeclSyntax: DeclSyntax {
  enum Cursor: Int {
    case attributes
    case accessLevelModifier
    case typealiasKeyword
    case identifier
    case genericParameterClause
    case equals
    case type
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 7)
    let _attributes = raw[Cursor.attributeList]
    precondition(_attributes.kind == .attributeList,
                 "expected child of kind .attributeList, " +
                 "got \(_attributes.kind)")
    let _accessLevelModifier = raw[Cursor.accessLevelModifier]
    precondition(_accessLevelModifier.kind == .accessLevelModifier,
                 "expected child of kind .accessLevelModifier, " +
                 "got \(_accessLevelModifier.kind)")
    let _typealiasKeyword = raw[Cursor.typealiasToken]
    guard let _typealiasKeywordTokenKind = _typealiasKeyword.tokenKind else {
      fatalError("expected token child, got \(_typealiasKeyword.kind)")
    }
    precondition([.typealiasKeyword].contains(_typealiasKeywordTokenKind),
      "expected one of [.typealiasKeyword] for 'typealiasKeyword' " + 
      "in node of kind typealiasDecl")
    let _identifier = raw[Cursor.identifierToken]
    guard let _identifierTokenKind = _identifier.tokenKind else {
      fatalError("expected token child, got \(_identifier.kind)")
    }
    precondition([.identifier].contains(_identifierTokenKind),
      "expected one of [.identifier] for 'identifier' " + 
      "in node of kind typealiasDecl")
    let _genericParameterClause = raw[Cursor.genericParameterClause]
    precondition(_genericParameterClause.kind == .genericParameterClause,
                 "expected child of kind .genericParameterClause, " +
                 "got \(_genericParameterClause.kind)")
    let _equals = raw[Cursor.equalToken]
    guard let _equalsTokenKind = _equals.tokenKind else {
      fatalError("expected token child, got \(_equals.kind)")
    }
    precondition([.equal].contains(_equalsTokenKind),
      "expected one of [.equal] for 'equals' " + 
      "in node of kind typealiasDecl")
    let _type = raw[Cursor.type]
    precondition(_type.kind == .type,
                 "expected child of kind .type, " +
                 "got \(_type.kind)")
  }
#endif

  public var attributes: AttributeListSyntax? {
    guard raw[Cursor.attributes].isPresent else { return nil }
    return AttributeListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.attributes))
  }

  public func addAttribute(_ elt: AttributeSyntax) -> TypealiasDeclSyntax {
    let childRaw = raw[Cursor.attributes].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.attributes)
    return TypealiasDeclSyntax(root: root, data: newData)
  }

  public func withAttributes(
    _ newAttributeListSyntax: AttributeListSyntax?) -> TypealiasDeclSyntax {
    let raw = newAttributeListSyntax?.raw ?? RawSyntax.missing(.attributeList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.attributes)
    return TypealiasDeclSyntax(root: root, data: newData)
  }

  public var accessLevelModifier: AccessLevelModifierSyntax? {
    guard raw[Cursor.accessLevelModifier].isPresent else { return nil }
    return AccessLevelModifierSyntax(root: _root,
      data: data.cachedChild(at: Cursor.accessLevelModifier))
  }

  public func withAccessLevelModifier(
    _ newAccessLevelModifierSyntax: AccessLevelModifierSyntax?) -> TypealiasDeclSyntax {
    let raw = newAccessLevelModifierSyntax?.raw ?? RawSyntax.missing(.accessLevelModifier)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.accessLevelModifier)
    return TypealiasDeclSyntax(root: root, data: newData)
  }

  public var typealiasKeyword: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.typealiasKeyword))
  }

  public func withTypealiasKeyword(
    _ newTokenSyntax: TokenSyntax?) -> TypealiasDeclSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.typealiasKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.typealiasKeyword)
    return TypealiasDeclSyntax(root: root, data: newData)
  }

  public var identifier: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.identifier))
  }

  public func withIdentifier(
    _ newTokenSyntax: TokenSyntax?) -> TypealiasDeclSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.identifier(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.identifier)
    return TypealiasDeclSyntax(root: root, data: newData)
  }

  public var genericParameterClause: GenericParameterClauseSyntax? {
    guard raw[Cursor.genericParameterClause].isPresent else { return nil }
    return GenericParameterClauseSyntax(root: _root,
      data: data.cachedChild(at: Cursor.genericParameterClause))
  }

  public func withGenericParameterClause(
    _ newGenericParameterClauseSyntax: GenericParameterClauseSyntax?) -> TypealiasDeclSyntax {
    let raw = newGenericParameterClauseSyntax?.raw ?? RawSyntax.missing(.genericParameterClause)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.genericParameterClause)
    return TypealiasDeclSyntax(root: root, data: newData)
  }

  public var equals: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.equals))
  }

  public func withEquals(
    _ newTokenSyntax: TokenSyntax?) -> TypealiasDeclSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.equal)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.equals)
    return TypealiasDeclSyntax(root: root, data: newData)
  }

  public var type: TypeSyntax {
    return TypeSyntax(root: _root,
      data: data.cachedChild(at: Cursor.type))
  }

  public func withType(
    _ newTypeSyntax: TypeSyntax?) -> TypealiasDeclSyntax {
    let raw = newTypeSyntax?.raw ?? RawSyntax.missing(.type)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.type)
    return TypealiasDeclSyntax(root: root, data: newData)
  }
}
public typealias FunctionParameterListSyntax = SyntaxCollection<FunctionParameterSyntax>
public class FunctionSignatureSyntax: Syntax {
  enum Cursor: Int {
    case leftParen
    case parameterList
    case rightParen
    case throwsOrRethrowsKeyword
    case arrow
    case returnTypeAttributes
    case returnType
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 7)
    let _leftParen = raw[Cursor.leftParenToken]
    guard let _leftParenTokenKind = _leftParen.tokenKind else {
      fatalError("expected token child, got \(_leftParen.kind)")
    }
    precondition([.leftParen].contains(_leftParenTokenKind),
      "expected one of [.leftParen] for 'leftParen' " + 
      "in node of kind functionSignature")
    let _parameterList = raw[Cursor.functionParameterList]
    precondition(_parameterList.kind == .functionParameterList,
                 "expected child of kind .functionParameterList, " +
                 "got \(_parameterList.kind)")
    let _rightParen = raw[Cursor.rightParenToken]
    guard let _rightParenTokenKind = _rightParen.tokenKind else {
      fatalError("expected token child, got \(_rightParen.kind)")
    }
    precondition([.rightParen].contains(_rightParenTokenKind),
      "expected one of [.rightParen] for 'rightParen' " + 
      "in node of kind functionSignature")
    let _throwsOrRethrowsKeyword = raw[Cursor.token]
    guard let _throwsOrRethrowsKeywordTokenKind = _throwsOrRethrowsKeyword.tokenKind else {
      fatalError("expected token child, got \(_throwsOrRethrowsKeyword.kind)")
    }
    precondition([.throwsKeyword, .rethrowsKeyword].contains(_throwsOrRethrowsKeywordTokenKind),
      "expected one of [.throwsKeyword, .rethrowsKeyword] for 'throwsOrRethrowsKeyword' " + 
      "in node of kind functionSignature")
    let _arrow = raw[Cursor.arrowToken]
    guard let _arrowTokenKind = _arrow.tokenKind else {
      fatalError("expected token child, got \(_arrow.kind)")
    }
    precondition([.arrow].contains(_arrowTokenKind),
      "expected one of [.arrow] for 'arrow' " + 
      "in node of kind functionSignature")
    let _returnTypeAttributes = raw[Cursor.attributeList]
    precondition(_returnTypeAttributes.kind == .attributeList,
                 "expected child of kind .attributeList, " +
                 "got \(_returnTypeAttributes.kind)")
    let _returnType = raw[Cursor.type]
    precondition(_returnType.kind == .type,
                 "expected child of kind .type, " +
                 "got \(_returnType.kind)")
  }
#endif

  public var leftParen: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.leftParen))
  }

  public func withLeftParen(
    _ newTokenSyntax: TokenSyntax?) -> FunctionSignatureSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.leftParen)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.leftParen)
    return FunctionSignatureSyntax(root: root, data: newData)
  }

  public var parameterList: FunctionParameterListSyntax {
    return FunctionParameterListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.parameterList))
  }

  public func addFunctionParameter(_ elt: FunctionParameterSyntax) -> FunctionSignatureSyntax {
    let childRaw = raw[Cursor.parameterList].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.parameterList)
    return FunctionSignatureSyntax(root: root, data: newData)
  }

  public func withParameterList(
    _ newFunctionParameterListSyntax: FunctionParameterListSyntax?) -> FunctionSignatureSyntax {
    let raw = newFunctionParameterListSyntax?.raw ?? RawSyntax.missing(.functionParameterList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.parameterList)
    return FunctionSignatureSyntax(root: root, data: newData)
  }

  public var rightParen: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.rightParen))
  }

  public func withRightParen(
    _ newTokenSyntax: TokenSyntax?) -> FunctionSignatureSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.rightParen)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.rightParen)
    return FunctionSignatureSyntax(root: root, data: newData)
  }

  public var throwsOrRethrowsKeyword: TokenSyntax? {
    guard raw[Cursor.throwsOrRethrowsKeyword].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.throwsOrRethrowsKeyword))
  }

  public func withThrowsOrRethrowsKeyword(
    _ newTokenSyntax: TokenSyntax?) -> FunctionSignatureSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.throwsKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.throwsOrRethrowsKeyword)
    return FunctionSignatureSyntax(root: root, data: newData)
  }

  public var arrow: TokenSyntax? {
    guard raw[Cursor.arrow].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.arrow))
  }

  public func withArrow(
    _ newTokenSyntax: TokenSyntax?) -> FunctionSignatureSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.arrow)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.arrow)
    return FunctionSignatureSyntax(root: root, data: newData)
  }

  public var returnTypeAttributes: AttributeListSyntax? {
    guard raw[Cursor.returnTypeAttributes].isPresent else { return nil }
    return AttributeListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.returnTypeAttributes))
  }

  public func addAttribute(_ elt: AttributeSyntax) -> FunctionSignatureSyntax {
    let childRaw = raw[Cursor.returnTypeAttributes].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.returnTypeAttributes)
    return FunctionSignatureSyntax(root: root, data: newData)
  }

  public func withReturnTypeAttributes(
    _ newAttributeListSyntax: AttributeListSyntax?) -> FunctionSignatureSyntax {
    let raw = newAttributeListSyntax?.raw ?? RawSyntax.missing(.attributeList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.returnTypeAttributes)
    return FunctionSignatureSyntax(root: root, data: newData)
  }

  public var returnType: TypeSyntax? {
    guard raw[Cursor.returnType].isPresent else { return nil }
    return TypeSyntax(root: _root,
      data: data.cachedChild(at: Cursor.returnType))
  }

  public func withReturnType(
    _ newTypeSyntax: TypeSyntax?) -> FunctionSignatureSyntax {
    let raw = newTypeSyntax?.raw ?? RawSyntax.missing(.type)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.returnType)
    return FunctionSignatureSyntax(root: root, data: newData)
  }
}
public class ElseifDirectiveClauseSyntax: Syntax {
  enum Cursor: Int {
    case poundElseif
    case condition
    case body
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 3)
    let _poundElseif = raw[Cursor.poundElseifToken]
    guard let _poundElseifTokenKind = _poundElseif.tokenKind else {
      fatalError("expected token child, got \(_poundElseif.kind)")
    }
    precondition([.poundElseifKeyword].contains(_poundElseifTokenKind),
      "expected one of [.poundElseifKeyword] for 'poundElseif' " + 
      "in node of kind elseifDirectiveClause")
    let _condition = raw[Cursor.expr]
    precondition(_condition.kind == .expr,
                 "expected child of kind .expr, " +
                 "got \(_condition.kind)")
    let _body = raw[Cursor.stmtList]
    precondition(_body.kind == .stmtList,
                 "expected child of kind .stmtList, " +
                 "got \(_body.kind)")
  }
#endif

  public var poundElseif: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.poundElseif))
  }

  public func withPoundElseif(
    _ newTokenSyntax: TokenSyntax?) -> ElseifDirectiveClauseSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.poundElseifKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.poundElseif)
    return ElseifDirectiveClauseSyntax(root: root, data: newData)
  }

  public var condition: ExprSyntax {
    return ExprSyntax(root: _root,
      data: data.cachedChild(at: Cursor.condition))
  }

  public func withCondition(
    _ newExprSyntax: ExprSyntax?) -> ElseifDirectiveClauseSyntax {
    let raw = newExprSyntax?.raw ?? RawSyntax.missing(.expr)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.condition)
    return ElseifDirectiveClauseSyntax(root: root, data: newData)
  }

  public var body: StmtListSyntax {
    return StmtListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.body))
  }

  public func addStmt(_ elt: StmtSyntax) -> ElseifDirectiveClauseSyntax {
    let childRaw = raw[Cursor.body].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.body)
    return ElseifDirectiveClauseSyntax(root: root, data: newData)
  }

  public func withBody(
    _ newStmtListSyntax: StmtListSyntax?) -> ElseifDirectiveClauseSyntax {
    let raw = newStmtListSyntax?.raw ?? RawSyntax.missing(.stmtList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.body)
    return ElseifDirectiveClauseSyntax(root: root, data: newData)
  }
}
public class IfConfigDeclSyntax: DeclSyntax {
  enum Cursor: Int {
    case poundIf
    case condition
    case body
    case elseifDirectiveClauses
    case elseClause
    case poundEndif
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 6)
    let _poundIf = raw[Cursor.poundIfToken]
    guard let _poundIfTokenKind = _poundIf.tokenKind else {
      fatalError("expected token child, got \(_poundIf.kind)")
    }
    precondition([.poundIfKeyword].contains(_poundIfTokenKind),
      "expected one of [.poundIfKeyword] for 'poundIf' " + 
      "in node of kind ifConfigDecl")
    let _condition = raw[Cursor.expr]
    precondition(_condition.kind == .expr,
                 "expected child of kind .expr, " +
                 "got \(_condition.kind)")
    let _body = raw[Cursor.stmtList]
    precondition(_body.kind == .stmtList,
                 "expected child of kind .stmtList, " +
                 "got \(_body.kind)")
    let _elseifDirectiveClauses = raw[Cursor.elseifDirectiveClauseList]
    precondition(_elseifDirectiveClauses.kind == .elseifDirectiveClauseList,
                 "expected child of kind .elseifDirectiveClauseList, " +
                 "got \(_elseifDirectiveClauses.kind)")
    let _elseClause = raw[Cursor.elseDirectiveClause]
    precondition(_elseClause.kind == .elseDirectiveClause,
                 "expected child of kind .elseDirectiveClause, " +
                 "got \(_elseClause.kind)")
    let _poundEndif = raw[Cursor.poundEndifToken]
    guard let _poundEndifTokenKind = _poundEndif.tokenKind else {
      fatalError("expected token child, got \(_poundEndif.kind)")
    }
    precondition([.poundEndifKeyword].contains(_poundEndifTokenKind),
      "expected one of [.poundEndifKeyword] for 'poundEndif' " + 
      "in node of kind ifConfigDecl")
  }
#endif

  public var poundIf: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.poundIf))
  }

  public func withPoundIf(
    _ newTokenSyntax: TokenSyntax?) -> IfConfigDeclSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.poundIfKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.poundIf)
    return IfConfigDeclSyntax(root: root, data: newData)
  }

  public var condition: ExprSyntax {
    return ExprSyntax(root: _root,
      data: data.cachedChild(at: Cursor.condition))
  }

  public func withCondition(
    _ newExprSyntax: ExprSyntax?) -> IfConfigDeclSyntax {
    let raw = newExprSyntax?.raw ?? RawSyntax.missing(.expr)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.condition)
    return IfConfigDeclSyntax(root: root, data: newData)
  }

  public var body: StmtListSyntax {
    return StmtListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.body))
  }

  public func addStmt(_ elt: StmtSyntax) -> IfConfigDeclSyntax {
    let childRaw = raw[Cursor.body].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.body)
    return IfConfigDeclSyntax(root: root, data: newData)
  }

  public func withBody(
    _ newStmtListSyntax: StmtListSyntax?) -> IfConfigDeclSyntax {
    let raw = newStmtListSyntax?.raw ?? RawSyntax.missing(.stmtList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.body)
    return IfConfigDeclSyntax(root: root, data: newData)
  }

  public var elseifDirectiveClauses: ElseifDirectiveClauseListSyntax {
    return ElseifDirectiveClauseListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.elseifDirectiveClauses))
  }

  public func addElseifDirectiveClause(_ elt: ElseifDirectiveClauseSyntax) -> IfConfigDeclSyntax {
    let childRaw = raw[Cursor.elseifDirectiveClauses].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.elseifDirectiveClauses)
    return IfConfigDeclSyntax(root: root, data: newData)
  }

  public func withElseifDirectiveClauses(
    _ newElseifDirectiveClauseListSyntax: ElseifDirectiveClauseListSyntax?) -> IfConfigDeclSyntax {
    let raw = newElseifDirectiveClauseListSyntax?.raw ?? RawSyntax.missing(.elseifDirectiveClauseList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.elseifDirectiveClauses)
    return IfConfigDeclSyntax(root: root, data: newData)
  }

  public var elseClause: ElseDirectiveClauseSyntax? {
    guard raw[Cursor.elseClause].isPresent else { return nil }
    return ElseDirectiveClauseSyntax(root: _root,
      data: data.cachedChild(at: Cursor.elseClause))
  }

  public func withElseClause(
    _ newElseDirectiveClauseSyntax: ElseDirectiveClauseSyntax?) -> IfConfigDeclSyntax {
    let raw = newElseDirectiveClauseSyntax?.raw ?? RawSyntax.missing(.elseDirectiveClause)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.elseClause)
    return IfConfigDeclSyntax(root: root, data: newData)
  }

  public var poundEndif: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.poundEndif))
  }

  public func withPoundEndif(
    _ newTokenSyntax: TokenSyntax?) -> IfConfigDeclSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.poundEndifKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.poundEndif)
    return IfConfigDeclSyntax(root: root, data: newData)
  }
}
public class DeclModifierSyntax: Syntax {
  enum Cursor: Int {
    case name
    case detail
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 2)
    let _name = raw[Cursor.token]
    guard let _nameTokenKind = _name.tokenKind else {
      fatalError("expected token child, got \(_name.kind)")
    }
    precondition(["class", "convenience", "dynamic", "final", "infix", "lazy", "optional", "override", "postfix", "prefix", "required", "static", "unowned", "weak", "private", "fileprivate", "internal", "public", "open", "mutating", "nonmutating"].contains(_nameTokenKind.text),
                 "expected one of '[class, convenience, dynamic, final, infix, lazy, optional, override, postfix, prefix, required, static, unowned, weak, private, fileprivate, internal, public, open, mutating, nonmutating]', got " +
                 "'\(_nameTokenKind.text)'")
    let _detail = raw[Cursor.tokenList]
    precondition(_detail.kind == .tokenList,
                 "expected child of kind .tokenList, " +
                 "got \(_detail.kind)")
  }
#endif

  public var name: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.name))
  }

  public func withName(
    _ newTokenSyntax: TokenSyntax?) -> DeclModifierSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.unknown)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.name)
    return DeclModifierSyntax(root: root, data: newData)
  }

  public var detail: TokenListSyntax {
    return TokenListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.detail))
  }

  public func addToken(_ elt: TokenSyntax) -> DeclModifierSyntax {
    let childRaw = raw[Cursor.detail].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.detail)
    return DeclModifierSyntax(root: root, data: newData)
  }

  public func withDetail(
    _ newTokenListSyntax: TokenListSyntax?) -> DeclModifierSyntax {
    let raw = newTokenListSyntax?.raw ?? RawSyntax.missingToken(.unknown)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.detail)
    return DeclModifierSyntax(root: root, data: newData)
  }
}
public class TypeInheritanceClauseSyntax: Syntax {
  enum Cursor: Int {
    case colon
    case inheritedType
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 2)
    let _colon = raw[Cursor.colonToken]
    guard let _colonTokenKind = _colon.tokenKind else {
      fatalError("expected token child, got \(_colon.kind)")
    }
    precondition([.colon].contains(_colonTokenKind),
      "expected one of [.colon] for 'colon' " + 
      "in node of kind typeInheritanceClause")
    let _inheritedType = raw[Cursor.type]
    precondition(_inheritedType.kind == .type,
                 "expected child of kind .type, " +
                 "got \(_inheritedType.kind)")
  }
#endif

  public var colon: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.colon))
  }

  public func withColon(
    _ newTokenSyntax: TokenSyntax?) -> TypeInheritanceClauseSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.colon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.colon)
    return TypeInheritanceClauseSyntax(root: root, data: newData)
  }

  public var inheritedType: TypeSyntax {
    return TypeSyntax(root: _root,
      data: data.cachedChild(at: Cursor.inheritedType))
  }

  public func withInheritedType(
    _ newTypeSyntax: TypeSyntax?) -> TypeInheritanceClauseSyntax {
    let raw = newTypeSyntax?.raw ?? RawSyntax.missing(.type)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.inheritedType)
    return TypeInheritanceClauseSyntax(root: root, data: newData)
  }
}
public class StructDeclSyntax: DeclSyntax {
  enum Cursor: Int {
    case attributes
    case accessLevelModifier
    case structKeyword
    case identifier
    case genericParameterClause
    case inheritanceClause
    case genericWhereClause
    case members
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 8)
    let _attributes = raw[Cursor.attributeList]
    precondition(_attributes.kind == .attributeList,
                 "expected child of kind .attributeList, " +
                 "got \(_attributes.kind)")
    let _accessLevelModifier = raw[Cursor.accessLevelModifier]
    precondition(_accessLevelModifier.kind == .accessLevelModifier,
                 "expected child of kind .accessLevelModifier, " +
                 "got \(_accessLevelModifier.kind)")
    let _structKeyword = raw[Cursor.structToken]
    guard let _structKeywordTokenKind = _structKeyword.tokenKind else {
      fatalError("expected token child, got \(_structKeyword.kind)")
    }
    precondition([.structKeyword].contains(_structKeywordTokenKind),
      "expected one of [.structKeyword] for 'structKeyword' " + 
      "in node of kind structDecl")
    let _identifier = raw[Cursor.identifierToken]
    guard let _identifierTokenKind = _identifier.tokenKind else {
      fatalError("expected token child, got \(_identifier.kind)")
    }
    precondition([.identifier].contains(_identifierTokenKind),
      "expected one of [.identifier] for 'identifier' " + 
      "in node of kind structDecl")
    let _genericParameterClause = raw[Cursor.genericParameterClause]
    precondition(_genericParameterClause.kind == .genericParameterClause,
                 "expected child of kind .genericParameterClause, " +
                 "got \(_genericParameterClause.kind)")
    let _inheritanceClause = raw[Cursor.typeInheritanceClause]
    precondition(_inheritanceClause.kind == .typeInheritanceClause,
                 "expected child of kind .typeInheritanceClause, " +
                 "got \(_inheritanceClause.kind)")
    let _genericWhereClause = raw[Cursor.genericWhereClause]
    precondition(_genericWhereClause.kind == .genericWhereClause,
                 "expected child of kind .genericWhereClause, " +
                 "got \(_genericWhereClause.kind)")
    let _members = raw[Cursor.memberDeclBlock]
    precondition(_members.kind == .memberDeclBlock,
                 "expected child of kind .memberDeclBlock, " +
                 "got \(_members.kind)")
  }
#endif

  public var attributes: AttributeListSyntax? {
    guard raw[Cursor.attributes].isPresent else { return nil }
    return AttributeListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.attributes))
  }

  public func addAttribute(_ elt: AttributeSyntax) -> StructDeclSyntax {
    let childRaw = raw[Cursor.attributes].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.attributes)
    return StructDeclSyntax(root: root, data: newData)
  }

  public func withAttributes(
    _ newAttributeListSyntax: AttributeListSyntax?) -> StructDeclSyntax {
    let raw = newAttributeListSyntax?.raw ?? RawSyntax.missing(.attributeList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.attributes)
    return StructDeclSyntax(root: root, data: newData)
  }

  public var accessLevelModifier: AccessLevelModifierSyntax? {
    guard raw[Cursor.accessLevelModifier].isPresent else { return nil }
    return AccessLevelModifierSyntax(root: _root,
      data: data.cachedChild(at: Cursor.accessLevelModifier))
  }

  public func withAccessLevelModifier(
    _ newAccessLevelModifierSyntax: AccessLevelModifierSyntax?) -> StructDeclSyntax {
    let raw = newAccessLevelModifierSyntax?.raw ?? RawSyntax.missing(.accessLevelModifier)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.accessLevelModifier)
    return StructDeclSyntax(root: root, data: newData)
  }

  public var structKeyword: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.structKeyword))
  }

  public func withStructKeyword(
    _ newTokenSyntax: TokenSyntax?) -> StructDeclSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.structKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.structKeyword)
    return StructDeclSyntax(root: root, data: newData)
  }

  public var identifier: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.identifier))
  }

  public func withIdentifier(
    _ newTokenSyntax: TokenSyntax?) -> StructDeclSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.identifier(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.identifier)
    return StructDeclSyntax(root: root, data: newData)
  }

  public var genericParameterClause: GenericParameterClauseSyntax? {
    guard raw[Cursor.genericParameterClause].isPresent else { return nil }
    return GenericParameterClauseSyntax(root: _root,
      data: data.cachedChild(at: Cursor.genericParameterClause))
  }

  public func withGenericParameterClause(
    _ newGenericParameterClauseSyntax: GenericParameterClauseSyntax?) -> StructDeclSyntax {
    let raw = newGenericParameterClauseSyntax?.raw ?? RawSyntax.missing(.genericParameterClause)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.genericParameterClause)
    return StructDeclSyntax(root: root, data: newData)
  }

  public var inheritanceClause: TypeInheritanceClauseSyntax? {
    guard raw[Cursor.inheritanceClause].isPresent else { return nil }
    return TypeInheritanceClauseSyntax(root: _root,
      data: data.cachedChild(at: Cursor.inheritanceClause))
  }

  public func withInheritanceClause(
    _ newTypeInheritanceClauseSyntax: TypeInheritanceClauseSyntax?) -> StructDeclSyntax {
    let raw = newTypeInheritanceClauseSyntax?.raw ?? RawSyntax.missing(.typeInheritanceClause)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.inheritanceClause)
    return StructDeclSyntax(root: root, data: newData)
  }

  public var genericWhereClause: GenericWhereClauseSyntax? {
    guard raw[Cursor.genericWhereClause].isPresent else { return nil }
    return GenericWhereClauseSyntax(root: _root,
      data: data.cachedChild(at: Cursor.genericWhereClause))
  }

  public func withGenericWhereClause(
    _ newGenericWhereClauseSyntax: GenericWhereClauseSyntax?) -> StructDeclSyntax {
    let raw = newGenericWhereClauseSyntax?.raw ?? RawSyntax.missing(.genericWhereClause)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.genericWhereClause)
    return StructDeclSyntax(root: root, data: newData)
  }

  public var members: MemberDeclBlockSyntax {
    return MemberDeclBlockSyntax(root: _root,
      data: data.cachedChild(at: Cursor.members))
  }

  public func withMembers(
    _ newMemberDeclBlockSyntax: MemberDeclBlockSyntax?) -> StructDeclSyntax {
    let raw = newMemberDeclBlockSyntax?.raw ?? RawSyntax.missing(.memberDeclBlock)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.members)
    return StructDeclSyntax(root: root, data: newData)
  }
}
public class MemberDeclBlockSyntax: Syntax {
  enum Cursor: Int {
    case leftBrace
    case members
    case rightBrace
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 3)
    let _leftBrace = raw[Cursor.leftBraceToken]
    guard let _leftBraceTokenKind = _leftBrace.tokenKind else {
      fatalError("expected token child, got \(_leftBrace.kind)")
    }
    precondition([.leftBrace].contains(_leftBraceTokenKind),
      "expected one of [.leftBrace] for 'leftBrace' " + 
      "in node of kind memberDeclBlock")
    let _members = raw[Cursor.declList]
    precondition(_members.kind == .declList,
                 "expected child of kind .declList, " +
                 "got \(_members.kind)")
    let _rightBrace = raw[Cursor.rightBraceToken]
    guard let _rightBraceTokenKind = _rightBrace.tokenKind else {
      fatalError("expected token child, got \(_rightBrace.kind)")
    }
    precondition([.rightBrace].contains(_rightBraceTokenKind),
      "expected one of [.rightBrace] for 'rightBrace' " + 
      "in node of kind memberDeclBlock")
  }
#endif

  public var leftBrace: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.leftBrace))
  }

  public func withLeftBrace(
    _ newTokenSyntax: TokenSyntax?) -> MemberDeclBlockSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.leftBrace)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.leftBrace)
    return MemberDeclBlockSyntax(root: root, data: newData)
  }

  public var members: DeclListSyntax {
    return DeclListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.members))
  }

  public func addDecl(_ elt: DeclSyntax) -> MemberDeclBlockSyntax {
    let childRaw = raw[Cursor.members].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.members)
    return MemberDeclBlockSyntax(root: root, data: newData)
  }

  public func withMembers(
    _ newDeclListSyntax: DeclListSyntax?) -> MemberDeclBlockSyntax {
    let raw = newDeclListSyntax?.raw ?? RawSyntax.missing(.declList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.members)
    return MemberDeclBlockSyntax(root: root, data: newData)
  }

  public var rightBrace: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.rightBrace))
  }

  public func withRightBrace(
    _ newTokenSyntax: TokenSyntax?) -> MemberDeclBlockSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.rightBrace)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.rightBrace)
    return MemberDeclBlockSyntax(root: root, data: newData)
  }
}
public typealias DeclListSyntax = SyntaxCollection<DeclSyntax>
public class SourceFileSyntax: Syntax {
  enum Cursor: Int {
    case topLevelDecls
    case eofToken
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 2)
    let _topLevelDecls = raw[Cursor.declList]
    precondition(_topLevelDecls.kind == .declList,
                 "expected child of kind .declList, " +
                 "got \(_topLevelDecls.kind)")
    let _eofToken = raw[Cursor.eofToken]
    precondition(_eofToken.kind == .eofToken,
                 "expected child of kind .eofToken, " +
                 "got \(_eofToken.kind)")
  }
#endif

  public var topLevelDecls: DeclListSyntax {
    return DeclListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.topLevelDecls))
  }

  public func addDecl(_ elt: DeclSyntax) -> SourceFileSyntax {
    let childRaw = raw[Cursor.topLevelDecls].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.topLevelDecls)
    return SourceFileSyntax(root: root, data: newData)
  }

  public func withTopLevelDecls(
    _ newDeclListSyntax: DeclListSyntax?) -> SourceFileSyntax {
    let raw = newDeclListSyntax?.raw ?? RawSyntax.missing(.declList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.topLevelDecls)
    return SourceFileSyntax(root: root, data: newData)
  }

  public var eofToken: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.eofToken))
  }

  public func withEOFToken(
    _ newTokenSyntax: TokenSyntax?) -> SourceFileSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.unknown)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.eofToken)
    return SourceFileSyntax(root: root, data: newData)
  }
}
public class TopLevelCodeDeclSyntax: DeclSyntax {
  enum Cursor: Int {
    case body
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 1)
    let _body = raw[Cursor.stmtList]
    precondition(_body.kind == .stmtList,
                 "expected child of kind .stmtList, " +
                 "got \(_body.kind)")
  }
#endif

  public var body: StmtListSyntax {
    return StmtListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.body))
  }

  public func addStmt(_ elt: StmtSyntax) -> TopLevelCodeDeclSyntax {
    let childRaw = raw[Cursor.body].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.body)
    return TopLevelCodeDeclSyntax(root: root, data: newData)
  }

  public func withBody(
    _ newStmtListSyntax: StmtListSyntax?) -> TopLevelCodeDeclSyntax {
    let raw = newStmtListSyntax?.raw ?? RawSyntax.missing(.stmtList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.body)
    return TopLevelCodeDeclSyntax(root: root, data: newData)
  }
}
public class FunctionParameterSyntax: Syntax {
  enum Cursor: Int {
    case externalName
    case localName
    case colon
    case typeAnnotation
    case ellipsis
    case defaultEquals
    case defaultValue
    case trailingComma
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 8)
    let _externalName = raw[Cursor.identifierToken]
    guard let _externalNameTokenKind = _externalName.tokenKind else {
      fatalError("expected token child, got \(_externalName.kind)")
    }
    precondition([.identifier].contains(_externalNameTokenKind),
      "expected one of [.identifier] for 'externalName' " + 
      "in node of kind functionParameter")
    let _localName = raw[Cursor.identifierToken]
    guard let _localNameTokenKind = _localName.tokenKind else {
      fatalError("expected token child, got \(_localName.kind)")
    }
    precondition([.identifier].contains(_localNameTokenKind),
      "expected one of [.identifier] for 'localName' " + 
      "in node of kind functionParameter")
    let _colon = raw[Cursor.colonToken]
    guard let _colonTokenKind = _colon.tokenKind else {
      fatalError("expected token child, got \(_colon.kind)")
    }
    precondition([.colon].contains(_colonTokenKind),
      "expected one of [.colon] for 'colon' " + 
      "in node of kind functionParameter")
    let _typeAnnotation = raw[Cursor.typeAnnotation]
    precondition(_typeAnnotation.kind == .typeAnnotation,
                 "expected child of kind .typeAnnotation, " +
                 "got \(_typeAnnotation.kind)")
    let _ellipsis = raw[Cursor.token]
    precondition(_ellipsis.kind == .token,
                 "expected child of kind .token, " +
                 "got \(_ellipsis.kind)")
    let _defaultEquals = raw[Cursor.equalToken]
    guard let _defaultEqualsTokenKind = _defaultEquals.tokenKind else {
      fatalError("expected token child, got \(_defaultEquals.kind)")
    }
    precondition([.equal].contains(_defaultEqualsTokenKind),
      "expected one of [.equal] for 'defaultEquals' " + 
      "in node of kind functionParameter")
    let _defaultValue = raw[Cursor.expr]
    precondition(_defaultValue.kind == .expr,
                 "expected child of kind .expr, " +
                 "got \(_defaultValue.kind)")
    let _trailingComma = raw[Cursor.commaToken]
    guard let _trailingCommaTokenKind = _trailingComma.tokenKind else {
      fatalError("expected token child, got \(_trailingComma.kind)")
    }
    precondition([.comma].contains(_trailingCommaTokenKind),
      "expected one of [.comma] for 'trailingComma' " + 
      "in node of kind functionParameter")
  }
#endif

  public var externalName: TokenSyntax? {
    guard raw[Cursor.externalName].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.externalName))
  }

  public func withExternalName(
    _ newTokenSyntax: TokenSyntax?) -> FunctionParameterSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.identifier(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.externalName)
    return FunctionParameterSyntax(root: root, data: newData)
  }

  public var localName: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.localName))
  }

  public func withLocalName(
    _ newTokenSyntax: TokenSyntax?) -> FunctionParameterSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.identifier(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.localName)
    return FunctionParameterSyntax(root: root, data: newData)
  }

  public var colon: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.colon))
  }

  public func withColon(
    _ newTokenSyntax: TokenSyntax?) -> FunctionParameterSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.colon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.colon)
    return FunctionParameterSyntax(root: root, data: newData)
  }

  public var typeAnnotation: TypeAnnotationSyntax {
    return TypeAnnotationSyntax(root: _root,
      data: data.cachedChild(at: Cursor.typeAnnotation))
  }

  public func withTypeAnnotation(
    _ newTypeAnnotationSyntax: TypeAnnotationSyntax?) -> FunctionParameterSyntax {
    let raw = newTypeAnnotationSyntax?.raw ?? RawSyntax.missing(.typeAnnotation)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.typeAnnotation)
    return FunctionParameterSyntax(root: root, data: newData)
  }

  public var ellipsis: TokenSyntax? {
    guard raw[Cursor.ellipsis].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.ellipsis))
  }

  public func withEllipsis(
    _ newTokenSyntax: TokenSyntax?) -> FunctionParameterSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.unknown)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.ellipsis)
    return FunctionParameterSyntax(root: root, data: newData)
  }

  public var defaultEquals: TokenSyntax? {
    guard raw[Cursor.defaultEquals].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.defaultEquals))
  }

  public func withDefaultEquals(
    _ newTokenSyntax: TokenSyntax?) -> FunctionParameterSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.equal)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.defaultEquals)
    return FunctionParameterSyntax(root: root, data: newData)
  }

  public var defaultValue: ExprSyntax? {
    guard raw[Cursor.defaultValue].isPresent else { return nil }
    return ExprSyntax(root: _root,
      data: data.cachedChild(at: Cursor.defaultValue))
  }

  public func withDefaultValue(
    _ newExprSyntax: ExprSyntax?) -> FunctionParameterSyntax {
    let raw = newExprSyntax?.raw ?? RawSyntax.missing(.expr)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.defaultValue)
    return FunctionParameterSyntax(root: root, data: newData)
  }

  public var trailingComma: TokenSyntax? {
    guard raw[Cursor.trailingComma].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.trailingComma))
  }

  public func withTrailingComma(
    _ newTokenSyntax: TokenSyntax?) -> FunctionParameterSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.comma)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.trailingComma)
    return FunctionParameterSyntax(root: root, data: newData)
  }
}
public typealias ModifierListSyntax = SyntaxCollection<Syntax>
public class FunctionDeclSyntax: DeclSyntax {
  enum Cursor: Int {
    case attributes
    case modifiers
    case funcKeyword
    case identifier
    case genericParameterClause
    case signature
    case genericWhereClause
    case body
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 8)
    let _attributes = raw[Cursor.attributeList]
    precondition(_attributes.kind == .attributeList,
                 "expected child of kind .attributeList, " +
                 "got \(_attributes.kind)")
    let _modifiers = raw[Cursor.modifierList]
    precondition(_modifiers.kind == .modifierList,
                 "expected child of kind .modifierList, " +
                 "got \(_modifiers.kind)")
    let _funcKeyword = raw[Cursor.funcToken]
    guard let _funcKeywordTokenKind = _funcKeyword.tokenKind else {
      fatalError("expected token child, got \(_funcKeyword.kind)")
    }
    precondition([.funcKeyword].contains(_funcKeywordTokenKind),
      "expected one of [.funcKeyword] for 'funcKeyword' " + 
      "in node of kind functionDecl")
    let _identifier = raw[Cursor.identifierToken]
    guard let _identifierTokenKind = _identifier.tokenKind else {
      fatalError("expected token child, got \(_identifier.kind)")
    }
    precondition([.identifier].contains(_identifierTokenKind),
      "expected one of [.identifier] for 'identifier' " + 
      "in node of kind functionDecl")
    let _genericParameterClause = raw[Cursor.genericParameterClause]
    precondition(_genericParameterClause.kind == .genericParameterClause,
                 "expected child of kind .genericParameterClause, " +
                 "got \(_genericParameterClause.kind)")
    let _signature = raw[Cursor.functionSignature]
    precondition(_signature.kind == .functionSignature,
                 "expected child of kind .functionSignature, " +
                 "got \(_signature.kind)")
    let _genericWhereClause = raw[Cursor.genericWhereClause]
    precondition(_genericWhereClause.kind == .genericWhereClause,
                 "expected child of kind .genericWhereClause, " +
                 "got \(_genericWhereClause.kind)")
    let _body = raw[Cursor.codeBlock]
    precondition(_body.kind == .codeBlock,
                 "expected child of kind .codeBlock, " +
                 "got \(_body.kind)")
  }
#endif

  public var attributes: AttributeListSyntax? {
    guard raw[Cursor.attributes].isPresent else { return nil }
    return AttributeListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.attributes))
  }

  public func addAttribute(_ elt: AttributeSyntax) -> FunctionDeclSyntax {
    let childRaw = raw[Cursor.attributes].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.attributes)
    return FunctionDeclSyntax(root: root, data: newData)
  }

  public func withAttributes(
    _ newAttributeListSyntax: AttributeListSyntax?) -> FunctionDeclSyntax {
    let raw = newAttributeListSyntax?.raw ?? RawSyntax.missing(.attributeList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.attributes)
    return FunctionDeclSyntax(root: root, data: newData)
  }

  public var modifiers: ModifierListSyntax? {
    guard raw[Cursor.modifiers].isPresent else { return nil }
    return ModifierListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.modifiers))
  }

  public func addModifier(_ elt: Syntax) -> FunctionDeclSyntax {
    let childRaw = raw[Cursor.modifiers].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.modifiers)
    return FunctionDeclSyntax(root: root, data: newData)
  }

  public func withModifiers(
    _ newModifierListSyntax: ModifierListSyntax?) -> FunctionDeclSyntax {
    let raw = newModifierListSyntax?.raw ?? RawSyntax.missing(.modifierList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.modifiers)
    return FunctionDeclSyntax(root: root, data: newData)
  }

  public var funcKeyword: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.funcKeyword))
  }

  public func withFuncKeyword(
    _ newTokenSyntax: TokenSyntax?) -> FunctionDeclSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.funcKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.funcKeyword)
    return FunctionDeclSyntax(root: root, data: newData)
  }

  public var identifier: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.identifier))
  }

  public func withIdentifier(
    _ newTokenSyntax: TokenSyntax?) -> FunctionDeclSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.identifier(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.identifier)
    return FunctionDeclSyntax(root: root, data: newData)
  }

  public var genericParameterClause: GenericParameterClauseSyntax? {
    guard raw[Cursor.genericParameterClause].isPresent else { return nil }
    return GenericParameterClauseSyntax(root: _root,
      data: data.cachedChild(at: Cursor.genericParameterClause))
  }

  public func withGenericParameterClause(
    _ newGenericParameterClauseSyntax: GenericParameterClauseSyntax?) -> FunctionDeclSyntax {
    let raw = newGenericParameterClauseSyntax?.raw ?? RawSyntax.missing(.genericParameterClause)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.genericParameterClause)
    return FunctionDeclSyntax(root: root, data: newData)
  }

  public var signature: FunctionSignatureSyntax {
    return FunctionSignatureSyntax(root: _root,
      data: data.cachedChild(at: Cursor.signature))
  }

  public func withSignature(
    _ newFunctionSignatureSyntax: FunctionSignatureSyntax?) -> FunctionDeclSyntax {
    let raw = newFunctionSignatureSyntax?.raw ?? RawSyntax.missing(.functionSignature)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.signature)
    return FunctionDeclSyntax(root: root, data: newData)
  }

  public var genericWhereClause: GenericWhereClauseSyntax? {
    guard raw[Cursor.genericWhereClause].isPresent else { return nil }
    return GenericWhereClauseSyntax(root: _root,
      data: data.cachedChild(at: Cursor.genericWhereClause))
  }

  public func withGenericWhereClause(
    _ newGenericWhereClauseSyntax: GenericWhereClauseSyntax?) -> FunctionDeclSyntax {
    let raw = newGenericWhereClauseSyntax?.raw ?? RawSyntax.missing(.genericWhereClause)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.genericWhereClause)
    return FunctionDeclSyntax(root: root, data: newData)
  }

  public var body: CodeBlockSyntax {
    return CodeBlockSyntax(root: _root,
      data: data.cachedChild(at: Cursor.body))
  }

  public func withBody(
    _ newCodeBlockSyntax: CodeBlockSyntax?) -> FunctionDeclSyntax {
    let raw = newCodeBlockSyntax?.raw ?? RawSyntax.missing(.codeBlock)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.body)
    return FunctionDeclSyntax(root: root, data: newData)
  }
}
public typealias ElseifDirectiveClauseListSyntax = SyntaxCollection<ElseifDirectiveClauseSyntax>
public class ElseDirectiveClauseSyntax: Syntax {
  enum Cursor: Int {
    case poundElse
    case body
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 2)
    let _poundElse = raw[Cursor.poundElseToken]
    guard let _poundElseTokenKind = _poundElse.tokenKind else {
      fatalError("expected token child, got \(_poundElse.kind)")
    }
    precondition([.poundElseKeyword].contains(_poundElseTokenKind),
      "expected one of [.poundElseKeyword] for 'poundElse' " + 
      "in node of kind elseDirectiveClause")
    let _body = raw[Cursor.stmtList]
    precondition(_body.kind == .stmtList,
                 "expected child of kind .stmtList, " +
                 "got \(_body.kind)")
  }
#endif

  public var poundElse: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.poundElse))
  }

  public func withPoundElse(
    _ newTokenSyntax: TokenSyntax?) -> ElseDirectiveClauseSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.poundElseKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.poundElse)
    return ElseDirectiveClauseSyntax(root: root, data: newData)
  }

  public var body: StmtListSyntax {
    return StmtListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.body))
  }

  public func addStmt(_ elt: StmtSyntax) -> ElseDirectiveClauseSyntax {
    let childRaw = raw[Cursor.body].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.body)
    return ElseDirectiveClauseSyntax(root: root, data: newData)
  }

  public func withBody(
    _ newStmtListSyntax: StmtListSyntax?) -> ElseDirectiveClauseSyntax {
    let raw = newStmtListSyntax?.raw ?? RawSyntax.missing(.stmtList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.body)
    return ElseDirectiveClauseSyntax(root: root, data: newData)
  }
}
public class AccessLevelModifierSyntax: Syntax {
  enum Cursor: Int {
    case name
    case openParen
    case modifier
    case closeParen
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 4)
    let _name = raw[Cursor.identifierToken]
    guard let _nameTokenKind = _name.tokenKind else {
      fatalError("expected token child, got \(_name.kind)")
    }
    precondition([.identifier].contains(_nameTokenKind),
      "expected one of [.identifier] for 'name' " + 
      "in node of kind accessLevelModifier")
    let _openParen = raw[Cursor.leftParenToken]
    guard let _openParenTokenKind = _openParen.tokenKind else {
      fatalError("expected token child, got \(_openParen.kind)")
    }
    precondition([.leftParen].contains(_openParenTokenKind),
      "expected one of [.leftParen] for 'openParen' " + 
      "in node of kind accessLevelModifier")
    let _modifier = raw[Cursor.identifierToken]
    guard let _modifierTokenKind = _modifier.tokenKind else {
      fatalError("expected token child, got \(_modifier.kind)")
    }
    precondition([.identifier].contains(_modifierTokenKind),
      "expected one of [.identifier] for 'modifier' " + 
      "in node of kind accessLevelModifier")
    let _closeParen = raw[Cursor.rightParenToken]
    guard let _closeParenTokenKind = _closeParen.tokenKind else {
      fatalError("expected token child, got \(_closeParen.kind)")
    }
    precondition([.rightParen].contains(_closeParenTokenKind),
      "expected one of [.rightParen] for 'closeParen' " + 
      "in node of kind accessLevelModifier")
  }
#endif

  public var name: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.name))
  }

  public func withName(
    _ newTokenSyntax: TokenSyntax?) -> AccessLevelModifierSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.identifier(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.name)
    return AccessLevelModifierSyntax(root: root, data: newData)
  }

  public var openParen: TokenSyntax? {
    guard raw[Cursor.openParen].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.openParen))
  }

  public func withOpenParen(
    _ newTokenSyntax: TokenSyntax?) -> AccessLevelModifierSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.leftParen)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.openParen)
    return AccessLevelModifierSyntax(root: root, data: newData)
  }

  public var modifier: TokenSyntax? {
    guard raw[Cursor.modifier].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.modifier))
  }

  public func withModifier(
    _ newTokenSyntax: TokenSyntax?) -> AccessLevelModifierSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.identifier(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.modifier)
    return AccessLevelModifierSyntax(root: root, data: newData)
  }

  public var closeParen: TokenSyntax? {
    guard raw[Cursor.closeParen].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.closeParen))
  }

  public func withCloseParen(
    _ newTokenSyntax: TokenSyntax?) -> AccessLevelModifierSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.rightParen)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.closeParen)
    return AccessLevelModifierSyntax(root: root, data: newData)
  }
}
public typealias TokenListSyntax = SyntaxCollection<TokenSyntax>
public class AttributeSyntax: Syntax {
  enum Cursor: Int {
    case atSignToken
    case attributeName
    case balancedTokens
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 3)
    let _atSignToken = raw[Cursor.atSignToken]
    guard let _atSignTokenTokenKind = _atSignToken.tokenKind else {
      fatalError("expected token child, got \(_atSignToken.kind)")
    }
    precondition([.atSign].contains(_atSignTokenTokenKind),
      "expected one of [.atSign] for 'atSignToken' " + 
      "in node of kind attribute")
    let _attributeName = raw[Cursor.token]
    precondition(_attributeName.kind == .token,
                 "expected child of kind .token, " +
                 "got \(_attributeName.kind)")
    let _balancedTokens = raw[Cursor.tokenList]
    precondition(_balancedTokens.kind == .tokenList,
                 "expected child of kind .tokenList, " +
                 "got \(_balancedTokens.kind)")
  }
#endif

  public var atSignToken: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.atSignToken))
  }

  public func withAtSignToken(
    _ newTokenSyntax: TokenSyntax?) -> AttributeSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.atSign)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.atSignToken)
    return AttributeSyntax(root: root, data: newData)
  }

  public var attributeName: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.attributeName))
  }

  public func withAttributeName(
    _ newTokenSyntax: TokenSyntax?) -> AttributeSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.unknown)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.attributeName)
    return AttributeSyntax(root: root, data: newData)
  }

  public var balancedTokens: TokenListSyntax {
    return TokenListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.balancedTokens))
  }

  public func addToken(_ elt: TokenSyntax) -> AttributeSyntax {
    let childRaw = raw[Cursor.balancedTokens].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.balancedTokens)
    return AttributeSyntax(root: root, data: newData)
  }

  public func withBalancedTokens(
    _ newTokenListSyntax: TokenListSyntax?) -> AttributeSyntax {
    let raw = newTokenListSyntax?.raw ?? RawSyntax.missingToken(.unknown)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.balancedTokens)
    return AttributeSyntax(root: root, data: newData)
  }
}
public typealias AttributeListSyntax = SyntaxCollection<AttributeSyntax>
public class ContinueStmtSyntax: StmtSyntax {
  enum Cursor: Int {
    case continueKeyword
    case label
    case semicolon
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 3)
    let _continueKeyword = raw[Cursor.continueToken]
    guard let _continueKeywordTokenKind = _continueKeyword.tokenKind else {
      fatalError("expected token child, got \(_continueKeyword.kind)")
    }
    precondition([.continueKeyword].contains(_continueKeywordTokenKind),
      "expected one of [.continueKeyword] for 'continueKeyword' " + 
      "in node of kind continueStmt")
    let _label = raw[Cursor.identifierToken]
    guard let _labelTokenKind = _label.tokenKind else {
      fatalError("expected token child, got \(_label.kind)")
    }
    precondition([.identifier].contains(_labelTokenKind),
      "expected one of [.identifier] for 'label' " + 
      "in node of kind continueStmt")
    let _semicolon = raw[Cursor.semicolonToken]
    guard let _semicolonTokenKind = _semicolon.tokenKind else {
      fatalError("expected token child, got \(_semicolon.kind)")
    }
    precondition([.semicolon].contains(_semicolonTokenKind),
      "expected one of [.semicolon] for 'semicolon' " + 
      "in node of kind continueStmt")
  }
#endif

  public var continueKeyword: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.continueKeyword))
  }

  public func withContinueKeyword(
    _ newTokenSyntax: TokenSyntax?) -> ContinueStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.continueKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.continueKeyword)
    return ContinueStmtSyntax(root: root, data: newData)
  }

  public var label: TokenSyntax? {
    guard raw[Cursor.label].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.label))
  }

  public func withLabel(
    _ newTokenSyntax: TokenSyntax?) -> ContinueStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.identifier(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.label)
    return ContinueStmtSyntax(root: root, data: newData)
  }

  public var semicolon: TokenSyntax? {
    guard raw[Cursor.semicolon].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.semicolon))
  }

  public func withSemicolon(
    _ newTokenSyntax: TokenSyntax?) -> ContinueStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.semicolon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.semicolon)
    return ContinueStmtSyntax(root: root, data: newData)
  }
}
public class WhileStmtSyntax: StmtSyntax {
  enum Cursor: Int {
    case labelName
    case labelColon
    case whileKeyword
    case conditions
    case body
    case semicolon
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 6)
    let _labelName = raw[Cursor.identifierToken]
    guard let _labelNameTokenKind = _labelName.tokenKind else {
      fatalError("expected token child, got \(_labelName.kind)")
    }
    precondition([.identifier].contains(_labelNameTokenKind),
      "expected one of [.identifier] for 'labelName' " + 
      "in node of kind whileStmt")
    let _labelColon = raw[Cursor.colonToken]
    guard let _labelColonTokenKind = _labelColon.tokenKind else {
      fatalError("expected token child, got \(_labelColon.kind)")
    }
    precondition([.colon].contains(_labelColonTokenKind),
      "expected one of [.colon] for 'labelColon' " + 
      "in node of kind whileStmt")
    let _whileKeyword = raw[Cursor.whileToken]
    guard let _whileKeywordTokenKind = _whileKeyword.tokenKind else {
      fatalError("expected token child, got \(_whileKeyword.kind)")
    }
    precondition([.whileKeyword].contains(_whileKeywordTokenKind),
      "expected one of [.whileKeyword] for 'whileKeyword' " + 
      "in node of kind whileStmt")
    let _conditions = raw[Cursor.conditionList]
    precondition(_conditions.kind == .conditionList,
                 "expected child of kind .conditionList, " +
                 "got \(_conditions.kind)")
    let _body = raw[Cursor.codeBlock]
    precondition(_body.kind == .codeBlock,
                 "expected child of kind .codeBlock, " +
                 "got \(_body.kind)")
    let _semicolon = raw[Cursor.semicolonToken]
    guard let _semicolonTokenKind = _semicolon.tokenKind else {
      fatalError("expected token child, got \(_semicolon.kind)")
    }
    precondition([.semicolon].contains(_semicolonTokenKind),
      "expected one of [.semicolon] for 'semicolon' " + 
      "in node of kind whileStmt")
  }
#endif

  public var labelName: TokenSyntax? {
    guard raw[Cursor.labelName].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.labelName))
  }

  public func withLabelName(
    _ newTokenSyntax: TokenSyntax?) -> WhileStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.identifier(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.labelName)
    return WhileStmtSyntax(root: root, data: newData)
  }

  public var labelColon: TokenSyntax? {
    guard raw[Cursor.labelColon].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.labelColon))
  }

  public func withLabelColon(
    _ newTokenSyntax: TokenSyntax?) -> WhileStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.colon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.labelColon)
    return WhileStmtSyntax(root: root, data: newData)
  }

  public var whileKeyword: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.whileKeyword))
  }

  public func withWhileKeyword(
    _ newTokenSyntax: TokenSyntax?) -> WhileStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.whileKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.whileKeyword)
    return WhileStmtSyntax(root: root, data: newData)
  }

  public var conditions: ConditionListSyntax {
    return ConditionListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.conditions))
  }

  public func addCondition(_ elt: ConditionSyntax) -> WhileStmtSyntax {
    let childRaw = raw[Cursor.conditions].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.conditions)
    return WhileStmtSyntax(root: root, data: newData)
  }

  public func withConditions(
    _ newConditionListSyntax: ConditionListSyntax?) -> WhileStmtSyntax {
    let raw = newConditionListSyntax?.raw ?? RawSyntax.missing(.conditionList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.conditions)
    return WhileStmtSyntax(root: root, data: newData)
  }

  public var body: CodeBlockSyntax {
    return CodeBlockSyntax(root: _root,
      data: data.cachedChild(at: Cursor.body))
  }

  public func withBody(
    _ newCodeBlockSyntax: CodeBlockSyntax?) -> WhileStmtSyntax {
    let raw = newCodeBlockSyntax?.raw ?? RawSyntax.missing(.codeBlock)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.body)
    return WhileStmtSyntax(root: root, data: newData)
  }

  public var semicolon: TokenSyntax? {
    guard raw[Cursor.semicolon].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.semicolon))
  }

  public func withSemicolon(
    _ newTokenSyntax: TokenSyntax?) -> WhileStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.semicolon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.semicolon)
    return WhileStmtSyntax(root: root, data: newData)
  }
}
public class DeferStmtSyntax: StmtSyntax {
  enum Cursor: Int {
    case deferKeyword
    case body
    case semicolon
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 3)
    let _deferKeyword = raw[Cursor.deferToken]
    guard let _deferKeywordTokenKind = _deferKeyword.tokenKind else {
      fatalError("expected token child, got \(_deferKeyword.kind)")
    }
    precondition([.deferKeyword].contains(_deferKeywordTokenKind),
      "expected one of [.deferKeyword] for 'deferKeyword' " + 
      "in node of kind deferStmt")
    let _body = raw[Cursor.codeBlock]
    precondition(_body.kind == .codeBlock,
                 "expected child of kind .codeBlock, " +
                 "got \(_body.kind)")
    let _semicolon = raw[Cursor.semicolonToken]
    guard let _semicolonTokenKind = _semicolon.tokenKind else {
      fatalError("expected token child, got \(_semicolon.kind)")
    }
    precondition([.semicolon].contains(_semicolonTokenKind),
      "expected one of [.semicolon] for 'semicolon' " + 
      "in node of kind deferStmt")
  }
#endif

  public var deferKeyword: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.deferKeyword))
  }

  public func withDeferKeyword(
    _ newTokenSyntax: TokenSyntax?) -> DeferStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.deferKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.deferKeyword)
    return DeferStmtSyntax(root: root, data: newData)
  }

  public var body: CodeBlockSyntax {
    return CodeBlockSyntax(root: _root,
      data: data.cachedChild(at: Cursor.body))
  }

  public func withBody(
    _ newCodeBlockSyntax: CodeBlockSyntax?) -> DeferStmtSyntax {
    let raw = newCodeBlockSyntax?.raw ?? RawSyntax.missing(.codeBlock)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.body)
    return DeferStmtSyntax(root: root, data: newData)
  }

  public var semicolon: TokenSyntax? {
    guard raw[Cursor.semicolon].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.semicolon))
  }

  public func withSemicolon(
    _ newTokenSyntax: TokenSyntax?) -> DeferStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.semicolon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.semicolon)
    return DeferStmtSyntax(root: root, data: newData)
  }
}
public class ExpressionStmtSyntax: StmtSyntax {
  enum Cursor: Int {
    case expression
    case semicolon
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 2)
    let _expression = raw[Cursor.expr]
    precondition(_expression.kind == .expr,
                 "expected child of kind .expr, " +
                 "got \(_expression.kind)")
    let _semicolon = raw[Cursor.semicolonToken]
    guard let _semicolonTokenKind = _semicolon.tokenKind else {
      fatalError("expected token child, got \(_semicolon.kind)")
    }
    precondition([.semicolon].contains(_semicolonTokenKind),
      "expected one of [.semicolon] for 'semicolon' " + 
      "in node of kind expressionStmt")
  }
#endif

  public var expression: ExprSyntax {
    return ExprSyntax(root: _root,
      data: data.cachedChild(at: Cursor.expression))
  }

  public func withExpression(
    _ newExprSyntax: ExprSyntax?) -> ExpressionStmtSyntax {
    let raw = newExprSyntax?.raw ?? RawSyntax.missing(.expr)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.expression)
    return ExpressionStmtSyntax(root: root, data: newData)
  }

  public var semicolon: TokenSyntax? {
    guard raw[Cursor.semicolon].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.semicolon))
  }

  public func withSemicolon(
    _ newTokenSyntax: TokenSyntax?) -> ExpressionStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.semicolon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.semicolon)
    return ExpressionStmtSyntax(root: root, data: newData)
  }
}
public typealias SwitchCaseListSyntax = SyntaxCollection<SwitchCaseSyntax>
public class RepeatWhileStmtSyntax: StmtSyntax {
  enum Cursor: Int {
    case labelName
    case labelColon
    case repeatKeyword
    case body
    case whileKeyword
    case condition
    case semicolon
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 7)
    let _labelName = raw[Cursor.identifierToken]
    guard let _labelNameTokenKind = _labelName.tokenKind else {
      fatalError("expected token child, got \(_labelName.kind)")
    }
    precondition([.identifier].contains(_labelNameTokenKind),
      "expected one of [.identifier] for 'labelName' " + 
      "in node of kind repeatWhileStmt")
    let _labelColon = raw[Cursor.colonToken]
    guard let _labelColonTokenKind = _labelColon.tokenKind else {
      fatalError("expected token child, got \(_labelColon.kind)")
    }
    precondition([.colon].contains(_labelColonTokenKind),
      "expected one of [.colon] for 'labelColon' " + 
      "in node of kind repeatWhileStmt")
    let _repeatKeyword = raw[Cursor.repeatToken]
    guard let _repeatKeywordTokenKind = _repeatKeyword.tokenKind else {
      fatalError("expected token child, got \(_repeatKeyword.kind)")
    }
    precondition([.repeatKeyword].contains(_repeatKeywordTokenKind),
      "expected one of [.repeatKeyword] for 'repeatKeyword' " + 
      "in node of kind repeatWhileStmt")
    let _body = raw[Cursor.codeBlock]
    precondition(_body.kind == .codeBlock,
                 "expected child of kind .codeBlock, " +
                 "got \(_body.kind)")
    let _whileKeyword = raw[Cursor.whileToken]
    guard let _whileKeywordTokenKind = _whileKeyword.tokenKind else {
      fatalError("expected token child, got \(_whileKeyword.kind)")
    }
    precondition([.whileKeyword].contains(_whileKeywordTokenKind),
      "expected one of [.whileKeyword] for 'whileKeyword' " + 
      "in node of kind repeatWhileStmt")
    let _condition = raw[Cursor.expr]
    precondition(_condition.kind == .expr,
                 "expected child of kind .expr, " +
                 "got \(_condition.kind)")
    let _semicolon = raw[Cursor.semicolonToken]
    guard let _semicolonTokenKind = _semicolon.tokenKind else {
      fatalError("expected token child, got \(_semicolon.kind)")
    }
    precondition([.semicolon].contains(_semicolonTokenKind),
      "expected one of [.semicolon] for 'semicolon' " + 
      "in node of kind repeatWhileStmt")
  }
#endif

  public var labelName: TokenSyntax? {
    guard raw[Cursor.labelName].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.labelName))
  }

  public func withLabelName(
    _ newTokenSyntax: TokenSyntax?) -> RepeatWhileStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.identifier(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.labelName)
    return RepeatWhileStmtSyntax(root: root, data: newData)
  }

  public var labelColon: TokenSyntax? {
    guard raw[Cursor.labelColon].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.labelColon))
  }

  public func withLabelColon(
    _ newTokenSyntax: TokenSyntax?) -> RepeatWhileStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.colon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.labelColon)
    return RepeatWhileStmtSyntax(root: root, data: newData)
  }

  public var repeatKeyword: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.repeatKeyword))
  }

  public func withRepeatKeyword(
    _ newTokenSyntax: TokenSyntax?) -> RepeatWhileStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.repeatKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.repeatKeyword)
    return RepeatWhileStmtSyntax(root: root, data: newData)
  }

  public var body: CodeBlockSyntax {
    return CodeBlockSyntax(root: _root,
      data: data.cachedChild(at: Cursor.body))
  }

  public func withBody(
    _ newCodeBlockSyntax: CodeBlockSyntax?) -> RepeatWhileStmtSyntax {
    let raw = newCodeBlockSyntax?.raw ?? RawSyntax.missing(.codeBlock)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.body)
    return RepeatWhileStmtSyntax(root: root, data: newData)
  }

  public var whileKeyword: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.whileKeyword))
  }

  public func withWhileKeyword(
    _ newTokenSyntax: TokenSyntax?) -> RepeatWhileStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.whileKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.whileKeyword)
    return RepeatWhileStmtSyntax(root: root, data: newData)
  }

  public var condition: ExprSyntax {
    return ExprSyntax(root: _root,
      data: data.cachedChild(at: Cursor.condition))
  }

  public func withCondition(
    _ newExprSyntax: ExprSyntax?) -> RepeatWhileStmtSyntax {
    let raw = newExprSyntax?.raw ?? RawSyntax.missing(.expr)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.condition)
    return RepeatWhileStmtSyntax(root: root, data: newData)
  }

  public var semicolon: TokenSyntax? {
    guard raw[Cursor.semicolon].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.semicolon))
  }

  public func withSemicolon(
    _ newTokenSyntax: TokenSyntax?) -> RepeatWhileStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.semicolon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.semicolon)
    return RepeatWhileStmtSyntax(root: root, data: newData)
  }
}
public class GuardStmtSyntax: StmtSyntax {
  enum Cursor: Int {
    case guardKeyword
    case conditions
    case elseKeyword
    case body
    case semicolon
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 5)
    let _guardKeyword = raw[Cursor.guardToken]
    guard let _guardKeywordTokenKind = _guardKeyword.tokenKind else {
      fatalError("expected token child, got \(_guardKeyword.kind)")
    }
    precondition([.guardKeyword].contains(_guardKeywordTokenKind),
      "expected one of [.guardKeyword] for 'guardKeyword' " + 
      "in node of kind guardStmt")
    let _conditions = raw[Cursor.conditionList]
    precondition(_conditions.kind == .conditionList,
                 "expected child of kind .conditionList, " +
                 "got \(_conditions.kind)")
    let _elseKeyword = raw[Cursor.elseToken]
    guard let _elseKeywordTokenKind = _elseKeyword.tokenKind else {
      fatalError("expected token child, got \(_elseKeyword.kind)")
    }
    precondition([.elseKeyword].contains(_elseKeywordTokenKind),
      "expected one of [.elseKeyword] for 'elseKeyword' " + 
      "in node of kind guardStmt")
    let _body = raw[Cursor.codeBlock]
    precondition(_body.kind == .codeBlock,
                 "expected child of kind .codeBlock, " +
                 "got \(_body.kind)")
    let _semicolon = raw[Cursor.semicolonToken]
    guard let _semicolonTokenKind = _semicolon.tokenKind else {
      fatalError("expected token child, got \(_semicolon.kind)")
    }
    precondition([.semicolon].contains(_semicolonTokenKind),
      "expected one of [.semicolon] for 'semicolon' " + 
      "in node of kind guardStmt")
  }
#endif

  public var guardKeyword: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.guardKeyword))
  }

  public func withGuardKeyword(
    _ newTokenSyntax: TokenSyntax?) -> GuardStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.guardKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.guardKeyword)
    return GuardStmtSyntax(root: root, data: newData)
  }

  public var conditions: ConditionListSyntax {
    return ConditionListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.conditions))
  }

  public func addCondition(_ elt: ConditionSyntax) -> GuardStmtSyntax {
    let childRaw = raw[Cursor.conditions].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.conditions)
    return GuardStmtSyntax(root: root, data: newData)
  }

  public func withConditions(
    _ newConditionListSyntax: ConditionListSyntax?) -> GuardStmtSyntax {
    let raw = newConditionListSyntax?.raw ?? RawSyntax.missing(.conditionList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.conditions)
    return GuardStmtSyntax(root: root, data: newData)
  }

  public var elseKeyword: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.elseKeyword))
  }

  public func withElseKeyword(
    _ newTokenSyntax: TokenSyntax?) -> GuardStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.elseKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.elseKeyword)
    return GuardStmtSyntax(root: root, data: newData)
  }

  public var body: CodeBlockSyntax {
    return CodeBlockSyntax(root: _root,
      data: data.cachedChild(at: Cursor.body))
  }

  public func withBody(
    _ newCodeBlockSyntax: CodeBlockSyntax?) -> GuardStmtSyntax {
    let raw = newCodeBlockSyntax?.raw ?? RawSyntax.missing(.codeBlock)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.body)
    return GuardStmtSyntax(root: root, data: newData)
  }

  public var semicolon: TokenSyntax? {
    guard raw[Cursor.semicolon].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.semicolon))
  }

  public func withSemicolon(
    _ newTokenSyntax: TokenSyntax?) -> GuardStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.semicolon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.semicolon)
    return GuardStmtSyntax(root: root, data: newData)
  }
}
public typealias ExprListSyntax = SyntaxCollection<ExprSyntax>
public class WhereClauseSyntax: Syntax {
  enum Cursor: Int {
    case whereKeyword
    case expressions
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 2)
    let _whereKeyword = raw[Cursor.whereToken]
    guard let _whereKeywordTokenKind = _whereKeyword.tokenKind else {
      fatalError("expected token child, got \(_whereKeyword.kind)")
    }
    precondition([.whereKeyword].contains(_whereKeywordTokenKind),
      "expected one of [.whereKeyword] for 'whereKeyword' " + 
      "in node of kind whereClause")
    let _expressions = raw[Cursor.exprList]
    precondition(_expressions.kind == .exprList,
                 "expected child of kind .exprList, " +
                 "got \(_expressions.kind)")
  }
#endif

  public var whereKeyword: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.whereKeyword))
  }

  public func withWhereKeyword(
    _ newTokenSyntax: TokenSyntax?) -> WhereClauseSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.whereKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.whereKeyword)
    return WhereClauseSyntax(root: root, data: newData)
  }

  public var expressions: ExprListSyntax {
    return ExprListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.expressions))
  }

  public func addExpression(_ elt: ExprSyntax) -> WhereClauseSyntax {
    let childRaw = raw[Cursor.expressions].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.expressions)
    return WhereClauseSyntax(root: root, data: newData)
  }

  public func withExpressions(
    _ newExprListSyntax: ExprListSyntax?) -> WhereClauseSyntax {
    let raw = newExprListSyntax?.raw ?? RawSyntax.missing(.exprList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.expressions)
    return WhereClauseSyntax(root: root, data: newData)
  }
}
public class ForInStmtSyntax: StmtSyntax {
  enum Cursor: Int {
    case labelName
    case labelColon
    case forKeyword
    case caseKeyword
    case itemPattern
    case inKeyword
    case collectionExpr
    case whereClause
    case body
    case semicolon
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 10)
    let _labelName = raw[Cursor.identifierToken]
    guard let _labelNameTokenKind = _labelName.tokenKind else {
      fatalError("expected token child, got \(_labelName.kind)")
    }
    precondition([.identifier].contains(_labelNameTokenKind),
      "expected one of [.identifier] for 'labelName' " + 
      "in node of kind forInStmt")
    let _labelColon = raw[Cursor.colonToken]
    guard let _labelColonTokenKind = _labelColon.tokenKind else {
      fatalError("expected token child, got \(_labelColon.kind)")
    }
    precondition([.colon].contains(_labelColonTokenKind),
      "expected one of [.colon] for 'labelColon' " + 
      "in node of kind forInStmt")
    let _forKeyword = raw[Cursor.forToken]
    guard let _forKeywordTokenKind = _forKeyword.tokenKind else {
      fatalError("expected token child, got \(_forKeyword.kind)")
    }
    precondition([.forKeyword].contains(_forKeywordTokenKind),
      "expected one of [.forKeyword] for 'forKeyword' " + 
      "in node of kind forInStmt")
    let _caseKeyword = raw[Cursor.caseToken]
    guard let _caseKeywordTokenKind = _caseKeyword.tokenKind else {
      fatalError("expected token child, got \(_caseKeyword.kind)")
    }
    precondition([.caseKeyword].contains(_caseKeywordTokenKind),
      "expected one of [.caseKeyword] for 'caseKeyword' " + 
      "in node of kind forInStmt")
    let _itemPattern = raw[Cursor.pattern]
    precondition(_itemPattern.kind == .pattern,
                 "expected child of kind .pattern, " +
                 "got \(_itemPattern.kind)")
    let _inKeyword = raw[Cursor.inToken]
    guard let _inKeywordTokenKind = _inKeyword.tokenKind else {
      fatalError("expected token child, got \(_inKeyword.kind)")
    }
    precondition([.inKeyword].contains(_inKeywordTokenKind),
      "expected one of [.inKeyword] for 'inKeyword' " + 
      "in node of kind forInStmt")
    let _collectionExpr = raw[Cursor.expr]
    precondition(_collectionExpr.kind == .expr,
                 "expected child of kind .expr, " +
                 "got \(_collectionExpr.kind)")
    let _whereClause = raw[Cursor.whereClause]
    precondition(_whereClause.kind == .whereClause,
                 "expected child of kind .whereClause, " +
                 "got \(_whereClause.kind)")
    let _body = raw[Cursor.codeBlock]
    precondition(_body.kind == .codeBlock,
                 "expected child of kind .codeBlock, " +
                 "got \(_body.kind)")
    let _semicolon = raw[Cursor.semicolonToken]
    guard let _semicolonTokenKind = _semicolon.tokenKind else {
      fatalError("expected token child, got \(_semicolon.kind)")
    }
    precondition([.semicolon].contains(_semicolonTokenKind),
      "expected one of [.semicolon] for 'semicolon' " + 
      "in node of kind forInStmt")
  }
#endif

  public var labelName: TokenSyntax? {
    guard raw[Cursor.labelName].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.labelName))
  }

  public func withLabelName(
    _ newTokenSyntax: TokenSyntax?) -> ForInStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.identifier(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.labelName)
    return ForInStmtSyntax(root: root, data: newData)
  }

  public var labelColon: TokenSyntax? {
    guard raw[Cursor.labelColon].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.labelColon))
  }

  public func withLabelColon(
    _ newTokenSyntax: TokenSyntax?) -> ForInStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.colon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.labelColon)
    return ForInStmtSyntax(root: root, data: newData)
  }

  public var forKeyword: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.forKeyword))
  }

  public func withForKeyword(
    _ newTokenSyntax: TokenSyntax?) -> ForInStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.forKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.forKeyword)
    return ForInStmtSyntax(root: root, data: newData)
  }

  public var caseKeyword: TokenSyntax? {
    guard raw[Cursor.caseKeyword].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.caseKeyword))
  }

  public func withCaseKeyword(
    _ newTokenSyntax: TokenSyntax?) -> ForInStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.caseKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.caseKeyword)
    return ForInStmtSyntax(root: root, data: newData)
  }

  public var itemPattern: PatternSyntax {
    return PatternSyntax(root: _root,
      data: data.cachedChild(at: Cursor.itemPattern))
  }

  public func withItemPattern(
    _ newPatternSyntax: PatternSyntax?) -> ForInStmtSyntax {
    let raw = newPatternSyntax?.raw ?? RawSyntax.missing(.pattern)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.itemPattern)
    return ForInStmtSyntax(root: root, data: newData)
  }

  public var inKeyword: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.inKeyword))
  }

  public func withInKeyword(
    _ newTokenSyntax: TokenSyntax?) -> ForInStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.inKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.inKeyword)
    return ForInStmtSyntax(root: root, data: newData)
  }

  public var collectionExpr: ExprSyntax {
    return ExprSyntax(root: _root,
      data: data.cachedChild(at: Cursor.collectionExpr))
  }

  public func withCollectionExpr(
    _ newExprSyntax: ExprSyntax?) -> ForInStmtSyntax {
    let raw = newExprSyntax?.raw ?? RawSyntax.missing(.expr)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.collectionExpr)
    return ForInStmtSyntax(root: root, data: newData)
  }

  public var whereClause: WhereClauseSyntax? {
    guard raw[Cursor.whereClause].isPresent else { return nil }
    return WhereClauseSyntax(root: _root,
      data: data.cachedChild(at: Cursor.whereClause))
  }

  public func withWhereClause(
    _ newWhereClauseSyntax: WhereClauseSyntax?) -> ForInStmtSyntax {
    let raw = newWhereClauseSyntax?.raw ?? RawSyntax.missing(.whereClause)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.whereClause)
    return ForInStmtSyntax(root: root, data: newData)
  }

  public var body: CodeBlockSyntax {
    return CodeBlockSyntax(root: _root,
      data: data.cachedChild(at: Cursor.body))
  }

  public func withBody(
    _ newCodeBlockSyntax: CodeBlockSyntax?) -> ForInStmtSyntax {
    let raw = newCodeBlockSyntax?.raw ?? RawSyntax.missing(.codeBlock)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.body)
    return ForInStmtSyntax(root: root, data: newData)
  }

  public var semicolon: TokenSyntax? {
    guard raw[Cursor.semicolon].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.semicolon))
  }

  public func withSemicolon(
    _ newTokenSyntax: TokenSyntax?) -> ForInStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.semicolon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.semicolon)
    return ForInStmtSyntax(root: root, data: newData)
  }
}
public class SwitchStmtSyntax: StmtSyntax {
  enum Cursor: Int {
    case labelName
    case labelColon
    case switchKeyword
    case expression
    case openBrace
    case cases
    case closeBrace
    case semicolon
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 8)
    let _labelName = raw[Cursor.identifierToken]
    guard let _labelNameTokenKind = _labelName.tokenKind else {
      fatalError("expected token child, got \(_labelName.kind)")
    }
    precondition([.identifier].contains(_labelNameTokenKind),
      "expected one of [.identifier] for 'labelName' " + 
      "in node of kind switchStmt")
    let _labelColon = raw[Cursor.colonToken]
    guard let _labelColonTokenKind = _labelColon.tokenKind else {
      fatalError("expected token child, got \(_labelColon.kind)")
    }
    precondition([.colon].contains(_labelColonTokenKind),
      "expected one of [.colon] for 'labelColon' " + 
      "in node of kind switchStmt")
    let _switchKeyword = raw[Cursor.switchToken]
    guard let _switchKeywordTokenKind = _switchKeyword.tokenKind else {
      fatalError("expected token child, got \(_switchKeyword.kind)")
    }
    precondition([.switchKeyword].contains(_switchKeywordTokenKind),
      "expected one of [.switchKeyword] for 'switchKeyword' " + 
      "in node of kind switchStmt")
    let _expression = raw[Cursor.expr]
    precondition(_expression.kind == .expr,
                 "expected child of kind .expr, " +
                 "got \(_expression.kind)")
    let _openBrace = raw[Cursor.leftBraceToken]
    guard let _openBraceTokenKind = _openBrace.tokenKind else {
      fatalError("expected token child, got \(_openBrace.kind)")
    }
    precondition([.leftBrace].contains(_openBraceTokenKind),
      "expected one of [.leftBrace] for 'openBrace' " + 
      "in node of kind switchStmt")
    let _cases = raw[Cursor.switchCaseList]
    precondition(_cases.kind == .switchCaseList,
                 "expected child of kind .switchCaseList, " +
                 "got \(_cases.kind)")
    let _closeBrace = raw[Cursor.rightBraceToken]
    guard let _closeBraceTokenKind = _closeBrace.tokenKind else {
      fatalError("expected token child, got \(_closeBrace.kind)")
    }
    precondition([.rightBrace].contains(_closeBraceTokenKind),
      "expected one of [.rightBrace] for 'closeBrace' " + 
      "in node of kind switchStmt")
    let _semicolon = raw[Cursor.semicolonToken]
    guard let _semicolonTokenKind = _semicolon.tokenKind else {
      fatalError("expected token child, got \(_semicolon.kind)")
    }
    precondition([.semicolon].contains(_semicolonTokenKind),
      "expected one of [.semicolon] for 'semicolon' " + 
      "in node of kind switchStmt")
  }
#endif

  public var labelName: TokenSyntax? {
    guard raw[Cursor.labelName].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.labelName))
  }

  public func withLabelName(
    _ newTokenSyntax: TokenSyntax?) -> SwitchStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.identifier(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.labelName)
    return SwitchStmtSyntax(root: root, data: newData)
  }

  public var labelColon: TokenSyntax? {
    guard raw[Cursor.labelColon].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.labelColon))
  }

  public func withLabelColon(
    _ newTokenSyntax: TokenSyntax?) -> SwitchStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.colon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.labelColon)
    return SwitchStmtSyntax(root: root, data: newData)
  }

  public var switchKeyword: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.switchKeyword))
  }

  public func withSwitchKeyword(
    _ newTokenSyntax: TokenSyntax?) -> SwitchStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.switchKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.switchKeyword)
    return SwitchStmtSyntax(root: root, data: newData)
  }

  public var expression: ExprSyntax {
    return ExprSyntax(root: _root,
      data: data.cachedChild(at: Cursor.expression))
  }

  public func withExpression(
    _ newExprSyntax: ExprSyntax?) -> SwitchStmtSyntax {
    let raw = newExprSyntax?.raw ?? RawSyntax.missing(.expr)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.expression)
    return SwitchStmtSyntax(root: root, data: newData)
  }

  public var openBrace: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.openBrace))
  }

  public func withOpenBrace(
    _ newTokenSyntax: TokenSyntax?) -> SwitchStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.leftBrace)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.openBrace)
    return SwitchStmtSyntax(root: root, data: newData)
  }

  public var cases: SwitchCaseListSyntax {
    return SwitchCaseListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.cases))
  }

  public func addSwitchCase(_ elt: SwitchCaseSyntax) -> SwitchStmtSyntax {
    let childRaw = raw[Cursor.cases].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.cases)
    return SwitchStmtSyntax(root: root, data: newData)
  }

  public func withCases(
    _ newSwitchCaseListSyntax: SwitchCaseListSyntax?) -> SwitchStmtSyntax {
    let raw = newSwitchCaseListSyntax?.raw ?? RawSyntax.missing(.switchCaseList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.cases)
    return SwitchStmtSyntax(root: root, data: newData)
  }

  public var closeBrace: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.closeBrace))
  }

  public func withCloseBrace(
    _ newTokenSyntax: TokenSyntax?) -> SwitchStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.rightBrace)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.closeBrace)
    return SwitchStmtSyntax(root: root, data: newData)
  }

  public var semicolon: TokenSyntax? {
    guard raw[Cursor.semicolon].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.semicolon))
  }

  public func withSemicolon(
    _ newTokenSyntax: TokenSyntax?) -> SwitchStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.semicolon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.semicolon)
    return SwitchStmtSyntax(root: root, data: newData)
  }
}
public typealias CatchClauseListSyntax = SyntaxCollection<CatchClauseSyntax>
public class DoStmtSyntax: StmtSyntax {
  enum Cursor: Int {
    case labelName
    case labelColon
    case doKeyword
    case body
    case catchClauses
    case semicolon
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 6)
    let _labelName = raw[Cursor.identifierToken]
    guard let _labelNameTokenKind = _labelName.tokenKind else {
      fatalError("expected token child, got \(_labelName.kind)")
    }
    precondition([.identifier].contains(_labelNameTokenKind),
      "expected one of [.identifier] for 'labelName' " + 
      "in node of kind doStmt")
    let _labelColon = raw[Cursor.colonToken]
    guard let _labelColonTokenKind = _labelColon.tokenKind else {
      fatalError("expected token child, got \(_labelColon.kind)")
    }
    precondition([.colon].contains(_labelColonTokenKind),
      "expected one of [.colon] for 'labelColon' " + 
      "in node of kind doStmt")
    let _doKeyword = raw[Cursor.doToken]
    guard let _doKeywordTokenKind = _doKeyword.tokenKind else {
      fatalError("expected token child, got \(_doKeyword.kind)")
    }
    precondition([.doKeyword].contains(_doKeywordTokenKind),
      "expected one of [.doKeyword] for 'doKeyword' " + 
      "in node of kind doStmt")
    let _body = raw[Cursor.codeBlock]
    precondition(_body.kind == .codeBlock,
                 "expected child of kind .codeBlock, " +
                 "got \(_body.kind)")
    let _catchClauses = raw[Cursor.catchClauseList]
    precondition(_catchClauses.kind == .catchClauseList,
                 "expected child of kind .catchClauseList, " +
                 "got \(_catchClauses.kind)")
    let _semicolon = raw[Cursor.semicolonToken]
    guard let _semicolonTokenKind = _semicolon.tokenKind else {
      fatalError("expected token child, got \(_semicolon.kind)")
    }
    precondition([.semicolon].contains(_semicolonTokenKind),
      "expected one of [.semicolon] for 'semicolon' " + 
      "in node of kind doStmt")
  }
#endif

  public var labelName: TokenSyntax? {
    guard raw[Cursor.labelName].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.labelName))
  }

  public func withLabelName(
    _ newTokenSyntax: TokenSyntax?) -> DoStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.identifier(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.labelName)
    return DoStmtSyntax(root: root, data: newData)
  }

  public var labelColon: TokenSyntax? {
    guard raw[Cursor.labelColon].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.labelColon))
  }

  public func withLabelColon(
    _ newTokenSyntax: TokenSyntax?) -> DoStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.colon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.labelColon)
    return DoStmtSyntax(root: root, data: newData)
  }

  public var doKeyword: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.doKeyword))
  }

  public func withDoKeyword(
    _ newTokenSyntax: TokenSyntax?) -> DoStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.doKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.doKeyword)
    return DoStmtSyntax(root: root, data: newData)
  }

  public var body: CodeBlockSyntax {
    return CodeBlockSyntax(root: _root,
      data: data.cachedChild(at: Cursor.body))
  }

  public func withBody(
    _ newCodeBlockSyntax: CodeBlockSyntax?) -> DoStmtSyntax {
    let raw = newCodeBlockSyntax?.raw ?? RawSyntax.missing(.codeBlock)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.body)
    return DoStmtSyntax(root: root, data: newData)
  }

  public var catchClauses: CatchClauseListSyntax {
    return CatchClauseListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.catchClauses))
  }

  public func addCatchClause(_ elt: CatchClauseSyntax) -> DoStmtSyntax {
    let childRaw = raw[Cursor.catchClauses].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.catchClauses)
    return DoStmtSyntax(root: root, data: newData)
  }

  public func withCatchClauses(
    _ newCatchClauseListSyntax: CatchClauseListSyntax?) -> DoStmtSyntax {
    let raw = newCatchClauseListSyntax?.raw ?? RawSyntax.missing(.catchClauseList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.catchClauses)
    return DoStmtSyntax(root: root, data: newData)
  }

  public var semicolon: TokenSyntax? {
    guard raw[Cursor.semicolon].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.semicolon))
  }

  public func withSemicolon(
    _ newTokenSyntax: TokenSyntax?) -> DoStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.semicolon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.semicolon)
    return DoStmtSyntax(root: root, data: newData)
  }
}
public class ReturnStmtSyntax: StmtSyntax {
  enum Cursor: Int {
    case returnKeyword
    case expression
    case semicolon
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 3)
    let _returnKeyword = raw[Cursor.returnToken]
    guard let _returnKeywordTokenKind = _returnKeyword.tokenKind else {
      fatalError("expected token child, got \(_returnKeyword.kind)")
    }
    precondition([.returnKeyword].contains(_returnKeywordTokenKind),
      "expected one of [.returnKeyword] for 'returnKeyword' " + 
      "in node of kind returnStmt")
    let _expression = raw[Cursor.expr]
    precondition(_expression.kind == .expr,
                 "expected child of kind .expr, " +
                 "got \(_expression.kind)")
    let _semicolon = raw[Cursor.semicolonToken]
    guard let _semicolonTokenKind = _semicolon.tokenKind else {
      fatalError("expected token child, got \(_semicolon.kind)")
    }
    precondition([.semicolon].contains(_semicolonTokenKind),
      "expected one of [.semicolon] for 'semicolon' " + 
      "in node of kind returnStmt")
  }
#endif

  public var returnKeyword: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.returnKeyword))
  }

  public func withReturnKeyword(
    _ newTokenSyntax: TokenSyntax?) -> ReturnStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.returnKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.returnKeyword)
    return ReturnStmtSyntax(root: root, data: newData)
  }

  public var expression: ExprSyntax? {
    guard raw[Cursor.expression].isPresent else { return nil }
    return ExprSyntax(root: _root,
      data: data.cachedChild(at: Cursor.expression))
  }

  public func withExpression(
    _ newExprSyntax: ExprSyntax?) -> ReturnStmtSyntax {
    let raw = newExprSyntax?.raw ?? RawSyntax.missing(.expr)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.expression)
    return ReturnStmtSyntax(root: root, data: newData)
  }

  public var semicolon: TokenSyntax? {
    guard raw[Cursor.semicolon].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.semicolon))
  }

  public func withSemicolon(
    _ newTokenSyntax: TokenSyntax?) -> ReturnStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.semicolon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.semicolon)
    return ReturnStmtSyntax(root: root, data: newData)
  }
}
public class FallthroughStmtSyntax: StmtSyntax {
  enum Cursor: Int {
    case fallthroughKeyword
    case semicolon
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 2)
    let _fallthroughKeyword = raw[Cursor.fallthroughToken]
    guard let _fallthroughKeywordTokenKind = _fallthroughKeyword.tokenKind else {
      fatalError("expected token child, got \(_fallthroughKeyword.kind)")
    }
    precondition([.fallthroughKeyword].contains(_fallthroughKeywordTokenKind),
      "expected one of [.fallthroughKeyword] for 'fallthroughKeyword' " + 
      "in node of kind fallthroughStmt")
    let _semicolon = raw[Cursor.semicolonToken]
    guard let _semicolonTokenKind = _semicolon.tokenKind else {
      fatalError("expected token child, got \(_semicolon.kind)")
    }
    precondition([.semicolon].contains(_semicolonTokenKind),
      "expected one of [.semicolon] for 'semicolon' " + 
      "in node of kind fallthroughStmt")
  }
#endif

  public var fallthroughKeyword: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.fallthroughKeyword))
  }

  public func withFallthroughKeyword(
    _ newTokenSyntax: TokenSyntax?) -> FallthroughStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.fallthroughKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.fallthroughKeyword)
    return FallthroughStmtSyntax(root: root, data: newData)
  }

  public var semicolon: TokenSyntax? {
    guard raw[Cursor.semicolon].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.semicolon))
  }

  public func withSemicolon(
    _ newTokenSyntax: TokenSyntax?) -> FallthroughStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.semicolon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.semicolon)
    return FallthroughStmtSyntax(root: root, data: newData)
  }
}
public class BreakStmtSyntax: StmtSyntax {
  enum Cursor: Int {
    case breakKeyword
    case label
    case semicolon
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 3)
    let _breakKeyword = raw[Cursor.breakToken]
    guard let _breakKeywordTokenKind = _breakKeyword.tokenKind else {
      fatalError("expected token child, got \(_breakKeyword.kind)")
    }
    precondition([.breakKeyword].contains(_breakKeywordTokenKind),
      "expected one of [.breakKeyword] for 'breakKeyword' " + 
      "in node of kind breakStmt")
    let _label = raw[Cursor.identifierToken]
    guard let _labelTokenKind = _label.tokenKind else {
      fatalError("expected token child, got \(_label.kind)")
    }
    precondition([.identifier].contains(_labelTokenKind),
      "expected one of [.identifier] for 'label' " + 
      "in node of kind breakStmt")
    let _semicolon = raw[Cursor.semicolonToken]
    guard let _semicolonTokenKind = _semicolon.tokenKind else {
      fatalError("expected token child, got \(_semicolon.kind)")
    }
    precondition([.semicolon].contains(_semicolonTokenKind),
      "expected one of [.semicolon] for 'semicolon' " + 
      "in node of kind breakStmt")
  }
#endif

  public var breakKeyword: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.breakKeyword))
  }

  public func withBreakKeyword(
    _ newTokenSyntax: TokenSyntax?) -> BreakStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.breakKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.breakKeyword)
    return BreakStmtSyntax(root: root, data: newData)
  }

  public var label: TokenSyntax? {
    guard raw[Cursor.label].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.label))
  }

  public func withLabel(
    _ newTokenSyntax: TokenSyntax?) -> BreakStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.identifier(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.label)
    return BreakStmtSyntax(root: root, data: newData)
  }

  public var semicolon: TokenSyntax? {
    guard raw[Cursor.semicolon].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.semicolon))
  }

  public func withSemicolon(
    _ newTokenSyntax: TokenSyntax?) -> BreakStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.semicolon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.semicolon)
    return BreakStmtSyntax(root: root, data: newData)
  }
}
public class CodeBlockSyntax: Syntax {
  enum Cursor: Int {
    case openBrace
    case statments
    case closeBrace
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 3)
    let _openBrace = raw[Cursor.leftBraceToken]
    guard let _openBraceTokenKind = _openBrace.tokenKind else {
      fatalError("expected token child, got \(_openBrace.kind)")
    }
    precondition([.leftBrace].contains(_openBraceTokenKind),
      "expected one of [.leftBrace] for 'openBrace' " + 
      "in node of kind codeBlock")
    let _statments = raw[Cursor.stmtList]
    precondition(_statments.kind == .stmtList,
                 "expected child of kind .stmtList, " +
                 "got \(_statments.kind)")
    let _closeBrace = raw[Cursor.rightBraceToken]
    guard let _closeBraceTokenKind = _closeBrace.tokenKind else {
      fatalError("expected token child, got \(_closeBrace.kind)")
    }
    precondition([.rightBrace].contains(_closeBraceTokenKind),
      "expected one of [.rightBrace] for 'closeBrace' " + 
      "in node of kind codeBlock")
  }
#endif

  public var openBrace: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.openBrace))
  }

  public func withOpenBrace(
    _ newTokenSyntax: TokenSyntax?) -> CodeBlockSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.leftBrace)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.openBrace)
    return CodeBlockSyntax(root: root, data: newData)
  }

  public var statments: StmtListSyntax {
    return StmtListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.statments))
  }

  public func addStmt(_ elt: StmtSyntax) -> CodeBlockSyntax {
    let childRaw = raw[Cursor.statments].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.statments)
    return CodeBlockSyntax(root: root, data: newData)
  }

  public func withStatments(
    _ newStmtListSyntax: StmtListSyntax?) -> CodeBlockSyntax {
    let raw = newStmtListSyntax?.raw ?? RawSyntax.missing(.stmtList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.statments)
    return CodeBlockSyntax(root: root, data: newData)
  }

  public var closeBrace: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.closeBrace))
  }

  public func withCloseBrace(
    _ newTokenSyntax: TokenSyntax?) -> CodeBlockSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.rightBrace)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.closeBrace)
    return CodeBlockSyntax(root: root, data: newData)
  }
}
public typealias CaseItemListSyntax = SyntaxCollection<CaseItemSyntax>
public class ConditionSyntax: Syntax {
  enum Cursor: Int {
    case condition
    case trailingComma
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 2)
    let _condition = raw[Cursor.syntax]
    precondition(_condition.kind == .syntax,
                 "expected child of kind .syntax, " +
                 "got \(_condition.kind)")
    let _trailingComma = raw[Cursor.commaToken]
    guard let _trailingCommaTokenKind = _trailingComma.tokenKind else {
      fatalError("expected token child, got \(_trailingComma.kind)")
    }
    precondition([.comma].contains(_trailingCommaTokenKind),
      "expected one of [.comma] for 'trailingComma' " + 
      "in node of kind condition")
  }
#endif

  public var condition: Syntax {
    return Syntax(root: _root,
      data: data.cachedChild(at: Cursor.condition))
  }

  public func withCondition(
    _ newSyntax: Syntax?) -> ConditionSyntax {
    let raw = newSyntax?.raw ?? RawSyntax.missing(.unknown)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.condition)
    return ConditionSyntax(root: root, data: newData)
  }

  public var trailingComma: TokenSyntax? {
    guard raw[Cursor.trailingComma].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.trailingComma))
  }

  public func withTrailingComma(
    _ newTokenSyntax: TokenSyntax?) -> ConditionSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.comma)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.trailingComma)
    return ConditionSyntax(root: root, data: newData)
  }
}
public typealias ConditionListSyntax = SyntaxCollection<ConditionSyntax>
public class DeclarationStmtSyntax: StmtSyntax {
  enum Cursor: Int {
    case declaration
    case semicolon
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 2)
    let _declaration = raw[Cursor.decl]
    precondition(_declaration.kind == .decl,
                 "expected child of kind .decl, " +
                 "got \(_declaration.kind)")
    let _semicolon = raw[Cursor.semicolonToken]
    guard let _semicolonTokenKind = _semicolon.tokenKind else {
      fatalError("expected token child, got \(_semicolon.kind)")
    }
    precondition([.semicolon].contains(_semicolonTokenKind),
      "expected one of [.semicolon] for 'semicolon' " + 
      "in node of kind declarationStmt")
  }
#endif

  public var declaration: DeclSyntax {
    return DeclSyntax(root: _root,
      data: data.cachedChild(at: Cursor.declaration))
  }

  public func withDeclaration(
    _ newDeclSyntax: DeclSyntax?) -> DeclarationStmtSyntax {
    let raw = newDeclSyntax?.raw ?? RawSyntax.missing(.decl)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.declaration)
    return DeclarationStmtSyntax(root: root, data: newData)
  }

  public var semicolon: TokenSyntax? {
    guard raw[Cursor.semicolon].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.semicolon))
  }

  public func withSemicolon(
    _ newTokenSyntax: TokenSyntax?) -> DeclarationStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.semicolon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.semicolon)
    return DeclarationStmtSyntax(root: root, data: newData)
  }
}
public class ThrowStmtSyntax: StmtSyntax {
  enum Cursor: Int {
    case throwKeyword
    case expression
    case semicolon
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 3)
    let _throwKeyword = raw[Cursor.throwToken]
    guard let _throwKeywordTokenKind = _throwKeyword.tokenKind else {
      fatalError("expected token child, got \(_throwKeyword.kind)")
    }
    precondition([.throwKeyword].contains(_throwKeywordTokenKind),
      "expected one of [.throwKeyword] for 'throwKeyword' " + 
      "in node of kind throwStmt")
    let _expression = raw[Cursor.expr]
    precondition(_expression.kind == .expr,
                 "expected child of kind .expr, " +
                 "got \(_expression.kind)")
    let _semicolon = raw[Cursor.semicolonToken]
    guard let _semicolonTokenKind = _semicolon.tokenKind else {
      fatalError("expected token child, got \(_semicolon.kind)")
    }
    precondition([.semicolon].contains(_semicolonTokenKind),
      "expected one of [.semicolon] for 'semicolon' " + 
      "in node of kind throwStmt")
  }
#endif

  public var throwKeyword: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.throwKeyword))
  }

  public func withThrowKeyword(
    _ newTokenSyntax: TokenSyntax?) -> ThrowStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.throwKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.throwKeyword)
    return ThrowStmtSyntax(root: root, data: newData)
  }

  public var expression: ExprSyntax {
    return ExprSyntax(root: _root,
      data: data.cachedChild(at: Cursor.expression))
  }

  public func withExpression(
    _ newExprSyntax: ExprSyntax?) -> ThrowStmtSyntax {
    let raw = newExprSyntax?.raw ?? RawSyntax.missing(.expr)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.expression)
    return ThrowStmtSyntax(root: root, data: newData)
  }

  public var semicolon: TokenSyntax? {
    guard raw[Cursor.semicolon].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.semicolon))
  }

  public func withSemicolon(
    _ newTokenSyntax: TokenSyntax?) -> ThrowStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.semicolon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.semicolon)
    return ThrowStmtSyntax(root: root, data: newData)
  }
}
public class IfStmtSyntax: StmtSyntax {
  enum Cursor: Int {
    case labelName
    case labelColon
    case ifKeyword
    case conditions
    case body
    case elseClause
    case semicolon
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 7)
    let _labelName = raw[Cursor.identifierToken]
    guard let _labelNameTokenKind = _labelName.tokenKind else {
      fatalError("expected token child, got \(_labelName.kind)")
    }
    precondition([.identifier].contains(_labelNameTokenKind),
      "expected one of [.identifier] for 'labelName' " + 
      "in node of kind ifStmt")
    let _labelColon = raw[Cursor.colonToken]
    guard let _labelColonTokenKind = _labelColon.tokenKind else {
      fatalError("expected token child, got \(_labelColon.kind)")
    }
    precondition([.colon].contains(_labelColonTokenKind),
      "expected one of [.colon] for 'labelColon' " + 
      "in node of kind ifStmt")
    let _ifKeyword = raw[Cursor.ifToken]
    guard let _ifKeywordTokenKind = _ifKeyword.tokenKind else {
      fatalError("expected token child, got \(_ifKeyword.kind)")
    }
    precondition([.ifKeyword].contains(_ifKeywordTokenKind),
      "expected one of [.ifKeyword] for 'ifKeyword' " + 
      "in node of kind ifStmt")
    let _conditions = raw[Cursor.conditionList]
    precondition(_conditions.kind == .conditionList,
                 "expected child of kind .conditionList, " +
                 "got \(_conditions.kind)")
    let _body = raw[Cursor.codeBlock]
    precondition(_body.kind == .codeBlock,
                 "expected child of kind .codeBlock, " +
                 "got \(_body.kind)")
    let _elseClause = raw[Cursor.syntax]
    precondition(_elseClause.kind == .syntax,
                 "expected child of kind .syntax, " +
                 "got \(_elseClause.kind)")
    let _semicolon = raw[Cursor.semicolonToken]
    guard let _semicolonTokenKind = _semicolon.tokenKind else {
      fatalError("expected token child, got \(_semicolon.kind)")
    }
    precondition([.semicolon].contains(_semicolonTokenKind),
      "expected one of [.semicolon] for 'semicolon' " + 
      "in node of kind ifStmt")
  }
#endif

  public var labelName: TokenSyntax? {
    guard raw[Cursor.labelName].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.labelName))
  }

  public func withLabelName(
    _ newTokenSyntax: TokenSyntax?) -> IfStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.identifier(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.labelName)
    return IfStmtSyntax(root: root, data: newData)
  }

  public var labelColon: TokenSyntax? {
    guard raw[Cursor.labelColon].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.labelColon))
  }

  public func withLabelColon(
    _ newTokenSyntax: TokenSyntax?) -> IfStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.colon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.labelColon)
    return IfStmtSyntax(root: root, data: newData)
  }

  public var ifKeyword: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.ifKeyword))
  }

  public func withIfKeyword(
    _ newTokenSyntax: TokenSyntax?) -> IfStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.ifKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.ifKeyword)
    return IfStmtSyntax(root: root, data: newData)
  }

  public var conditions: ConditionListSyntax {
    return ConditionListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.conditions))
  }

  public func addCondition(_ elt: ConditionSyntax) -> IfStmtSyntax {
    let childRaw = raw[Cursor.conditions].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.conditions)
    return IfStmtSyntax(root: root, data: newData)
  }

  public func withConditions(
    _ newConditionListSyntax: ConditionListSyntax?) -> IfStmtSyntax {
    let raw = newConditionListSyntax?.raw ?? RawSyntax.missing(.conditionList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.conditions)
    return IfStmtSyntax(root: root, data: newData)
  }

  public var body: CodeBlockSyntax {
    return CodeBlockSyntax(root: _root,
      data: data.cachedChild(at: Cursor.body))
  }

  public func withBody(
    _ newCodeBlockSyntax: CodeBlockSyntax?) -> IfStmtSyntax {
    let raw = newCodeBlockSyntax?.raw ?? RawSyntax.missing(.codeBlock)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.body)
    return IfStmtSyntax(root: root, data: newData)
  }

  public var elseClause: Syntax? {
    guard raw[Cursor.elseClause].isPresent else { return nil }
    return Syntax(root: _root,
      data: data.cachedChild(at: Cursor.elseClause))
  }

  public func withElseClause(
    _ newSyntax: Syntax?) -> IfStmtSyntax {
    let raw = newSyntax?.raw ?? RawSyntax.missing(.unknown)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.elseClause)
    return IfStmtSyntax(root: root, data: newData)
  }

  public var semicolon: TokenSyntax? {
    guard raw[Cursor.semicolon].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.semicolon))
  }

  public func withSemicolon(
    _ newTokenSyntax: TokenSyntax?) -> IfStmtSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.semicolon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.semicolon)
    return IfStmtSyntax(root: root, data: newData)
  }
}
public class ElseIfContinuationSyntax: Syntax {
  enum Cursor: Int {
    case ifStatement
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 1)
    let _ifStatement = raw[Cursor.ifStmt]
    precondition(_ifStatement.kind == .ifStmt,
                 "expected child of kind .ifStmt, " +
                 "got \(_ifStatement.kind)")
  }
#endif

  public var ifStatement: IfStmtSyntax {
    return IfStmtSyntax(root: _root,
      data: data.cachedChild(at: Cursor.ifStatement))
  }

  public func withIfStatement(
    _ newIfStmtSyntax: IfStmtSyntax?) -> ElseIfContinuationSyntax {
    let raw = newIfStmtSyntax?.raw ?? RawSyntax.missing(.ifStmt)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.ifStatement)
    return ElseIfContinuationSyntax(root: root, data: newData)
  }
}
public class ElseBlockSyntax: Syntax {
  enum Cursor: Int {
    case elseKeyword
    case body
    case semicolon
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 3)
    let _elseKeyword = raw[Cursor.elseToken]
    guard let _elseKeywordTokenKind = _elseKeyword.tokenKind else {
      fatalError("expected token child, got \(_elseKeyword.kind)")
    }
    precondition([.elseKeyword].contains(_elseKeywordTokenKind),
      "expected one of [.elseKeyword] for 'elseKeyword' " + 
      "in node of kind elseBlock")
    let _body = raw[Cursor.codeBlock]
    precondition(_body.kind == .codeBlock,
                 "expected child of kind .codeBlock, " +
                 "got \(_body.kind)")
    let _semicolon = raw[Cursor.semicolonToken]
    guard let _semicolonTokenKind = _semicolon.tokenKind else {
      fatalError("expected token child, got \(_semicolon.kind)")
    }
    precondition([.semicolon].contains(_semicolonTokenKind),
      "expected one of [.semicolon] for 'semicolon' " + 
      "in node of kind elseBlock")
  }
#endif

  public var elseKeyword: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.elseKeyword))
  }

  public func withElseKeyword(
    _ newTokenSyntax: TokenSyntax?) -> ElseBlockSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.elseKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.elseKeyword)
    return ElseBlockSyntax(root: root, data: newData)
  }

  public var body: CodeBlockSyntax {
    return CodeBlockSyntax(root: _root,
      data: data.cachedChild(at: Cursor.body))
  }

  public func withBody(
    _ newCodeBlockSyntax: CodeBlockSyntax?) -> ElseBlockSyntax {
    let raw = newCodeBlockSyntax?.raw ?? RawSyntax.missing(.codeBlock)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.body)
    return ElseBlockSyntax(root: root, data: newData)
  }

  public var semicolon: TokenSyntax? {
    guard raw[Cursor.semicolon].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.semicolon))
  }

  public func withSemicolon(
    _ newTokenSyntax: TokenSyntax?) -> ElseBlockSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.semicolon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.semicolon)
    return ElseBlockSyntax(root: root, data: newData)
  }
}
public typealias StmtListSyntax = SyntaxCollection<StmtSyntax>
public class SwitchCaseSyntax: Syntax {
  enum Cursor: Int {
    case label
    case body
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 2)
    let _label = raw[Cursor.syntax]
    precondition(_label.kind == .syntax,
                 "expected child of kind .syntax, " +
                 "got \(_label.kind)")
    let _body = raw[Cursor.stmtList]
    precondition(_body.kind == .stmtList,
                 "expected child of kind .stmtList, " +
                 "got \(_body.kind)")
  }
#endif

  public var label: Syntax {
    return Syntax(root: _root,
      data: data.cachedChild(at: Cursor.label))
  }

  public func withLabel(
    _ newSyntax: Syntax?) -> SwitchCaseSyntax {
    let raw = newSyntax?.raw ?? RawSyntax.missing(.unknown)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.label)
    return SwitchCaseSyntax(root: root, data: newData)
  }

  public var body: StmtListSyntax {
    return StmtListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.body))
  }

  public func addStmt(_ elt: StmtSyntax) -> SwitchCaseSyntax {
    let childRaw = raw[Cursor.body].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.body)
    return SwitchCaseSyntax(root: root, data: newData)
  }

  public func withBody(
    _ newStmtListSyntax: StmtListSyntax?) -> SwitchCaseSyntax {
    let raw = newStmtListSyntax?.raw ?? RawSyntax.missing(.stmtList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.body)
    return SwitchCaseSyntax(root: root, data: newData)
  }
}
public class SwitchDefaultLabelSyntax: Syntax {
  enum Cursor: Int {
    case defaultKeyword
    case colon
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 2)
    let _defaultKeyword = raw[Cursor.defaultToken]
    guard let _defaultKeywordTokenKind = _defaultKeyword.tokenKind else {
      fatalError("expected token child, got \(_defaultKeyword.kind)")
    }
    precondition([.defaultKeyword].contains(_defaultKeywordTokenKind),
      "expected one of [.defaultKeyword] for 'defaultKeyword' " + 
      "in node of kind switchDefaultLabel")
    let _colon = raw[Cursor.colonToken]
    guard let _colonTokenKind = _colon.tokenKind else {
      fatalError("expected token child, got \(_colon.kind)")
    }
    precondition([.colon].contains(_colonTokenKind),
      "expected one of [.colon] for 'colon' " + 
      "in node of kind switchDefaultLabel")
  }
#endif

  public var defaultKeyword: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.defaultKeyword))
  }

  public func withDefaultKeyword(
    _ newTokenSyntax: TokenSyntax?) -> SwitchDefaultLabelSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.defaultKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.defaultKeyword)
    return SwitchDefaultLabelSyntax(root: root, data: newData)
  }

  public var colon: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.colon))
  }

  public func withColon(
    _ newTokenSyntax: TokenSyntax?) -> SwitchDefaultLabelSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.colon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.colon)
    return SwitchDefaultLabelSyntax(root: root, data: newData)
  }
}
public class CaseItemSyntax: Syntax {
  enum Cursor: Int {
    case pattern
    case whereClause
    case comma
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 3)
    let _pattern = raw[Cursor.pattern]
    precondition(_pattern.kind == .pattern,
                 "expected child of kind .pattern, " +
                 "got \(_pattern.kind)")
    let _whereClause = raw[Cursor.whereClause]
    precondition(_whereClause.kind == .whereClause,
                 "expected child of kind .whereClause, " +
                 "got \(_whereClause.kind)")
    let _comma = raw[Cursor.commaToken]
    guard let _commaTokenKind = _comma.tokenKind else {
      fatalError("expected token child, got \(_comma.kind)")
    }
    precondition([.comma].contains(_commaTokenKind),
      "expected one of [.comma] for 'comma' " + 
      "in node of kind caseItem")
  }
#endif

  public var pattern: PatternSyntax {
    return PatternSyntax(root: _root,
      data: data.cachedChild(at: Cursor.pattern))
  }

  public func withPattern(
    _ newPatternSyntax: PatternSyntax?) -> CaseItemSyntax {
    let raw = newPatternSyntax?.raw ?? RawSyntax.missing(.pattern)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.pattern)
    return CaseItemSyntax(root: root, data: newData)
  }

  public var whereClause: WhereClauseSyntax? {
    guard raw[Cursor.whereClause].isPresent else { return nil }
    return WhereClauseSyntax(root: _root,
      data: data.cachedChild(at: Cursor.whereClause))
  }

  public func withWhereClause(
    _ newWhereClauseSyntax: WhereClauseSyntax?) -> CaseItemSyntax {
    let raw = newWhereClauseSyntax?.raw ?? RawSyntax.missing(.whereClause)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.whereClause)
    return CaseItemSyntax(root: root, data: newData)
  }

  public var comma: TokenSyntax? {
    guard raw[Cursor.comma].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.comma))
  }

  public func withComma(
    _ newTokenSyntax: TokenSyntax?) -> CaseItemSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.comma)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.comma)
    return CaseItemSyntax(root: root, data: newData)
  }
}
public class SwitchCaseLabelSyntax: Syntax {
  enum Cursor: Int {
    case caseKeyword
    case caseItems
    case colon
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 3)
    let _caseKeyword = raw[Cursor.caseToken]
    guard let _caseKeywordTokenKind = _caseKeyword.tokenKind else {
      fatalError("expected token child, got \(_caseKeyword.kind)")
    }
    precondition([.caseKeyword].contains(_caseKeywordTokenKind),
      "expected one of [.caseKeyword] for 'caseKeyword' " + 
      "in node of kind switchCaseLabel")
    let _caseItems = raw[Cursor.caseItemList]
    precondition(_caseItems.kind == .caseItemList,
                 "expected child of kind .caseItemList, " +
                 "got \(_caseItems.kind)")
    let _colon = raw[Cursor.colonToken]
    guard let _colonTokenKind = _colon.tokenKind else {
      fatalError("expected token child, got \(_colon.kind)")
    }
    precondition([.colon].contains(_colonTokenKind),
      "expected one of [.colon] for 'colon' " + 
      "in node of kind switchCaseLabel")
  }
#endif

  public var caseKeyword: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.caseKeyword))
  }

  public func withCaseKeyword(
    _ newTokenSyntax: TokenSyntax?) -> SwitchCaseLabelSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.caseKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.caseKeyword)
    return SwitchCaseLabelSyntax(root: root, data: newData)
  }

  public var caseItems: CaseItemListSyntax {
    return CaseItemListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.caseItems))
  }

  public func addCaseItem(_ elt: CaseItemSyntax) -> SwitchCaseLabelSyntax {
    let childRaw = raw[Cursor.caseItems].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.caseItems)
    return SwitchCaseLabelSyntax(root: root, data: newData)
  }

  public func withCaseItems(
    _ newCaseItemListSyntax: CaseItemListSyntax?) -> SwitchCaseLabelSyntax {
    let raw = newCaseItemListSyntax?.raw ?? RawSyntax.missing(.caseItemList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.caseItems)
    return SwitchCaseLabelSyntax(root: root, data: newData)
  }

  public var colon: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.colon))
  }

  public func withColon(
    _ newTokenSyntax: TokenSyntax?) -> SwitchCaseLabelSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.colon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.colon)
    return SwitchCaseLabelSyntax(root: root, data: newData)
  }
}
public class CatchClauseSyntax: Syntax {
  enum Cursor: Int {
    case catchKeyword
    case pattern
    case whereClause
    case body
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 4)
    let _catchKeyword = raw[Cursor.catchToken]
    guard let _catchKeywordTokenKind = _catchKeyword.tokenKind else {
      fatalError("expected token child, got \(_catchKeyword.kind)")
    }
    precondition([.catchKeyword].contains(_catchKeywordTokenKind),
      "expected one of [.catchKeyword] for 'catchKeyword' " + 
      "in node of kind catchClause")
    let _pattern = raw[Cursor.pattern]
    precondition(_pattern.kind == .pattern,
                 "expected child of kind .pattern, " +
                 "got \(_pattern.kind)")
    let _whereClause = raw[Cursor.whereClause]
    precondition(_whereClause.kind == .whereClause,
                 "expected child of kind .whereClause, " +
                 "got \(_whereClause.kind)")
    let _body = raw[Cursor.codeBlock]
    precondition(_body.kind == .codeBlock,
                 "expected child of kind .codeBlock, " +
                 "got \(_body.kind)")
  }
#endif

  public var catchKeyword: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.catchKeyword))
  }

  public func withCatchKeyword(
    _ newTokenSyntax: TokenSyntax?) -> CatchClauseSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.catchKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.catchKeyword)
    return CatchClauseSyntax(root: root, data: newData)
  }

  public var pattern: PatternSyntax? {
    guard raw[Cursor.pattern].isPresent else { return nil }
    return PatternSyntax(root: _root,
      data: data.cachedChild(at: Cursor.pattern))
  }

  public func withPattern(
    _ newPatternSyntax: PatternSyntax?) -> CatchClauseSyntax {
    let raw = newPatternSyntax?.raw ?? RawSyntax.missing(.pattern)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.pattern)
    return CatchClauseSyntax(root: root, data: newData)
  }

  public var whereClause: WhereClauseSyntax? {
    guard raw[Cursor.whereClause].isPresent else { return nil }
    return WhereClauseSyntax(root: _root,
      data: data.cachedChild(at: Cursor.whereClause))
  }

  public func withWhereClause(
    _ newWhereClauseSyntax: WhereClauseSyntax?) -> CatchClauseSyntax {
    let raw = newWhereClauseSyntax?.raw ?? RawSyntax.missing(.whereClause)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.whereClause)
    return CatchClauseSyntax(root: root, data: newData)
  }

  public var body: CodeBlockSyntax {
    return CodeBlockSyntax(root: _root,
      data: data.cachedChild(at: Cursor.body))
  }

  public func withBody(
    _ newCodeBlockSyntax: CodeBlockSyntax?) -> CatchClauseSyntax {
    let raw = newCodeBlockSyntax?.raw ?? RawSyntax.missing(.codeBlock)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.body)
    return CatchClauseSyntax(root: root, data: newData)
  }
}
public class GenericWhereClauseSyntax: Syntax {
  enum Cursor: Int {
    case whereKeyword
    case requirementList
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 2)
    let _whereKeyword = raw[Cursor.whereToken]
    guard let _whereKeywordTokenKind = _whereKeyword.tokenKind else {
      fatalError("expected token child, got \(_whereKeyword.kind)")
    }
    precondition([.whereKeyword].contains(_whereKeywordTokenKind),
      "expected one of [.whereKeyword] for 'whereKeyword' " + 
      "in node of kind genericWhereClause")
    let _requirementList = raw[Cursor.genericRequirementList]
    precondition(_requirementList.kind == .genericRequirementList,
                 "expected child of kind .genericRequirementList, " +
                 "got \(_requirementList.kind)")
  }
#endif

  public var whereKeyword: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.whereKeyword))
  }

  public func withWhereKeyword(
    _ newTokenSyntax: TokenSyntax?) -> GenericWhereClauseSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.whereKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.whereKeyword)
    return GenericWhereClauseSyntax(root: root, data: newData)
  }

  public var requirementList: GenericRequirementListSyntax {
    return GenericRequirementListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.requirementList))
  }

  public func addGenericRequirement(_ elt: Syntax) -> GenericWhereClauseSyntax {
    let childRaw = raw[Cursor.requirementList].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.requirementList)
    return GenericWhereClauseSyntax(root: root, data: newData)
  }

  public func withRequirementList(
    _ newGenericRequirementListSyntax: GenericRequirementListSyntax?) -> GenericWhereClauseSyntax {
    let raw = newGenericRequirementListSyntax?.raw ?? RawSyntax.missing(.genericRequirementList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.requirementList)
    return GenericWhereClauseSyntax(root: root, data: newData)
  }
}
public typealias GenericRequirementListSyntax = SyntaxCollection<Syntax>
public class SameTypeRequirementSyntax: Syntax {
  enum Cursor: Int {
    case leftTypeIdentifier
    case equalityToken
    case rightTypeIdentifier
    case trailingComma
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 4)
    let _leftTypeIdentifier = raw[Cursor.type]
    precondition(_leftTypeIdentifier.kind == .type,
                 "expected child of kind .type, " +
                 "got \(_leftTypeIdentifier.kind)")
    let _equalityToken = raw[Cursor.token]
    guard let _equalityTokenTokenKind = _equalityToken.tokenKind else {
      fatalError("expected token child, got \(_equalityToken.kind)")
    }
    precondition([.spacedBinaryOperator, .unspacedBinaryOperator].contains(_equalityTokenTokenKind),
      "expected one of [.spacedBinaryOperator, .unspacedBinaryOperator] for 'equalityToken' " + 
      "in node of kind sameTypeRequirement")
    let _rightTypeIdentifier = raw[Cursor.type]
    precondition(_rightTypeIdentifier.kind == .type,
                 "expected child of kind .type, " +
                 "got \(_rightTypeIdentifier.kind)")
    let _trailingComma = raw[Cursor.commaToken]
    guard let _trailingCommaTokenKind = _trailingComma.tokenKind else {
      fatalError("expected token child, got \(_trailingComma.kind)")
    }
    precondition([.comma].contains(_trailingCommaTokenKind),
      "expected one of [.comma] for 'trailingComma' " + 
      "in node of kind sameTypeRequirement")
  }
#endif

  public var leftTypeIdentifier: TypeSyntax {
    return TypeSyntax(root: _root,
      data: data.cachedChild(at: Cursor.leftTypeIdentifier))
  }

  public func withLeftTypeIdentifier(
    _ newTypeSyntax: TypeSyntax?) -> SameTypeRequirementSyntax {
    let raw = newTypeSyntax?.raw ?? RawSyntax.missing(.type)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.leftTypeIdentifier)
    return SameTypeRequirementSyntax(root: root, data: newData)
  }

  public var equalityToken: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.equalityToken))
  }

  public func withEqualityToken(
    _ newTokenSyntax: TokenSyntax?) -> SameTypeRequirementSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.spacedBinaryOperator(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.equalityToken)
    return SameTypeRequirementSyntax(root: root, data: newData)
  }

  public var rightTypeIdentifier: TypeSyntax {
    return TypeSyntax(root: _root,
      data: data.cachedChild(at: Cursor.rightTypeIdentifier))
  }

  public func withRightTypeIdentifier(
    _ newTypeSyntax: TypeSyntax?) -> SameTypeRequirementSyntax {
    let raw = newTypeSyntax?.raw ?? RawSyntax.missing(.type)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.rightTypeIdentifier)
    return SameTypeRequirementSyntax(root: root, data: newData)
  }

  public var trailingComma: TokenSyntax? {
    guard raw[Cursor.trailingComma].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.trailingComma))
  }

  public func withTrailingComma(
    _ newTokenSyntax: TokenSyntax?) -> SameTypeRequirementSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.comma)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.trailingComma)
    return SameTypeRequirementSyntax(root: root, data: newData)
  }
}
public typealias GenericParameterListSyntax = SyntaxCollection<GenericParameterSyntax>
public class GenericParameterSyntax: Syntax {
  enum Cursor: Int {
    case name
    case colon
    case inheritedType
    case trailingComma
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 4)
    let _name = raw[Cursor.identifierToken]
    guard let _nameTokenKind = _name.tokenKind else {
      fatalError("expected token child, got \(_name.kind)")
    }
    precondition([.identifier].contains(_nameTokenKind),
      "expected one of [.identifier] for 'name' " + 
      "in node of kind genericParameter")
    let _colon = raw[Cursor.colonToken]
    guard let _colonTokenKind = _colon.tokenKind else {
      fatalError("expected token child, got \(_colon.kind)")
    }
    precondition([.colon].contains(_colonTokenKind),
      "expected one of [.colon] for 'colon' " + 
      "in node of kind genericParameter")
    let _inheritedType = raw[Cursor.type]
    precondition(_inheritedType.kind == .type,
                 "expected child of kind .type, " +
                 "got \(_inheritedType.kind)")
    let _trailingComma = raw[Cursor.commaToken]
    guard let _trailingCommaTokenKind = _trailingComma.tokenKind else {
      fatalError("expected token child, got \(_trailingComma.kind)")
    }
    precondition([.comma].contains(_trailingCommaTokenKind),
      "expected one of [.comma] for 'trailingComma' " + 
      "in node of kind genericParameter")
  }
#endif

  public var name: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.name))
  }

  public func withName(
    _ newTokenSyntax: TokenSyntax?) -> GenericParameterSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.identifier(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.name)
    return GenericParameterSyntax(root: root, data: newData)
  }

  public var colon: TokenSyntax? {
    guard raw[Cursor.colon].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.colon))
  }

  public func withColon(
    _ newTokenSyntax: TokenSyntax?) -> GenericParameterSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.colon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.colon)
    return GenericParameterSyntax(root: root, data: newData)
  }

  public var inheritedType: TypeSyntax? {
    guard raw[Cursor.inheritedType].isPresent else { return nil }
    return TypeSyntax(root: _root,
      data: data.cachedChild(at: Cursor.inheritedType))
  }

  public func withInheritedType(
    _ newTypeSyntax: TypeSyntax?) -> GenericParameterSyntax {
    let raw = newTypeSyntax?.raw ?? RawSyntax.missing(.type)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.inheritedType)
    return GenericParameterSyntax(root: root, data: newData)
  }

  public var trailingComma: TokenSyntax? {
    guard raw[Cursor.trailingComma].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.trailingComma))
  }

  public func withTrailingComma(
    _ newTokenSyntax: TokenSyntax?) -> GenericParameterSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.comma)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.trailingComma)
    return GenericParameterSyntax(root: root, data: newData)
  }
}
public class GenericParameterClauseSyntax: Syntax {
  enum Cursor: Int {
    case leftAngleBracket
    case genericParameterList
    case rightAngleBracket
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 3)
    let _leftAngleBracket = raw[Cursor.leftAngleToken]
    guard let _leftAngleBracketTokenKind = _leftAngleBracket.tokenKind else {
      fatalError("expected token child, got \(_leftAngleBracket.kind)")
    }
    precondition([.leftAngle].contains(_leftAngleBracketTokenKind),
      "expected one of [.leftAngle] for 'leftAngleBracket' " + 
      "in node of kind genericParameterClause")
    let _genericParameterList = raw[Cursor.genericParameterList]
    precondition(_genericParameterList.kind == .genericParameterList,
                 "expected child of kind .genericParameterList, " +
                 "got \(_genericParameterList.kind)")
    let _rightAngleBracket = raw[Cursor.rightAngleToken]
    guard let _rightAngleBracketTokenKind = _rightAngleBracket.tokenKind else {
      fatalError("expected token child, got \(_rightAngleBracket.kind)")
    }
    precondition([.rightAngle].contains(_rightAngleBracketTokenKind),
      "expected one of [.rightAngle] for 'rightAngleBracket' " + 
      "in node of kind genericParameterClause")
  }
#endif

  public var leftAngleBracket: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.leftAngleBracket))
  }

  public func withLeftAngleBracket(
    _ newTokenSyntax: TokenSyntax?) -> GenericParameterClauseSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.leftAngle)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.leftAngleBracket)
    return GenericParameterClauseSyntax(root: root, data: newData)
  }

  public var genericParameterList: GenericParameterListSyntax {
    return GenericParameterListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.genericParameterList))
  }

  public func addGenericParameter(_ elt: GenericParameterSyntax) -> GenericParameterClauseSyntax {
    let childRaw = raw[Cursor.genericParameterList].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.genericParameterList)
    return GenericParameterClauseSyntax(root: root, data: newData)
  }

  public func withGenericParameterList(
    _ newGenericParameterListSyntax: GenericParameterListSyntax?) -> GenericParameterClauseSyntax {
    let raw = newGenericParameterListSyntax?.raw ?? RawSyntax.missing(.genericParameterList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.genericParameterList)
    return GenericParameterClauseSyntax(root: root, data: newData)
  }

  public var rightAngleBracket: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.rightAngleBracket))
  }

  public func withRightAngleBracket(
    _ newTokenSyntax: TokenSyntax?) -> GenericParameterClauseSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.rightAngle)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.rightAngleBracket)
    return GenericParameterClauseSyntax(root: root, data: newData)
  }
}
public class ConformanceRequirementSyntax: Syntax {
  enum Cursor: Int {
    case leftTypeIdentifier
    case colon
    case rightTypeIdentifier
    case trailingComma
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 4)
    let _leftTypeIdentifier = raw[Cursor.type]
    precondition(_leftTypeIdentifier.kind == .type,
                 "expected child of kind .type, " +
                 "got \(_leftTypeIdentifier.kind)")
    let _colon = raw[Cursor.colonToken]
    guard let _colonTokenKind = _colon.tokenKind else {
      fatalError("expected token child, got \(_colon.kind)")
    }
    precondition([.colon].contains(_colonTokenKind),
      "expected one of [.colon] for 'colon' " + 
      "in node of kind conformanceRequirement")
    let _rightTypeIdentifier = raw[Cursor.type]
    precondition(_rightTypeIdentifier.kind == .type,
                 "expected child of kind .type, " +
                 "got \(_rightTypeIdentifier.kind)")
    let _trailingComma = raw[Cursor.commaToken]
    guard let _trailingCommaTokenKind = _trailingComma.tokenKind else {
      fatalError("expected token child, got \(_trailingComma.kind)")
    }
    precondition([.comma].contains(_trailingCommaTokenKind),
      "expected one of [.comma] for 'trailingComma' " + 
      "in node of kind conformanceRequirement")
  }
#endif

  public var leftTypeIdentifier: TypeSyntax {
    return TypeSyntax(root: _root,
      data: data.cachedChild(at: Cursor.leftTypeIdentifier))
  }

  public func withLeftTypeIdentifier(
    _ newTypeSyntax: TypeSyntax?) -> ConformanceRequirementSyntax {
    let raw = newTypeSyntax?.raw ?? RawSyntax.missing(.type)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.leftTypeIdentifier)
    return ConformanceRequirementSyntax(root: root, data: newData)
  }

  public var colon: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.colon))
  }

  public func withColon(
    _ newTokenSyntax: TokenSyntax?) -> ConformanceRequirementSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.colon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.colon)
    return ConformanceRequirementSyntax(root: root, data: newData)
  }

  public var rightTypeIdentifier: TypeSyntax {
    return TypeSyntax(root: _root,
      data: data.cachedChild(at: Cursor.rightTypeIdentifier))
  }

  public func withRightTypeIdentifier(
    _ newTypeSyntax: TypeSyntax?) -> ConformanceRequirementSyntax {
    let raw = newTypeSyntax?.raw ?? RawSyntax.missing(.type)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.rightTypeIdentifier)
    return ConformanceRequirementSyntax(root: root, data: newData)
  }

  public var trailingComma: TokenSyntax? {
    guard raw[Cursor.trailingComma].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.trailingComma))
  }

  public func withTrailingComma(
    _ newTokenSyntax: TokenSyntax?) -> ConformanceRequirementSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.comma)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.trailingComma)
    return ConformanceRequirementSyntax(root: root, data: newData)
  }
}
public class SimpleTypeIdentifierSyntax: TypeSyntax {
  enum Cursor: Int {
    case name
    case genericArgumentClause
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 2)
    let _name = raw[Cursor.token]
    guard let _nameTokenKind = _name.tokenKind else {
      fatalError("expected token child, got \(_name.kind)")
    }
    precondition([.identifier, .capitalSelfKeyword, .anyKeyword].contains(_nameTokenKind),
      "expected one of [.identifier, .capitalSelfKeyword, .anyKeyword] for 'name' " + 
      "in node of kind simpleTypeIdentifier")
    let _genericArgumentClause = raw[Cursor.genericArgumentClause]
    precondition(_genericArgumentClause.kind == .genericArgumentClause,
                 "expected child of kind .genericArgumentClause, " +
                 "got \(_genericArgumentClause.kind)")
  }
#endif

  public var name: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.name))
  }

  public func withName(
    _ newTokenSyntax: TokenSyntax?) -> SimpleTypeIdentifierSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.identifier(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.name)
    return SimpleTypeIdentifierSyntax(root: root, data: newData)
  }

  public var genericArgumentClause: GenericArgumentClauseSyntax? {
    guard raw[Cursor.genericArgumentClause].isPresent else { return nil }
    return GenericArgumentClauseSyntax(root: _root,
      data: data.cachedChild(at: Cursor.genericArgumentClause))
  }

  public func withGenericArgumentClause(
    _ newGenericArgumentClauseSyntax: GenericArgumentClauseSyntax?) -> SimpleTypeIdentifierSyntax {
    let raw = newGenericArgumentClauseSyntax?.raw ?? RawSyntax.missing(.genericArgumentClause)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.genericArgumentClause)
    return SimpleTypeIdentifierSyntax(root: root, data: newData)
  }
}
public class MemberTypeIdentifierSyntax: TypeSyntax {
  enum Cursor: Int {
    case baseType
    case period
    case name
    case genericArgumentClause
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 4)
    let _baseType = raw[Cursor.type]
    precondition(_baseType.kind == .type,
                 "expected child of kind .type, " +
                 "got \(_baseType.kind)")
    let _period = raw[Cursor.token]
    guard let _periodTokenKind = _period.tokenKind else {
      fatalError("expected token child, got \(_period.kind)")
    }
    precondition([.period, .prefixPeriod].contains(_periodTokenKind),
      "expected one of [.period, .prefixPeriod] for 'period' " + 
      "in node of kind memberTypeIdentifier")
    let _name = raw[Cursor.token]
    guard let _nameTokenKind = _name.tokenKind else {
      fatalError("expected token child, got \(_name.kind)")
    }
    precondition([.identifier, .capitalSelfKeyword, .anyKeyword].contains(_nameTokenKind),
      "expected one of [.identifier, .capitalSelfKeyword, .anyKeyword] for 'name' " + 
      "in node of kind memberTypeIdentifier")
    let _genericArgumentClause = raw[Cursor.genericArgumentClause]
    precondition(_genericArgumentClause.kind == .genericArgumentClause,
                 "expected child of kind .genericArgumentClause, " +
                 "got \(_genericArgumentClause.kind)")
  }
#endif

  public var baseType: TypeSyntax {
    return TypeSyntax(root: _root,
      data: data.cachedChild(at: Cursor.baseType))
  }

  public func withBaseType(
    _ newTypeSyntax: TypeSyntax?) -> MemberTypeIdentifierSyntax {
    let raw = newTypeSyntax?.raw ?? RawSyntax.missing(.type)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.baseType)
    return MemberTypeIdentifierSyntax(root: root, data: newData)
  }

  public var period: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.period))
  }

  public func withPeriod(
    _ newTokenSyntax: TokenSyntax?) -> MemberTypeIdentifierSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.period)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.period)
    return MemberTypeIdentifierSyntax(root: root, data: newData)
  }

  public var name: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.name))
  }

  public func withName(
    _ newTokenSyntax: TokenSyntax?) -> MemberTypeIdentifierSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.identifier(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.name)
    return MemberTypeIdentifierSyntax(root: root, data: newData)
  }

  public var genericArgumentClause: GenericArgumentClauseSyntax? {
    guard raw[Cursor.genericArgumentClause].isPresent else { return nil }
    return GenericArgumentClauseSyntax(root: _root,
      data: data.cachedChild(at: Cursor.genericArgumentClause))
  }

  public func withGenericArgumentClause(
    _ newGenericArgumentClauseSyntax: GenericArgumentClauseSyntax?) -> MemberTypeIdentifierSyntax {
    let raw = newGenericArgumentClauseSyntax?.raw ?? RawSyntax.missing(.genericArgumentClause)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.genericArgumentClause)
    return MemberTypeIdentifierSyntax(root: root, data: newData)
  }
}
public class ArrayTypeSyntax: TypeSyntax {
  enum Cursor: Int {
    case leftSquareBracket
    case elementType
    case rightSquareBracket
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 3)
    let _leftSquareBracket = raw[Cursor.leftSquareBracketToken]
    guard let _leftSquareBracketTokenKind = _leftSquareBracket.tokenKind else {
      fatalError("expected token child, got \(_leftSquareBracket.kind)")
    }
    precondition([.leftSquareBracket].contains(_leftSquareBracketTokenKind),
      "expected one of [.leftSquareBracket] for 'leftSquareBracket' " + 
      "in node of kind arrayType")
    let _elementType = raw[Cursor.type]
    precondition(_elementType.kind == .type,
                 "expected child of kind .type, " +
                 "got \(_elementType.kind)")
    let _rightSquareBracket = raw[Cursor.rightSquareBracketToken]
    guard let _rightSquareBracketTokenKind = _rightSquareBracket.tokenKind else {
      fatalError("expected token child, got \(_rightSquareBracket.kind)")
    }
    precondition([.rightSquareBracket].contains(_rightSquareBracketTokenKind),
      "expected one of [.rightSquareBracket] for 'rightSquareBracket' " + 
      "in node of kind arrayType")
  }
#endif

  public var leftSquareBracket: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.leftSquareBracket))
  }

  public func withLeftSquareBracket(
    _ newTokenSyntax: TokenSyntax?) -> ArrayTypeSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.leftSquareBracket)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.leftSquareBracket)
    return ArrayTypeSyntax(root: root, data: newData)
  }

  public var elementType: TypeSyntax {
    return TypeSyntax(root: _root,
      data: data.cachedChild(at: Cursor.elementType))
  }

  public func withElementType(
    _ newTypeSyntax: TypeSyntax?) -> ArrayTypeSyntax {
    let raw = newTypeSyntax?.raw ?? RawSyntax.missing(.type)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.elementType)
    return ArrayTypeSyntax(root: root, data: newData)
  }

  public var rightSquareBracket: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.rightSquareBracket))
  }

  public func withRightSquareBracket(
    _ newTokenSyntax: TokenSyntax?) -> ArrayTypeSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.rightSquareBracket)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.rightSquareBracket)
    return ArrayTypeSyntax(root: root, data: newData)
  }
}
public class DictionaryTypeSyntax: TypeSyntax {
  enum Cursor: Int {
    case leftSquareBracket
    case keyType
    case colon
    case valueType
    case rightSquareBracket
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 5)
    let _leftSquareBracket = raw[Cursor.leftSquareBracketToken]
    guard let _leftSquareBracketTokenKind = _leftSquareBracket.tokenKind else {
      fatalError("expected token child, got \(_leftSquareBracket.kind)")
    }
    precondition([.leftSquareBracket].contains(_leftSquareBracketTokenKind),
      "expected one of [.leftSquareBracket] for 'leftSquareBracket' " + 
      "in node of kind dictionaryType")
    let _keyType = raw[Cursor.type]
    precondition(_keyType.kind == .type,
                 "expected child of kind .type, " +
                 "got \(_keyType.kind)")
    let _colon = raw[Cursor.colonToken]
    guard let _colonTokenKind = _colon.tokenKind else {
      fatalError("expected token child, got \(_colon.kind)")
    }
    precondition([.colon].contains(_colonTokenKind),
      "expected one of [.colon] for 'colon' " + 
      "in node of kind dictionaryType")
    let _valueType = raw[Cursor.type]
    precondition(_valueType.kind == .type,
                 "expected child of kind .type, " +
                 "got \(_valueType.kind)")
    let _rightSquareBracket = raw[Cursor.rightSquareBracketToken]
    guard let _rightSquareBracketTokenKind = _rightSquareBracket.tokenKind else {
      fatalError("expected token child, got \(_rightSquareBracket.kind)")
    }
    precondition([.rightSquareBracket].contains(_rightSquareBracketTokenKind),
      "expected one of [.rightSquareBracket] for 'rightSquareBracket' " + 
      "in node of kind dictionaryType")
  }
#endif

  public var leftSquareBracket: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.leftSquareBracket))
  }

  public func withLeftSquareBracket(
    _ newTokenSyntax: TokenSyntax?) -> DictionaryTypeSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.leftSquareBracket)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.leftSquareBracket)
    return DictionaryTypeSyntax(root: root, data: newData)
  }

  public var keyType: TypeSyntax {
    return TypeSyntax(root: _root,
      data: data.cachedChild(at: Cursor.keyType))
  }

  public func withKeyType(
    _ newTypeSyntax: TypeSyntax?) -> DictionaryTypeSyntax {
    let raw = newTypeSyntax?.raw ?? RawSyntax.missing(.type)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.keyType)
    return DictionaryTypeSyntax(root: root, data: newData)
  }

  public var colon: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.colon))
  }

  public func withColon(
    _ newTokenSyntax: TokenSyntax?) -> DictionaryTypeSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.colon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.colon)
    return DictionaryTypeSyntax(root: root, data: newData)
  }

  public var valueType: TypeSyntax {
    return TypeSyntax(root: _root,
      data: data.cachedChild(at: Cursor.valueType))
  }

  public func withValueType(
    _ newTypeSyntax: TypeSyntax?) -> DictionaryTypeSyntax {
    let raw = newTypeSyntax?.raw ?? RawSyntax.missing(.type)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.valueType)
    return DictionaryTypeSyntax(root: root, data: newData)
  }

  public var rightSquareBracket: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.rightSquareBracket))
  }

  public func withRightSquareBracket(
    _ newTokenSyntax: TokenSyntax?) -> DictionaryTypeSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.rightSquareBracket)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.rightSquareBracket)
    return DictionaryTypeSyntax(root: root, data: newData)
  }
}
public class MetatypeTypeSyntax: TypeSyntax {
  enum Cursor: Int {
    case baseType
    case period
    case typeOrProtocol
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 3)
    let _baseType = raw[Cursor.type]
    precondition(_baseType.kind == .type,
                 "expected child of kind .type, " +
                 "got \(_baseType.kind)")
    let _period = raw[Cursor.periodToken]
    guard let _periodTokenKind = _period.tokenKind else {
      fatalError("expected token child, got \(_period.kind)")
    }
    precondition([.period].contains(_periodTokenKind),
      "expected one of [.period] for 'period' " + 
      "in node of kind metatypeType")
    let _typeOrProtocol = raw[Cursor.identifierToken]
    guard let _typeOrProtocolTokenKind = _typeOrProtocol.tokenKind else {
      fatalError("expected token child, got \(_typeOrProtocol.kind)")
    }
    precondition([.identifier].contains(_typeOrProtocolTokenKind),
      "expected one of [.identifier] for 'typeOrProtocol' " + 
      "in node of kind metatypeType")
  }
#endif

  public var baseType: TypeSyntax {
    return TypeSyntax(root: _root,
      data: data.cachedChild(at: Cursor.baseType))
  }

  public func withBaseType(
    _ newTypeSyntax: TypeSyntax?) -> MetatypeTypeSyntax {
    let raw = newTypeSyntax?.raw ?? RawSyntax.missing(.type)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.baseType)
    return MetatypeTypeSyntax(root: root, data: newData)
  }

  public var period: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.period))
  }

  public func withPeriod(
    _ newTokenSyntax: TokenSyntax?) -> MetatypeTypeSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.period)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.period)
    return MetatypeTypeSyntax(root: root, data: newData)
  }

  public var typeOrProtocol: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.typeOrProtocol))
  }

  public func withTypeOrProtocol(
    _ newTokenSyntax: TokenSyntax?) -> MetatypeTypeSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.identifier(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.typeOrProtocol)
    return MetatypeTypeSyntax(root: root, data: newData)
  }
}
public class OptionalTypeSyntax: TypeSyntax {
  enum Cursor: Int {
    case wrappedType
    case questionMark
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 2)
    let _wrappedType = raw[Cursor.type]
    precondition(_wrappedType.kind == .type,
                 "expected child of kind .type, " +
                 "got \(_wrappedType.kind)")
    let _questionMark = raw[Cursor.postfixQuestionMarkToken]
    guard let _questionMarkTokenKind = _questionMark.tokenKind else {
      fatalError("expected token child, got \(_questionMark.kind)")
    }
    precondition([.postfixQuestionMark].contains(_questionMarkTokenKind),
      "expected one of [.postfixQuestionMark] for 'questionMark' " + 
      "in node of kind optionalType")
  }
#endif

  public var wrappedType: TypeSyntax {
    return TypeSyntax(root: _root,
      data: data.cachedChild(at: Cursor.wrappedType))
  }

  public func withWrappedType(
    _ newTypeSyntax: TypeSyntax?) -> OptionalTypeSyntax {
    let raw = newTypeSyntax?.raw ?? RawSyntax.missing(.type)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.wrappedType)
    return OptionalTypeSyntax(root: root, data: newData)
  }

  public var questionMark: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.questionMark))
  }

  public func withQuestionMark(
    _ newTokenSyntax: TokenSyntax?) -> OptionalTypeSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.postfixQuestionMark)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.questionMark)
    return OptionalTypeSyntax(root: root, data: newData)
  }
}
public class ImplicitlyUnwrappedOptionalTypeSyntax: TypeSyntax {
  enum Cursor: Int {
    case wrappedType
    case exclamationMark
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 2)
    let _wrappedType = raw[Cursor.type]
    precondition(_wrappedType.kind == .type,
                 "expected child of kind .type, " +
                 "got \(_wrappedType.kind)")
    let _exclamationMark = raw[Cursor.exclamationMarkToken]
    guard let _exclamationMarkTokenKind = _exclamationMark.tokenKind else {
      fatalError("expected token child, got \(_exclamationMark.kind)")
    }
    precondition([.exclamationMark].contains(_exclamationMarkTokenKind),
      "expected one of [.exclamationMark] for 'exclamationMark' " + 
      "in node of kind implicitlyUnwrappedOptionalType")
  }
#endif

  public var wrappedType: TypeSyntax {
    return TypeSyntax(root: _root,
      data: data.cachedChild(at: Cursor.wrappedType))
  }

  public func withWrappedType(
    _ newTypeSyntax: TypeSyntax?) -> ImplicitlyUnwrappedOptionalTypeSyntax {
    let raw = newTypeSyntax?.raw ?? RawSyntax.missing(.type)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.wrappedType)
    return ImplicitlyUnwrappedOptionalTypeSyntax(root: root, data: newData)
  }

  public var exclamationMark: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.exclamationMark))
  }

  public func withExclamationMark(
    _ newTokenSyntax: TokenSyntax?) -> ImplicitlyUnwrappedOptionalTypeSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.exclamationMark)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.exclamationMark)
    return ImplicitlyUnwrappedOptionalTypeSyntax(root: root, data: newData)
  }
}
public class FunctionTypeSyntax: TypeSyntax {
  enum Cursor: Int {
    case typeAttributes
    case leftParen
    case argumentList
    case rightParen
    case throwsOrRethrowsKeyword
    case arrow
    case returnType
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 7)
    let _typeAttributes = raw[Cursor.attributeList]
    precondition(_typeAttributes.kind == .attributeList,
                 "expected child of kind .attributeList, " +
                 "got \(_typeAttributes.kind)")
    let _leftParen = raw[Cursor.leftParenToken]
    guard let _leftParenTokenKind = _leftParen.tokenKind else {
      fatalError("expected token child, got \(_leftParen.kind)")
    }
    precondition([.leftParen].contains(_leftParenTokenKind),
      "expected one of [.leftParen] for 'leftParen' " + 
      "in node of kind functionType")
    let _argumentList = raw[Cursor.functionTypeArgumentList]
    precondition(_argumentList.kind == .functionTypeArgumentList,
                 "expected child of kind .functionTypeArgumentList, " +
                 "got \(_argumentList.kind)")
    let _rightParen = raw[Cursor.rightParenToken]
    guard let _rightParenTokenKind = _rightParen.tokenKind else {
      fatalError("expected token child, got \(_rightParen.kind)")
    }
    precondition([.rightParen].contains(_rightParenTokenKind),
      "expected one of [.rightParen] for 'rightParen' " + 
      "in node of kind functionType")
    let _throwsOrRethrowsKeyword = raw[Cursor.token]
    guard let _throwsOrRethrowsKeywordTokenKind = _throwsOrRethrowsKeyword.tokenKind else {
      fatalError("expected token child, got \(_throwsOrRethrowsKeyword.kind)")
    }
    precondition([.throwsKeyword, .rethrowsKeyword].contains(_throwsOrRethrowsKeywordTokenKind),
      "expected one of [.throwsKeyword, .rethrowsKeyword] for 'throwsOrRethrowsKeyword' " + 
      "in node of kind functionType")
    let _arrow = raw[Cursor.arrowToken]
    guard let _arrowTokenKind = _arrow.tokenKind else {
      fatalError("expected token child, got \(_arrow.kind)")
    }
    precondition([.arrow].contains(_arrowTokenKind),
      "expected one of [.arrow] for 'arrow' " + 
      "in node of kind functionType")
    let _returnType = raw[Cursor.type]
    precondition(_returnType.kind == .type,
                 "expected child of kind .type, " +
                 "got \(_returnType.kind)")
  }
#endif

  public var typeAttributes: AttributeListSyntax {
    return AttributeListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.typeAttributes))
  }

  public func addAttribute(_ elt: AttributeSyntax) -> FunctionTypeSyntax {
    let childRaw = raw[Cursor.typeAttributes].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.typeAttributes)
    return FunctionTypeSyntax(root: root, data: newData)
  }

  public func withTypeAttributes(
    _ newAttributeListSyntax: AttributeListSyntax?) -> FunctionTypeSyntax {
    let raw = newAttributeListSyntax?.raw ?? RawSyntax.missing(.attributeList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.typeAttributes)
    return FunctionTypeSyntax(root: root, data: newData)
  }

  public var leftParen: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.leftParen))
  }

  public func withLeftParen(
    _ newTokenSyntax: TokenSyntax?) -> FunctionTypeSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.leftParen)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.leftParen)
    return FunctionTypeSyntax(root: root, data: newData)
  }

  public var argumentList: FunctionTypeArgumentListSyntax {
    return FunctionTypeArgumentListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.argumentList))
  }

  public func addFunctionTypeArgument(_ elt: FunctionTypeArgumentSyntax) -> FunctionTypeSyntax {
    let childRaw = raw[Cursor.argumentList].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.argumentList)
    return FunctionTypeSyntax(root: root, data: newData)
  }

  public func withArgumentList(
    _ newFunctionTypeArgumentListSyntax: FunctionTypeArgumentListSyntax?) -> FunctionTypeSyntax {
    let raw = newFunctionTypeArgumentListSyntax?.raw ?? RawSyntax.missing(.functionTypeArgumentList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.argumentList)
    return FunctionTypeSyntax(root: root, data: newData)
  }

  public var rightParen: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.rightParen))
  }

  public func withRightParen(
    _ newTokenSyntax: TokenSyntax?) -> FunctionTypeSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.rightParen)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.rightParen)
    return FunctionTypeSyntax(root: root, data: newData)
  }

  public var throwsOrRethrowsKeyword: TokenSyntax? {
    guard raw[Cursor.throwsOrRethrowsKeyword].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.throwsOrRethrowsKeyword))
  }

  public func withThrowsOrRethrowsKeyword(
    _ newTokenSyntax: TokenSyntax?) -> FunctionTypeSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.throwsKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.throwsOrRethrowsKeyword)
    return FunctionTypeSyntax(root: root, data: newData)
  }

  public var arrow: TokenSyntax? {
    guard raw[Cursor.arrow].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.arrow))
  }

  public func withArrow(
    _ newTokenSyntax: TokenSyntax?) -> FunctionTypeSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.arrow)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.arrow)
    return FunctionTypeSyntax(root: root, data: newData)
  }

  public var returnType: TypeSyntax? {
    guard raw[Cursor.returnType].isPresent else { return nil }
    return TypeSyntax(root: _root,
      data: data.cachedChild(at: Cursor.returnType))
  }

  public func withReturnType(
    _ newTypeSyntax: TypeSyntax?) -> FunctionTypeSyntax {
    let raw = newTypeSyntax?.raw ?? RawSyntax.missing(.type)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.returnType)
    return FunctionTypeSyntax(root: root, data: newData)
  }
}
public class TupleTypeSyntax: TypeSyntax {
  enum Cursor: Int {
    case leftParen
    case elements
    case rightParen
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 3)
    let _leftParen = raw[Cursor.leftParenToken]
    guard let _leftParenTokenKind = _leftParen.tokenKind else {
      fatalError("expected token child, got \(_leftParen.kind)")
    }
    precondition([.leftParen].contains(_leftParenTokenKind),
      "expected one of [.leftParen] for 'leftParen' " + 
      "in node of kind tupleType")
    let _elements = raw[Cursor.tupleTypeElementList]
    precondition(_elements.kind == .tupleTypeElementList,
                 "expected child of kind .tupleTypeElementList, " +
                 "got \(_elements.kind)")
    let _rightParen = raw[Cursor.rightParenToken]
    guard let _rightParenTokenKind = _rightParen.tokenKind else {
      fatalError("expected token child, got \(_rightParen.kind)")
    }
    precondition([.rightParen].contains(_rightParenTokenKind),
      "expected one of [.rightParen] for 'rightParen' " + 
      "in node of kind tupleType")
  }
#endif

  public var leftParen: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.leftParen))
  }

  public func withLeftParen(
    _ newTokenSyntax: TokenSyntax?) -> TupleTypeSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.leftParen)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.leftParen)
    return TupleTypeSyntax(root: root, data: newData)
  }

  public var elements: TupleTypeElementListSyntax {
    return TupleTypeElementListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.elements))
  }

  public func addTupleTypeElement(_ elt: TupleTypeElementSyntax) -> TupleTypeSyntax {
    let childRaw = raw[Cursor.elements].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.elements)
    return TupleTypeSyntax(root: root, data: newData)
  }

  public func withElements(
    _ newTupleTypeElementListSyntax: TupleTypeElementListSyntax?) -> TupleTypeSyntax {
    let raw = newTupleTypeElementListSyntax?.raw ?? RawSyntax.missing(.tupleTypeElementList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.elements)
    return TupleTypeSyntax(root: root, data: newData)
  }

  public var rightParen: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.rightParen))
  }

  public func withRightParen(
    _ newTokenSyntax: TokenSyntax?) -> TupleTypeSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.rightParen)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.rightParen)
    return TupleTypeSyntax(root: root, data: newData)
  }
}
public class TupleTypeElementSyntax: Syntax {
  enum Cursor: Int {
    case label
    case colon
    case typeAnnotation
    case comma
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 4)
    let _label = raw[Cursor.identifierToken]
    guard let _labelTokenKind = _label.tokenKind else {
      fatalError("expected token child, got \(_label.kind)")
    }
    precondition([.identifier].contains(_labelTokenKind),
      "expected one of [.identifier] for 'label' " + 
      "in node of kind tupleTypeElement")
    let _colon = raw[Cursor.colonToken]
    guard let _colonTokenKind = _colon.tokenKind else {
      fatalError("expected token child, got \(_colon.kind)")
    }
    precondition([.colon].contains(_colonTokenKind),
      "expected one of [.colon] for 'colon' " + 
      "in node of kind tupleTypeElement")
    let _typeAnnotation = raw[Cursor.typeAnnotation]
    precondition(_typeAnnotation.kind == .typeAnnotation,
                 "expected child of kind .typeAnnotation, " +
                 "got \(_typeAnnotation.kind)")
    let _comma = raw[Cursor.commaToken]
    guard let _commaTokenKind = _comma.tokenKind else {
      fatalError("expected token child, got \(_comma.kind)")
    }
    precondition([.comma].contains(_commaTokenKind),
      "expected one of [.comma] for 'comma' " + 
      "in node of kind tupleTypeElement")
  }
#endif

  public var label: TokenSyntax? {
    guard raw[Cursor.label].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.label))
  }

  public func withLabel(
    _ newTokenSyntax: TokenSyntax?) -> TupleTypeElementSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.identifier(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.label)
    return TupleTypeElementSyntax(root: root, data: newData)
  }

  public var colon: TokenSyntax? {
    guard raw[Cursor.colon].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.colon))
  }

  public func withColon(
    _ newTokenSyntax: TokenSyntax?) -> TupleTypeElementSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.colon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.colon)
    return TupleTypeElementSyntax(root: root, data: newData)
  }

  public var typeAnnotation: TypeAnnotationSyntax {
    return TypeAnnotationSyntax(root: _root,
      data: data.cachedChild(at: Cursor.typeAnnotation))
  }

  public func withTypeAnnotation(
    _ newTypeAnnotationSyntax: TypeAnnotationSyntax?) -> TupleTypeElementSyntax {
    let raw = newTypeAnnotationSyntax?.raw ?? RawSyntax.missing(.typeAnnotation)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.typeAnnotation)
    return TupleTypeElementSyntax(root: root, data: newData)
  }

  public var comma: TokenSyntax? {
    guard raw[Cursor.comma].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.comma))
  }

  public func withComma(
    _ newTokenSyntax: TokenSyntax?) -> TupleTypeElementSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.comma)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.comma)
    return TupleTypeElementSyntax(root: root, data: newData)
  }
}
public class TypeAnnotationSyntax: Syntax {
  enum Cursor: Int {
    case attributes
    case inOutKeyword
    case type
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 3)
    let _attributes = raw[Cursor.attributeList]
    precondition(_attributes.kind == .attributeList,
                 "expected child of kind .attributeList, " +
                 "got \(_attributes.kind)")
    let _inOutKeyword = raw[Cursor.inoutToken]
    guard let _inOutKeywordTokenKind = _inOutKeyword.tokenKind else {
      fatalError("expected token child, got \(_inOutKeyword.kind)")
    }
    precondition([.inoutKeyword].contains(_inOutKeywordTokenKind),
      "expected one of [.inoutKeyword] for 'inOutKeyword' " + 
      "in node of kind typeAnnotation")
    let _type = raw[Cursor.type]
    precondition(_type.kind == .type,
                 "expected child of kind .type, " +
                 "got \(_type.kind)")
  }
#endif

  public var attributes: AttributeListSyntax {
    return AttributeListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.attributes))
  }

  public func addAttribute(_ elt: AttributeSyntax) -> TypeAnnotationSyntax {
    let childRaw = raw[Cursor.attributes].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.attributes)
    return TypeAnnotationSyntax(root: root, data: newData)
  }

  public func withAttributes(
    _ newAttributeListSyntax: AttributeListSyntax?) -> TypeAnnotationSyntax {
    let raw = newAttributeListSyntax?.raw ?? RawSyntax.missing(.attributeList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.attributes)
    return TypeAnnotationSyntax(root: root, data: newData)
  }

  public var inOutKeyword: TokenSyntax? {
    guard raw[Cursor.inOutKeyword].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.inOutKeyword))
  }

  public func withInOutKeyword(
    _ newTokenSyntax: TokenSyntax?) -> TypeAnnotationSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.inoutKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.inOutKeyword)
    return TypeAnnotationSyntax(root: root, data: newData)
  }

  public var type: TypeSyntax {
    return TypeSyntax(root: _root,
      data: data.cachedChild(at: Cursor.type))
  }

  public func withType(
    _ newTypeSyntax: TypeSyntax?) -> TypeAnnotationSyntax {
    let raw = newTypeSyntax?.raw ?? RawSyntax.missing(.type)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.type)
    return TypeAnnotationSyntax(root: root, data: newData)
  }
}
public typealias ProtocolCompositionElementListSyntax = SyntaxCollection<ProtocolCompositionElementSyntax>
public typealias TupleTypeElementListSyntax = SyntaxCollection<TupleTypeElementSyntax>
public class ProtocolCompositionElementSyntax: Syntax {
  enum Cursor: Int {
    case protocolType
    case ampersand
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 2)
    let _protocolType = raw[Cursor.type]
    precondition(_protocolType.kind == .type,
                 "expected child of kind .type, " +
                 "got \(_protocolType.kind)")
    let _ampersand = raw[Cursor.ampersandToken]
    guard let _ampersandTokenKind = _ampersand.tokenKind else {
      fatalError("expected token child, got \(_ampersand.kind)")
    }
    precondition([.ampersand].contains(_ampersandTokenKind),
      "expected one of [.ampersand] for 'ampersand' " + 
      "in node of kind protocolCompositionElement")
  }
#endif

  public var protocolType: TypeSyntax {
    return TypeSyntax(root: _root,
      data: data.cachedChild(at: Cursor.protocolType))
  }

  public func withProtocolType(
    _ newTypeSyntax: TypeSyntax?) -> ProtocolCompositionElementSyntax {
    let raw = newTypeSyntax?.raw ?? RawSyntax.missing(.type)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.protocolType)
    return ProtocolCompositionElementSyntax(root: root, data: newData)
  }

  public var ampersand: TokenSyntax? {
    guard raw[Cursor.ampersand].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.ampersand))
  }

  public func withAmpersand(
    _ newTokenSyntax: TokenSyntax?) -> ProtocolCompositionElementSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.ampersand)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.ampersand)
    return ProtocolCompositionElementSyntax(root: root, data: newData)
  }
}
public typealias GenericArgumentListSyntax = SyntaxCollection<GenericArgumentSyntax>
public class GenericArgumentSyntax: Syntax {
  enum Cursor: Int {
    case argumentType
    case trailingComma
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 2)
    let _argumentType = raw[Cursor.type]
    precondition(_argumentType.kind == .type,
                 "expected child of kind .type, " +
                 "got \(_argumentType.kind)")
    let _trailingComma = raw[Cursor.commaToken]
    guard let _trailingCommaTokenKind = _trailingComma.tokenKind else {
      fatalError("expected token child, got \(_trailingComma.kind)")
    }
    precondition([.comma].contains(_trailingCommaTokenKind),
      "expected one of [.comma] for 'trailingComma' " + 
      "in node of kind genericArgument")
  }
#endif

  public var argumentType: TypeSyntax {
    return TypeSyntax(root: _root,
      data: data.cachedChild(at: Cursor.argumentType))
  }

  public func withArgumentType(
    _ newTypeSyntax: TypeSyntax?) -> GenericArgumentSyntax {
    let raw = newTypeSyntax?.raw ?? RawSyntax.missing(.type)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.argumentType)
    return GenericArgumentSyntax(root: root, data: newData)
  }

  public var trailingComma: TokenSyntax? {
    guard raw[Cursor.trailingComma].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.trailingComma))
  }

  public func withTrailingComma(
    _ newTokenSyntax: TokenSyntax?) -> GenericArgumentSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.comma)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.trailingComma)
    return GenericArgumentSyntax(root: root, data: newData)
  }
}
public class GenericArgumentClauseSyntax: Syntax {
  enum Cursor: Int {
    case leftAngleBracket
    case arguments
    case rightAngleBracket
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 3)
    let _leftAngleBracket = raw[Cursor.leftAngleToken]
    guard let _leftAngleBracketTokenKind = _leftAngleBracket.tokenKind else {
      fatalError("expected token child, got \(_leftAngleBracket.kind)")
    }
    precondition([.leftAngle].contains(_leftAngleBracketTokenKind),
      "expected one of [.leftAngle] for 'leftAngleBracket' " + 
      "in node of kind genericArgumentClause")
    let _arguments = raw[Cursor.genericArgumentList]
    precondition(_arguments.kind == .genericArgumentList,
                 "expected child of kind .genericArgumentList, " +
                 "got \(_arguments.kind)")
    let _rightAngleBracket = raw[Cursor.rightAngleToken]
    guard let _rightAngleBracketTokenKind = _rightAngleBracket.tokenKind else {
      fatalError("expected token child, got \(_rightAngleBracket.kind)")
    }
    precondition([.rightAngle].contains(_rightAngleBracketTokenKind),
      "expected one of [.rightAngle] for 'rightAngleBracket' " + 
      "in node of kind genericArgumentClause")
  }
#endif

  public var leftAngleBracket: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.leftAngleBracket))
  }

  public func withLeftAngleBracket(
    _ newTokenSyntax: TokenSyntax?) -> GenericArgumentClauseSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.leftAngle)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.leftAngleBracket)
    return GenericArgumentClauseSyntax(root: root, data: newData)
  }

  public var arguments: GenericArgumentListSyntax {
    return GenericArgumentListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.arguments))
  }

  public func addGenericArgument(_ elt: GenericArgumentSyntax) -> GenericArgumentClauseSyntax {
    let childRaw = raw[Cursor.arguments].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.arguments)
    return GenericArgumentClauseSyntax(root: root, data: newData)
  }

  public func withArguments(
    _ newGenericArgumentListSyntax: GenericArgumentListSyntax?) -> GenericArgumentClauseSyntax {
    let raw = newGenericArgumentListSyntax?.raw ?? RawSyntax.missing(.genericArgumentList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.arguments)
    return GenericArgumentClauseSyntax(root: root, data: newData)
  }

  public var rightAngleBracket: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.rightAngleBracket))
  }

  public func withRightAngleBracket(
    _ newTokenSyntax: TokenSyntax?) -> GenericArgumentClauseSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.rightAngle)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.rightAngleBracket)
    return GenericArgumentClauseSyntax(root: root, data: newData)
  }
}
public class FunctionTypeArgumentSyntax: Syntax {
  enum Cursor: Int {
    case externalName
    case localName
    case colon
    case typeAnnotation
    case trailingComma
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 5)
    let _externalName = raw[Cursor.identifierToken]
    guard let _externalNameTokenKind = _externalName.tokenKind else {
      fatalError("expected token child, got \(_externalName.kind)")
    }
    precondition([.identifier].contains(_externalNameTokenKind),
      "expected one of [.identifier] for 'externalName' " + 
      "in node of kind functionTypeArgument")
    let _localName = raw[Cursor.identifierToken]
    guard let _localNameTokenKind = _localName.tokenKind else {
      fatalError("expected token child, got \(_localName.kind)")
    }
    precondition([.identifier].contains(_localNameTokenKind),
      "expected one of [.identifier] for 'localName' " + 
      "in node of kind functionTypeArgument")
    let _colon = raw[Cursor.colonToken]
    guard let _colonTokenKind = _colon.tokenKind else {
      fatalError("expected token child, got \(_colon.kind)")
    }
    precondition([.colon].contains(_colonTokenKind),
      "expected one of [.colon] for 'colon' " + 
      "in node of kind functionTypeArgument")
    let _typeAnnotation = raw[Cursor.typeAnnotation]
    precondition(_typeAnnotation.kind == .typeAnnotation,
                 "expected child of kind .typeAnnotation, " +
                 "got \(_typeAnnotation.kind)")
    let _trailingComma = raw[Cursor.commaToken]
    guard let _trailingCommaTokenKind = _trailingComma.tokenKind else {
      fatalError("expected token child, got \(_trailingComma.kind)")
    }
    precondition([.comma].contains(_trailingCommaTokenKind),
      "expected one of [.comma] for 'trailingComma' " + 
      "in node of kind functionTypeArgument")
  }
#endif

  public var externalName: TokenSyntax? {
    guard raw[Cursor.externalName].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.externalName))
  }

  public func withExternalName(
    _ newTokenSyntax: TokenSyntax?) -> FunctionTypeArgumentSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.identifier(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.externalName)
    return FunctionTypeArgumentSyntax(root: root, data: newData)
  }

  public var localName: TokenSyntax? {
    guard raw[Cursor.localName].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.localName))
  }

  public func withLocalName(
    _ newTokenSyntax: TokenSyntax?) -> FunctionTypeArgumentSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.identifier(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.localName)
    return FunctionTypeArgumentSyntax(root: root, data: newData)
  }

  public var colon: TokenSyntax? {
    guard raw[Cursor.colon].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.colon))
  }

  public func withColon(
    _ newTokenSyntax: TokenSyntax?) -> FunctionTypeArgumentSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.colon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.colon)
    return FunctionTypeArgumentSyntax(root: root, data: newData)
  }

  public var typeAnnotation: TypeAnnotationSyntax {
    return TypeAnnotationSyntax(root: _root,
      data: data.cachedChild(at: Cursor.typeAnnotation))
  }

  public func withTypeAnnotation(
    _ newTypeAnnotationSyntax: TypeAnnotationSyntax?) -> FunctionTypeArgumentSyntax {
    let raw = newTypeAnnotationSyntax?.raw ?? RawSyntax.missing(.typeAnnotation)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.typeAnnotation)
    return FunctionTypeArgumentSyntax(root: root, data: newData)
  }

  public var trailingComma: TokenSyntax? {
    guard raw[Cursor.trailingComma].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.trailingComma))
  }

  public func withTrailingComma(
    _ newTokenSyntax: TokenSyntax?) -> FunctionTypeArgumentSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.comma)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.trailingComma)
    return FunctionTypeArgumentSyntax(root: root, data: newData)
  }
}
public typealias FunctionTypeArgumentListSyntax = SyntaxCollection<FunctionTypeArgumentSyntax>
public class ProtocolCompositionTypeSyntax: TypeSyntax {
  enum Cursor: Int {
    case elements
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 1)
    let _elements = raw[Cursor.protocolCompositionElementList]
    precondition(_elements.kind == .protocolCompositionElementList,
                 "expected child of kind .protocolCompositionElementList, " +
                 "got \(_elements.kind)")
  }
#endif

  public var elements: ProtocolCompositionElementListSyntax {
    return ProtocolCompositionElementListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.elements))
  }

  public func addProtocolCompositionElement(_ elt: ProtocolCompositionElementSyntax) -> ProtocolCompositionTypeSyntax {
    let childRaw = raw[Cursor.elements].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.elements)
    return ProtocolCompositionTypeSyntax(root: root, data: newData)
  }

  public func withElements(
    _ newProtocolCompositionElementListSyntax: ProtocolCompositionElementListSyntax?) -> ProtocolCompositionTypeSyntax {
    let raw = newProtocolCompositionElementListSyntax?.raw ?? RawSyntax.missing(.protocolCompositionElementList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.elements)
    return ProtocolCompositionTypeSyntax(root: root, data: newData)
  }
}
public class EnumCasePatternSyntax: PatternSyntax {
  enum Cursor: Int {
    case type
    case period
    case caseName
    case associatedTuple
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 4)
    let _type = raw[Cursor.type]
    precondition(_type.kind == .type,
                 "expected child of kind .type, " +
                 "got \(_type.kind)")
    let _period = raw[Cursor.periodToken]
    guard let _periodTokenKind = _period.tokenKind else {
      fatalError("expected token child, got \(_period.kind)")
    }
    precondition([.period].contains(_periodTokenKind),
      "expected one of [.period] for 'period' " + 
      "in node of kind enumCasePattern")
    let _caseName = raw[Cursor.identifierToken]
    guard let _caseNameTokenKind = _caseName.tokenKind else {
      fatalError("expected token child, got \(_caseName.kind)")
    }
    precondition([.identifier].contains(_caseNameTokenKind),
      "expected one of [.identifier] for 'caseName' " + 
      "in node of kind enumCasePattern")
    let _associatedTuple = raw[Cursor.tuplePattern]
    precondition(_associatedTuple.kind == .tuplePattern,
                 "expected child of kind .tuplePattern, " +
                 "got \(_associatedTuple.kind)")
  }
#endif

  public var type: TypeSyntax? {
    guard raw[Cursor.type].isPresent else { return nil }
    return TypeSyntax(root: _root,
      data: data.cachedChild(at: Cursor.type))
  }

  public func withType(
    _ newTypeSyntax: TypeSyntax?) -> EnumCasePatternSyntax {
    let raw = newTypeSyntax?.raw ?? RawSyntax.missing(.type)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.type)
    return EnumCasePatternSyntax(root: root, data: newData)
  }

  public var period: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.period))
  }

  public func withPeriod(
    _ newTokenSyntax: TokenSyntax?) -> EnumCasePatternSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.period)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.period)
    return EnumCasePatternSyntax(root: root, data: newData)
  }

  public var caseName: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.caseName))
  }

  public func withCaseName(
    _ newTokenSyntax: TokenSyntax?) -> EnumCasePatternSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.identifier(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.caseName)
    return EnumCasePatternSyntax(root: root, data: newData)
  }

  public var associatedTuple: TuplePatternSyntax? {
    guard raw[Cursor.associatedTuple].isPresent else { return nil }
    return TuplePatternSyntax(root: _root,
      data: data.cachedChild(at: Cursor.associatedTuple))
  }

  public func withAssociatedTuple(
    _ newTuplePatternSyntax: TuplePatternSyntax?) -> EnumCasePatternSyntax {
    let raw = newTuplePatternSyntax?.raw ?? RawSyntax.missing(.tuplePattern)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.associatedTuple)
    return EnumCasePatternSyntax(root: root, data: newData)
  }
}
public class IsTypePatternSyntax: PatternSyntax {
  enum Cursor: Int {
    case isKeyword
    case type
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 2)
    let _isKeyword = raw[Cursor.isToken]
    guard let _isKeywordTokenKind = _isKeyword.tokenKind else {
      fatalError("expected token child, got \(_isKeyword.kind)")
    }
    precondition([.isKeyword].contains(_isKeywordTokenKind),
      "expected one of [.isKeyword] for 'isKeyword' " + 
      "in node of kind isTypePattern")
    let _type = raw[Cursor.type]
    precondition(_type.kind == .type,
                 "expected child of kind .type, " +
                 "got \(_type.kind)")
  }
#endif

  public var isKeyword: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.isKeyword))
  }

  public func withIsKeyword(
    _ newTokenSyntax: TokenSyntax?) -> IsTypePatternSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.isKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.isKeyword)
    return IsTypePatternSyntax(root: root, data: newData)
  }

  public var type: TypeSyntax {
    return TypeSyntax(root: _root,
      data: data.cachedChild(at: Cursor.type))
  }

  public func withType(
    _ newTypeSyntax: TypeSyntax?) -> IsTypePatternSyntax {
    let raw = newTypeSyntax?.raw ?? RawSyntax.missing(.type)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.type)
    return IsTypePatternSyntax(root: root, data: newData)
  }
}
public class OptionalPatternSyntax: PatternSyntax {
  enum Cursor: Int {
    case identifier
    case questionMark
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 2)
    let _identifier = raw[Cursor.identifierToken]
    guard let _identifierTokenKind = _identifier.tokenKind else {
      fatalError("expected token child, got \(_identifier.kind)")
    }
    precondition([.identifier].contains(_identifierTokenKind),
      "expected one of [.identifier] for 'identifier' " + 
      "in node of kind optionalPattern")
    let _questionMark = raw[Cursor.postfixQuestionMarkToken]
    guard let _questionMarkTokenKind = _questionMark.tokenKind else {
      fatalError("expected token child, got \(_questionMark.kind)")
    }
    precondition([.postfixQuestionMark].contains(_questionMarkTokenKind),
      "expected one of [.postfixQuestionMark] for 'questionMark' " + 
      "in node of kind optionalPattern")
  }
#endif

  public var identifier: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.identifier))
  }

  public func withIdentifier(
    _ newTokenSyntax: TokenSyntax?) -> OptionalPatternSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.identifier(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.identifier)
    return OptionalPatternSyntax(root: root, data: newData)
  }

  public var questionMark: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.questionMark))
  }

  public func withQuestionMark(
    _ newTokenSyntax: TokenSyntax?) -> OptionalPatternSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.postfixQuestionMark)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.questionMark)
    return OptionalPatternSyntax(root: root, data: newData)
  }
}
public class IdentifierPatternSyntax: PatternSyntax {
  enum Cursor: Int {
    case identifier
    case typeAnnotation
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 2)
    let _identifier = raw[Cursor.identifierToken]
    guard let _identifierTokenKind = _identifier.tokenKind else {
      fatalError("expected token child, got \(_identifier.kind)")
    }
    precondition([.identifier].contains(_identifierTokenKind),
      "expected one of [.identifier] for 'identifier' " + 
      "in node of kind identifierPattern")
    let _typeAnnotation = raw[Cursor.typeAnnotation]
    precondition(_typeAnnotation.kind == .typeAnnotation,
                 "expected child of kind .typeAnnotation, " +
                 "got \(_typeAnnotation.kind)")
  }
#endif

  public var identifier: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.identifier))
  }

  public func withIdentifier(
    _ newTokenSyntax: TokenSyntax?) -> IdentifierPatternSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.identifier(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.identifier)
    return IdentifierPatternSyntax(root: root, data: newData)
  }

  public var typeAnnotation: TypeAnnotationSyntax? {
    guard raw[Cursor.typeAnnotation].isPresent else { return nil }
    return TypeAnnotationSyntax(root: _root,
      data: data.cachedChild(at: Cursor.typeAnnotation))
  }

  public func withTypeAnnotation(
    _ newTypeAnnotationSyntax: TypeAnnotationSyntax?) -> IdentifierPatternSyntax {
    let raw = newTypeAnnotationSyntax?.raw ?? RawSyntax.missing(.typeAnnotation)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.typeAnnotation)
    return IdentifierPatternSyntax(root: root, data: newData)
  }
}
public class AsTypePatternSyntax: PatternSyntax {
  enum Cursor: Int {
    case pattern
    case asKeyword
    case type
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 3)
    let _pattern = raw[Cursor.pattern]
    precondition(_pattern.kind == .pattern,
                 "expected child of kind .pattern, " +
                 "got \(_pattern.kind)")
    let _asKeyword = raw[Cursor.asToken]
    guard let _asKeywordTokenKind = _asKeyword.tokenKind else {
      fatalError("expected token child, got \(_asKeyword.kind)")
    }
    precondition([.asKeyword].contains(_asKeywordTokenKind),
      "expected one of [.asKeyword] for 'asKeyword' " + 
      "in node of kind asTypePattern")
    let _type = raw[Cursor.type]
    precondition(_type.kind == .type,
                 "expected child of kind .type, " +
                 "got \(_type.kind)")
  }
#endif

  public var pattern: PatternSyntax {
    return PatternSyntax(root: _root,
      data: data.cachedChild(at: Cursor.pattern))
  }

  public func withPattern(
    _ newPatternSyntax: PatternSyntax?) -> AsTypePatternSyntax {
    let raw = newPatternSyntax?.raw ?? RawSyntax.missing(.pattern)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.pattern)
    return AsTypePatternSyntax(root: root, data: newData)
  }

  public var asKeyword: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.asKeyword))
  }

  public func withAsKeyword(
    _ newTokenSyntax: TokenSyntax?) -> AsTypePatternSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.asKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.asKeyword)
    return AsTypePatternSyntax(root: root, data: newData)
  }

  public var type: TypeSyntax {
    return TypeSyntax(root: _root,
      data: data.cachedChild(at: Cursor.type))
  }

  public func withType(
    _ newTypeSyntax: TypeSyntax?) -> AsTypePatternSyntax {
    let raw = newTypeSyntax?.raw ?? RawSyntax.missing(.type)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.type)
    return AsTypePatternSyntax(root: root, data: newData)
  }
}
public class TuplePatternSyntax: PatternSyntax {
  enum Cursor: Int {
    case openParen
    case elements
    case closeParen
    case typeAnnotation
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 4)
    let _openParen = raw[Cursor.leftParenToken]
    guard let _openParenTokenKind = _openParen.tokenKind else {
      fatalError("expected token child, got \(_openParen.kind)")
    }
    precondition([.leftParen].contains(_openParenTokenKind),
      "expected one of [.leftParen] for 'openParen' " + 
      "in node of kind tuplePattern")
    let _elements = raw[Cursor.tuplePatternElementList]
    precondition(_elements.kind == .tuplePatternElementList,
                 "expected child of kind .tuplePatternElementList, " +
                 "got \(_elements.kind)")
    let _closeParen = raw[Cursor.rightParenToken]
    guard let _closeParenTokenKind = _closeParen.tokenKind else {
      fatalError("expected token child, got \(_closeParen.kind)")
    }
    precondition([.rightParen].contains(_closeParenTokenKind),
      "expected one of [.rightParen] for 'closeParen' " + 
      "in node of kind tuplePattern")
    let _typeAnnotation = raw[Cursor.typeAnnotation]
    precondition(_typeAnnotation.kind == .typeAnnotation,
                 "expected child of kind .typeAnnotation, " +
                 "got \(_typeAnnotation.kind)")
  }
#endif

  public var openParen: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.openParen))
  }

  public func withOpenParen(
    _ newTokenSyntax: TokenSyntax?) -> TuplePatternSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.leftParen)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.openParen)
    return TuplePatternSyntax(root: root, data: newData)
  }

  public var elements: TuplePatternElementListSyntax {
    return TuplePatternElementListSyntax(root: _root,
      data: data.cachedChild(at: Cursor.elements))
  }

  public func addTuplePatternElement(_ elt: TuplePatternElementSyntax) -> TuplePatternSyntax {
    let childRaw = raw[Cursor.elements].appending(elt.raw)
    let (root, newData) = data.replacingChild(childRaw,
                                              at: Cursor.elements)
    return TuplePatternSyntax(root: root, data: newData)
  }

  public func withElements(
    _ newTuplePatternElementListSyntax: TuplePatternElementListSyntax?) -> TuplePatternSyntax {
    let raw = newTuplePatternElementListSyntax?.raw ?? RawSyntax.missing(.tuplePatternElementList)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.elements)
    return TuplePatternSyntax(root: root, data: newData)
  }

  public var closeParen: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.closeParen))
  }

  public func withCloseParen(
    _ newTokenSyntax: TokenSyntax?) -> TuplePatternSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.rightParen)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.closeParen)
    return TuplePatternSyntax(root: root, data: newData)
  }

  public var typeAnnotation: TypeAnnotationSyntax? {
    guard raw[Cursor.typeAnnotation].isPresent else { return nil }
    return TypeAnnotationSyntax(root: _root,
      data: data.cachedChild(at: Cursor.typeAnnotation))
  }

  public func withTypeAnnotation(
    _ newTypeAnnotationSyntax: TypeAnnotationSyntax?) -> TuplePatternSyntax {
    let raw = newTypeAnnotationSyntax?.raw ?? RawSyntax.missing(.typeAnnotation)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.typeAnnotation)
    return TuplePatternSyntax(root: root, data: newData)
  }
}
public class WildcardPatternSyntax: PatternSyntax {
  enum Cursor: Int {
    case wildcard
    case typeAnnotation
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 2)
    let _wildcard = raw[Cursor.wildcardToken]
    guard let _wildcardTokenKind = _wildcard.tokenKind else {
      fatalError("expected token child, got \(_wildcard.kind)")
    }
    precondition([.wildcardKeyword].contains(_wildcardTokenKind),
      "expected one of [.wildcardKeyword] for 'wildcard' " + 
      "in node of kind wildcardPattern")
    let _typeAnnotation = raw[Cursor.typeAnnotation]
    precondition(_typeAnnotation.kind == .typeAnnotation,
                 "expected child of kind .typeAnnotation, " +
                 "got \(_typeAnnotation.kind)")
  }
#endif

  public var wildcard: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.wildcard))
  }

  public func withWildcard(
    _ newTokenSyntax: TokenSyntax?) -> WildcardPatternSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.wildcardKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.wildcard)
    return WildcardPatternSyntax(root: root, data: newData)
  }

  public var typeAnnotation: TypeAnnotationSyntax? {
    guard raw[Cursor.typeAnnotation].isPresent else { return nil }
    return TypeAnnotationSyntax(root: _root,
      data: data.cachedChild(at: Cursor.typeAnnotation))
  }

  public func withTypeAnnotation(
    _ newTypeAnnotationSyntax: TypeAnnotationSyntax?) -> WildcardPatternSyntax {
    let raw = newTypeAnnotationSyntax?.raw ?? RawSyntax.missing(.typeAnnotation)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.typeAnnotation)
    return WildcardPatternSyntax(root: root, data: newData)
  }
}
public class TuplePatternElementSyntax: Syntax {
  enum Cursor: Int {
    case labelName
    case labelColon
    case pattern
    case comma
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 4)
    let _labelName = raw[Cursor.identifierToken]
    guard let _labelNameTokenKind = _labelName.tokenKind else {
      fatalError("expected token child, got \(_labelName.kind)")
    }
    precondition([.identifier].contains(_labelNameTokenKind),
      "expected one of [.identifier] for 'labelName' " + 
      "in node of kind tuplePatternElement")
    let _labelColon = raw[Cursor.colonToken]
    guard let _labelColonTokenKind = _labelColon.tokenKind else {
      fatalError("expected token child, got \(_labelColon.kind)")
    }
    precondition([.colon].contains(_labelColonTokenKind),
      "expected one of [.colon] for 'labelColon' " + 
      "in node of kind tuplePatternElement")
    let _pattern = raw[Cursor.pattern]
    precondition(_pattern.kind == .pattern,
                 "expected child of kind .pattern, " +
                 "got \(_pattern.kind)")
    let _comma = raw[Cursor.commaToken]
    guard let _commaTokenKind = _comma.tokenKind else {
      fatalError("expected token child, got \(_comma.kind)")
    }
    precondition([.comma].contains(_commaTokenKind),
      "expected one of [.comma] for 'comma' " + 
      "in node of kind tuplePatternElement")
  }
#endif

  public var labelName: TokenSyntax? {
    guard raw[Cursor.labelName].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.labelName))
  }

  public func withLabelName(
    _ newTokenSyntax: TokenSyntax?) -> TuplePatternElementSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.identifier(""))
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.labelName)
    return TuplePatternElementSyntax(root: root, data: newData)
  }

  public var labelColon: TokenSyntax? {
    guard raw[Cursor.labelColon].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.labelColon))
  }

  public func withLabelColon(
    _ newTokenSyntax: TokenSyntax?) -> TuplePatternElementSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.colon)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.labelColon)
    return TuplePatternElementSyntax(root: root, data: newData)
  }

  public var pattern: PatternSyntax {
    return PatternSyntax(root: _root,
      data: data.cachedChild(at: Cursor.pattern))
  }

  public func withPattern(
    _ newPatternSyntax: PatternSyntax?) -> TuplePatternElementSyntax {
    let raw = newPatternSyntax?.raw ?? RawSyntax.missing(.pattern)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.pattern)
    return TuplePatternElementSyntax(root: root, data: newData)
  }

  public var comma: TokenSyntax? {
    guard raw[Cursor.comma].isPresent else { return nil }
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.comma))
  }

  public func withComma(
    _ newTokenSyntax: TokenSyntax?) -> TuplePatternElementSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.comma)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.comma)
    return TuplePatternElementSyntax(root: root, data: newData)
  }
}
public class ExpressionPatternSyntax: PatternSyntax {
  enum Cursor: Int {
    case expression
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 1)
    let _expression = raw[Cursor.expr]
    precondition(_expression.kind == .expr,
                 "expected child of kind .expr, " +
                 "got \(_expression.kind)")
  }
#endif

  public var expression: ExprSyntax {
    return ExprSyntax(root: _root,
      data: data.cachedChild(at: Cursor.expression))
  }

  public func withExpression(
    _ newExprSyntax: ExprSyntax?) -> ExpressionPatternSyntax {
    let raw = newExprSyntax?.raw ?? RawSyntax.missing(.expr)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.expression)
    return ExpressionPatternSyntax(root: root, data: newData)
  }
}
public typealias TuplePatternElementListSyntax = SyntaxCollection<TuplePatternElementSyntax>
public class ValueBindingPatternSyntax: PatternSyntax {
  enum Cursor: Int {
    case letOrVarKeyword
    case valuePattern
  }

#if DEBUG
  override func validate() {
      if isMissing { return }
    precondition(raw.layout.count == 2)
    let _letOrVarKeyword = raw[Cursor.token]
    guard let _letOrVarKeywordTokenKind = _letOrVarKeyword.tokenKind else {
      fatalError("expected token child, got \(_letOrVarKeyword.kind)")
    }
    precondition([.letKeyword, .varKeyword].contains(_letOrVarKeywordTokenKind),
      "expected one of [.letKeyword, .varKeyword] for 'letOrVarKeyword' " + 
      "in node of kind valueBindingPattern")
    let _valuePattern = raw[Cursor.pattern]
    precondition(_valuePattern.kind == .pattern,
                 "expected child of kind .pattern, " +
                 "got \(_valuePattern.kind)")
  }
#endif

  public var letOrVarKeyword: TokenSyntax {
    return TokenSyntax(root: _root,
      data: data.cachedChild(at: Cursor.letOrVarKeyword))
  }

  public func withLetOrVarKeyword(
    _ newTokenSyntax: TokenSyntax?) -> ValueBindingPatternSyntax {
    let raw = newTokenSyntax?.raw ?? RawSyntax.missingToken(.letKeyword)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.letOrVarKeyword)
    return ValueBindingPatternSyntax(root: root, data: newData)
  }

  public var valuePattern: PatternSyntax {
    return PatternSyntax(root: _root,
      data: data.cachedChild(at: Cursor.valuePattern))
  }

  public func withValuePattern(
    _ newPatternSyntax: PatternSyntax?) -> ValueBindingPatternSyntax {
    let raw = newPatternSyntax?.raw ?? RawSyntax.missing(.pattern)
    let (root, newData) = data.replacingChild(raw,
                                              at: Cursor.valuePattern)
    return ValueBindingPatternSyntax(root: root, data: newData)
  }
}

/// MARK: Convenience methods

extension StructDeclSyntax {
  func withIdentifier(_ name: String) -> StructDeclSyntax {
    let newToken = SyntaxFactory.makeIdentifier(name,
      leadingTrivia: identifier.leadingTrivia,
      trailingTrivia: identifier.trailingTrivia)
    return withIdentifier(newToken)
  }
}