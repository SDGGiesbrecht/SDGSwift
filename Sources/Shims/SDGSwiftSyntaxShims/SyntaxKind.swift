//// Automatically Generated From SyntaxKind.swift.gyb.
//// Do Not Edit Directly!
//===--------------- SyntaxKind.swift - Syntax Kind definitions -----------===//
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

import Foundation

/// Enumerates the known kinds of Syntax represented in the Syntax tree.
internal enum SyntaxKind: String, Codable {
  case token = "Token"
  case unknown = "Unknown"
  case decl = "Decl"
  case unknownDecl = "UnknownDecl"
  case expr = "Expr"
  case unknownExpr = "UnknownExpr"
  case stmt = "Stmt"
  case unknownStmt = "UnknownStmt"
  case type = "Type"
  case unknownType = "UnknownType"
  case pattern = "Pattern"
  case unknownPattern = "UnknownPattern"
  case inOutExpr = "InOutExpr"
  case poundColumnExpr = "PoundColumnExpr"
  case functionCallArgumentList = "FunctionCallArgumentList"
  case tupleElementList = "TupleElementList"
  case arrayElementList = "ArrayElementList"
  case dictionaryElementList = "DictionaryElementList"
  case tryOperator = "TryOperator"
  case identifierExpr = "IdentifierExpr"
  case nilLiteralExpr = "NilLiteralExpr"
  case discardAssignmentExpr = "DiscardAssignmentExpr"
  case assignmentExpr = "AssignmentExpr"
  case sequenceExpr = "SequenceExpr"
  case poundLineExpr = "PoundLineExpr"
  case poundFileExpr = "PoundFileExpr"
  case poundFunctionExpr = "PoundFunctionExpr"
  case symbolicReferenceExpr = "SymbolicReferenceExpr"
  case prefixOperatorExpr = "PrefixOperatorExpr"
  case binaryOperatorExpr = "BinaryOperatorExpr"
  case floatLiteralExpr = "FloatLiteralExpr"
  case functionCallExpr = "FunctionCallExpr"
  case tupleExpr = "TupleExpr"
  case arrayExpr = "ArrayExpr"
  case dictionaryExpr = "DictionaryExpr"
  case functionCallArgument = "FunctionCallArgument"
  case tupleElement = "TupleElement"
  case arrayElement = "ArrayElement"
  case dictionaryElement = "DictionaryElement"
  case integerLiteralExpr = "IntegerLiteralExpr"
  case stringLiteralExpr = "StringLiteralExpr"
  case booleanLiteralExpr = "BooleanLiteralExpr"
  case ternaryExpr = "TernaryExpr"
  case memberAccessExpr = "MemberAccessExpr"
  case isExpr = "IsExpr"
  case asExpr = "AsExpr"
  case typealiasDecl = "TypealiasDecl"
  case functionParameterList = "FunctionParameterList"
  case functionSignature = "FunctionSignature"
  case elseifDirectiveClause = "ElseifDirectiveClause"
  case ifConfigDecl = "IfConfigDecl"
  case declModifier = "DeclModifier"
  case typeInheritanceClause = "TypeInheritanceClause"
  case structDecl = "StructDecl"
  case memberDeclBlock = "MemberDeclBlock"
  case declList = "DeclList"
  case sourceFile = "SourceFile"
  case topLevelCodeDecl = "TopLevelCodeDecl"
  case functionParameter = "FunctionParameter"
  case modifierList = "ModifierList"
  case functionDecl = "FunctionDecl"
  case elseifDirectiveClauseList = "ElseifDirectiveClauseList"
  case elseDirectiveClause = "ElseDirectiveClause"
  case accessLevelModifier = "AccessLevelModifier"
  case tokenList = "TokenList"
  case attribute = "Attribute"
  case attributeList = "AttributeList"
  case continueStmt = "ContinueStmt"
  case whileStmt = "WhileStmt"
  case deferStmt = "DeferStmt"
  case expressionStmt = "ExpressionStmt"
  case switchCaseList = "SwitchCaseList"
  case repeatWhileStmt = "RepeatWhileStmt"
  case guardStmt = "GuardStmt"
  case exprList = "ExprList"
  case whereClause = "WhereClause"
  case forInStmt = "ForInStmt"
  case switchStmt = "SwitchStmt"
  case catchClauseList = "CatchClauseList"
  case doStmt = "DoStmt"
  case returnStmt = "ReturnStmt"
  case fallthroughStmt = "FallthroughStmt"
  case breakStmt = "BreakStmt"
  case codeBlock = "CodeBlock"
  case caseItemList = "CaseItemList"
  case condition = "Condition"
  case conditionList = "ConditionList"
  case declarationStmt = "DeclarationStmt"
  case throwStmt = "ThrowStmt"
  case ifStmt = "IfStmt"
  case elseIfContinuation = "ElseIfContinuation"
  case elseBlock = "ElseBlock"
  case stmtList = "StmtList"
  case switchCase = "SwitchCase"
  case switchDefaultLabel = "SwitchDefaultLabel"
  case caseItem = "CaseItem"
  case switchCaseLabel = "SwitchCaseLabel"
  case catchClause = "CatchClause"
  case genericWhereClause = "GenericWhereClause"
  case genericRequirementList = "GenericRequirementList"
  case sameTypeRequirement = "SameTypeRequirement"
  case genericParameterList = "GenericParameterList"
  case genericParameter = "GenericParameter"
  case genericParameterClause = "GenericParameterClause"
  case conformanceRequirement = "ConformanceRequirement"
  case simpleTypeIdentifier = "SimpleTypeIdentifier"
  case memberTypeIdentifier = "MemberTypeIdentifier"
  case arrayType = "ArrayType"
  case dictionaryType = "DictionaryType"
  case metatypeType = "MetatypeType"
  case optionalType = "OptionalType"
  case implicitlyUnwrappedOptionalType = "ImplicitlyUnwrappedOptionalType"
  case functionType = "FunctionType"
  case tupleType = "TupleType"
  case tupleTypeElement = "TupleTypeElement"
  case typeAnnotation = "TypeAnnotation"
  case protocolCompositionElementList = "ProtocolCompositionElementList"
  case tupleTypeElementList = "TupleTypeElementList"
  case protocolCompositionElement = "ProtocolCompositionElement"
  case genericArgumentList = "GenericArgumentList"
  case genericArgument = "GenericArgument"
  case genericArgumentClause = "GenericArgumentClause"
  case functionTypeArgument = "FunctionTypeArgument"
  case functionTypeArgumentList = "FunctionTypeArgumentList"
  case protocolCompositionType = "ProtocolCompositionType"
  case enumCasePattern = "EnumCasePattern"
  case isTypePattern = "IsTypePattern"
  case optionalPattern = "OptionalPattern"
  case identifierPattern = "IdentifierPattern"
  case asTypePattern = "AsTypePattern"
  case tuplePattern = "TuplePattern"
  case wildcardPattern = "WildcardPattern"
  case tuplePatternElement = "TuplePatternElement"
  case expressionPattern = "ExpressionPattern"
  case tuplePatternElementList = "TuplePatternElementList"
  case valueBindingPattern = "ValueBindingPattern"

