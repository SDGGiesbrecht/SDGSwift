//// Automatically Generated From SyntaxFactory.swift.gyb.
//// Do Not Edit Directly!
//===------- SyntaxFactory.swift - Syntax Factory implementations ---------===//
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
//
// This file defines the SyntaxFactory, one of the most important client-facing
// types in lib/Syntax and likely to be very commonly used.
//
// Effectively a namespace, SyntaxFactory is never instantiated, but is *the*
// one-stop shop for making new Syntax nodes. Putting all of these into a
// collection of static methods provides a single point of API lookup for
// clients' convenience.
//
//===----------------------------------------------------------------------===//

public enum SyntaxFactory {
  public static func makeToken(_ kind: TokenKind, presence: SourcePresence,
                 leadingTrivia: Trivia = [],
                 trailingTrivia: Trivia = []) -> TokenSyntax {
    let data = SyntaxData(raw: .token(kind, leadingTrivia,
                                      trailingTrivia, presence))
    return TokenSyntax(root: data, data: data)
  }

  public static func makeUnknownSyntax(tokens: [TokenSyntax]) -> Syntax {
    let data = SyntaxData(raw: .node(.unknown, 
                                     tokens.map { $0.data.raw },
                                     .present))
    return Syntax(root: data, data: data)
  }

/// MARK: Syntax Node Creation APIs


  public static func makeBlankDecl() -> DeclSyntax {
    let data = SyntaxData(raw: .node(.decl, [
    ], .present))
    return DeclSyntax(root: data, data: data)
  }

  public static func makeBlankUnknownDecl() -> UnknownDeclSyntax {
    let data = SyntaxData(raw: .node(.unknownDecl, [
    ], .present))
    return UnknownDeclSyntax(root: data, data: data)
  }

  public static func makeBlankExpr() -> ExprSyntax {
    let data = SyntaxData(raw: .node(.expr, [
    ], .present))
    return ExprSyntax(root: data, data: data)
  }

  public static func makeBlankUnknownExpr() -> UnknownExprSyntax {
    let data = SyntaxData(raw: .node(.unknownExpr, [
    ], .present))
    return UnknownExprSyntax(root: data, data: data)
  }

  public static func makeBlankStmt() -> StmtSyntax {
    let data = SyntaxData(raw: .node(.stmt, [
    ], .present))
    return StmtSyntax(root: data, data: data)
  }

  public static func makeBlankUnknownStmt() -> UnknownStmtSyntax {
    let data = SyntaxData(raw: .node(.unknownStmt, [
    ], .present))
    return UnknownStmtSyntax(root: data, data: data)
  }

  public static func makeBlankType() -> TypeSyntax {
    let data = SyntaxData(raw: .node(.type, [
    ], .present))
    return TypeSyntax(root: data, data: data)
  }

  public static func makeBlankUnknownType() -> UnknownTypeSyntax {
    let data = SyntaxData(raw: .node(.unknownType, [
    ], .present))
    return UnknownTypeSyntax(root: data, data: data)
  }

  public static func makeBlankPattern() -> PatternSyntax {
    let data = SyntaxData(raw: .node(.pattern, [
    ], .present))
    return PatternSyntax(root: data, data: data)
  }

  public static func makeBlankUnknownPattern() -> UnknownPatternSyntax {
    let data = SyntaxData(raw: .node(.unknownPattern, [
    ], .present))
    return UnknownPatternSyntax(root: data, data: data)
  }
  public static func makeInOutExpr(ampersand: TokenSyntax, identifier: TokenSyntax) -> InOutExprSyntax {
    let data = SyntaxData(raw: .node(.inOutExpr, [
      ampersand.data.raw,
      identifier.data.raw,
    ], .present))
    return InOutExprSyntax(root: data, data: data)
  }

  public static func makeBlankInOutExpr() -> InOutExprSyntax {
    let data = SyntaxData(raw: .node(.inOutExpr, [
      RawSyntax.missingToken(.ampersand),
      RawSyntax.missingToken(.identifier("")),
    ], .present))
    return InOutExprSyntax(root: data, data: data)
  }
  public static func makePoundColumnExpr(poundColumn: TokenSyntax) -> PoundColumnExprSyntax {
    let data = SyntaxData(raw: .node(.poundColumnExpr, [
      poundColumn.data.raw,
    ], .present))
    return PoundColumnExprSyntax(root: data, data: data)
  }

  public static func makeBlankPoundColumnExpr() -> PoundColumnExprSyntax {
    let data = SyntaxData(raw: .node(.poundColumnExpr, [
      RawSyntax.missingToken(.poundColumnKeyword),
    ], .present))
    return PoundColumnExprSyntax(root: data, data: data)
  }
  public static func makeFunctionCallArgumentList(
    _ elements: [FunctionCallArgumentSyntax]) -> FunctionCallArgumentListSyntax {
    let data = SyntaxData(raw: .node(.functionCallArgumentList,
                                     elements.map { $0.data.raw }, .present))
    return FunctionCallArgumentListSyntax(root: data, data: data)
  }

  public static func makeBlankFunctionCallArgumentList() -> FunctionCallArgumentListSyntax {
    let data = SyntaxData(raw: .node(.functionCallArgumentList, [
    ], .present))
    return FunctionCallArgumentListSyntax(root: data, data: data)
  }
  public static func makeTupleElementList(
    _ elements: [TupleElementSyntax]) -> TupleElementListSyntax {
    let data = SyntaxData(raw: .node(.tupleElementList,
                                     elements.map { $0.data.raw }, .present))
    return TupleElementListSyntax(root: data, data: data)
  }

  public static func makeBlankTupleElementList() -> TupleElementListSyntax {
    let data = SyntaxData(raw: .node(.tupleElementList, [
    ], .present))
    return TupleElementListSyntax(root: data, data: data)
  }
  public static func makeArrayElementList(
    _ elements: [ArrayElementSyntax]) -> ArrayElementListSyntax {
    let data = SyntaxData(raw: .node(.arrayElementList,
                                     elements.map { $0.data.raw }, .present))
    return ArrayElementListSyntax(root: data, data: data)
  }

  public static func makeBlankArrayElementList() -> ArrayElementListSyntax {
    let data = SyntaxData(raw: .node(.arrayElementList, [
    ], .present))
    return ArrayElementListSyntax(root: data, data: data)
  }
  public static func makeDictionaryElementList(
    _ elements: [DictionaryElementSyntax]) -> DictionaryElementListSyntax {
    let data = SyntaxData(raw: .node(.dictionaryElementList,
                                     elements.map { $0.data.raw }, .present))
    return DictionaryElementListSyntax(root: data, data: data)
  }

  public static func makeBlankDictionaryElementList() -> DictionaryElementListSyntax {
    let data = SyntaxData(raw: .node(.dictionaryElementList, [
    ], .present))
    return DictionaryElementListSyntax(root: data, data: data)
  }
  public static func makeTryOperator(tryKeyword: TokenSyntax, questionOrExclamationMark: TokenSyntax?) -> TryOperatorSyntax {
    let data = SyntaxData(raw: .node(.tryOperator, [
      tryKeyword.data.raw,
      questionOrExclamationMark?.data.raw ?? RawSyntax.missingToken(.postfixQuestionMark),
    ], .present))
    return TryOperatorSyntax(root: data, data: data)
  }

  public static func makeBlankTryOperator() -> TryOperatorSyntax {
    let data = SyntaxData(raw: .node(.tryOperator, [
      RawSyntax.missingToken(.tryKeyword),
      RawSyntax.missingToken(.postfixQuestionMark),
    ], .present))
    return TryOperatorSyntax(root: data, data: data)
  }
  public static func makeIdentifierExpr(identifier: TokenSyntax) -> IdentifierExprSyntax {
    let data = SyntaxData(raw: .node(.identifierExpr, [
      identifier.data.raw,
    ], .present))
    return IdentifierExprSyntax(root: data, data: data)
  }

  public static func makeBlankIdentifierExpr() -> IdentifierExprSyntax {
    let data = SyntaxData(raw: .node(.identifierExpr, [
      RawSyntax.missingToken(.identifier("")),
    ], .present))
    return IdentifierExprSyntax(root: data, data: data)
  }
  public static func makeNilLiteralExpr(nilKeyword: TokenSyntax) -> NilLiteralExprSyntax {
    let data = SyntaxData(raw: .node(.nilLiteralExpr, [
      nilKeyword.data.raw,
    ], .present))
    return NilLiteralExprSyntax(root: data, data: data)
  }

  public static func makeBlankNilLiteralExpr() -> NilLiteralExprSyntax {
    let data = SyntaxData(raw: .node(.nilLiteralExpr, [
      RawSyntax.missingToken(.nilKeyword),
    ], .present))
    return NilLiteralExprSyntax(root: data, data: data)
  }
  public static func makeDiscardAssignmentExpr(wildcard: TokenSyntax) -> DiscardAssignmentExprSyntax {
    let data = SyntaxData(raw: .node(.discardAssignmentExpr, [
      wildcard.data.raw,
    ], .present))
    return DiscardAssignmentExprSyntax(root: data, data: data)
  }

  public static func makeBlankDiscardAssignmentExpr() -> DiscardAssignmentExprSyntax {
    let data = SyntaxData(raw: .node(.discardAssignmentExpr, [
      RawSyntax.missingToken(.wildcardKeyword),
    ], .present))
    return DiscardAssignmentExprSyntax(root: data, data: data)
  }
  public static func makeAssignmentExpr(assignToken: TokenSyntax) -> AssignmentExprSyntax {
    let data = SyntaxData(raw: .node(.assignmentExpr, [
      assignToken.data.raw,
    ], .present))
    return AssignmentExprSyntax(root: data, data: data)
  }

  public static func makeBlankAssignmentExpr() -> AssignmentExprSyntax {
    let data = SyntaxData(raw: .node(.assignmentExpr, [
      RawSyntax.missingToken(.equal),
    ], .present))
    return AssignmentExprSyntax(root: data, data: data)
  }
  public static func makeSequenceExpr(elements: ExprListSyntax) -> SequenceExprSyntax {
    let data = SyntaxData(raw: .node(.sequenceExpr, [
      elements.data.raw,
    ], .present))
    return SequenceExprSyntax(root: data, data: data)
  }

  public static func makeBlankSequenceExpr() -> SequenceExprSyntax {
    let data = SyntaxData(raw: .node(.sequenceExpr, [
      RawSyntax.missing(.exprList),
    ], .present))
    return SequenceExprSyntax(root: data, data: data)
  }
  public static func makePoundLineExpr(poundLine: TokenSyntax) -> PoundLineExprSyntax {
    let data = SyntaxData(raw: .node(.poundLineExpr, [
      poundLine.data.raw,
    ], .present))
    return PoundLineExprSyntax(root: data, data: data)
  }

  public static func makeBlankPoundLineExpr() -> PoundLineExprSyntax {
    let data = SyntaxData(raw: .node(.poundLineExpr, [
      RawSyntax.missingToken(.poundLineKeyword),
    ], .present))
    return PoundLineExprSyntax(root: data, data: data)
  }
  public static func makePoundFileExpr(poundFile: TokenSyntax) -> PoundFileExprSyntax {
    let data = SyntaxData(raw: .node(.poundFileExpr, [
      poundFile.data.raw,
    ], .present))
    return PoundFileExprSyntax(root: data, data: data)
  }

  public static func makeBlankPoundFileExpr() -> PoundFileExprSyntax {
    let data = SyntaxData(raw: .node(.poundFileExpr, [
      RawSyntax.missingToken(.poundFileKeyword),
    ], .present))
    return PoundFileExprSyntax(root: data, data: data)
  }
  public static func makePoundFunctionExpr(poundFunction: TokenSyntax) -> PoundFunctionExprSyntax {
    let data = SyntaxData(raw: .node(.poundFunctionExpr, [
      poundFunction.data.raw,
    ], .present))
    return PoundFunctionExprSyntax(root: data, data: data)
  }

  public static func makeBlankPoundFunctionExpr() -> PoundFunctionExprSyntax {
    let data = SyntaxData(raw: .node(.poundFunctionExpr, [
      RawSyntax.missingToken(.poundFunctionKeyword),
    ], .present))
    return PoundFunctionExprSyntax(root: data, data: data)
  }
  public static func makeSymbolicReferenceExpr(identifier: TokenSyntax, genericArgumentClause: GenericArgumentClauseSyntax?) -> SymbolicReferenceExprSyntax {
    let data = SyntaxData(raw: .node(.symbolicReferenceExpr, [
      identifier.data.raw,
      genericArgumentClause?.data.raw ?? RawSyntax.missing(.genericArgumentClause),
    ], .present))
    return SymbolicReferenceExprSyntax(root: data, data: data)
  }

  public static func makeBlankSymbolicReferenceExpr() -> SymbolicReferenceExprSyntax {
    let data = SyntaxData(raw: .node(.symbolicReferenceExpr, [
      RawSyntax.missingToken(.identifier("")),
      RawSyntax.missing(.genericArgumentClause),
    ], .present))
    return SymbolicReferenceExprSyntax(root: data, data: data)
  }
  public static func makePrefixOperatorExpr(operatorToken: TokenSyntax?, postfixExpression: ExprSyntax) -> PrefixOperatorExprSyntax {
    let data = SyntaxData(raw: .node(.prefixOperatorExpr, [
      operatorToken?.data.raw ?? RawSyntax.missingToken(.prefixOperator("")),
      postfixExpression.data.raw,
    ], .present))
    return PrefixOperatorExprSyntax(root: data, data: data)
  }

