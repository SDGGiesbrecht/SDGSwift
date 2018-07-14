//// Automatically Generated From TokenKind.swift.gyb.
//// Do Not Edit Directly!
//===----------------- TokenKind.swift - Token Kind Enum ------------------===//
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

/// Enumerates the kinds of tokens in the Swift language.
public enum TokenKind: Codable {
  case unknown
  case eof
  case associatedtypeKeyword
  case classKeyword
  case deinitKeyword
  case enumKeyword
  case extensionKeyword
  case funcKeyword
  case importKeyword
  case initKeyword
  case inoutKeyword
  case letKeyword
  case operatorKeyword
  case precedencegroupKeyword
  case protocolKeyword
  case structKeyword
  case subscriptKeyword
  case typealiasKeyword
  case varKeyword
  case fileprivateKeyword
  case internalKeyword
  case privateKeyword
  case publicKeyword
  case staticKeyword
  case deferKeyword
  case ifKeyword
  case guardKeyword
  case doKeyword
  case repeatKeyword
  case elseKeyword
  case forKeyword
  case inKeyword
  case whileKeyword
  case returnKeyword
  case breakKeyword
  case continueKeyword
  case fallthroughKeyword
  case switchKeyword
  case caseKeyword
  case defaultKeyword
  case whereKeyword
  case catchKeyword
  case asKeyword
  case anyKeyword
  case falseKeyword
  case isKeyword
  case nilKeyword
  case rethrowsKeyword
  case superKeyword
  case selfKeyword
  case capitalSelfKeyword
  case throwKeyword
  case trueKeyword
  case tryKeyword
  case throwsKeyword
  case __file__Keyword
  case __line__Keyword
  case __column__Keyword
  case __function__Keyword
  case __dso_handle__Keyword
  case wildcardKeyword
  case poundAvailableKeyword
  case poundEndifKeyword
  case poundElseKeyword
  case poundElseifKeyword
  case poundIfKeyword
  case poundSourceLocationKeyword
  case poundFileKeyword
  case poundLineKeyword
  case poundColumnKeyword
  case poundFunctionKeyword
  case arrow
  case atSign
  case colon
  case semicolon
  case comma
  case period
  case equal
  case prefixPeriod
  case leftParen
  case rightParen
  case leftBrace
  case rightBrace
  case leftSquareBracket
  case rightSquareBracket
  case leftAngle
  case rightAngle
  case ampersand
  case postfixQuestionMark
  case infixQuestionMark
  case exclamationMark
  case identifier(String)
  case dollarIdentifier(String)
  case unspacedBinaryOperator(String)
  case spacedBinaryOperator(String)
  case prefixOperator(String)
  case postfixOperator(String)
  case integerLiteral(String)
  case floatingLiteral(String)
  case stringLiteral(String)