  /// Whether the underlying kind is a sub-kind of DeclSyntax.
  public var isDecl: Bool {
    switch self {
    case .unknownDecl: return true
    case .typealiasDecl: return true
    case .ifConfigDecl: return true
    case .structDecl: return true
    case .topLevelCodeDecl: return true
    case .functionDecl: return true
    default: return false
    }
  }
  /// Whether the underlying kind is a sub-kind of ExprSyntax.
  public var isExpr: Bool {
    switch self {
    case .unknownExpr: return true
    case .inOutExpr: return true
    case .poundColumnExpr: return true
    case .identifierExpr: return true
    case .nilLiteralExpr: return true
    case .discardAssignmentExpr: return true
    case .assignmentExpr: return true
    case .sequenceExpr: return true
    case .poundLineExpr: return true
    case .poundFileExpr: return true
    case .poundFunctionExpr: return true
    case .symbolicReferenceExpr: return true
    case .prefixOperatorExpr: return true
    case .binaryOperatorExpr: return true
    case .floatLiteralExpr: return true
    case .functionCallExpr: return true
    case .tupleExpr: return true
    case .arrayExpr: return true
    case .dictionaryExpr: return true
    case .integerLiteralExpr: return true
    case .stringLiteralExpr: return true
    case .booleanLiteralExpr: return true
    case .ternaryExpr: return true
    case .memberAccessExpr: return true
    case .isExpr: return true
    case .asExpr: return true
    default: return false
    }
  }
  /// Whether the underlying kind is a sub-kind of StmtSyntax.
  public var isStmt: Bool {
    switch self {
    case .unknownStmt: return true
    case .continueStmt: return true
    case .whileStmt: return true
    case .deferStmt: return true
    case .expressionStmt: return true
    case .repeatWhileStmt: return true
    case .guardStmt: return true
    case .forInStmt: return true
    case .switchStmt: return true
    case .doStmt: return true
    case .returnStmt: return true
    case .fallthroughStmt: return true
    case .breakStmt: return true
    case .declarationStmt: return true
    case .throwStmt: return true
    case .ifStmt: return true
    default: return false
    }
  }
  /// Whether the underlying kind is a sub-kind of PatternSyntax.
  public var isPattern: Bool {
    switch self {
    case .unknownPattern: return true
    case .enumCasePattern: return true
    case .isTypePattern: return true
    case .optionalPattern: return true
    case .identifierPattern: return true
    case .asTypePattern: return true
    case .tuplePattern: return true
    case .wildcardPattern: return true
    case .expressionPattern: return true
    case .valueBindingPattern: return true
    default: return false
    }
  }
  /// Whether the underlying kind is a sub-kind of TypeSyntax.
  public var isType: Bool {
    switch self {
    case .unknownType: return true
    case .simpleTypeIdentifier: return true
    case .memberTypeIdentifier: return true
    case .arrayType: return true
    case .dictionaryType: return true
    case .metatypeType: return true
    case .optionalType: return true
    case .implicitlyUnwrappedOptionalType: return true
    case .functionType: return true
    case .tupleType: return true
    case .protocolCompositionType: return true
    default: return false
    }
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let kind = try container.decode(String.self)
    self = SyntaxKind(rawValue: kind) ?? .unknown
  }
}