  public static func makeBlankPrefixOperatorExpr() -> PrefixOperatorExprSyntax {
    let data = SyntaxData(raw: .node(.prefixOperatorExpr, [
      RawSyntax.missingToken(.prefixOperator("")),
      RawSyntax.missing(.expr),
    ], .present))
    return PrefixOperatorExprSyntax(root: data, data: data)
  }
  public static func makeBinaryOperatorExpr(operatorToken: TokenSyntax) -> BinaryOperatorExprSyntax {
    let data = SyntaxData(raw: .node(.binaryOperatorExpr, [
      operatorToken.data.raw,
    ], .present))
    return BinaryOperatorExprSyntax(root: data, data: data)
  }

  public static func makeBlankBinaryOperatorExpr() -> BinaryOperatorExprSyntax {
    let data = SyntaxData(raw: .node(.binaryOperatorExpr, [
      RawSyntax.missingToken(.unknown),
    ], .present))
    return BinaryOperatorExprSyntax(root: data, data: data)
  }
  public static func makeFloatLiteralExpr(floatingDigits: TokenSyntax) -> FloatLiteralExprSyntax {
    let data = SyntaxData(raw: .node(.floatLiteralExpr, [
      floatingDigits.data.raw,
    ], .present))
    return FloatLiteralExprSyntax(root: data, data: data)
  }

  public static func makeBlankFloatLiteralExpr() -> FloatLiteralExprSyntax {
    let data = SyntaxData(raw: .node(.floatLiteralExpr, [
      RawSyntax.missingToken(.floatingLiteral("")),
    ], .present))
    return FloatLiteralExprSyntax(root: data, data: data)
  }
  public static func makeFunctionCallExpr(calledExpression: ExprSyntax, leftParen: TokenSyntax, argumentList: FunctionCallArgumentListSyntax, rightParen: TokenSyntax) -> FunctionCallExprSyntax {
    let data = SyntaxData(raw: .node(.functionCallExpr, [
      calledExpression.data.raw,
      leftParen.data.raw,
      argumentList.data.raw,
      rightParen.data.raw,
    ], .present))
    return FunctionCallExprSyntax(root: data, data: data)
  }

  public static func makeBlankFunctionCallExpr() -> FunctionCallExprSyntax {
    let data = SyntaxData(raw: .node(.functionCallExpr, [
      RawSyntax.missing(.expr),
      RawSyntax.missingToken(.leftParen),
      RawSyntax.missing(.functionCallArgumentList),
      RawSyntax.missingToken(.rightParen),
    ], .present))
    return FunctionCallExprSyntax(root: data, data: data)
  }
  public static func makeTupleExpr(leftParen: TokenSyntax, elementList: TupleElementListSyntax, rightParen: TokenSyntax) -> TupleExprSyntax {
    let data = SyntaxData(raw: .node(.tupleExpr, [
      leftParen.data.raw,
      elementList.data.raw,
      rightParen.data.raw,
    ], .present))
    return TupleExprSyntax(root: data, data: data)
  }

  public static func makeBlankTupleExpr() -> TupleExprSyntax {
    let data = SyntaxData(raw: .node(.tupleExpr, [
      RawSyntax.missingToken(.leftParen),
      RawSyntax.missing(.tupleElementList),
      RawSyntax.missingToken(.rightParen),
    ], .present))
    return TupleExprSyntax(root: data, data: data)
  }
  public static func makeArrayExpr(leftSquare: TokenSyntax, elements: ArrayElementListSyntax, rightSquare: TokenSyntax) -> ArrayExprSyntax {
    let data = SyntaxData(raw: .node(.arrayExpr, [
      leftSquare.data.raw,
      elements.data.raw,
      rightSquare.data.raw,
    ], .present))
    return ArrayExprSyntax(root: data, data: data)
  }

  public static func makeBlankArrayExpr() -> ArrayExprSyntax {
    let data = SyntaxData(raw: .node(.arrayExpr, [
      RawSyntax.missingToken(.unknown),
      RawSyntax.missing(.arrayElementList),
      RawSyntax.missingToken(.unknown),
    ], .present))
    return ArrayExprSyntax(root: data, data: data)
  }
  public static func makeDictionaryExpr(leftSquare: TokenSyntax, elements: DictionaryElementListSyntax, rightSquare: TokenSyntax) -> DictionaryExprSyntax {
    let data = SyntaxData(raw: .node(.dictionaryExpr, [
      leftSquare.data.raw,
      elements.data.raw,
      rightSquare.data.raw,
    ], .present))
    return DictionaryExprSyntax(root: data, data: data)
  }

  public static func makeBlankDictionaryExpr() -> DictionaryExprSyntax {
    let data = SyntaxData(raw: .node(.dictionaryExpr, [
      RawSyntax.missingToken(.unknown),
      RawSyntax.missing(.dictionaryElementList),
      RawSyntax.missingToken(.unknown),
    ], .present))
    return DictionaryExprSyntax(root: data, data: data)
  }
  public static func makeFunctionCallArgument(label: TokenSyntax?, colon: TokenSyntax?, expression: ExprSyntax, trailingComma: TokenSyntax?) -> FunctionCallArgumentSyntax {
    let data = SyntaxData(raw: .node(.functionCallArgument, [
      label?.data.raw ?? RawSyntax.missingToken(.identifier("")),
      colon?.data.raw ?? RawSyntax.missingToken(.colon),
      expression.data.raw,
      trailingComma?.data.raw ?? RawSyntax.missingToken(.comma),
    ], .present))
    return FunctionCallArgumentSyntax(root: data, data: data)
  }

  public static func makeBlankFunctionCallArgument() -> FunctionCallArgumentSyntax {
    let data = SyntaxData(raw: .node(.functionCallArgument, [
      RawSyntax.missingToken(.identifier("")),
      RawSyntax.missingToken(.colon),
      RawSyntax.missing(.expr),
      RawSyntax.missingToken(.comma),
    ], .present))
    return FunctionCallArgumentSyntax(root: data, data: data)
  }
  public static func makeTupleElement(label: TokenSyntax?, colon: TokenSyntax?, expression: ExprSyntax, trailingComma: TokenSyntax?) -> TupleElementSyntax {
    let data = SyntaxData(raw: .node(.tupleElement, [
      label?.data.raw ?? RawSyntax.missingToken(.identifier("")),
      colon?.data.raw ?? RawSyntax.missingToken(.colon),
      expression.data.raw,
      trailingComma?.data.raw ?? RawSyntax.missingToken(.comma),
    ], .present))
    return TupleElementSyntax(root: data, data: data)
  }

  public static func makeBlankTupleElement() -> TupleElementSyntax {
    let data = SyntaxData(raw: .node(.tupleElement, [
      RawSyntax.missingToken(.identifier("")),
      RawSyntax.missingToken(.colon),
      RawSyntax.missing(.expr),
      RawSyntax.missingToken(.comma),
    ], .present))
    return TupleElementSyntax(root: data, data: data)
  }
  public static func makeArrayElement(expression: ExprSyntax, trailingComma: TokenSyntax?) -> ArrayElementSyntax {
    let data = SyntaxData(raw: .node(.arrayElement, [
      expression.data.raw,
      trailingComma?.data.raw ?? RawSyntax.missingToken(.comma),
    ], .present))
    return ArrayElementSyntax(root: data, data: data)
  }

  public static func makeBlankArrayElement() -> ArrayElementSyntax {
    let data = SyntaxData(raw: .node(.arrayElement, [
      RawSyntax.missing(.expr),
      RawSyntax.missingToken(.comma),
    ], .present))
    return ArrayElementSyntax(root: data, data: data)
  }
  public static func makeDictionaryElement(keyExpression: ExprSyntax, colon: TokenSyntax, valueExpression: ExprSyntax, trailingComma: TokenSyntax?) -> DictionaryElementSyntax {
    let data = SyntaxData(raw: .node(.dictionaryElement, [
      keyExpression.data.raw,
      colon.data.raw,
      valueExpression.data.raw,
      trailingComma?.data.raw ?? RawSyntax.missingToken(.comma),
    ], .present))
    return DictionaryElementSyntax(root: data, data: data)
  }

  public static func makeBlankDictionaryElement() -> DictionaryElementSyntax {
    let data = SyntaxData(raw: .node(.dictionaryElement, [
      RawSyntax.missing(.expr),
      RawSyntax.missingToken(.colon),
      RawSyntax.missing(.expr),
      RawSyntax.missingToken(.comma),
    ], .present))
    return DictionaryElementSyntax(root: data, data: data)
  }
  public static func makeIntegerLiteralExpr(digits: TokenSyntax) -> IntegerLiteralExprSyntax {
    let data = SyntaxData(raw: .node(.integerLiteralExpr, [
      digits.data.raw,
    ], .present))
    return IntegerLiteralExprSyntax(root: data, data: data)
  }

  public static func makeBlankIntegerLiteralExpr() -> IntegerLiteralExprSyntax {
    let data = SyntaxData(raw: .node(.integerLiteralExpr, [
      RawSyntax.missingToken(.integerLiteral("")),
    ], .present))
    return IntegerLiteralExprSyntax(root: data, data: data)
  }
  public static func makeStringLiteralExpr(stringLiteral: TokenSyntax) -> StringLiteralExprSyntax {
    let data = SyntaxData(raw: .node(.stringLiteralExpr, [
      stringLiteral.data.raw,
    ], .present))
    return StringLiteralExprSyntax(root: data, data: data)
  }

  public static func makeBlankStringLiteralExpr() -> StringLiteralExprSyntax {
    let data = SyntaxData(raw: .node(.stringLiteralExpr, [
      RawSyntax.missingToken(.stringLiteral("")),
    ], .present))
    return StringLiteralExprSyntax(root: data, data: data)
  }
  public static func makeBooleanLiteralExpr(booleanLiteral: TokenSyntax) -> BooleanLiteralExprSyntax {
    let data = SyntaxData(raw: .node(.booleanLiteralExpr, [
      booleanLiteral.data.raw,
    ], .present))
    return BooleanLiteralExprSyntax(root: data, data: data)
  }

  public static func makeBlankBooleanLiteralExpr() -> BooleanLiteralExprSyntax {
    let data = SyntaxData(raw: .node(.booleanLiteralExpr, [
      RawSyntax.missingToken(.trueKeyword),
    ], .present))
    return BooleanLiteralExprSyntax(root: data, data: data)
  }
  public static func makeTernaryExpr(conditionExpression: ExprSyntax, questionMark: TokenSyntax, firstChoice: ExprSyntax, colonMark: TokenSyntax, secondChoice: ExprSyntax) -> TernaryExprSyntax {
    let data = SyntaxData(raw: .node(.ternaryExpr, [
      conditionExpression.data.raw,
      questionMark.data.raw,
      firstChoice.data.raw,
      colonMark.data.raw,
      secondChoice.data.raw,
    ], .present))
    return TernaryExprSyntax(root: data, data: data)
  }

  public static func makeBlankTernaryExpr() -> TernaryExprSyntax {
    let data = SyntaxData(raw: .node(.ternaryExpr, [
      RawSyntax.missing(.expr),
      RawSyntax.missingToken(.infixQuestionMark),
      RawSyntax.missing(.expr),
      RawSyntax.missingToken(.colon),
      RawSyntax.missing(.expr),
    ], .present))
    return TernaryExprSyntax(root: data, data: data)
  }
  public static func makeMemberAccessExpr(base: ExprSyntax, dot: TokenSyntax, name: TokenSyntax) -> MemberAccessExprSyntax {
    let data = SyntaxData(raw: .node(.memberAccessExpr, [
      base.data.raw,
      dot.data.raw,
      name.data.raw,
    ], .present))
    return MemberAccessExprSyntax(root: data, data: data)
  }

  public static func makeBlankMemberAccessExpr() -> MemberAccessExprSyntax {
    let data = SyntaxData(raw: .node(.memberAccessExpr, [
      RawSyntax.missing(.expr),
      RawSyntax.missingToken(.period),
      RawSyntax.missingToken(.unknown),
    ], .present))
    return MemberAccessExprSyntax(root: data, data: data)
  }
  public static func makeIsExpr(isTok: TokenSyntax, typeName: TypeSyntax) -> IsExprSyntax {
    let data = SyntaxData(raw: .node(.isExpr, [
      isTok.data.raw,
      typeName.data.raw,
    ], .present))
    return IsExprSyntax(root: data, data: data)
  }

  public static func makeBlankIsExpr() -> IsExprSyntax {
    let data = SyntaxData(raw: .node(.isExpr, [
      RawSyntax.missingToken(.isKeyword),
      RawSyntax.missing(.type),
    ], .present))
    return IsExprSyntax(root: data, data: data)
  }
  public static func makeAsExpr(asTok: TokenSyntax, questionOrExclamationMark: TokenSyntax?, typeName: TypeSyntax) -> AsExprSyntax {
    let data = SyntaxData(raw: .node(.asExpr, [
      asTok.data.raw,
      questionOrExclamationMark?.data.raw ?? RawSyntax.missingToken(.postfixQuestionMark),
      typeName.data.raw,
    ], .present))
    return AsExprSyntax(root: data, data: data)
  }

  public static func makeBlankAsExpr() -> AsExprSyntax {
    let data = SyntaxData(raw: .node(.asExpr, [
      RawSyntax.missingToken(.asKeyword),
      RawSyntax.missingToken(.postfixQuestionMark),
      RawSyntax.missing(.type),
    ], .present))
    return AsExprSyntax(root: data, data: data)
  }
  public static func makeTypealiasDecl(attributes: AttributeListSyntax?, accessLevelModifier: AccessLevelModifierSyntax?, typealiasKeyword: TokenSyntax, identifier: TokenSyntax, genericParameterClause: GenericParameterClauseSyntax?, equals: TokenSyntax, type: TypeSyntax) -> TypealiasDeclSyntax {
    let data = SyntaxData(raw: .node(.typealiasDecl, [
      attributes?.data.raw ?? RawSyntax.missing(.attributeList),
      accessLevelModifier?.data.raw ?? RawSyntax.missing(.accessLevelModifier),
      typealiasKeyword.data.raw,
      identifier.data.raw,
      genericParameterClause?.data.raw ?? RawSyntax.missing(.genericParameterClause),
      equals.data.raw,
      type.data.raw,
    ], .present))
    return TypealiasDeclSyntax(root: data, data: data)
  }