  /// The textual representation of this token kind.
  var text: String {
    switch self {
    case .unknown: return "unknown"
    case .eof: return ""
    case .associatedtypeKeyword: return "associatedtype"
    case .classKeyword: return "class"
    case .deinitKeyword: return "deinit"
    case .enumKeyword: return "enum"
    case .extensionKeyword: return "extension"
    case .funcKeyword: return "func"
    case .importKeyword: return "import"
    case .initKeyword: return "init"
    case .inoutKeyword: return "inout"
    case .letKeyword: return "let"
    case .operatorKeyword: return "operator"
    case .precedencegroupKeyword: return "precedencegroup"
    case .protocolKeyword: return "protocol"
    case .structKeyword: return "struct"
    case .subscriptKeyword: return "subscript"
    case .typealiasKeyword: return "typealias"
    case .varKeyword: return "var"
    case .fileprivateKeyword: return "fileprivate"
    case .internalKeyword: return "internal"
    case .privateKeyword: return "private"
    case .publicKeyword: return "public"
    case .staticKeyword: return "static"
    case .deferKeyword: return "defer"
    case .ifKeyword: return "if"
    case .guardKeyword: return "guard"
    case .doKeyword: return "do"
    case .repeatKeyword: return "repeat"
    case .elseKeyword: return "else"
    case .forKeyword: return "for"
    case .inKeyword: return "in"
    case .whileKeyword: return "while"
    case .returnKeyword: return "return"
    case .breakKeyword: return "break"
    case .continueKeyword: return "continue"
    case .fallthroughKeyword: return "fallthrough"
    case .switchKeyword: return "switch"
    case .caseKeyword: return "case"
    case .defaultKeyword: return "default"
    case .whereKeyword: return "where"
    case .catchKeyword: return "catch"
    case .asKeyword: return "as"
    case .anyKeyword: return "Any"
    case .falseKeyword: return "false"
    case .isKeyword: return "is"
    case .nilKeyword: return "nil"
    case .rethrowsKeyword: return "rethrows"
    case .superKeyword: return "super"
    case .selfKeyword: return "self"
    case .capitalSelfKeyword: return "Self"
    case .throwKeyword: return "throw"
    case .trueKeyword: return "true"
    case .tryKeyword: return "try"
    case .throwsKeyword: return "throws"
    case .__file__Keyword: return "__FILE__"
    case .__line__Keyword: return "__LINE__"
    case .__column__Keyword: return "__COLUMN__"
    case .__function__Keyword: return "__FUNCTION__"
    case .__dso_handle__Keyword: return "__DSO_HANDLE__"
    case .wildcardKeyword: return "_"
    case .poundAvailableKeyword: return "#available"
    case .poundEndifKeyword: return "#endif"
    case .poundElseKeyword: return "#else"
    case .poundElseifKeyword: return "#elseif"
    case .poundIfKeyword: return "#if"
    case .poundSourceLocationKeyword: return "#sourceLocation"
    case .poundFileKeyword: return "#file"
    case .poundLineKeyword: return "#line"
    case .poundColumnKeyword: return "#column"
    case .poundFunctionKeyword: return "#function"
    case .arrow: return "->"
    case .atSign: return "@"
    case .colon: return ":"
    case .semicolon: return ";"
    case .comma: return ","
    case .period: return "."
    case .equal: return "="
    case .prefixPeriod: return "."
    case .leftParen: return "("
    case .rightParen: return ")"
    case .leftBrace: return "{"
    case .rightBrace: return "}"
    case .leftSquareBracket: return "["
    case .rightSquareBracket: return "]"
    case .leftAngle: return "<"
    case .rightAngle: return ">"
    case .ampersand: return "&"
    case .postfixQuestionMark: return "?"
    case .infixQuestionMark: return "?"
    case .exclamationMark: return "!"
    case .identifier(let text): return text
    case .dollarIdentifier(let text): return text
    case .unspacedBinaryOperator(let text): return text
    case .spacedBinaryOperator(let text): return text
    case .prefixOperator(let text): return text
    case .postfixOperator(let text): return text
    case .integerLiteral(let text): return text
    case .floatingLiteral(let text): return text
    case .stringLiteral(let text): return text
    }
  }

