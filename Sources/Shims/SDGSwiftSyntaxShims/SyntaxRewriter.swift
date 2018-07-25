//// Automatically Generated From SyntaxFactory.swift.gyb.
//// Do Not Edit Directly!
//===------------ SyntaxRewriter.swift - Syntax Rewriter class ------------===//
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
// This file defines the SyntaxRewriter, a class that performs a standard walk
// and tree-rebuilding pattern.
//
// Subclassers of this class can override the walking behavior for any syntax
// node and transform nodes however they like.
//
//===----------------------------------------------------------------------===//

open class SyntaxRewriter {
  public init() {}
  open func visit(_ node: UnknownDeclSyntax) -> DeclSyntax {
    return visitChildren(node)as! DeclSyntax
  }

  open func visit(_ node: UnknownExprSyntax) -> ExprSyntax {
    return visitChildren(node)as! ExprSyntax
  }

  open func visit(_ node: UnknownStmtSyntax) -> StmtSyntax {
    return visitChildren(node)as! StmtSyntax
  }

  open func visit(_ node: UnknownTypeSyntax) -> TypeSyntax {
    return visitChildren(node)as! TypeSyntax
  }

  open func visit(_ node: UnknownPatternSyntax) -> PatternSyntax {
    return visitChildren(node)as! PatternSyntax
  }

  open func visit(_ node: InOutExprSyntax) -> ExprSyntax {
    return visitChildren(node)as! ExprSyntax
  }

  open func visit(_ node: PoundColumnExprSyntax) -> ExprSyntax {
    return visitChildren(node)as! ExprSyntax
  }

  open func visit(_ node: TryOperatorSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: IdentifierExprSyntax) -> ExprSyntax {
    return visitChildren(node)as! ExprSyntax
  }

  open func visit(_ node: NilLiteralExprSyntax) -> ExprSyntax {
    return visitChildren(node)as! ExprSyntax
  }

  open func visit(_ node: DiscardAssignmentExprSyntax) -> ExprSyntax {
    return visitChildren(node)as! ExprSyntax
  }

  open func visit(_ node: AssignmentExprSyntax) -> ExprSyntax {
    return visitChildren(node)as! ExprSyntax
  }

  open func visit(_ node: SequenceExprSyntax) -> ExprSyntax {
    return visitChildren(node)as! ExprSyntax
  }

  open func visit(_ node: PoundLineExprSyntax) -> ExprSyntax {
    return visitChildren(node)as! ExprSyntax
  }

  open func visit(_ node: PoundFileExprSyntax) -> ExprSyntax {
    return visitChildren(node)as! ExprSyntax
  }

  open func visit(_ node: PoundFunctionExprSyntax) -> ExprSyntax {
    return visitChildren(node)as! ExprSyntax
  }

  open func visit(_ node: SymbolicReferenceExprSyntax) -> ExprSyntax {
    return visitChildren(node)as! ExprSyntax
  }

  open func visit(_ node: PrefixOperatorExprSyntax) -> ExprSyntax {
    return visitChildren(node)as! ExprSyntax
  }

  open func visit(_ node: BinaryOperatorExprSyntax) -> ExprSyntax {
    return visitChildren(node)as! ExprSyntax
  }

  open func visit(_ node: FloatLiteralExprSyntax) -> ExprSyntax {
    return visitChildren(node)as! ExprSyntax
  }

  open func visit(_ node: FunctionCallExprSyntax) -> ExprSyntax {
    return visitChildren(node)as! ExprSyntax
  }

  open func visit(_ node: TupleExprSyntax) -> ExprSyntax {
    return visitChildren(node)as! ExprSyntax
  }

  open func visit(_ node: ArrayExprSyntax) -> ExprSyntax {
    return visitChildren(node)as! ExprSyntax
  }

  open func visit(_ node: DictionaryExprSyntax) -> ExprSyntax {
    return visitChildren(node)as! ExprSyntax
  }

  open func visit(_ node: FunctionCallArgumentSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: TupleElementSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: ArrayElementSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: DictionaryElementSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: IntegerLiteralExprSyntax) -> ExprSyntax {
    return visitChildren(node)as! ExprSyntax
  }