  public static func makeBlankTypealiasDecl() -> TypealiasDeclSyntax {
    let data = SyntaxData(raw: .node(.typealiasDecl, [
      RawSyntax.missing(.attributeList),
      RawSyntax.missing(.accessLevelModifier),
      RawSyntax.missingToken(.typealiasKeyword),
      RawSyntax.missingToken(.identifier("")),
      RawSyntax.missing(.genericParameterClause),
      RawSyntax.missingToken(.equal),
      RawSyntax.missing(.type),
    ], .present))
    return TypealiasDeclSyntax(root: data, data: data)
  }
  public static func makeFunctionParameterList(
    _ elements: [FunctionParameterSyntax]) -> FunctionParameterListSyntax {
    let data = SyntaxData(raw: .node(.functionParameterList,
                                     elements.map { $0.data.raw }, .present))
    return FunctionParameterListSyntax(root: data, data: data)
  }

  public static func makeBlankFunctionParameterList() -> FunctionParameterListSyntax {
    let data = SyntaxData(raw: .node(.functionParameterList, [
    ], .present))
    return FunctionParameterListSyntax(root: data, data: data)
  }
  public static func makeFunctionSignature(leftParen: TokenSyntax, parameterList: FunctionParameterListSyntax, rightParen: TokenSyntax, throwsOrRethrowsKeyword: TokenSyntax?, arrow: TokenSyntax?, returnTypeAttributes: AttributeListSyntax?, returnType: TypeSyntax?) -> FunctionSignatureSyntax {
    let data = SyntaxData(raw: .node(.functionSignature, [
      leftParen.data.raw,
      parameterList.data.raw,
      rightParen.data.raw,
      throwsOrRethrowsKeyword?.data.raw ?? RawSyntax.missingToken(.throwsKeyword),
      arrow?.data.raw ?? RawSyntax.missingToken(.arrow),
      returnTypeAttributes?.data.raw ?? RawSyntax.missing(.attributeList),
      returnType?.data.raw ?? RawSyntax.missing(.type),
    ], .present))
    return FunctionSignatureSyntax(root: data, data: data)
  }

  public static func makeBlankFunctionSignature() -> FunctionSignatureSyntax {
    let data = SyntaxData(raw: .node(.functionSignature, [
      RawSyntax.missingToken(.leftParen),
      RawSyntax.missing(.functionParameterList),
      RawSyntax.missingToken(.rightParen),
      RawSyntax.missingToken(.throwsKeyword),
      RawSyntax.missingToken(.arrow),
      RawSyntax.missing(.attributeList),
      RawSyntax.missing(.type),
    ], .present))
    return FunctionSignatureSyntax(root: data, data: data)
  }
  public static func makeElseifDirectiveClause(poundElseif: TokenSyntax, condition: ExprSyntax, body: StmtListSyntax) -> ElseifDirectiveClauseSyntax {
    let data = SyntaxData(raw: .node(.elseifDirectiveClause, [
      poundElseif.data.raw,
      condition.data.raw,
      body.data.raw,
    ], .present))
    return ElseifDirectiveClauseSyntax(root: data, data: data)
  }

  public static func makeBlankElseifDirectiveClause() -> ElseifDirectiveClauseSyntax {
    let data = SyntaxData(raw: .node(.elseifDirectiveClause, [
      RawSyntax.missingToken(.poundElseifKeyword),
      RawSyntax.missing(.expr),
      RawSyntax.missing(.stmtList),
    ], .present))
    return ElseifDirectiveClauseSyntax(root: data, data: data)
  }
  public static func makeIfConfigDecl(poundIf: TokenSyntax, condition: ExprSyntax, body: StmtListSyntax, elseifDirectiveClauses: ElseifDirectiveClauseListSyntax, elseClause: ElseDirectiveClauseSyntax?, poundEndif: TokenSyntax) -> IfConfigDeclSyntax {
    let data = SyntaxData(raw: .node(.ifConfigDecl, [
      poundIf.data.raw,
      condition.data.raw,
      body.data.raw,
      elseifDirectiveClauses.data.raw,
      elseClause?.data.raw ?? RawSyntax.missing(.elseDirectiveClause),
      poundEndif.data.raw,
    ], .present))
    return IfConfigDeclSyntax(root: data, data: data)
  }

  public static func makeBlankIfConfigDecl() -> IfConfigDeclSyntax {
    let data = SyntaxData(raw: .node(.ifConfigDecl, [
      RawSyntax.missingToken(.poundIfKeyword),
      RawSyntax.missing(.expr),
      RawSyntax.missing(.stmtList),
      RawSyntax.missing(.elseifDirectiveClauseList),
      RawSyntax.missing(.elseDirectiveClause),
      RawSyntax.missingToken(.poundEndifKeyword),
    ], .present))
    return IfConfigDeclSyntax(root: data, data: data)
  }
  public static func makeDeclModifier(name: TokenSyntax, detail: TokenListSyntax) -> DeclModifierSyntax {
    let data = SyntaxData(raw: .node(.declModifier, [
      name.data.raw,
      detail.data.raw,
    ], .present))
    return DeclModifierSyntax(root: data, data: data)
  }

  public static func makeBlankDeclModifier() -> DeclModifierSyntax {
    let data = SyntaxData(raw: .node(.declModifier, [
      RawSyntax.missingToken(.unknown),
      RawSyntax.missingToken(.unknown),
    ], .present))
    return DeclModifierSyntax(root: data, data: data)
  }
  public static func makeTypeInheritanceClause(colon: TokenSyntax, inheritedType: TypeSyntax) -> TypeInheritanceClauseSyntax {
    let data = SyntaxData(raw: .node(.typeInheritanceClause, [
      colon.data.raw,
      inheritedType.data.raw,
    ], .present))
    return TypeInheritanceClauseSyntax(root: data, data: data)
  }

  public static func makeBlankTypeInheritanceClause() -> TypeInheritanceClauseSyntax {
    let data = SyntaxData(raw: .node(.typeInheritanceClause, [
      RawSyntax.missingToken(.colon),
      RawSyntax.missing(.type),
    ], .present))
    return TypeInheritanceClauseSyntax(root: data, data: data)
  }
  public static func makeStructDecl(attributes: AttributeListSyntax?, accessLevelModifier: AccessLevelModifierSyntax?, structKeyword: TokenSyntax, identifier: TokenSyntax, genericParameterClause: GenericParameterClauseSyntax?, inheritanceClause: TypeInheritanceClauseSyntax?, genericWhereClause: GenericWhereClauseSyntax?, members: MemberDeclBlockSyntax) -> StructDeclSyntax {
    let data = SyntaxData(raw: .node(.structDecl, [
      attributes?.data.raw ?? RawSyntax.missing(.attributeList),
      accessLevelModifier?.data.raw ?? RawSyntax.missing(.accessLevelModifier),
      structKeyword.data.raw,
      identifier.data.raw,
      genericParameterClause?.data.raw ?? RawSyntax.missing(.genericParameterClause),
      inheritanceClause?.data.raw ?? RawSyntax.missing(.typeInheritanceClause),
      genericWhereClause?.data.raw ?? RawSyntax.missing(.genericWhereClause),
      members.data.raw,
    ], .present))
    return StructDeclSyntax(root: data, data: data)
  }

  public static func makeBlankStructDecl() -> StructDeclSyntax {
    let data = SyntaxData(raw: .node(.structDecl, [
      RawSyntax.missing(.attributeList),
      RawSyntax.missing(.accessLevelModifier),
      RawSyntax.missingToken(.structKeyword),
      RawSyntax.missingToken(.identifier("")),
      RawSyntax.missing(.genericParameterClause),
      RawSyntax.missing(.typeInheritanceClause),
      RawSyntax.missing(.genericWhereClause),
      RawSyntax.missing(.memberDeclBlock),
    ], .present))
    return StructDeclSyntax(root: data, data: data)
  }
  public static func makeMemberDeclBlock(leftBrace: TokenSyntax, members: DeclListSyntax, rightBrace: TokenSyntax) -> MemberDeclBlockSyntax {
    let data = SyntaxData(raw: .node(.memberDeclBlock, [
      leftBrace.data.raw,
      members.data.raw,
      rightBrace.data.raw,
    ], .present))
    return MemberDeclBlockSyntax(root: data, data: data)
  }

  public static func makeBlankMemberDeclBlock() -> MemberDeclBlockSyntax {
    let data = SyntaxData(raw: .node(.memberDeclBlock, [
      RawSyntax.missingToken(.leftBrace),
      RawSyntax.missing(.declList),
      RawSyntax.missingToken(.rightBrace),
    ], .present))
    return MemberDeclBlockSyntax(root: data, data: data)
  }
  public static func makeDeclList(
    _ elements: [DeclSyntax]) -> DeclListSyntax {
    let data = SyntaxData(raw: .node(.declList,
                                     elements.map { $0.data.raw }, .present))
    return DeclListSyntax(root: data, data: data)
  }

  public static func makeBlankDeclList() -> DeclListSyntax {
    let data = SyntaxData(raw: .node(.declList, [
    ], .present))
    return DeclListSyntax(root: data, data: data)
  }
  public static func makeSourceFile(topLevelDecls: DeclListSyntax, eofToken: TokenSyntax) -> SourceFileSyntax {
    let data = SyntaxData(raw: .node(.sourceFile, [
      topLevelDecls.data.raw,
      eofToken.data.raw,
    ], .present))
    return SourceFileSyntax(root: data, data: data)
  }

  public static func makeBlankSourceFile() -> SourceFileSyntax {
    let data = SyntaxData(raw: .node(.sourceFile, [
      RawSyntax.missing(.declList),
      RawSyntax.missingToken(.unknown),
    ], .present))
    return SourceFileSyntax(root: data, data: data)
  }
  public static func makeTopLevelCodeDecl(body: StmtListSyntax) -> TopLevelCodeDeclSyntax {
    let data = SyntaxData(raw: .node(.topLevelCodeDecl, [
      body.data.raw,
    ], .present))
    return TopLevelCodeDeclSyntax(root: data, data: data)
  }

  public static func makeBlankTopLevelCodeDecl() -> TopLevelCodeDeclSyntax {
    let data = SyntaxData(raw: .node(.topLevelCodeDecl, [
      RawSyntax.missing(.stmtList),
    ], .present))
    return TopLevelCodeDeclSyntax(root: data, data: data)
  }
  public static func makeFunctionParameter(externalName: TokenSyntax?, localName: TokenSyntax, colon: TokenSyntax, typeAnnotation: TypeAnnotationSyntax, ellipsis: TokenSyntax?, defaultEquals: TokenSyntax?, defaultValue: ExprSyntax?, trailingComma: TokenSyntax?) -> FunctionParameterSyntax {
    let data = SyntaxData(raw: .node(.functionParameter, [
      externalName?.data.raw ?? RawSyntax.missingToken(.identifier("")),
      localName.data.raw,
      colon.data.raw,
      typeAnnotation.data.raw,
      ellipsis?.data.raw ?? RawSyntax.missingToken(.unknown),
      defaultEquals?.data.raw ?? RawSyntax.missingToken(.equal),
      defaultValue?.data.raw ?? RawSyntax.missing(.expr),
      trailingComma?.data.raw ?? RawSyntax.missingToken(.comma),
    ], .present))
    return FunctionParameterSyntax(root: data, data: data)
  }

  public static func makeBlankFunctionParameter() -> FunctionParameterSyntax {
    let data = SyntaxData(raw: .node(.functionParameter, [
      RawSyntax.missingToken(.identifier("")),
      RawSyntax.missingToken(.identifier("")),
      RawSyntax.missingToken(.colon),
      RawSyntax.missing(.typeAnnotation),
      RawSyntax.missingToken(.unknown),
      RawSyntax.missingToken(.equal),
      RawSyntax.missing(.expr),
      RawSyntax.missingToken(.comma),
    ], .present))
    return FunctionParameterSyntax(root: data, data: data)
  }
  public static func makeModifierList(
    _ elements: [Syntax]) -> ModifierListSyntax {
    let data = SyntaxData(raw: .node(.modifierList,
                                     elements.map { $0.data.raw }, .present))
    return ModifierListSyntax(root: data, data: data)
  }

  public static func makeBlankModifierList() -> ModifierListSyntax {
    let data = SyntaxData(raw: .node(.modifierList, [
    ], .present))
    return ModifierListSyntax(root: data, data: data)
  }
  public static func makeFunctionDecl(attributes: AttributeListSyntax?, modifiers: ModifierListSyntax?, funcKeyword: TokenSyntax, identifier: TokenSyntax, genericParameterClause: GenericParameterClauseSyntax?, signature: FunctionSignatureSyntax, genericWhereClause: GenericWhereClauseSyntax?, body: CodeBlockSyntax) -> FunctionDeclSyntax {
    let data = SyntaxData(raw: .node(.functionDecl, [
      attributes?.data.raw ?? RawSyntax.missing(.attributeList),
      modifiers?.data.raw ?? RawSyntax.missing(.modifierList),
      funcKeyword.data.raw,
      identifier.data.raw,
      genericParameterClause?.data.raw ?? RawSyntax.missing(.genericParameterClause),
      signature.data.raw,
      genericWhereClause?.data.raw ?? RawSyntax.missing(.genericWhereClause),
      body.data.raw,
    ], .present))
    return FunctionDeclSyntax(root: data, data: data)
  }