  /// Keys for serializing and deserializing token kinds.
  enum CodingKeys: String, CodingKey {
    case kind, text
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let kind = try container.decode(String.self, forKey: .kind)
    switch kind {
    case "unknown": self = .unknown
    case "eof": self = .eof
    case "kw_associatedtype":
      self = .associatedtypeKeyword
    case "kw_class":
      self = .classKeyword
    case "kw_deinit":
      self = .deinitKeyword
    case "kw_enum":
      self = .enumKeyword
    case "kw_extension":
      self = .extensionKeyword
    case "kw_func":
      self = .funcKeyword
    case "kw_import":
      self = .importKeyword
    case "kw_init":
      self = .initKeyword
    case "kw_inout":
      self = .inoutKeyword
    case "kw_let":
      self = .letKeyword
    case "kw_operator":
      self = .operatorKeyword
    case "kw_precedencegroup":
      self = .precedencegroupKeyword
    case "kw_protocol":
      self = .protocolKeyword
    case "kw_struct":
      self = .structKeyword
    case "kw_subscript":
      self = .subscriptKeyword
    case "kw_typealias":
      self = .typealiasKeyword
    case "kw_var":
      self = .varKeyword
    case "kw_fileprivate":
      self = .fileprivateKeyword
    case "kw_internal":
      self = .internalKeyword
    case "kw_private":
      self = .privateKeyword
    case "kw_public":
      self = .publicKeyword
    case "kw_static":
      self = .staticKeyword
    case "kw_defer":
      self = .deferKeyword
    case "kw_if":
      self = .ifKeyword
    case "kw_guard":
      self = .guardKeyword
    case "kw_do":
      self = .doKeyword
    case "kw_repeat":
      self = .repeatKeyword
    case "kw_else":
      self = .elseKeyword
    case "kw_for":
      self = .forKeyword
    case "kw_in":
      self = .inKeyword
    case "kw_while":
      self = .whileKeyword
    case "kw_return":
      self = .returnKeyword
    case "kw_break":
      self = .breakKeyword
    case "kw_continue":
      self = .continueKeyword
    case "kw_fallthrough":
      self = .fallthroughKeyword
    case "kw_switch":
      self = .switchKeyword
    case "kw_case":
      self = .caseKeyword
    case "kw_default":
      self = .defaultKeyword
    case "kw_where":
      self = .whereKeyword
    case "kw_catch":
      self = .catchKeyword
    case "kw_as":
      self = .asKeyword
    case "kw_Any":
      self = .anyKeyword
    case "kw_false":
      self = .falseKeyword
    case "kw_is":
      self = .isKeyword
    case "kw_nil":
      self = .nilKeyword
    case "kw_rethrows":
      self = .rethrowsKeyword
    case "kw_super":
      self = .superKeyword
    case "kw_self":
      self = .selfKeyword
    case "kw_Self":
      self = .capitalSelfKeyword
    case "kw_throw":
      self = .throwKeyword
    case "kw_true":
      self = .trueKeyword
    case "kw_try":
      self = .tryKeyword
    case "kw_throws":
      self = .throwsKeyword
    case "kw___FILE__":
      self = .__file__Keyword
    case "kw___LINE__":
      self = .__line__Keyword
    case "kw___COLUMN__":
      self = .__column__Keyword
    case "kw___FUNCTION__":
      self = .__function__Keyword
    case "kw___DSO_HANDLE__":
      self = .__dso_handle__Keyword
    case "kw__":
      self = .wildcardKeyword
    case "pound_available":
      self = .poundAvailableKeyword
    case "pound_endif":
      self = .poundEndifKeyword
    case "pound_else":
      self = .poundElseKeyword
    case "pound_elseif":
      self = .poundElseifKeyword
    case "pound_if":
      self = .poundIfKeyword
    case "pound_sourceLocation":
      self = .poundSourceLocationKeyword
    case "pound_file":
      self = .poundFileKeyword
    case "pound_line":
      self = .poundLineKeyword
    case "pound_column":
      self = .poundColumnKeyword
    case "pound_function":
      self = .poundFunctionKeyword
    case "arrow":
      self = .arrow
    case "at_sign":
      self = .atSign
    case "colon":
      self = .colon
    case "semi":
      self = .semicolon
    case "comma":
      self = .comma
    case "period":
      self = .period
    case "equal":
      self = .equal
    case "period_prefix":
      self = .prefixPeriod
    case "l_paren":
      self = .leftParen
    case "r_paren":
      self = .rightParen
    case "l_brace":
      self = .leftBrace
    case "r_brace":
      self = .rightBrace
    case "l_square":
      self = .leftSquareBracket
    case "r_square":
      self = .rightSquareBracket
    case "l_angle":
      self = .leftAngle
    case "r_angle":
      self = .rightAngle
    case "amp_prefix":
      self = .ampersand
    case "question_postfix":
      self = .postfixQuestionMark
    case "question_infix":
      self = .infixQuestionMark
    case "exclaim_postfix":
      self = .exclamationMark
    case "identifier":
      let text = try container.decode(String.self, forKey: .text)
      self = .identifier(text)
    case "dollarident":
      let text = try container.decode(String.self, forKey: .text)
      self = .dollarIdentifier(text)
    case "oper_binary_unspaced":
      let text = try container.decode(String.self, forKey: .text)
      self = .unspacedBinaryOperator(text)
    case "oper_binary_spaced":
      let text = try container.decode(String.self, forKey: .text)
      self = .spacedBinaryOperator(text)
    case "oper_prefix":
      let text = try container.decode(String.self, forKey: .text)
      self = .prefixOperator(text)
    case "oper_postfix":
      let text = try container.decode(String.self, forKey: .text)
      self = .postfixOperator(text)
    case "integer_literal":
      let text = try container.decode(String.self, forKey: .text)
      self = .integerLiteral(text)
    case "floating_literal":
      let text = try container.decode(String.self, forKey: .text)
      self = .floatingLiteral(text)
    case "string_literal":
      let text = try container.decode(String.self, forKey: .text)
      self = .stringLiteral(text)
    default: fatalError("unknown token kind \(kind)")
    }
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(kind, forKey: .kind)
    try container.encode(text, forKey: .text)
  }
  