  open func visit(_ node: StringLiteralExprSyntax) -> ExprSyntax {
    return visitChildren(node)as! ExprSyntax
  }

  open func visit(_ node: BooleanLiteralExprSyntax) -> ExprSyntax {
    return visitChildren(node)as! ExprSyntax
  }

  open func visit(_ node: TernaryExprSyntax) -> ExprSyntax {
    return visitChildren(node)as! ExprSyntax
  }

  open func visit(_ node: MemberAccessExprSyntax) -> ExprSyntax {
    return visitChildren(node)as! ExprSyntax
  }

  open func visit(_ node: IsExprSyntax) -> ExprSyntax {
    return visitChildren(node)as! ExprSyntax
  }

  open func visit(_ node: AsExprSyntax) -> ExprSyntax {
    return visitChildren(node)as! ExprSyntax
  }

  open func visit(_ node: TypealiasDeclSyntax) -> DeclSyntax {
    return visitChildren(node)as! DeclSyntax
  }

  open func visit(_ node: FunctionSignatureSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: ElseifDirectiveClauseSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: IfConfigDeclSyntax) -> DeclSyntax {
    return visitChildren(node)as! DeclSyntax
  }

  open func visit(_ node: DeclModifierSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: TypeInheritanceClauseSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: StructDeclSyntax) -> DeclSyntax {
    return visitChildren(node)as! DeclSyntax
  }

  open func visit(_ node: MemberDeclBlockSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: SourceFileSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: TopLevelCodeDeclSyntax) -> DeclSyntax {
    return visitChildren(node)as! DeclSyntax
  }

  open func visit(_ node: FunctionParameterSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: FunctionDeclSyntax) -> DeclSyntax {
    return visitChildren(node)as! DeclSyntax
  }

  open func visit(_ node: ElseDirectiveClauseSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: AccessLevelModifierSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: AttributeSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: ContinueStmtSyntax) -> StmtSyntax {
    return visitChildren(node)as! StmtSyntax
  }

  open func visit(_ node: WhileStmtSyntax) -> StmtSyntax {
    return visitChildren(node)as! StmtSyntax
  }

  open func visit(_ node: DeferStmtSyntax) -> StmtSyntax {
    return visitChildren(node)as! StmtSyntax
  }

  open func visit(_ node: ExpressionStmtSyntax) -> StmtSyntax {
    return visitChildren(node)as! StmtSyntax
  }

  open func visit(_ node: RepeatWhileStmtSyntax) -> StmtSyntax {
    return visitChildren(node)as! StmtSyntax
  }

  open func visit(_ node: GuardStmtSyntax) -> StmtSyntax {
    return visitChildren(node)as! StmtSyntax
  }

  open func visit(_ node: WhereClauseSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: ForInStmtSyntax) -> StmtSyntax {
    return visitChildren(node)as! StmtSyntax
  }

  open func visit(_ node: SwitchStmtSyntax) -> StmtSyntax {
    return visitChildren(node)as! StmtSyntax
  }

  open func visit(_ node: DoStmtSyntax) -> StmtSyntax {
    return visitChildren(node)as! StmtSyntax
  }

  open func visit(_ node: ReturnStmtSyntax) -> StmtSyntax {
    return visitChildren(node)as! StmtSyntax
  }

  open func visit(_ node: FallthroughStmtSyntax) -> StmtSyntax {
    return visitChildren(node)as! StmtSyntax
  }

  open func visit(_ node: BreakStmtSyntax) -> StmtSyntax {
    return visitChildren(node)as! StmtSyntax
  }

  open func visit(_ node: CodeBlockSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: ConditionSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: DeclarationStmtSyntax) -> StmtSyntax {
    return visitChildren(node)as! StmtSyntax
  }

  open func visit(_ node: ThrowStmtSyntax) -> StmtSyntax {
    return visitChildren(node)as! StmtSyntax
  }

  open func visit(_ node: IfStmtSyntax) -> StmtSyntax {
    return visitChildren(node)as! StmtSyntax
  }