  public static func makeBlankFunctionDecl() -> FunctionDeclSyntax {
    let data = SyntaxData(raw: .node(.functionDecl, [
      RawSyntax.missing(.attributeList),
      RawSyntax.missing(.modifierList),
      RawSyntax.missingToken(.funcKeyword),
      RawSyntax.missingToken(.identifier("")),
      RawSyntax.missing(.genericParameterClause),
      RawSyntax.missing(.functionSignature),
      RawSyntax.missing(.genericWhereClause),
      RawSyntax.missing(.codeBlock),
    ], .present))
    return FunctionDeclSyntax(root: data, data: data)
  }
  public static func makeElseifDirectiveClauseList(
    _ elements: [ElseifDirectiveClauseSyntax]) -> ElseifDirectiveClauseListSyntax {
    let data = SyntaxData(raw: .node(.elseifDirectiveClauseList,
                                     elements.map { $0.data.raw }, .present))
    return ElseifDirectiveClauseListSyntax(root: data, data: data)
  }

  public static func makeBlankElseifDirectiveClauseList() -> ElseifDirectiveClauseListSyntax {
    let data = SyntaxData(raw: .node(.elseifDirectiveClauseList, [
    ], .present))
    return ElseifDirectiveClauseListSyntax(root: data, data: data)
  }
  public static func makeElseDirectiveClause(poundElse: TokenSyntax, body: StmtListSyntax) -> ElseDirectiveClauseSyntax {
    let data = SyntaxData(raw: .node(.elseDirectiveClause, [
      poundElse.data.raw,
      body.data.raw,
    ], .present))
    return ElseDirectiveClauseSyntax(root: data, data: data)
  }

  public static func makeBlankElseDirectiveClause() -> ElseDirectiveClauseSyntax {
    let data = SyntaxData(raw: .node(.elseDirectiveClause, [
      RawSyntax.missingToken(.poundElseKeyword),
      RawSyntax.missing(.stmtList),
    ], .present))
    return ElseDirectiveClauseSyntax(root: data, data: data)
  }
  public static func makeAccessLevelModifier(name: TokenSyntax, openParen: TokenSyntax?, modifier: TokenSyntax?, closeParen: TokenSyntax?) -> AccessLevelModifierSyntax {
    let data = SyntaxData(raw: .node(.accessLevelModifier, [
      name.data.raw,
      openParen?.data.raw ?? RawSyntax.missingToken(.leftParen),
      modifier?.data.raw ?? RawSyntax.missingToken(.identifier("")),
      closeParen?.data.raw ?? RawSyntax.missingToken(.rightParen),
    ], .present))
    return AccessLevelModifierSyntax(root: data, data: data)
  }

  public static func makeBlankAccessLevelModifier() -> AccessLevelModifierSyntax {
    let data = SyntaxData(raw: .node(.accessLevelModifier, [
      RawSyntax.missingToken(.identifier("")),
      RawSyntax.missingToken(.leftParen),
      RawSyntax.missingToken(.identifier("")),
      RawSyntax.missingToken(.rightParen),
    ], .present))
    return AccessLevelModifierSyntax(root: data, data: data)
  }
  public static func makeTokenList(
    _ elements: [TokenSyntax]) -> TokenListSyntax {
    let data = SyntaxData(raw: .node(.tokenList,
                                     elements.map { $0.data.raw }, .present))
    return TokenListSyntax(root: data, data: data)
  }

  public static func makeBlankTokenList() -> TokenListSyntax {
    let data = SyntaxData(raw: .node(.tokenList, [
    ], .present))
    return TokenListSyntax(root: data, data: data)
  }
  public static func makeAttribute(atSignToken: TokenSyntax, attributeName: TokenSyntax, balancedTokens: TokenListSyntax) -> AttributeSyntax {
    let data = SyntaxData(raw: .node(.attribute, [
      atSignToken.data.raw,
      attributeName.data.raw,
      balancedTokens.data.raw,
    ], .present))
    return AttributeSyntax(root: data, data: data)
  }

  public static func makeBlankAttribute() -> AttributeSyntax {
    let data = SyntaxData(raw: .node(.attribute, [
      RawSyntax.missingToken(.atSign),
      RawSyntax.missingToken(.unknown),
      RawSyntax.missingToken(.unknown),
    ], .present))
    return AttributeSyntax(root: data, data: data)
  }
  public static func makeAttributeList(
    _ elements: [AttributeSyntax]) -> AttributeListSyntax {
    let data = SyntaxData(raw: .node(.attributeList,
                                     elements.map { $0.data.raw }, .present))
    return AttributeListSyntax(root: data, data: data)
  }

  public static func makeBlankAttributeList() -> AttributeListSyntax {
    let data = SyntaxData(raw: .node(.attributeList, [
    ], .present))
    return AttributeListSyntax(root: data, data: data)
  }
  public static func makeContinueStmt(continueKeyword: TokenSyntax, label: TokenSyntax?, semicolon: TokenSyntax?) -> ContinueStmtSyntax {
    let data = SyntaxData(raw: .node(.continueStmt, [
      continueKeyword.data.raw,
      label?.data.raw ?? RawSyntax.missingToken(.identifier("")),
      semicolon?.data.raw ?? RawSyntax.missingToken(.semicolon),
    ], .present))
    return ContinueStmtSyntax(root: data, data: data)
  }

  public static func makeBlankContinueStmt() -> ContinueStmtSyntax {
    let data = SyntaxData(raw: .node(.continueStmt, [
      RawSyntax.missingToken(.continueKeyword),
      RawSyntax.missingToken(.identifier("")),
      RawSyntax.missingToken(.semicolon),
    ], .present))
    return ContinueStmtSyntax(root: data, data: data)
  }
  public static func makeWhileStmt(labelName: TokenSyntax?, labelColon: TokenSyntax?, whileKeyword: TokenSyntax, conditions: ConditionListSyntax, body: CodeBlockSyntax, semicolon: TokenSyntax?) -> WhileStmtSyntax {
    let data = SyntaxData(raw: .node(.whileStmt, [
      labelName?.data.raw ?? RawSyntax.missingToken(.identifier("")),
      labelColon?.data.raw ?? RawSyntax.missingToken(.colon),
      whileKeyword.data.raw,
      conditions.data.raw,
      body.data.raw,
      semicolon?.data.raw ?? RawSyntax.missingToken(.semicolon),
    ], .present))
    return WhileStmtSyntax(root: data, data: data)
  }

  public static func makeBlankWhileStmt() -> WhileStmtSyntax {
    let data = SyntaxData(raw: .node(.whileStmt, [
      RawSyntax.missingToken(.identifier("")),
      RawSyntax.missingToken(.colon),
      RawSyntax.missingToken(.whileKeyword),
      RawSyntax.missing(.conditionList),
      RawSyntax.missing(.codeBlock),
      RawSyntax.missingToken(.semicolon),
    ], .present))
    return WhileStmtSyntax(root: data, data: data)
  }
  public static func makeDeferStmt(deferKeyword: TokenSyntax, body: CodeBlockSyntax, semicolon: TokenSyntax?) -> DeferStmtSyntax {
    let data = SyntaxData(raw: .node(.deferStmt, [
      deferKeyword.data.raw,
      body.data.raw,
      semicolon?.data.raw ?? RawSyntax.missingToken(.semicolon),
    ], .present))
    return DeferStmtSyntax(root: data, data: data)
  }

  public static func makeBlankDeferStmt() -> DeferStmtSyntax {
    let data = SyntaxData(raw: .node(.deferStmt, [
      RawSyntax.missingToken(.deferKeyword),
      RawSyntax.missing(.codeBlock),
      RawSyntax.missingToken(.semicolon),
    ], .present))
    return DeferStmtSyntax(root: data, data: data)
  }
  public static func makeExpressionStmt(expression: ExprSyntax, semicolon: TokenSyntax?) -> ExpressionStmtSyntax {
    let data = SyntaxData(raw: .node(.expressionStmt, [
      expression.data.raw,
      semicolon?.data.raw ?? RawSyntax.missingToken(.semicolon),
    ], .present))
    return ExpressionStmtSyntax(root: data, data: data)
  }

  public static func makeBlankExpressionStmt() -> ExpressionStmtSyntax {
    let data = SyntaxData(raw: .node(.expressionStmt, [
      RawSyntax.missing(.expr),
      RawSyntax.missingToken(.semicolon),
    ], .present))
    return ExpressionStmtSyntax(root: data, data: data)
  }
  public static func makeSwitchCaseList(
    _ elements: [SwitchCaseSyntax]) -> SwitchCaseListSyntax {
    let data = SyntaxData(raw: .node(.switchCaseList,
                                     elements.map { $0.data.raw }, .present))
    return SwitchCaseListSyntax(root: data, data: data)
  }

  public static func makeBlankSwitchCaseList() -> SwitchCaseListSyntax {
    let data = SyntaxData(raw: .node(.switchCaseList, [
    ], .present))
    return SwitchCaseListSyntax(root: data, data: data)
  }
  public static func makeRepeatWhileStmt(labelName: TokenSyntax?, labelColon: TokenSyntax?, repeatKeyword: TokenSyntax, body: CodeBlockSyntax, whileKeyword: TokenSyntax, condition: ExprSyntax, semicolon: TokenSyntax?) -> RepeatWhileStmtSyntax {
    let data = SyntaxData(raw: .node(.repeatWhileStmt, [
      labelName?.data.raw ?? RawSyntax.missingToken(.identifier("")),
      labelColon?.data.raw ?? RawSyntax.missingToken(.colon),
      repeatKeyword.data.raw,
      body.data.raw,
      whileKeyword.data.raw,
      condition.data.raw,
      semicolon?.data.raw ?? RawSyntax.missingToken(.semicolon),
    ], .present))
    return RepeatWhileStmtSyntax(root: data, data: data)
  }

  public static func makeBlankRepeatWhileStmt() -> RepeatWhileStmtSyntax {
    let data = SyntaxData(raw: .node(.repeatWhileStmt, [
      RawSyntax.missingToken(.identifier("")),
      RawSyntax.missingToken(.colon),
      RawSyntax.missingToken(.repeatKeyword),
      RawSyntax.missing(.codeBlock),
      RawSyntax.missingToken(.whileKeyword),
      RawSyntax.missing(.expr),
      RawSyntax.missingToken(.semicolon),
    ], .present))
    return RepeatWhileStmtSyntax(root: data, data: data)
  }
  public static func makeGuardStmt(guardKeyword: TokenSyntax, conditions: ConditionListSyntax, elseKeyword: TokenSyntax, body: CodeBlockSyntax, semicolon: TokenSyntax?) -> GuardStmtSyntax {
    let data = SyntaxData(raw: .node(.guardStmt, [
      guardKeyword.data.raw,
      conditions.data.raw,
      elseKeyword.data.raw,
      body.data.raw,
      semicolon?.data.raw ?? RawSyntax.missingToken(.semicolon),
    ], .present))
    return GuardStmtSyntax(root: data, data: data)
  }

  public static func makeBlankGuardStmt() -> GuardStmtSyntax {
    let data = SyntaxData(raw: .node(.guardStmt, [
      RawSyntax.missingToken(.guardKeyword),
      RawSyntax.missing(.conditionList),
      RawSyntax.missingToken(.elseKeyword),
      RawSyntax.missing(.codeBlock),
      RawSyntax.missingToken(.semicolon),
    ], .present))
    return GuardStmtSyntax(root: data, data: data)
  }
  public static func makeExprList(
    _ elements: [ExprSyntax]) -> ExprListSyntax {
    let data = SyntaxData(raw: .node(.exprList,
                                     elements.map { $0.data.raw }, .present))
    return ExprListSyntax(root: data, data: data)
  }

  public static func makeBlankExprList() -> ExprListSyntax {
    let data = SyntaxData(raw: .node(.exprList, [
    ], .present))
    return ExprListSyntax(root: data, data: data)
  }
  public static func makeWhereClause(whereKeyword: TokenSyntax, expressions: ExprListSyntax) -> WhereClauseSyntax {
    let data = SyntaxData(raw: .node(.whereClause, [
      whereKeyword.data.raw,
      expressions.data.raw,
    ], .present))
    return WhereClauseSyntax(root: data, data: data)
  }

  public static func makeBlankWhereClause() -> WhereClauseSyntax {
    let data = SyntaxData(raw: .node(.whereClause, [
      RawSyntax.missingToken(.whereKeyword),
      RawSyntax.missing(.exprList),
    ], .present))
    return WhereClauseSyntax(root: data, data: data)
  }
  public static func makeForInStmt(labelName: TokenSyntax?, labelColon: TokenSyntax?, forKeyword: TokenSyntax, caseKeyword: TokenSyntax?, itemPattern: PatternSyntax, inKeyword: TokenSyntax, collectionExpr: ExprSyntax, whereClause: WhereClauseSyntax?, body: CodeBlockSyntax, semicolon: TokenSyntax?) -> ForInStmtSyntax {
    let data = SyntaxData(raw: .node(.forInStmt, [
      labelName?.data.raw ?? RawSyntax.missingToken(.identifier("")),
      labelColon?.data.raw ?? RawSyntax.missingToken(.colon),
      forKeyword.data.raw,
      caseKeyword?.data.raw ?? RawSyntax.missingToken(.caseKeyword),
      itemPattern.data.raw,
      inKeyword.data.raw,
      collectionExpr.data.raw,
      whereClause?.data.raw ?? RawSyntax.missing(.whereClause),
      body.data.raw,
      semicolon?.data.raw ?? RawSyntax.missingToken(.semicolon),
    ], .present))
    return ForInStmtSyntax(root: data, data: data)
  }