extension Syntax {
  /// Creates a Syntax node from the provided RawSyntax using the appropriate
  /// Syntax type, as specified by its kind.
  /// - Parameters:
  ///   - raw: The raw syntax with which to create this node.
  ///   - root: The root of this tree, or `nil` if the new node is the root.
  static func fromRaw(_ raw: RawSyntax) -> Syntax {
    let data = SyntaxData(raw: raw)
    return make(root: nil, data: data)
  }

  /// Creates a Syntax node from the provided SyntaxData using the appropriate
  /// Syntax type, as specified by its kind.
  /// - Parameters:
  ///   - root: The root of this tree, or `nil` if the new node is the root.
  ///   - data: The data for this new node.
  static func make(root: SyntaxData?, data: SyntaxData) -> Syntax {
    let root = root ?? data
    switch data.raw.kind {
    case .token: return TokenSyntax(root: root, data: data)
    case .unknown: return Syntax(root: root, data: data)
    case .decl: return DeclSyntax(root: root, data: data)
    case .unknownDecl: return UnknownDeclSyntax(root: root, data: data)
    case .expr: return ExprSyntax(root: root, data: data)
    case .unknownExpr: return UnknownExprSyntax(root: root, data: data)
    case .stmt: return StmtSyntax(root: root, data: data)
    case .unknownStmt: return UnknownStmtSyntax(root: root, data: data)
    case .type: return TypeSyntax(root: root, data: data)
    case .unknownType: return UnknownTypeSyntax(root: root, data: data)
    case .pattern: return PatternSyntax(root: root, data: data)
    case .unknownPattern: return UnknownPatternSyntax(root: root, data: data)
    case .inOutExpr: return InOutExprSyntax(root: root, data: data)
    case .poundColumnExpr: return PoundColumnExprSyntax(root: root, data: data)
    case .functionCallArgumentList: return FunctionCallArgumentListSyntax(root: root, data: data)
    case .tupleElementList: return TupleElementListSyntax(root: root, data: data)
    case .arrayElementList: return ArrayElementListSyntax(root: root, data: data)
    case .dictionaryElementList: return DictionaryElementListSyntax(root: root, data: data)
    case .tryOperator: return TryOperatorSyntax(root: root, data: data)
    case .identifierExpr: return IdentifierExprSyntax(root: root, data: data)
    case .nilLiteralExpr: return NilLiteralExprSyntax(root: root, data: data)
    case .discardAssignmentExpr: return DiscardAssignmentExprSyntax(root: root, data: data)
    case .assignmentExpr: return AssignmentExprSyntax(root: root, data: data)
    case .sequenceExpr: return SequenceExprSyntax(root: root, data: data)
    case .poundLineExpr: return PoundLineExprSyntax(root: root, data: data)
    case .poundFileExpr: return PoundFileExprSyntax(root: root, data: data)
    case .poundFunctionExpr: return PoundFunctionExprSyntax(root: root, data: data)
    case .symbolicReferenceExpr: return SymbolicReferenceExprSyntax(root: root, data: data)
    case .prefixOperatorExpr: return PrefixOperatorExprSyntax(root: root, data: data)
    case .binaryOperatorExpr: return BinaryOperatorExprSyntax(root: root, data: data)
    case .floatLiteralExpr: return FloatLiteralExprSyntax(root: root, data: data)
    case .functionCallExpr: return FunctionCallExprSyntax(root: root, data: data)
    case .tupleExpr: return TupleExprSyntax(root: root, data: data)
    case .arrayExpr: return ArrayExprSyntax(root: root, data: data)
    case .dictionaryExpr: return DictionaryExprSyntax(root: root, data: data)
    case .functionCallArgument: return FunctionCallArgumentSyntax(root: root, data: data)
    case .tupleElement: return TupleElementSyntax(root: root, data: data)
    case .arrayElement: return ArrayElementSyntax(root: root, data: data)
    case .dictionaryElement: return DictionaryElementSyntax(root: root, data: data)
    case .integerLiteralExpr: return IntegerLiteralExprSyntax(root: root, data: data)
    case .stringLiteralExpr: return StringLiteralExprSyntax(root: root, data: data)
    case .booleanLiteralExpr: return BooleanLiteralExprSyntax(root: root, data: data)
    case .ternaryExpr: return TernaryExprSyntax(root: root, data: data)
    case .memberAccessExpr: return MemberAccessExprSyntax(root: root, data: data)
    case .isExpr: return IsExprSyntax(root: root, data: data)
    case .asExpr: return AsExprSyntax(root: root, data: data)
    case .typealiasDecl: return TypealiasDeclSyntax(root: root, data: data)
    case .functionParameterList: return FunctionParameterListSyntax(root: root, data: data)
    case .functionSignature: return FunctionSignatureSyntax(root: root, data: data)
    case .elseifDirectiveClause: return ElseifDirectiveClauseSyntax(root: root, data: data)
    case .ifConfigDecl: return IfConfigDeclSyntax(root: root, data: data)
    case .declModifier: return DeclModifierSyntax(root: root, data: data)
    case .typeInheritanceClause: return TypeInheritanceClauseSyntax(root: root, data: data)
    case .structDecl: return StructDeclSyntax(root: root, data: data)
    case .memberDeclBlock: return MemberDeclBlockSyntax(root: root, data: data)
    case .declList: return DeclListSyntax(root: root, data: data)
    case .sourceFile: return SourceFileSyntax(root: root, data: data)
    case .topLevelCodeDecl: return TopLevelCodeDeclSyntax(root: root, data: data)
    case .functionParameter: return FunctionParameterSyntax(root: root, data: data)
    case .modifierList: return ModifierListSyntax(root: root, data: data)
    case .functionDecl: return FunctionDeclSyntax(root: root, data: data)
    case .elseifDirectiveClauseList: return ElseifDirectiveClauseListSyntax(root: root, data: data)
    case .elseDirectiveClause: return ElseDirectiveClauseSyntax(root: root, data: data)
    case .accessLevelModifier: return AccessLevelModifierSyntax(root: root, data: data)
    case .tokenList: return TokenListSyntax(root: root, data: data)
    case .attribute: return AttributeSyntax(root: root, data: data)
    case .attributeList: return AttributeListSyntax(root: root, data: data)
    case .continueStmt: return ContinueStmtSyntax(root: root, data: data)
    case .whileStmt: return WhileStmtSyntax(root: root, data: data)
    case .deferStmt: return DeferStmtSyntax(root: root, data: data)
    case .expressionStmt: return ExpressionStmtSyntax(root: root, data: data)
    case .switchCaseList: return SwitchCaseListSyntax(root: root, data: data)
    case .repeatWhileStmt: return RepeatWhileStmtSyntax(root: root, data: data)
    case .guardStmt: return GuardStmtSyntax(root: root, data: data)
    case .exprList: return ExprListSyntax(root: root, data: data)
    case .whereClause: return WhereClauseSyntax(root: root, data: data)
    case .forInStmt: return ForInStmtSyntax(root: root, data: data)
    case .switchStmt: return SwitchStmtSyntax(root: root, data: data)
    case .catchClauseList: return CatchClauseListSyntax(root: root, data: data)
    case .doStmt: return DoStmtSyntax(root: root, data: data)
    case .returnStmt: return ReturnStmtSyntax(root: root, data: data)
    case .fallthroughStmt: return FallthroughStmtSyntax(root: root, data: data)
    case .breakStmt: return BreakStmtSyntax(root: root, data: data)
    case .codeBlock: return CodeBlockSyntax(root: root, data: data)
    case .caseItemList: return CaseItemListSyntax(root: root, data: data)
    case .condition: return ConditionSyntax(root: root, data: data)
    case .conditionList: return ConditionListSyntax(root: root, data: data)
    case .declarationStmt: return DeclarationStmtSyntax(root: root, data: data)
    case .throwStmt: return ThrowStmtSyntax(root: root, data: data)
    case .ifStmt: return IfStmtSyntax(root: root, data: data)
    case .elseIfContinuation: return ElseIfContinuationSyntax(root: root, data: data)
    case .elseBlock: return ElseBlockSyntax(root: root, data: data)
    case .stmtList: return StmtListSyntax(root: root, data: data)
    case .switchCase: return SwitchCaseSyntax(root: root, data: data)
    case .switchDefaultLabel: return SwitchDefaultLabelSyntax(root: root, data: data)
    case .caseItem: return CaseItemSyntax(root: root, data: data)
    case .switchCaseLabel: return SwitchCaseLabelSyntax(root: root, data: data)
    case .catchClause: return CatchClauseSyntax(root: root, data: data)
    case .genericWhereClause: return GenericWhereClauseSyntax(root: root, data: data)
    case .genericRequirementList: return GenericRequirementListSyntax(root: root, data: data)
    case .sameTypeRequirement: return SameTypeRequirementSyntax(root: root, data: data)
    case .genericParameterList: return GenericParameterListSyntax(root: root, data: data)
    case .genericParameter: return GenericParameterSyntax(root: root, data: data)
    case .genericParameterClause: return GenericParameterClauseSyntax(root: root, data: data)
    case .conformanceRequirement: return ConformanceRequirementSyntax(root: root, data: data)
    case .simpleTypeIdentifier: return SimpleTypeIdentifierSyntax(root: root, data: data)
    case .memberTypeIdentifier: return MemberTypeIdentifierSyntax(root: root, data: data)
    case .arrayType: return ArrayTypeSyntax(root: root, data: data)
    case .dictionaryType: return DictionaryTypeSyntax(root: root, data: data)
    case .metatypeType: return MetatypeTypeSyntax(root: root, data: data)
    case .optionalType: return OptionalTypeSyntax(root: root, data: data)
    case .implicitlyUnwrappedOptionalType: return ImplicitlyUnwrappedOptionalTypeSyntax(root: root, data: data)
    case .functionType: return FunctionTypeSyntax(root: root, data: data)
    case .tupleType: return TupleTypeSyntax(root: root, data: data)
    case .tupleTypeElement: return TupleTypeElementSyntax(root: root, data: data)
    case .typeAnnotation: return TypeAnnotationSyntax(root: root, data: data)
    case .protocolCompositionElementList: return ProtocolCompositionElementListSyntax(root: root, data: data)
    case .tupleTypeElementList: return TupleTypeElementListSyntax(root: root, data: data)
    case .protocolCompositionElement: return ProtocolCompositionElementSyntax(root: root, data: data)
    case .genericArgumentList: return GenericArgumentListSyntax(root: root, data: data)
    case .genericArgument: return GenericArgumentSyntax(root: root, data: data)
    case .genericArgumentClause: return GenericArgumentClauseSyntax(root: root, data: data)
    case .functionTypeArgument: return FunctionTypeArgumentSyntax(root: root, data: data)
    case .functionTypeArgumentList: return FunctionTypeArgumentListSyntax(root: root, data: data)
    case .protocolCompositionType: return ProtocolCompositionTypeSyntax(root: root, data: data)
    case .enumCasePattern: return EnumCasePatternSyntax(root: root, data: data)
    case .isTypePattern: return IsTypePatternSyntax(root: root, data: data)
    case .optionalPattern: return OptionalPatternSyntax(root: root, data: data)
    case .identifierPattern: return IdentifierPatternSyntax(root: root, data: data)
    case .asTypePattern: return AsTypePatternSyntax(root: root, data: data)
    case .tuplePattern: return TuplePatternSyntax(root: root, data: data)
    case .wildcardPattern: return WildcardPatternSyntax(root: root, data: data)
    case .tuplePatternElement: return TuplePatternElementSyntax(root: root, data: data)
    case .expressionPattern: return ExpressionPatternSyntax(root: root, data: data)
    case .tuplePatternElementList: return TuplePatternElementListSyntax(root: root, data: data)
    case .valueBindingPattern: return ValueBindingPatternSyntax(root: root, data: data)
    }
  }
}