  open func visit(_ node: ElseIfContinuationSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: ElseBlockSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: SwitchCaseSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: SwitchDefaultLabelSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: CaseItemSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: SwitchCaseLabelSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: CatchClauseSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: GenericWhereClauseSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: SameTypeRequirementSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: GenericParameterSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: GenericParameterClauseSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: ConformanceRequirementSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: SimpleTypeIdentifierSyntax) -> TypeSyntax {
    return visitChildren(node)as! TypeSyntax
  }

  open func visit(_ node: MemberTypeIdentifierSyntax) -> TypeSyntax {
    return visitChildren(node)as! TypeSyntax
  }

  open func visit(_ node: ArrayTypeSyntax) -> TypeSyntax {
    return visitChildren(node)as! TypeSyntax
  }

  open func visit(_ node: DictionaryTypeSyntax) -> TypeSyntax {
    return visitChildren(node)as! TypeSyntax
  }

  open func visit(_ node: MetatypeTypeSyntax) -> TypeSyntax {
    return visitChildren(node)as! TypeSyntax
  }

  open func visit(_ node: OptionalTypeSyntax) -> TypeSyntax {
    return visitChildren(node)as! TypeSyntax
  }

  open func visit(_ node: ImplicitlyUnwrappedOptionalTypeSyntax) -> TypeSyntax {
    return visitChildren(node)as! TypeSyntax
  }

  open func visit(_ node: FunctionTypeSyntax) -> TypeSyntax {
    return visitChildren(node)as! TypeSyntax
  }

  open func visit(_ node: TupleTypeSyntax) -> TypeSyntax {
    return visitChildren(node)as! TypeSyntax
  }

  open func visit(_ node: TupleTypeElementSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: TypeAnnotationSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: ProtocolCompositionElementSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: GenericArgumentSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: GenericArgumentClauseSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: FunctionTypeArgumentSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: ProtocolCompositionTypeSyntax) -> TypeSyntax {
    return visitChildren(node)as! TypeSyntax
  }

  open func visit(_ node: EnumCasePatternSyntax) -> PatternSyntax {
    return visitChildren(node)as! PatternSyntax
  }

  open func visit(_ node: IsTypePatternSyntax) -> PatternSyntax {
    return visitChildren(node)as! PatternSyntax
  }

  open func visit(_ node: OptionalPatternSyntax) -> PatternSyntax {
    return visitChildren(node)as! PatternSyntax
  }

  open func visit(_ node: IdentifierPatternSyntax) -> PatternSyntax {
    return visitChildren(node)as! PatternSyntax
  }

  open func visit(_ node: AsTypePatternSyntax) -> PatternSyntax {
    return visitChildren(node)as! PatternSyntax
  }

  open func visit(_ node: TuplePatternSyntax) -> PatternSyntax {
    return visitChildren(node)as! PatternSyntax
  }

  open func visit(_ node: WildcardPatternSyntax) -> PatternSyntax {
    return visitChildren(node)as! PatternSyntax
  }

  open func visit(_ node: TuplePatternElementSyntax) -> Syntax {
    return visitChildren(node)
  }

  open func visit(_ node: ExpressionPatternSyntax) -> PatternSyntax {
    return visitChildren(node)as! PatternSyntax
  }

  open func visit(_ node: ValueBindingPatternSyntax) -> PatternSyntax {
    return visitChildren(node)as! PatternSyntax
  }