  public static func makeBlankForInStmt() -> ForInStmtSyntax {
    let data = SyntaxData(raw: .node(.forInStmt, [
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
    ], .present))
    return ForInStmtSyntax(root: data, data: data)
  }
  public static func makeSwitchStmt(labelName: TokenSyntax?, labelColon: TokenSyntax?, switchKeyword: TokenSyntax, expression: ExprSyntax, openBrace: TokenSyntax, cases: SwitchCaseListSyntax, closeBrace: TokenSyntax, semicolon: TokenSyntax?) -> SwitchStmtSyntax {
    let data = SyntaxData(raw: .node(.switchStmt, [
      labelName?.data.raw ?? RawSyntax.missingToken(.identifier("")),
      labelColon?.data.raw ?? RawSyntax.missingToken(.colon),
      switchKeyword.data.raw,
      expression.data.raw,
      openBrace.data.raw,
      cases.data.raw,
      closeBrace.data.raw,
      semicolon?.data.raw ?? RawSyntax.missingToken(.semicolon),
    ], .present))
    return SwitchStmtSyntax(root: data, data: data)
  }

  public static func makeBlankSwitchStmt() -> SwitchStmtSyntax {
    let data = SyntaxData(raw: .node(.switchStmt, [
      RawSyntax.missingToken(.identifier("")),
      RawSyntax.missingToken(.colon),
      RawSyntax.missingToken(.switchKeyword),
      RawSyntax.missing(.expr),
      RawSyntax.missingToken(.leftBrace),
      RawSyntax.missing(.switchCaseList),
      RawSyntax.missingToken(.rightBrace),
      RawSyntax.missingToken(.semicolon),
    ], .present))
    return SwitchStmtSyntax(root: data, data: data)
  }
  public static func makeCatchClauseList(
    _ elements: [CatchClauseSyntax]) -> CatchClauseListSyntax {
    let data = SyntaxData(raw: .node(.catchClauseList,
                                     elements.map { $0.data.raw }, .present))
    return CatchClauseListSyntax(root: data, data: data)
  }

  public static func makeBlankCatchClauseList() -> CatchClauseListSyntax {
    let data = SyntaxData(raw: .node(.catchClauseList, [
    ], .present))
    return CatchClauseListSyntax(root: data, data: data)
  }
  public static func makeDoStmt(labelName: TokenSyntax?, labelColon: TokenSyntax?, doKeyword: TokenSyntax, body: CodeBlockSyntax, catchClauses: CatchClauseListSyntax, semicolon: TokenSyntax?) -> DoStmtSyntax {
    let data = SyntaxData(raw: .node(.doStmt, [
      labelName?.data.raw ?? RawSyntax.missingToken(.identifier("")),
      labelColon?.data.raw ?? RawSyntax.missingToken(.colon),
      doKeyword.data.raw,
      body.data.raw,
      catchClauses.data.raw,
      semicolon?.data.raw ?? RawSyntax.missingToken(.semicolon),
    ], .present))
    return DoStmtSyntax(root: data, data: data)
  }

  public static func makeBlankDoStmt() -> DoStmtSyntax {
    let data = SyntaxData(raw: .node(.doStmt, [
      RawSyntax.missingToken(.identifier("")),
      RawSyntax.missingToken(.colon),
      RawSyntax.missingToken(.doKeyword),
      RawSyntax.missing(.codeBlock),
      RawSyntax.missing(.catchClauseList),
      RawSyntax.missingToken(.semicolon),
    ], .present))
    return DoStmtSyntax(root: data, data: data)
  }
  public static func makeReturnStmt(returnKeyword: TokenSyntax, expression: ExprSyntax?, semicolon: TokenSyntax?) -> ReturnStmtSyntax {
    let data = SyntaxData(raw: .node(.returnStmt, [
      returnKeyword.data.raw,
      expression?.data.raw ?? RawSyntax.missing(.expr),
      semicolon?.data.raw ?? RawSyntax.missingToken(.semicolon),
    ], .present))
    return ReturnStmtSyntax(root: data, data: data)
  }

  public static func makeBlankReturnStmt() -> ReturnStmtSyntax {
    let data = SyntaxData(raw: .node(.returnStmt, [
      RawSyntax.missingToken(.returnKeyword),
      RawSyntax.missing(.expr),
      RawSyntax.missingToken(.semicolon),
    ], .present))
    return ReturnStmtSyntax(root: data, data: data)
  }
  public static func makeFallthroughStmt(fallthroughKeyword: TokenSyntax, semicolon: TokenSyntax?) -> FallthroughStmtSyntax {
    let data = SyntaxData(raw: .node(.fallthroughStmt, [
      fallthroughKeyword.data.raw,
      semicolon?.data.raw ?? RawSyntax.missingToken(.semicolon),
    ], .present))
    return FallthroughStmtSyntax(root: data, data: data)
  }

  public static func makeBlankFallthroughStmt() -> FallthroughStmtSyntax {
    let data = SyntaxData(raw: .node(.fallthroughStmt, [
      RawSyntax.missingToken(.fallthroughKeyword),
      RawSyntax.missingToken(.semicolon),
    ], .present))
    return FallthroughStmtSyntax(root: data, data: data)
  }
  public static func makeBreakStmt(breakKeyword: TokenSyntax, label: TokenSyntax?, semicolon: TokenSyntax?) -> BreakStmtSyntax {
    let data = SyntaxData(raw: .node(.breakStmt, [
      breakKeyword.data.raw,
      label?.data.raw ?? RawSyntax.missingToken(.identifier("")),
      semicolon?.data.raw ?? RawSyntax.missingToken(.semicolon),
    ], .present))
    return BreakStmtSyntax(root: data, data: data)
  }

  public static func makeBlankBreakStmt() -> BreakStmtSyntax {
    let data = SyntaxData(raw: .node(.breakStmt, [
      RawSyntax.missingToken(.breakKeyword),
      RawSyntax.missingToken(.identifier("")),
      RawSyntax.missingToken(.semicolon),
    ], .present))
    return BreakStmtSyntax(root: data, data: data)
  }
  public static func makeCodeBlock(openBrace: TokenSyntax, statments: StmtListSyntax, closeBrace: TokenSyntax) -> CodeBlockSyntax {
    let data = SyntaxData(raw: .node(.codeBlock, [
      openBrace.data.raw,
      statments.data.raw,
      closeBrace.data.raw,
    ], .present))
    return CodeBlockSyntax(root: data, data: data)
  }

  public static func makeBlankCodeBlock() -> CodeBlockSyntax {
    let data = SyntaxData(raw: .node(.codeBlock, [
      RawSyntax.missingToken(.leftBrace),
      RawSyntax.missing(.stmtList),
      RawSyntax.missingToken(.rightBrace),
    ], .present))
    return CodeBlockSyntax(root: data, data: data)
  }
  public static func makeCaseItemList(
    _ elements: [CaseItemSyntax]) -> CaseItemListSyntax {
    let data = SyntaxData(raw: .node(.caseItemList,
                                     elements.map { $0.data.raw }, .present))
    return CaseItemListSyntax(root: data, data: data)
  }

  public static func makeBlankCaseItemList() -> CaseItemListSyntax {
    let data = SyntaxData(raw: .node(.caseItemList, [
    ], .present))
    return CaseItemListSyntax(root: data, data: data)
  }
  public static func makeCondition(condition: Syntax, trailingComma: TokenSyntax?) -> ConditionSyntax {
    let data = SyntaxData(raw: .node(.condition, [
      condition.data.raw,
      trailingComma?.data.raw ?? RawSyntax.missingToken(.comma),
    ], .present))
    return ConditionSyntax(root: data, data: data)
  }

  public static func makeBlankCondition() -> ConditionSyntax {
    let data = SyntaxData(raw: .node(.condition, [
      RawSyntax.missing(.unknown),
      RawSyntax.missingToken(.comma),
    ], .present))
    return ConditionSyntax(root: data, data: data)
  }
  public static func makeConditionList(
    _ elements: [ConditionSyntax]) -> ConditionListSyntax {
    let data = SyntaxData(raw: .node(.conditionList,
                                     elements.map { $0.data.raw }, .present))
    return ConditionListSyntax(root: data, data: data)
  }

  public static func makeBlankConditionList() -> ConditionListSyntax {
    let data = SyntaxData(raw: .node(.conditionList, [
    ], .present))
    return ConditionListSyntax(root: data, data: data)
  }
  public static func makeDeclarationStmt(declaration: DeclSyntax, semicolon: TokenSyntax?) -> DeclarationStmtSyntax {
    let data = SyntaxData(raw: .node(.declarationStmt, [
      declaration.data.raw,
      semicolon?.data.raw ?? RawSyntax.missingToken(.semicolon),
    ], .present))
    return DeclarationStmtSyntax(root: data, data: data)
  }

  public static func makeBlankDeclarationStmt() -> DeclarationStmtSyntax {
    let data = SyntaxData(raw: .node(.declarationStmt, [
      RawSyntax.missing(.decl),
      RawSyntax.missingToken(.semicolon),
    ], .present))
    return DeclarationStmtSyntax(root: data, data: data)
  }
  public static func makeThrowStmt(throwKeyword: TokenSyntax, expression: ExprSyntax, semicolon: TokenSyntax?) -> ThrowStmtSyntax {
    let data = SyntaxData(raw: .node(.throwStmt, [
      throwKeyword.data.raw,
      expression.data.raw,
      semicolon?.data.raw ?? RawSyntax.missingToken(.semicolon),
    ], .present))
    return ThrowStmtSyntax(root: data, data: data)
  }

  public static func makeBlankThrowStmt() -> ThrowStmtSyntax {
    let data = SyntaxData(raw: .node(.throwStmt, [
      RawSyntax.missingToken(.throwKeyword),
      RawSyntax.missing(.expr),
      RawSyntax.missingToken(.semicolon),
    ], .present))
    return ThrowStmtSyntax(root: data, data: data)
  }
  public static func makeIfStmt(labelName: TokenSyntax?, labelColon: TokenSyntax?, ifKeyword: TokenSyntax, conditions: ConditionListSyntax, body: CodeBlockSyntax, elseClause: Syntax?, semicolon: TokenSyntax?) -> IfStmtSyntax {
    let data = SyntaxData(raw: .node(.ifStmt, [
      labelName?.data.raw ?? RawSyntax.missingToken(.identifier("")),
      labelColon?.data.raw ?? RawSyntax.missingToken(.colon),
      ifKeyword.data.raw,
      conditions.data.raw,
      body.data.raw,
      elseClause?.data.raw ?? RawSyntax.missing(.unknown),
      semicolon?.data.raw ?? RawSyntax.missingToken(.semicolon),
    ], .present))
    return IfStmtSyntax(root: data, data: data)
  }

  public static func makeBlankIfStmt() -> IfStmtSyntax {
    let data = SyntaxData(raw: .node(.ifStmt, [
      RawSyntax.missingToken(.identifier("")),
      RawSyntax.missingToken(.colon),
      RawSyntax.missingToken(.ifKeyword),
      RawSyntax.missing(.conditionList),
      RawSyntax.missing(.codeBlock),
      RawSyntax.missing(.unknown),
      RawSyntax.missingToken(.semicolon),
    ], .present))
    return IfStmtSyntax(root: data, data: data)
  }
  public static func makeElseIfContinuation(ifStatement: IfStmtSyntax) -> ElseIfContinuationSyntax {
    let data = SyntaxData(raw: .node(.elseIfContinuation, [
      ifStatement.data.raw,
    ], .present))
    return ElseIfContinuationSyntax(root: data, data: data)
  }

  public static func makeBlankElseIfContinuation() -> ElseIfContinuationSyntax {
    let data = SyntaxData(raw: .node(.elseIfContinuation, [
      RawSyntax.missing(.ifStmt),
    ], .present))
    return ElseIfContinuationSyntax(root: data, data: data)
  }
  public static func makeElseBlock(elseKeyword: TokenSyntax, body: CodeBlockSyntax, semicolon: TokenSyntax?) -> ElseBlockSyntax {
    let data = SyntaxData(raw: .node(.elseBlock, [
      elseKeyword.data.raw,
      body.data.raw,
      semicolon?.data.raw ?? RawSyntax.missingToken(.semicolon),
    ], .present))
    return ElseBlockSyntax(root: data, data: data)
  }

  public static func makeBlankElseBlock() -> ElseBlockSyntax {
    let data = SyntaxData(raw: .node(.elseBlock, [
      RawSyntax.missingToken(.elseKeyword),
      RawSyntax.missing(.codeBlock),
      RawSyntax.missingToken(.semicolon),
    ], .present))
    return ElseBlockSyntax(root: data, data: data)
  }
  public static func makeStmtList(
    _ elements: [StmtSyntax]) -> StmtListSyntax {
    let data = SyntaxData(raw: .node(.stmtList,
                                     elements.map { $0.data.raw }, .present))
    return StmtListSyntax(root: data, data: data)
  }

  public static func makeBlankStmtList() -> StmtListSyntax {
    let data = SyntaxData(raw: .node(.stmtList, [
    ], .present))
    return StmtListSyntax(root: data, data: data)
  }
  public static func makeSwitchCase(label: Syntax, body: StmtListSyntax) -> SwitchCaseSyntax {
    let data = SyntaxData(raw: .node(.switchCase, [
      label.data.raw,
      body.data.raw,
    ], .present))
    return SwitchCaseSyntax(root: data, data: data)
  }