  var kind: String {
    switch self {
    case .unknown: return "unknown"
    case .eof: return "eof"
    case .associatedtypeKeyword: return "kw_associatedtype"
    case .classKeyword: return "kw_class"
    case .deinitKeyword: return "kw_deinit"
    case .enumKeyword: return "kw_enum"
    case .extensionKeyword: return "kw_extension"
    case .funcKeyword: return "kw_func"
    case .importKeyword: return "kw_import"
    case .initKeyword: return "kw_init"
    case .inoutKeyword: return "kw_inout"
    case .letKeyword: return "kw_let"
    case .operatorKeyword: return "kw_operator"
    case .precedencegroupKeyword: return "kw_precedencegroup"
    case .protocolKeyword: return "kw_protocol"
    case .structKeyword: return "kw_struct"
    case .subscriptKeyword: return "kw_subscript"
    case .typealiasKeyword: return "kw_typealias"
    case .varKeyword: return "kw_var"
    case .fileprivateKeyword: return "kw_fileprivate"
    case .internalKeyword: return "kw_internal"
    case .privateKeyword: return "kw_private"
    case .publicKeyword: return "kw_public"
    case .staticKeyword: return "kw_static"
    case .deferKeyword: return "kw_defer"
    case .ifKeyword: return "kw_if"
    case .guardKeyword: return "kw_guard"
    case .doKeyword: return "kw_do"
    case .repeatKeyword: return "kw_repeat"
    case .elseKeyword: return "kw_else"
    case .forKeyword: return "kw_for"
    case .inKeyword: return "kw_in"
    case .whileKeyword: return "kw_while"
    case .returnKeyword: return "kw_return"
    case .breakKeyword: return "kw_break"
    case .continueKeyword: return "kw_continue"
    case .fallthroughKeyword: return "kw_fallthrough"
    case .switchKeyword: return "kw_switch"
    case .caseKeyword: return "kw_case"
    case .defaultKeyword: return "kw_default"
    case .whereKeyword: return "kw_where"
    case .catchKeyword: return "kw_catch"
    case .asKeyword: return "kw_as"
    case .anyKeyword: return "kw_Any"
    case .falseKeyword: return "kw_false"
    case .isKeyword: return "kw_is"
    case .nilKeyword: return "kw_nil"
    case .rethrowsKeyword: return "kw_rethrows"
    case .superKeyword: return "kw_super"
    case .selfKeyword: return "kw_self"
    case .capitalSelfKeyword: return "kw_Self"
    case .throwKeyword: return "kw_throw"
    case .trueKeyword: return "kw_true"
    case .tryKeyword: return "kw_try"
    case .throwsKeyword: return "kw_throws"
    case .__file__Keyword: return "kw___FILE__"
    case .__line__Keyword: return "kw___LINE__"
    case .__column__Keyword: return "kw___COLUMN__"
    case .__function__Keyword: return "kw___FUNCTION__"
    case .__dso_handle__Keyword: return "kw___DSO_HANDLE__"
    case .wildcardKeyword: return "kw__"
    case .poundAvailableKeyword: return "pound_available"
    case .poundEndifKeyword: return "pound_endif"
    case .poundElseKeyword: return "pound_else"
    case .poundElseifKeyword: return "pound_elseif"
    case .poundIfKeyword: return "pound_if"
    case .poundSourceLocationKeyword: return "pound_sourceLocation"
    case .poundFileKeyword: return "pound_file"
    case .poundLineKeyword: return "pound_line"
    case .poundColumnKeyword: return "pound_column"
    case .poundFunctionKeyword: return "pound_function"
    case .arrow: return "arrow"
    case .atSign: return "at_sign"
    case .colon: return "colon"
    case .semicolon: return "semi"
    case .comma: return "comma"
    case .period: return "period"
    case .equal: return "equal"
    case .prefixPeriod: return "period_prefix"
    case .leftParen: return "l_paren"
    case .rightParen: return "r_paren"
    case .leftBrace: return "l_brace"
    case .rightBrace: return "r_brace"
    case .leftSquareBracket: return "l_square"
    case .rightSquareBracket: return "r_square"
    case .leftAngle: return "l_angle"
    case .rightAngle: return "r_angle"
    case .ampersand: return "amp_prefix"
    case .postfixQuestionMark: return "question_postfix"
    case .infixQuestionMark: return "question_infix"
    case .exclamationMark: return "exclaim_postfix"
    case .identifier(_): return "identifier"
    case .dollarIdentifier(_): return "dollarident"
    case .unspacedBinaryOperator(_): return "oper_binary_unspaced"
    case .spacedBinaryOperator(_): return "oper_binary_spaced"
    case .prefixOperator(_): return "oper_prefix"
    case .postfixOperator(_): return "oper_postfix"
    case .integerLiteral(_): return "integer_literal"
    case .floatingLiteral(_): return "floating_literal"
    case .stringLiteral(_): return "string_literal"
    }
  }
}