  open func visit(_ token: TokenSyntax) -> Syntax {
    return token
  }
  public func visit(_ node: Syntax) -> Syntax {
    switch node.raw.kind {
    case .token: return visit(node as! TokenSyntax)
    case .unknownDecl: return visit(node as! UnknownDeclSyntax)
    case .unknownExpr: return visit(node as! UnknownExprSyntax)
    case .unknownStmt: return visit(node as! UnknownStmtSyntax)
    case .unknownType: return visit(node as! UnknownTypeSyntax)
    case .unknownPattern: return visit(node as! UnknownPatternSyntax)
    case .inOutExpr: return visit(node as! InOutExprSyntax)
    case .poundColumnExpr: return visit(node as! PoundColumnExprSyntax)
    case .tryOperator: return visit(node as! TryOperatorSyntax)
    case .identifierExpr: return visit(node as! IdentifierExprSyntax)
    case .nilLiteralExpr: return visit(node as! NilLiteralExprSyntax)
    case .discardAssignmentExpr: return visit(node as! DiscardAssignmentExprSyntax)
    case .assignmentExpr: return visit(node as! AssignmentExprSyntax)
    case .sequenceExpr: return visit(node as! SequenceExprSyntax)
    case .poundLineExpr: return visit(node as! PoundLineExprSyntax)
    case .poundFileExpr: return visit(node as! PoundFileExprSyntax)
    case .poundFunctionExpr: return visit(node as! PoundFunctionExprSyntax)
    case .symbolicReferenceExpr: return visit(node as! SymbolicReferenceExprSyntax)
    case .prefixOperatorExpr: return visit(node as! PrefixOperatorExprSyntax)
    case .binaryOperatorExpr: return visit(node as! BinaryOperatorExprSyntax)
    case .floatLiteralExpr: return visit(node as! FloatLiteralExprSyntax)
    case .functionCallExpr: return visit(node as! FunctionCallExprSyntax)
    case .tupleExpr: return visit(node as! TupleExprSyntax)
    case .arrayExpr: return visit(node as! ArrayExprSyntax)
    case .dictionaryExpr: return visit(node as! DictionaryExprSyntax)
    case .functionCallArgument: return visit(node as! FunctionCallArgumentSyntax)
    case .tupleElement: return visit(node as! TupleElementSyntax)
    case .arrayElement: return visit(node as! ArrayElementSyntax)
    case .dictionaryElement: return visit(node as! DictionaryElementSyntax)
    case .integerLiteralExpr: return visit(node as! IntegerLiteralExprSyntax)
    case .stringLiteralExpr: return visit(node as! StringLiteralExprSyntax)
    case .booleanLiteralExpr: return visit(node as! BooleanLiteralExprSyntax)
    case .ternaryExpr: return visit(node as! TernaryExprSyntax)
    case .memberAccessExpr: return visit(node as! MemberAccessExprSyntax)
    case .isExpr: return visit(node as! IsExprSyntax)
    case .asExpr: return visit(node as! AsExprSyntax)
    case .typealiasDecl: return visit(node as! TypealiasDeclSyntax)
    case .functionSignature: return visit(node as! FunctionSignatureSyntax)
    case .elseifDirectiveClause: return visit(node as! ElseifDirectiveClauseSyntax)
    case .ifConfigDecl: return visit(node as! IfConfigDeclSyntax)
    case .declModifier: return visit(node as! DeclModifierSyntax)
    case .typeInheritanceClause: return visit(node as! TypeInheritanceClauseSyntax)
    case .structDecl: return visit(node as! StructDeclSyntax)
    case .memberDeclBlock: return visit(node as! MemberDeclBlockSyntax)
    case .sourceFile: return visit(node as! SourceFileSyntax)
    case .topLevelCodeDecl: return visit(node as! TopLevelCodeDeclSyntax)
    case .functionParameter: return visit(node as! FunctionParameterSyntax)
    case .functionDecl: return visit(node as! FunctionDeclSyntax)
    case .elseDirectiveClause: return visit(node as! ElseDirectiveClauseSyntax)
    case .accessLevelModifier: return visit(node as! AccessLevelModifierSyntax)
    case .attribute: return visit(node as! AttributeSyntax)
    case .continueStmt: return visit(node as! ContinueStmtSyntax)
    case .whileStmt: return visit(node as! WhileStmtSyntax)
    case .deferStmt: return visit(node as! DeferStmtSyntax)
    case .expressionStmt: return visit(node as! ExpressionStmtSyntax)
    case .repeatWhileStmt: return visit(node as! RepeatWhileStmtSyntax)
    case .guardStmt: return visit(node as! GuardStmtSyntax)
    case .whereClause: return visit(node as! WhereClauseSyntax)
    case .forInStmt: return visit(node as! ForInStmtSyntax)
    case .switchStmt: return visit(node as! SwitchStmtSyntax)
    case .doStmt: return visit(node as! DoStmtSyntax)
    case .returnStmt: return visit(node as! ReturnStmtSyntax)
    case .fallthroughStmt: return visit(node as! FallthroughStmtSyntax)
    case .breakStmt: return visit(node as! BreakStmtSyntax)
    case .codeBlock: return visit(node as! CodeBlockSyntax)
    case .condition: return visit(node as! ConditionSyntax)
    case .declarationStmt: return visit(node as! DeclarationStmtSyntax)
    case .throwStmt: return visit(node as! ThrowStmtSyntax)
    case .ifStmt: return visit(node as! IfStmtSyntax)
    case .elseIfContinuation: return visit(node as! ElseIfContinuationSyntax)
    case .elseBlock: return visit(node as! ElseBlockSyntax)
    case .switchCase: return visit(node as! SwitchCaseSyntax)
    case .switchDefaultLabel: return visit(node as! SwitchDefaultLabelSyntax)
    case .caseItem: return visit(node as! CaseItemSyntax)
    case .switchCaseLabel: return visit(node as! SwitchCaseLabelSyntax)
    case .catchClause: return visit(node as! CatchClauseSyntax)
    case .genericWhereClause: return visit(node as! GenericWhereClauseSyntax)
    case .sameTypeRequirement: return visit(node as! SameTypeRequirementSyntax)
    case .genericParameter: return visit(node as! GenericParameterSyntax)
    case .genericParameterClause: return visit(node as! GenericParameterClauseSyntax)
    case .conformanceRequirement: return visit(node as! ConformanceRequirementSyntax)
    case .simpleTypeIdentifier: return visit(node as! SimpleTypeIdentifierSyntax)
    case .memberTypeIdentifier: return visit(node as! MemberTypeIdentifierSyntax)
    case .arrayType: return visit(node as! ArrayTypeSyntax)
    case .dictionaryType: return visit(node as! DictionaryTypeSyntax)
    case .metatypeType: return visit(node as! MetatypeTypeSyntax)
    case .optionalType: return visit(node as! OptionalTypeSyntax)
    case .implicitlyUnwrappedOptionalType: return visit(node as! ImplicitlyUnwrappedOptionalTypeSyntax)
    case .functionType: return visit(node as! FunctionTypeSyntax)
    case .tupleType: return visit(node as! TupleTypeSyntax)
    case .tupleTypeElement: return visit(node as! TupleTypeElementSyntax)
    case .typeAnnotation: return visit(node as! TypeAnnotationSyntax)
    case .protocolCompositionElement: return visit(node as! ProtocolCompositionElementSyntax)
    case .genericArgument: return visit(node as! GenericArgumentSyntax)
    case .genericArgumentClause: return visit(node as! GenericArgumentClauseSyntax)
    case .functionTypeArgument: return visit(node as! FunctionTypeArgumentSyntax)
    case .protocolCompositionType: return visit(node as! ProtocolCompositionTypeSyntax)
    case .enumCasePattern: return visit(node as! EnumCasePatternSyntax)
    case .isTypePattern: return visit(node as! IsTypePatternSyntax)
    case .optionalPattern: return visit(node as! OptionalPatternSyntax)
    case .identifierPattern: return visit(node as! IdentifierPatternSyntax)
    case .asTypePattern: return visit(node as! AsTypePatternSyntax)
    case .tuplePattern: return visit(node as! TuplePatternSyntax)
    case .wildcardPattern: return visit(node as! WildcardPatternSyntax)
    case .tuplePatternElement: return visit(node as! TuplePatternElementSyntax)
    case .expressionPattern: return visit(node as! ExpressionPatternSyntax)
    case .valueBindingPattern: return visit(node as! ValueBindingPatternSyntax)
    default: return visitChildren(node)
    }
  }

  func visitChildren(_ node: Syntax) -> Syntax {
    let newLayout = node.children.map { visit($0).raw }
    return Syntax.fromRaw(node.raw.replacingLayout(newLayout))
  }
}