  public static func makeBlankSwitchCase() -> SwitchCaseSyntax {
    let data = SyntaxData(raw: .node(.switchCase, [
      RawSyntax.missing(.unknown),
      RawSyntax.missing(.stmtList),
    ], .present))
    return SwitchCaseSyntax(root: data, data: data)
  }
  public static func makeSwitchDefaultLabel(defaultKeyword: TokenSyntax, colon: TokenSyntax) -> SwitchDefaultLabelSyntax {
    let data = SyntaxData(raw: .node(.switchDefaultLabel, [
      defaultKeyword.data.raw,
      colon.data.raw,
    ], .present))
    return SwitchDefaultLabelSyntax(root: data, data: data)
  }

  public static func makeBlankSwitchDefaultLabel() -> SwitchDefaultLabelSyntax {
    let data = SyntaxData(raw: .node(.switchDefaultLabel, [
      RawSyntax.missingToken(.defaultKeyword),
      RawSyntax.missingToken(.colon),
    ], .present))
    return SwitchDefaultLabelSyntax(root: data, data: data)
  }
  public static func makeCaseItem(pattern: PatternSyntax, whereClause: WhereClauseSyntax?, comma: TokenSyntax?) -> CaseItemSyntax {
    let data = SyntaxData(raw: .node(.caseItem, [
      pattern.data.raw,
      whereClause?.data.raw ?? RawSyntax.missing(.whereClause),
      comma?.data.raw ?? RawSyntax.missingToken(.comma),
    ], .present))
    return CaseItemSyntax(root: data, data: data)
  }

  public static func makeBlankCaseItem() -> CaseItemSyntax {
    let data = SyntaxData(raw: .node(.caseItem, [
      RawSyntax.missing(.pattern),
      RawSyntax.missing(.whereClause),
      RawSyntax.missingToken(.comma),
    ], .present))
    return CaseItemSyntax(root: data, data: data)
  }
  public static func makeSwitchCaseLabel(caseKeyword: TokenSyntax, caseItems: CaseItemListSyntax, colon: TokenSyntax) -> SwitchCaseLabelSyntax {
    let data = SyntaxData(raw: .node(.switchCaseLabel, [
      caseKeyword.data.raw,
      caseItems.data.raw,
      colon.data.raw,
    ], .present))
    return SwitchCaseLabelSyntax(root: data, data: data)
  }

  public static func makeBlankSwitchCaseLabel() -> SwitchCaseLabelSyntax {
    let data = SyntaxData(raw: .node(.switchCaseLabel, [
      RawSyntax.missingToken(.caseKeyword),
      RawSyntax.missing(.caseItemList),
      RawSyntax.missingToken(.colon),
    ], .present))
    return SwitchCaseLabelSyntax(root: data, data: data)
  }
  public static func makeCatchClause(catchKeyword: TokenSyntax, pattern: PatternSyntax?, whereClause: WhereClauseSyntax?, body: CodeBlockSyntax) -> CatchClauseSyntax {
    let data = SyntaxData(raw: .node(.catchClause, [
      catchKeyword.data.raw,
      pattern?.data.raw ?? RawSyntax.missing(.pattern),
      whereClause?.data.raw ?? RawSyntax.missing(.whereClause),
      body.data.raw,
    ], .present))
    return CatchClauseSyntax(root: data, data: data)
  }

  public static func makeBlankCatchClause() -> CatchClauseSyntax {
    let data = SyntaxData(raw: .node(.catchClause, [
      RawSyntax.missingToken(.catchKeyword),
      RawSyntax.missing(.pattern),
      RawSyntax.missing(.whereClause),
      RawSyntax.missing(.codeBlock),
    ], .present))
    return CatchClauseSyntax(root: data, data: data)
  }
  public static func makeGenericWhereClause(whereKeyword: TokenSyntax, requirementList: GenericRequirementListSyntax) -> GenericWhereClauseSyntax {
    let data = SyntaxData(raw: .node(.genericWhereClause, [
      whereKeyword.data.raw,
      requirementList.data.raw,
    ], .present))
    return GenericWhereClauseSyntax(root: data, data: data)
  }

  public static func makeBlankGenericWhereClause() -> GenericWhereClauseSyntax {
    let data = SyntaxData(raw: .node(.genericWhereClause, [
      RawSyntax.missingToken(.whereKeyword),
      RawSyntax.missing(.genericRequirementList),
    ], .present))
    return GenericWhereClauseSyntax(root: data, data: data)
  }
  public static func makeGenericRequirementList(
    _ elements: [Syntax]) -> GenericRequirementListSyntax {
    let data = SyntaxData(raw: .node(.genericRequirementList,
                                     elements.map { $0.data.raw }, .present))
    return GenericRequirementListSyntax(root: data, data: data)
  }

  public static func makeBlankGenericRequirementList() -> GenericRequirementListSyntax {
    let data = SyntaxData(raw: .node(.genericRequirementList, [
    ], .present))
    return GenericRequirementListSyntax(root: data, data: data)
  }
  public static func makeSameTypeRequirement(leftTypeIdentifier: TypeSyntax, equalityToken: TokenSyntax, rightTypeIdentifier: TypeSyntax, trailingComma: TokenSyntax?) -> SameTypeRequirementSyntax {
    let data = SyntaxData(raw: .node(.sameTypeRequirement, [
      leftTypeIdentifier.data.raw,
      equalityToken.data.raw,
      rightTypeIdentifier.data.raw,
      trailingComma?.data.raw ?? RawSyntax.missingToken(.comma),
    ], .present))
    return SameTypeRequirementSyntax(root: data, data: data)
  }

  public static func makeBlankSameTypeRequirement() -> SameTypeRequirementSyntax {
    let data = SyntaxData(raw: .node(.sameTypeRequirement, [
      RawSyntax.missing(.type),
      RawSyntax.missingToken(.spacedBinaryOperator("")),
      RawSyntax.missing(.type),
      RawSyntax.missingToken(.comma),
    ], .present))
    return SameTypeRequirementSyntax(root: data, data: data)
  }
  public static func makeGenericParameterList(
    _ elements: [GenericParameterSyntax]) -> GenericParameterListSyntax {
    let data = SyntaxData(raw: .node(.genericParameterList,
                                     elements.map { $0.data.raw }, .present))
    return GenericParameterListSyntax(root: data, data: data)
  }

  public static func makeBlankGenericParameterList() -> GenericParameterListSyntax {
    let data = SyntaxData(raw: .node(.genericParameterList, [
    ], .present))
    return GenericParameterListSyntax(root: data, data: data)
  }
  public static func makeGenericParameter(name: TokenSyntax, colon: TokenSyntax?, inheritedType: TypeSyntax?, trailingComma: TokenSyntax?) -> GenericParameterSyntax {
    let data = SyntaxData(raw: .node(.genericParameter, [
      name.data.raw,
      colon?.data.raw ?? RawSyntax.missingToken(.colon),
      inheritedType?.data.raw ?? RawSyntax.missing(.type),
      trailingComma?.data.raw ?? RawSyntax.missingToken(.comma),
    ], .present))
    return GenericParameterSyntax(root: data, data: data)
  }

  public static func makeBlankGenericParameter() -> GenericParameterSyntax {
    let data = SyntaxData(raw: .node(.genericParameter, [
      RawSyntax.missingToken(.identifier("")),
      RawSyntax.missingToken(.colon),
      RawSyntax.missing(.type),
      RawSyntax.missingToken(.comma),
    ], .present))
    return GenericParameterSyntax(root: data, data: data)
  }
  public static func makeGenericParameterClause(leftAngleBracket: TokenSyntax, genericParameterList: GenericParameterListSyntax, rightAngleBracket: TokenSyntax) -> GenericParameterClauseSyntax {
    let data = SyntaxData(raw: .node(.genericParameterClause, [
      leftAngleBracket.data.raw,
      genericParameterList.data.raw,
      rightAngleBracket.data.raw,
    ], .present))
    return GenericParameterClauseSyntax(root: data, data: data)
  }

  public static func makeBlankGenericParameterClause() -> GenericParameterClauseSyntax {
    let data = SyntaxData(raw: .node(.genericParameterClause, [
      RawSyntax.missingToken(.leftAngle),
      RawSyntax.missing(.genericParameterList),
      RawSyntax.missingToken(.rightAngle),
    ], .present))
    return GenericParameterClauseSyntax(root: data, data: data)
  }
  public static func makeConformanceRequirement(leftTypeIdentifier: TypeSyntax, colon: TokenSyntax, rightTypeIdentifier: TypeSyntax, trailingComma: TokenSyntax?) -> ConformanceRequirementSyntax {
    let data = SyntaxData(raw: .node(.conformanceRequirement, [
      leftTypeIdentifier.data.raw,
      colon.data.raw,
      rightTypeIdentifier.data.raw,
      trailingComma?.data.raw ?? RawSyntax.missingToken(.comma),
    ], .present))
    return ConformanceRequirementSyntax(root: data, data: data)
  }

  public static func makeBlankConformanceRequirement() -> ConformanceRequirementSyntax {
    let data = SyntaxData(raw: .node(.conformanceRequirement, [
      RawSyntax.missing(.type),
      RawSyntax.missingToken(.colon),
      RawSyntax.missing(.type),
      RawSyntax.missingToken(.comma),
    ], .present))
    return ConformanceRequirementSyntax(root: data, data: data)
  }
  public static func makeSimpleTypeIdentifier(name: TokenSyntax, genericArgumentClause: GenericArgumentClauseSyntax?) -> SimpleTypeIdentifierSyntax {
    let data = SyntaxData(raw: .node(.simpleTypeIdentifier, [
      name.data.raw,
      genericArgumentClause?.data.raw ?? RawSyntax.missing(.genericArgumentClause),
    ], .present))
    return SimpleTypeIdentifierSyntax(root: data, data: data)
  }

  public static func makeBlankSimpleTypeIdentifier() -> SimpleTypeIdentifierSyntax {
    let data = SyntaxData(raw: .node(.simpleTypeIdentifier, [
      RawSyntax.missingToken(.identifier("")),
      RawSyntax.missing(.genericArgumentClause),
    ], .present))
    return SimpleTypeIdentifierSyntax(root: data, data: data)
  }
  public static func makeMemberTypeIdentifier(baseType: TypeSyntax, period: TokenSyntax, name: TokenSyntax, genericArgumentClause: GenericArgumentClauseSyntax?) -> MemberTypeIdentifierSyntax {
    let data = SyntaxData(raw: .node(.memberTypeIdentifier, [
      baseType.data.raw,
      period.data.raw,
      name.data.raw,
      genericArgumentClause?.data.raw ?? RawSyntax.missing(.genericArgumentClause),
    ], .present))
    return MemberTypeIdentifierSyntax(root: data, data: data)
  }

  public static func makeBlankMemberTypeIdentifier() -> MemberTypeIdentifierSyntax {
    let data = SyntaxData(raw: .node(.memberTypeIdentifier, [
      RawSyntax.missing(.type),
      RawSyntax.missingToken(.period),
      RawSyntax.missingToken(.identifier("")),
      RawSyntax.missing(.genericArgumentClause),
    ], .present))
    return MemberTypeIdentifierSyntax(root: data, data: data)
  }
  public static func makeArrayType(leftSquareBracket: TokenSyntax, elementType: TypeSyntax, rightSquareBracket: TokenSyntax) -> ArrayTypeSyntax {
    let data = SyntaxData(raw: .node(.arrayType, [
      leftSquareBracket.data.raw,
      elementType.data.raw,
      rightSquareBracket.data.raw,
    ], .present))
    return ArrayTypeSyntax(root: data, data: data)
  }

  public static func makeBlankArrayType() -> ArrayTypeSyntax {
    let data = SyntaxData(raw: .node(.arrayType, [
      RawSyntax.missingToken(.leftSquareBracket),
      RawSyntax.missing(.type),
      RawSyntax.missingToken(.rightSquareBracket),
    ], .present))
    return ArrayTypeSyntax(root: data, data: data)
  }
  public static func makeDictionaryType(leftSquareBracket: TokenSyntax, keyType: TypeSyntax, colon: TokenSyntax, valueType: TypeSyntax, rightSquareBracket: TokenSyntax) -> DictionaryTypeSyntax {
    let data = SyntaxData(raw: .node(.dictionaryType, [
      leftSquareBracket.data.raw,
      keyType.data.raw,
      colon.data.raw,
      valueType.data.raw,
      rightSquareBracket.data.raw,
    ], .present))
    return DictionaryTypeSyntax(root: data, data: data)
  }

  public static func makeBlankDictionaryType() -> DictionaryTypeSyntax {
    let data = SyntaxData(raw: .node(.dictionaryType, [
      RawSyntax.missingToken(.leftSquareBracket),
      RawSyntax.missing(.type),
      RawSyntax.missingToken(.colon),
      RawSyntax.missing(.type),
      RawSyntax.missingToken(.rightSquareBracket),
    ], .present))
    return DictionaryTypeSyntax(root: data, data: data)
  }
  public static func makeMetatypeType(baseType: TypeSyntax, period: TokenSyntax, typeOrProtocol: TokenSyntax) -> MetatypeTypeSyntax {
    let data = SyntaxData(raw: .node(.metatypeType, [
      baseType.data.raw,
      period.data.raw,
      typeOrProtocol.data.raw,
    ], .present))
    return MetatypeTypeSyntax(root: data, data: data)
  }

  public static func makeBlankMetatypeType() -> MetatypeTypeSyntax {
    let data = SyntaxData(raw: .node(.metatypeType, [
      RawSyntax.missing(.type),
      RawSyntax.missingToken(.period),
      RawSyntax.missingToken(.identifier("")),
    ], .present))
    return MetatypeTypeSyntax(root: data, data: data)
  }
  public static func makeOptionalType(wrappedType: TypeSyntax, questionMark: TokenSyntax) -> OptionalTypeSyntax {
    let data = SyntaxData(raw: .node(.optionalType, [
      wrappedType.data.raw,
      questionMark.data.raw,
    ], .present))
    return OptionalTypeSyntax(root: data, data: data)
  }