extension TokenKind: Equatable {
  public static func ==(lhs: TokenKind, rhs: TokenKind) -> Bool {
    switch (lhs, rhs) {
    case (.unknown, .unknown): return true
    case (.eof, .eof): return true
    case (.associatedtypeKeyword, .associatedtypeKeyword): return true
    case (.classKeyword, .classKeyword): return true
    case (.deinitKeyword, .deinitKeyword): return true
    case (.enumKeyword, .enumKeyword): return true
    case (.extensionKeyword, .extensionKeyword): return true
    case (.funcKeyword, .funcKeyword): return true
    case (.importKeyword, .importKeyword): return true
    case (.initKeyword, .initKeyword): return true
    case (.inoutKeyword, .inoutKeyword): return true
    case (.letKeyword, .letKeyword): return true
    case (.operatorKeyword, .operatorKeyword): return true
    case (.precedencegroupKeyword, .precedencegroupKeyword): return true
    case (.protocolKeyword, .protocolKeyword): return true
    case (.structKeyword, .structKeyword): return true
    case (.subscriptKeyword, .subscriptKeyword): return true
    case (.typealiasKeyword, .typealiasKeyword): return true
    case (.varKeyword, .varKeyword): return true
    case (.fileprivateKeyword, .fileprivateKeyword): return true
    case (.internalKeyword, .internalKeyword): return true
    case (.privateKeyword, .privateKeyword): return true
    case (.publicKeyword, .publicKeyword): return true
    case (.staticKeyword, .staticKeyword): return true
    case (.deferKeyword, .deferKeyword): return true
    case (.ifKeyword, .ifKeyword): return true
    case (.guardKeyword, .guardKeyword): return true
    case (.doKeyword, .doKeyword): return true
    case (.repeatKeyword, .repeatKeyword): return true
    case (.elseKeyword, .elseKeyword): return true
    case (.forKeyword, .forKeyword): return true
    case (.inKeyword, .inKeyword): return true
    case (.whileKeyword, .whileKeyword): return true
    case (.returnKeyword, .returnKeyword): return true
    case (.breakKeyword, .breakKeyword): return true
    case (.continueKeyword, .continueKeyword): return true
    case (.fallthroughKeyword, .fallthroughKeyword): return true
    case (.switchKeyword, .switchKeyword): return true
    case (.caseKeyword, .caseKeyword): return true
    case (.defaultKeyword, .defaultKeyword): return true
    case (.whereKeyword, .whereKeyword): return true
    case (.catchKeyword, .catchKeyword): return true
    case (.asKeyword, .asKeyword): return true
    case (.anyKeyword, .anyKeyword): return true
    case (.falseKeyword, .falseKeyword): return true
    case (.isKeyword, .isKeyword): return true
    case (.nilKeyword, .nilKeyword): return true
    case (.rethrowsKeyword, .rethrowsKeyword): return true
    case (.superKeyword, .superKeyword): return true
    case (.selfKeyword, .selfKeyword): return true
    case (.capitalSelfKeyword, .capitalSelfKeyword): return true
    case (.throwKeyword, .throwKeyword): return true
    case (.trueKeyword, .trueKeyword): return true
    case (.tryKeyword, .tryKeyword): return true
    case (.throwsKeyword, .throwsKeyword): return true
    case (.__file__Keyword, .__file__Keyword): return true
    case (.__line__Keyword, .__line__Keyword): return true
    case (.__column__Keyword, .__column__Keyword): return true
    case (.__function__Keyword, .__function__Keyword): return true
    case (.__dso_handle__Keyword, .__dso_handle__Keyword): return true
    case (.wildcardKeyword, .wildcardKeyword): return true
    case (.poundAvailableKeyword, .poundAvailableKeyword): return true
    case (.poundEndifKeyword, .poundEndifKeyword): return true
    case (.poundElseKeyword, .poundElseKeyword): return true
    case (.poundElseifKeyword, .poundElseifKeyword): return true
    case (.poundIfKeyword, .poundIfKeyword): return true
    case (.poundSourceLocationKeyword, .poundSourceLocationKeyword): return true
    case (.poundFileKeyword, .poundFileKeyword): return true
    case (.poundLineKeyword, .poundLineKeyword): return true
    case (.poundColumnKeyword, .poundColumnKeyword): return true
    case (.poundFunctionKeyword, .poundFunctionKeyword): return true
    case (.arrow, .arrow): return true
    case (.atSign, .atSign): return true
    case (.colon, .colon): return true
    case (.semicolon, .semicolon): return true
    case (.comma, .comma): return true
    case (.period, .period): return true
    case (.equal, .equal): return true
    case (.prefixPeriod, .prefixPeriod): return true
    case (.leftParen, .leftParen): return true
    case (.rightParen, .rightParen): return true
    case (.leftBrace, .leftBrace): return true
    case (.rightBrace, .rightBrace): return true
    case (.leftSquareBracket, .leftSquareBracket): return true
    case (.rightSquareBracket, .rightSquareBracket): return true
    case (.leftAngle, .leftAngle): return true
    case (.rightAngle, .rightAngle): return true
    case (.ampersand, .ampersand): return true
    case (.postfixQuestionMark, .postfixQuestionMark): return true
    case (.infixQuestionMark, .infixQuestionMark): return true
    case (.exclamationMark, .exclamationMark): return true
    case (.identifier(let lhsText), .identifier(let rhsText)):
      return lhsText == rhsText
    case (.dollarIdentifier(let lhsText), .dollarIdentifier(let rhsText)):
      return lhsText == rhsText
    case (.unspacedBinaryOperator(let lhsText), .unspacedBinaryOperator(let rhsText)):
      return lhsText == rhsText
    case (.spacedBinaryOperator(let lhsText), .spacedBinaryOperator(let rhsText)):
      return lhsText == rhsText
    case (.prefixOperator(let lhsText), .prefixOperator(let rhsText)):
      return lhsText == rhsText
    case (.postfixOperator(let lhsText), .postfixOperator(let rhsText)):
      return lhsText == rhsText
    case (.integerLiteral(let lhsText), .integerLiteral(let rhsText)):
      return lhsText == rhsText
    case (.floatingLiteral(let lhsText), .floatingLiteral(let rhsText)):
      return lhsText == rhsText
    case (.stringLiteral(let lhsText), .stringLiteral(let rhsText)):
      return lhsText == rhsText
    default: return false
    }
  }
}