  public static func makeBlankOptionalType() -> OptionalTypeSyntax {
    let data = SyntaxData(raw: .node(.optionalType, [
      RawSyntax.missing(.type),
      RawSyntax.missingToken(.postfixQuestionMark),
    ], .present))
    return OptionalTypeSyntax(root: data, data: data)
  }
  public static func makeImplicitlyUnwrappedOptionalType(wrappedType: TypeSyntax, exclamationMark: TokenSyntax) -> ImplicitlyUnwrappedOptionalTypeSyntax {
    let data = SyntaxData(raw: .node(.implicitlyUnwrappedOptionalType, [
      wrappedType.data.raw,
      exclamationMark.data.raw,
    ], .present))
    return ImplicitlyUnwrappedOptionalTypeSyntax(root: data, data: data)
  }

  public static func makeBlankImplicitlyUnwrappedOptionalType() -> ImplicitlyUnwrappedOptionalTypeSyntax {
    let data = SyntaxData(raw: .node(.implicitlyUnwrappedOptionalType, [
      RawSyntax.missing(.type),
      RawSyntax.missingToken(.exclamationMark),
    ], .present))
    return ImplicitlyUnwrappedOptionalTypeSyntax(root: data, data: data)
  }
  public static func makeFunctionType(typeAttributes: AttributeListSyntax, leftParen: TokenSyntax, argumentList: FunctionTypeArgumentListSyntax, rightParen: TokenSyntax, throwsOrRethrowsKeyword: TokenSyntax?, arrow: TokenSyntax?, returnType: TypeSyntax?) -> FunctionTypeSyntax {
    let data = SyntaxData(raw: .node(.functionType, [
      typeAttributes.data.raw,
      leftParen.data.raw,
      argumentList.data.raw,
      rightParen.data.raw,
      throwsOrRethrowsKeyword?.data.raw ?? RawSyntax.missingToken(.throwsKeyword),
      arrow?.data.raw ?? RawSyntax.missingToken(.arrow),
      returnType?.data.raw ?? RawSyntax.missing(.type),
    ], .present))
    return FunctionTypeSyntax(root: data, data: data)
  }

  public static func makeBlankFunctionType() -> FunctionTypeSyntax {
    let data = SyntaxData(raw: .node(.functionType, [
      RawSyntax.missing(.attributeList),
      RawSyntax.missingToken(.leftParen),
      RawSyntax.missing(.functionTypeArgumentList),
      RawSyntax.missingToken(.rightParen),
      RawSyntax.missingToken(.throwsKeyword),
      RawSyntax.missingToken(.arrow),
      RawSyntax.missing(.type),
    ], .present))
    return FunctionTypeSyntax(root: data, data: data)
  }
  public static func makeTupleType(leftParen: TokenSyntax, elements: TupleTypeElementListSyntax, rightParen: TokenSyntax) -> TupleTypeSyntax {
    let data = SyntaxData(raw: .node(.tupleType, [
      leftParen.data.raw,
      elements.data.raw,
      rightParen.data.raw,
    ], .present))
    return TupleTypeSyntax(root: data, data: data)
  }

  public static func makeBlankTupleType() -> TupleTypeSyntax {
    let data = SyntaxData(raw: .node(.tupleType, [
      RawSyntax.missingToken(.leftParen),
      RawSyntax.missing(.tupleTypeElementList),
      RawSyntax.missingToken(.rightParen),
    ], .present))
    return TupleTypeSyntax(root: data, data: data)
  }
  public static func makeTupleTypeElement(label: TokenSyntax?, colon: TokenSyntax?, typeAnnotation: TypeAnnotationSyntax, comma: TokenSyntax?) -> TupleTypeElementSyntax {
    let data = SyntaxData(raw: .node(.tupleTypeElement, [
      label?.data.raw ?? RawSyntax.missingToken(.identifier("")),
      colon?.data.raw ?? RawSyntax.missingToken(.colon),
      typeAnnotation.data.raw,
      comma?.data.raw ?? RawSyntax.missingToken(.comma),
    ], .present))
    return TupleTypeElementSyntax(root: data, data: data)
  }

  public static func makeBlankTupleTypeElement() -> TupleTypeElementSyntax {
    let data = SyntaxData(raw: .node(.tupleTypeElement, [
      RawSyntax.missingToken(.identifier("")),
      RawSyntax.missingToken(.colon),
      RawSyntax.missing(.typeAnnotation),
      RawSyntax.missingToken(.comma),
    ], .present))
    return TupleTypeElementSyntax(root: data, data: data)
  }
  public static func makeTypeAnnotation(attributes: AttributeListSyntax, inOutKeyword: TokenSyntax?, type: TypeSyntax) -> TypeAnnotationSyntax {
    let data = SyntaxData(raw: .node(.typeAnnotation, [
      attributes.data.raw,
      inOutKeyword?.data.raw ?? RawSyntax.missingToken(.inoutKeyword),
      type.data.raw,
    ], .present))
    return TypeAnnotationSyntax(root: data, data: data)
  }

  public static func makeBlankTypeAnnotation() -> TypeAnnotationSyntax {
    let data = SyntaxData(raw: .node(.typeAnnotation, [
      RawSyntax.missing(.attributeList),
      RawSyntax.missingToken(.inoutKeyword),
      RawSyntax.missing(.type),
    ], .present))
    return TypeAnnotationSyntax(root: data, data: data)
  }
  public static func makeProtocolCompositionElementList(
    _ elements: [ProtocolCompositionElementSyntax]) -> ProtocolCompositionElementListSyntax {
    let data = SyntaxData(raw: .node(.protocolCompositionElementList,
                                     elements.map { $0.data.raw }, .present))
    return ProtocolCompositionElementListSyntax(root: data, data: data)
  }

  public static func makeBlankProtocolCompositionElementList() -> ProtocolCompositionElementListSyntax {
    let data = SyntaxData(raw: .node(.protocolCompositionElementList, [
    ], .present))
    return ProtocolCompositionElementListSyntax(root: data, data: data)
  }
  public static func makeTupleTypeElementList(
    _ elements: [TupleTypeElementSyntax]) -> TupleTypeElementListSyntax {
    let data = SyntaxData(raw: .node(.tupleTypeElementList,
                                     elements.map { $0.data.raw }, .present))
    return TupleTypeElementListSyntax(root: data, data: data)
  }

  public static func makeBlankTupleTypeElementList() -> TupleTypeElementListSyntax {
    let data = SyntaxData(raw: .node(.tupleTypeElementList, [
    ], .present))
    return TupleTypeElementListSyntax(root: data, data: data)
  }
  public static func makeProtocolCompositionElement(protocolType: TypeSyntax, ampersand: TokenSyntax?) -> ProtocolCompositionElementSyntax {
    let data = SyntaxData(raw: .node(.protocolCompositionElement, [
      protocolType.data.raw,
      ampersand?.data.raw ?? RawSyntax.missingToken(.ampersand),
    ], .present))
    return ProtocolCompositionElementSyntax(root: data, data: data)
  }

  public static func makeBlankProtocolCompositionElement() -> ProtocolCompositionElementSyntax {
    let data = SyntaxData(raw: .node(.protocolCompositionElement, [
      RawSyntax.missing(.type),
      RawSyntax.missingToken(.ampersand),
    ], .present))
    return ProtocolCompositionElementSyntax(root: data, data: data)
  }
  public static func makeGenericArgumentList(
    _ elements: [GenericArgumentSyntax]) -> GenericArgumentListSyntax {
    let data = SyntaxData(raw: .node(.genericArgumentList,
                                     elements.map { $0.data.raw }, .present))
    return GenericArgumentListSyntax(root: data, data: data)
  }

  public static func makeBlankGenericArgumentList() -> GenericArgumentListSyntax {
    let data = SyntaxData(raw: .node(.genericArgumentList, [
    ], .present))
    return GenericArgumentListSyntax(root: data, data: data)
  }
  public static func makeGenericArgument(argumentType: TypeSyntax, trailingComma: TokenSyntax?) -> GenericArgumentSyntax {
    let data = SyntaxData(raw: .node(.genericArgument, [
      argumentType.data.raw,
      trailingComma?.data.raw ?? RawSyntax.missingToken(.comma),
    ], .present))
    return GenericArgumentSyntax(root: data, data: data)
  }

  public static func makeBlankGenericArgument() -> GenericArgumentSyntax {
    let data = SyntaxData(raw: .node(.genericArgument, [
      RawSyntax.missing(.type),
      RawSyntax.missingToken(.comma),
    ], .present))
    return GenericArgumentSyntax(root: data, data: data)
  }
  public static func makeGenericArgumentClause(leftAngleBracket: TokenSyntax, arguments: GenericArgumentListSyntax, rightAngleBracket: TokenSyntax) -> GenericArgumentClauseSyntax {
    let data = SyntaxData(raw: .node(.genericArgumentClause, [
      leftAngleBracket.data.raw,
      arguments.data.raw,
      rightAngleBracket.data.raw,
    ], .present))
    return GenericArgumentClauseSyntax(root: data, data: data)
  }

  public static func makeBlankGenericArgumentClause() -> GenericArgumentClauseSyntax {
    let data = SyntaxData(raw: .node(.genericArgumentClause, [
      RawSyntax.missingToken(.leftAngle),
      RawSyntax.missing(.genericArgumentList),
      RawSyntax.missingToken(.rightAngle),
    ], .present))
    return GenericArgumentClauseSyntax(root: data, data: data)
  }
  public static func makeFunctionTypeArgument(externalName: TokenSyntax?, localName: TokenSyntax?, colon: TokenSyntax?, typeAnnotation: TypeAnnotationSyntax, trailingComma: TokenSyntax?) -> FunctionTypeArgumentSyntax {
    let data = SyntaxData(raw: .node(.functionTypeArgument, [
      externalName?.data.raw ?? RawSyntax.missingToken(.identifier("")),
      localName?.data.raw ?? RawSyntax.missingToken(.identifier("")),
      colon?.data.raw ?? RawSyntax.missingToken(.colon),
      typeAnnotation.data.raw,
      trailingComma?.data.raw ?? RawSyntax.missingToken(.comma),
    ], .present))
    return FunctionTypeArgumentSyntax(root: data, data: data)
  }

  public static func makeBlankFunctionTypeArgument() -> FunctionTypeArgumentSyntax {
    let data = SyntaxData(raw: .node(.functionTypeArgument, [
      RawSyntax.missingToken(.identifier("")),
      RawSyntax.missingToken(.identifier("")),
      RawSyntax.missingToken(.colon),
      RawSyntax.missing(.typeAnnotation),
      RawSyntax.missingToken(.comma),
    ], .present))
    return FunctionTypeArgumentSyntax(root: data, data: data)
  }
  public static func makeFunctionTypeArgumentList(
    _ elements: [FunctionTypeArgumentSyntax]) -> FunctionTypeArgumentListSyntax {
    let data = SyntaxData(raw: .node(.functionTypeArgumentList,
                                     elements.map { $0.data.raw }, .present))
    return FunctionTypeArgumentListSyntax(root: data, data: data)
  }

  public static func makeBlankFunctionTypeArgumentList() -> FunctionTypeArgumentListSyntax {
    let data = SyntaxData(raw: .node(.functionTypeArgumentList, [
    ], .present))
    return FunctionTypeArgumentListSyntax(root: data, data: data)
  }
  public static func makeProtocolCompositionType(elements: ProtocolCompositionElementListSyntax) -> ProtocolCompositionTypeSyntax {
    let data = SyntaxData(raw: .node(.protocolCompositionType, [
      elements.data.raw,
    ], .present))
    return ProtocolCompositionTypeSyntax(root: data, data: data)
  }

  public static func makeBlankProtocolCompositionType() -> ProtocolCompositionTypeSyntax {
    let data = SyntaxData(raw: .node(.protocolCompositionType, [
      RawSyntax.missing(.protocolCompositionElementList),
    ], .present))
    return ProtocolCompositionTypeSyntax(root: data, data: data)
  }
  public static func makeEnumCasePattern(type: TypeSyntax?, period: TokenSyntax, caseName: TokenSyntax, associatedTuple: TuplePatternSyntax?) -> EnumCasePatternSyntax {
    let data = SyntaxData(raw: .node(.enumCasePattern, [
      type?.data.raw ?? RawSyntax.missing(.type),
      period.data.raw,
      caseName.data.raw,
      associatedTuple?.data.raw ?? RawSyntax.missing(.tuplePattern),
    ], .present))
    return EnumCasePatternSyntax(root: data, data: data)
  }

  public static func makeBlankEnumCasePattern() -> EnumCasePatternSyntax {
    let data = SyntaxData(raw: .node(.enumCasePattern, [
      RawSyntax.missing(.type),
      RawSyntax.missingToken(.period),
      RawSyntax.missingToken(.identifier("")),
      RawSyntax.missing(.tuplePattern),
    ], .present))
    return EnumCasePatternSyntax(root: data, data: data)
  }
  public static func makeIsTypePattern(isKeyword: TokenSyntax, type: TypeSyntax) -> IsTypePatternSyntax {
    let data = SyntaxData(raw: .node(.isTypePattern, [
      isKeyword.data.raw,
      type.data.raw,
    ], .present))
    return IsTypePatternSyntax(root: data, data: data)
  }

  public static func makeBlankIsTypePattern() -> IsTypePatternSyntax {
    let data = SyntaxData(raw: .node(.isTypePattern, [
      RawSyntax.missingToken(.isKeyword),
      RawSyntax.missing(.type),
    ], .present))
    return IsTypePatternSyntax(root: data, data: data)
  }
  public static func makeOptionalPattern(identifier: TokenSyntax, questionMark: TokenSyntax) -> OptionalPatternSyntax {
    let data = SyntaxData(raw: .node(.optionalPattern, [
      identifier.data.raw,
      questionMark.data.raw,
    ], .present))
    return OptionalPatternSyntax(root: data, data: data)
  }

  public static func makeBlankOptionalPattern() -> OptionalPatternSyntax {
    let data = SyntaxData(raw: .node(.optionalPattern, [
      RawSyntax.missingToken(.identifier("")),
      RawSyntax.missingToken(.postfixQuestionMark),
    ], .present))
    return OptionalPatternSyntax(root: data, data: data)
  }
  public static func makeIdentifierPattern(identifier: TokenSyntax, typeAnnotation: TypeAnnotationSyntax?) -> IdentifierPatternSyntax {
    let data = SyntaxData(raw: .node(.identifierPattern, [
      identifier.data.raw,
      typeAnnotation?.data.raw ?? RawSyntax.missing(.typeAnnotation),
    ], .present))
    return IdentifierPatternSyntax(root: data, data: data)
  }

  public static func makeBlankIdentifierPattern() -> IdentifierPatternSyntax {
    let data = SyntaxData(raw: .node(.identifierPattern, [
      RawSyntax.missingToken(.identifier("")),
      RawSyntax.missing(.typeAnnotation),
    ], .present))
    return IdentifierPatternSyntax(root: data, data: data)
  }
  public static func makeAsTypePattern(pattern: PatternSyntax, asKeyword: TokenSyntax, type: TypeSyntax) -> AsTypePatternSyntax {
    let data = SyntaxData(raw: .node(.asTypePattern, [
      pattern.data.raw,
      asKeyword.data.raw,
      type.data.raw,
    ], .present))
    return AsTypePatternSyntax(root: data, data: data)
  }

  public static func makeBlankAsTypePattern() -> AsTypePatternSyntax {
    let data = SyntaxData(raw: .node(.asTypePattern, [
      RawSyntax.missing(.pattern),
      RawSyntax.missingToken(.asKeyword),
      RawSyntax.missing(.type),
    ], .present))
    return AsTypePatternSyntax(root: data, data: data)
  }
  public static func makeTuplePattern(openParen: TokenSyntax, elements: TuplePatternElementListSyntax, closeParen: TokenSyntax, typeAnnotation: TypeAnnotationSyntax?) -> TuplePatternSyntax {
    let data = SyntaxData(raw: .node(.tuplePattern, [
      openParen.data.raw,
      elements.data.raw,
      closeParen.data.raw,
      typeAnnotation?.data.raw ?? RawSyntax.missing(.typeAnnotation),
    ], .present))
    return TuplePatternSyntax(root: data, data: data)
  }

  public static func makeBlankTuplePattern() -> TuplePatternSyntax {
    let data = SyntaxData(raw: .node(.tuplePattern, [
      RawSyntax.missingToken(.leftParen),
      RawSyntax.missing(.tuplePatternElementList),
      RawSyntax.missingToken(.rightParen),
      RawSyntax.missing(.typeAnnotation),
    ], .present))
    return TuplePatternSyntax(root: data, data: data)
  }
  public static func makeWildcardPattern(wildcard: TokenSyntax, typeAnnotation: TypeAnnotationSyntax?) -> WildcardPatternSyntax {
    let data = SyntaxData(raw: .node(.wildcardPattern, [
      wildcard.data.raw,
      typeAnnotation?.data.raw ?? RawSyntax.missing(.typeAnnotation),
    ], .present))
    return WildcardPatternSyntax(root: data, data: data)
  }

  public static func makeBlankWildcardPattern() -> WildcardPatternSyntax {
    let data = SyntaxData(raw: .node(.wildcardPattern, [
      RawSyntax.missingToken(.wildcardKeyword),
      RawSyntax.missing(.typeAnnotation),
    ], .present))
    return WildcardPatternSyntax(root: data, data: data)
  }
  public static func makeTuplePatternElement(labelName: TokenSyntax?, labelColon: TokenSyntax?, pattern: PatternSyntax, comma: TokenSyntax?) -> TuplePatternElementSyntax {
    let data = SyntaxData(raw: .node(.tuplePatternElement, [
      labelName?.data.raw ?? RawSyntax.missingToken(.identifier("")),
      labelColon?.data.raw ?? RawSyntax.missingToken(.colon),
      pattern.data.raw,
      comma?.data.raw ?? RawSyntax.missingToken(.comma),
    ], .present))
    return TuplePatternElementSyntax(root: data, data: data)
  }

  public static func makeBlankTuplePatternElement() -> TuplePatternElementSyntax {
    let data = SyntaxData(raw: .node(.tuplePatternElement, [
      RawSyntax.missingToken(.identifier("")),
      RawSyntax.missingToken(.colon),
      RawSyntax.missing(.pattern),
      RawSyntax.missingToken(.comma),
    ], .present))
    return TuplePatternElementSyntax(root: data, data: data)
  }
  public static func makeExpressionPattern(expression: ExprSyntax) -> ExpressionPatternSyntax {
    let data = SyntaxData(raw: .node(.expressionPattern, [
      expression.data.raw,
    ], .present))
    return ExpressionPatternSyntax(root: data, data: data)
  }

  public static func makeBlankExpressionPattern() -> ExpressionPatternSyntax {
    let data = SyntaxData(raw: .node(.expressionPattern, [
      RawSyntax.missing(.expr),
    ], .present))
    return ExpressionPatternSyntax(root: data, data: data)
  }
  public static func makeTuplePatternElementList(
    _ elements: [TuplePatternElementSyntax]) -> TuplePatternElementListSyntax {
    let data = SyntaxData(raw: .node(.tuplePatternElementList,
                                     elements.map { $0.data.raw }, .present))
    return TuplePatternElementListSyntax(root: data, data: data)
  }

  public static func makeBlankTuplePatternElementList() -> TuplePatternElementListSyntax {
    let data = SyntaxData(raw: .node(.tuplePatternElementList, [
    ], .present))
    return TuplePatternElementListSyntax(root: data, data: data)
  }
  public static func makeValueBindingPattern(letOrVarKeyword: TokenSyntax, valuePattern: PatternSyntax) -> ValueBindingPatternSyntax {
    let data = SyntaxData(raw: .node(.valueBindingPattern, [
      letOrVarKeyword.data.raw,
      valuePattern.data.raw,
    ], .present))
    return ValueBindingPatternSyntax(root: data, data: data)
  }

  public static func makeBlankValueBindingPattern() -> ValueBindingPatternSyntax {
    let data = SyntaxData(raw: .node(.valueBindingPattern, [
      RawSyntax.missingToken(.letKeyword),
      RawSyntax.missing(.pattern),
    ], .present))
    return ValueBindingPatternSyntax(root: data, data: data)
  }

/// MARK: Token Creation APIs

  public static func makeAssociatedtypeKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.associatedtypeKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeClassKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.classKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeDeinitKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.deinitKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeEnumKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.enumKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeExtensionKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.extensionKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeFuncKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.funcKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeImportKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.importKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeInitKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.initKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeInoutKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.inoutKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeLetKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.letKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeOperatorKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.operatorKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePrecedencegroupKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.precedencegroupKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeProtocolKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.protocolKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeStructKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.structKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeSubscriptKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.subscriptKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeTypealiasKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.typealiasKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeVarKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.varKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeFileprivateKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.fileprivateKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeInternalKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.internalKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePrivateKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.privateKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePublicKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.publicKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeStaticKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.staticKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeDeferKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.deferKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeIfKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.ifKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeGuardKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.guardKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeDoKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.doKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeRepeatKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.repeatKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeElseKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.elseKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeForKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.forKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeInKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.inKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeWhileKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.whileKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeReturnKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.returnKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeBreakKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.breakKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeContinueKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.continueKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeFallthroughKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.fallthroughKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeSwitchKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.switchKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeCaseKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.caseKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeDefaultKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.defaultKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeWhereKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.whereKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeCatchKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.catchKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeAsKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.asKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeAnyKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.anyKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeFalseKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.falseKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeIsKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.isKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeNilKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.nilKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeRethrowsKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.rethrowsKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeSuperKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.superKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeSelfKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.selfKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeCapitalSelfKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.capitalSelfKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeThrowKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.throwKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeTrueKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.trueKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeTryKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.tryKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeThrowsKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.throwsKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func make__FILE__Keyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.__file__Keyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func make__LINE__Keyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.__line__Keyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func make__COLUMN__Keyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.__column__Keyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func make__FUNCTION__Keyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.__function__Keyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func make__DSO_HANDLE__Keyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.__dso_handle__Keyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeWildcardKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.wildcardKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundAvailableKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundAvailableKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundEndifKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundEndifKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundElseKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundElseKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundElseifKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundElseifKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundIfKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundIfKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundSourceLocationKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundSourceLocationKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundFileKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundFileKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundLineKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundLineKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundColumnKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundColumnKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePoundFunctionKeyword(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.poundFunctionKeyword, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeArrowToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.arrow, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeAtSignToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.atSign, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeColonToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.colon, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeSemicolonToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.semicolon, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeCommaToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.comma, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePeriodToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.period, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeEqualToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.equal, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePrefixPeriodToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.prefixPeriod, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeLeftParenToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.leftParen, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeRightParenToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.rightParen, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeLeftBraceToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.leftBrace, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeRightBraceToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.rightBrace, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeLeftSquareBracketToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.leftSquareBracket, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeRightSquareBracketToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.rightSquareBracket, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeLeftAngleToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.leftAngle, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeRightAngleToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.rightAngle, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeAmpersandToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.ampersand, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePostfixQuestionMarkToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.postfixQuestionMark, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeInfixQuestionMarkToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.infixQuestionMark, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeExclamationMarkToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.exclamationMark, presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeIdentifier(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.identifier(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeDollarIdentifier(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.dollarIdentifier(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeUnspacedBinaryOperator(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.unspacedBinaryOperator(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeSpacedBinaryOperator(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.spacedBinaryOperator(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePrefixOperator(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.prefixOperator(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makePostfixOperator(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.postfixOperator(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeIntegerLiteral(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.integerLiteral(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeFloatingLiteral(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.floatingLiteral(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }
  public static func makeStringLiteral(_ text: String,
    leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.stringLiteral(text), presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }

/// MARK: Convenience APIs

  public static func makeVoidTupleType() -> TupleTypeSyntax {
    return makeTupleType(leftParen: makeLeftParenToken(),
                         elements: makeBlankTupleTypeElementList(),
                         rightParen: makeRightParenToken())
  }

  public static func makeTupleTypeElement(label: TokenSyntax?,
    colon: TokenSyntax?, type: TypeSyntax,
    comma: TokenSyntax?) -> TupleTypeElementSyntax {
    let annotation = makeTypeAnnotation(attributes: makeBlankAttributeList(),
                                        inOutKeyword: nil,
                                        type: type)
    return makeTupleTypeElement(label: label, colon: colon, 
                                typeAnnotation: annotation,
                                comma: comma)
  }

  public static func makeTupleTypeElement(type: TypeSyntax,
    comma: TokenSyntax?) -> TupleTypeElementSyntax  {
    return makeTupleTypeElement(label: nil, colon: nil, 
                                type: type, comma: comma)
  }

  public static func makeGenericParameter(name: TokenSyntax,
      trailingComma: TokenSyntax) -> GenericParameterSyntax {
    return makeGenericParameter(name: name, colon: nil,
                                inheritedType: nil,
                                trailingComma: trailingComma)
  }

  public static func makeTypeIdentifier(_ name: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TypeSyntax {
    let identifier = makeIdentifier(name, leadingTrivia: leadingTrivia, 
                                    trailingTrivia: trailingTrivia)
    return makeSimpleTypeIdentifier(name: identifier,
                                    genericArgumentClause: nil)
  }

  public static func makeAnyTypeIdentifier(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TypeSyntax {
    return makeTypeIdentifier("Any", leadingTrivia: leadingTrivia, 
                              trailingTrivia: trailingTrivia)
  }

  public static func makeSelfTypeIdentifier(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TypeSyntax {
    return makeTypeIdentifier("Self", leadingTrivia: leadingTrivia, 
                              trailingTrivia: trailingTrivia)
  }

  public static func makeTypeToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeIdentifier("Type", leadingTrivia: leadingTrivia, 
                          trailingTrivia: trailingTrivia)
  }

  public static func makeProtocolToken(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeIdentifier("Protocol", leadingTrivia: leadingTrivia,
                          trailingTrivia: trailingTrivia)
  }

  public static func makeEqualityOperator(leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> TokenSyntax {
    return makeToken(.spacedBinaryOperator("=="),
                     presence: .present,
                     leadingTrivia: leadingTrivia,
                     trailingTrivia: trailingTrivia)
  }

  public static func makeStringLiteralExpr(_ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> StringLiteralExprSyntax {
    let literal = makeStringLiteral("\"\(text)\"", 
                                    leadingTrivia: leadingTrivia,
                                    trailingTrivia: trailingTrivia)
    return makeStringLiteralExpr(stringLiteral: literal)
  }

  public static func makeVariableExpr(_ text: String,
    leadingTrivia: Trivia = [],
    trailingTrivia: Trivia = []) -> SymbolicReferenceExprSyntax {
    let string = makeIdentifier(text,
      leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
    return makeSymbolicReferenceExpr(identifier: string,
                                     genericArgumentClause: nil)
  }
}
