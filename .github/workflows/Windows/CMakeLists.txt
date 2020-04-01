

cmake_minimum_required(VERSION 3.15)

project("SDGSwift" LANGUAGES Swift)

include(CTest)

set(CMAKE_Swift_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/swift)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

option(BUILD_SHARED_LIBS "Use dynamic linking" YES)

add_library("SDGControlFlow"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGControlFlow/APILocalization.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGControlFlow/Assert.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGControlFlow/AutoreleasePool.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGControlFlow/Caching.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGControlFlow/Decodable.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGControlFlow/DefaultAssignmentPropertyWrapper.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGControlFlow/Encodable.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGControlFlow/NonmutatingVariants.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGControlFlow/ProjectingPropertyWrapper.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGControlFlow/PropertyWrapper.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGControlFlow/Shared.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGControlFlow/SharedProperty.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGControlFlow/SharedValueObserver.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGControlFlow/TextualPlaygroundDisplay.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGControlFlow/TransparentWrapper.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGControlFlow/Weak.swift"
)
set_target_properties("SDGControlFlow" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGControlFlow" PRIVATE -enable-testing)

add_library("SDGLogic"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLogic/Any.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLogic/Bool.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLogic/Equatable.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLogic/NilLiteral.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLogic/Operators.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLogic/Tuple.swift"
)
set_target_properties("SDGLogic" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGLogic" PRIVATE -enable-testing)

add_library("SDGMathematics"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Angle.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/BitField.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/ClosedRange.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Comparable.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Data.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Float.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/FunctionAnalysis.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Int.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Measurement.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/Addable.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/FixedScaleOneDimensionalPoint.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/GenericAdditiveArithmetic.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/IntegerProtocol.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/IntegralArithmetic.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/Negatable.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/NumericAdditiveArithmetic.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/OneDimensionalPoint.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/OneDimensionalVector.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/PointProtocol.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/RationalArithmetic.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/RationalNumberProtocol.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/RationalVector.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/RealArithmetic.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/RealNumberProtocol.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/Subtractable.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/VectorProtocol.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/WholeArithmetic.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Numeric Protocols/WholeNumberProtocol.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Operators.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/OrderedEnumeration.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Sequence.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/Tuple.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGMathematics/UInt.swift"
)
set_target_properties("SDGMathematics" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGMathematics" PRIVATE -enable-testing)
target_link_libraries("SDGMathematics" PRIVATE
  "SDGControlFlow"
  "SDGLogic"
)

add_library("SDGCollections"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Addable.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Associative/BijectiveMapping.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Associative/ContextualMapping.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Associative/Dictionary.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Conformances/CharacterSet.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Conformances/Data.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Conformances/String.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/LegacyMode.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Operators.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/AnyCollection.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/Array.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/BidirectionalCollection.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/Collection.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/CollectionDifference.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/CollectionDifferenceChange.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/FillDirection.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/Patterns/AlternativePatterns.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/Patterns/AnyPattern.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/Patterns/ConcatenatedPatterns.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/Patterns/ConditionalPattern.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/Patterns/NaryAlternativePatterns.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/Patterns/NaryConcatenatedPatterns.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/Patterns/NegatedPattern.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/Patterns/NestingLevel.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/Patterns/Pattern.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/Patterns/PatternConsumption.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/Patterns/PatternMatch.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/Patterns/RepetitionPattern.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/Range.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/RangeExpression.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/RangeReplaceableCollection.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/ReversedCollection.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/SearchableBidirectionalCollection.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/SearchableCollection.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Ordered/Slice.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Unordered/AbsoluteComplement.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Unordered/ComparableSet.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Unordered/FiniteSet.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Unordered/IntensionalSet.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Unordered/Intersection.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Unordered/MutableSet.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Unordered/Set.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Unordered/SetDefinition.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Unordered/SetInRepresentableUniverse.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCollections/Unordered/Union.swift"
)
set_target_properties("SDGCollections" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGCollections" PRIVATE -enable-testing)
target_link_libraries("SDGCollections" PRIVATE
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
)

add_library("SDGText"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/Array.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/CharacterSet.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/Collection.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/Compatibility/StaticString.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/Compatibility/String.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/Compatibility/StringClusterView.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/Compatibility/StringScalarView.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/ExtendedGraphemeCluster.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/Font.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/MarkupPlaygroundDisplay.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/Range.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/SemanticMarkup.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/SemanticMarkupStringInterpolation.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/Strict/StrictString.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/Strict/StrictStringClusterView.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/Strict/StrictStringInterpolationProtocol.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/Strict/StrictStringStringInterpolation.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/String Family/ExtendedGraphemeClusterView.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/String Family/Line.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/String Family/LineView.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/String Family/LineViewIndex.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/String Family/NewlinePattern.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/String Family/StringFamily.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/String Family/StringIndex.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/String Family/UnicodeScalarView.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGText/UnicodeScalar.swift"
)
set_target_properties("SDGText" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGText" PRIVATE -enable-testing)
target_link_libraries("SDGText" PRIVATE
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
  "SDGCollections"
)

add_library("SDGPersistence"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGPersistence/Data.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGPersistence/FileConvertible.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGPersistence/FileManager.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGPersistence/Preference.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGPersistence/PreferenceSet.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGPersistence/ProcessInfo.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGPersistence/StrictString.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGPersistence/String.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGPersistence/URL.swift"
)
set_target_properties("SDGPersistence" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGPersistence" PRIVATE -enable-testing)
target_link_libraries("SDGPersistence" PRIVATE
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
  "SDGCollections"
  "SDGText"
)

add_library("SDGLocalization"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/CachedLocalization.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/Bool.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/Decodable.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/LosslessStringConvertible.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/Numbers/Angle.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/Numbers/Float.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/Numbers/Int.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/Numbers/IntegerProtcool.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/Numbers/IntegralArithmetic.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/Numbers/RationalArithmetic.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/Numbers/RationalNumberProtocol.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/Numbers/UInt.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/Numbers/WholeArithmetic.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/Numbers/WholeNumberProtocol.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/Precondition.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/PresentableError.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/Range.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/TextConvertibleNumber.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Extensions/TextConvertibleNumberParseError.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/InputLocalization.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Interpolation/Casing.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Interpolation/EnglishCasing.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Interpolation/GenreGrammatical.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Interpolation/GrammaticalGender.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Interpolation/GrammaticalNumber.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Interpolation/GrammatikiPtosi.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Localization.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/LocalizationSetting.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/LocalizationSettingStabilizationMode.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Localizations/APILocalization.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Localizations/AnyLocalization.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Localizations/ContentLocalization.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Localizations/FormatLocalization.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Localizations/InterfaceLocalization.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Metadata/Language.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Metadata/LocalizationData.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Metadata/Script.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Metadata/State.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Metadata/StateData.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/Metadata/TextDirection.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/UserFacing.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalization/UserFacingDynamic.swift"
)
set_target_properties("SDGLocalization" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGLocalization" PRIVATE -enable-testing)
target_link_libraries("SDGLocalization" PRIVATE
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
  "SDGCollections"
  "SDGText"
  "SDGPersistence"
)

add_library("SDGCornerstoneLocalizations"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCornerstoneLocalizations/APILocalization.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCornerstoneLocalizations/FormatLocalization.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCornerstoneLocalizations/InterfaceLocalization.swift"
)
set_target_properties("SDGCornerstoneLocalizations" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGCornerstoneLocalizations" PRIVATE -enable-testing)
target_link_libraries("SDGCornerstoneLocalizations" PRIVATE
  "SDGControlFlow"
  "SDGLocalization"
)

add_library("SDGCalendar"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Abstract Components/CalendarComponent.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Abstract Components/CardinalCalendarComponent.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Abstract Components/ConsistentDurationCalendarComponent.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Abstract Components/ConsistentlyOrderedCalendarComponent.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Abstract Components/Day.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Abstract Components/EnumerationCalendarComponent.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Abstract Components/ICalendarComponent.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Abstract Components/ISOCalendarComponent.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Abstract Components/Month.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Abstract Components/NumericCalendarComponent.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Abstract Components/OrdinalCalendarComponent.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Abstract Components/RawRepresentableCalendarComponent.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Abstract Components/SmallestCalendarComponent.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Abstract Components/Weekday.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Abstract Components/Year.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/AnyDescribableDate.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/CalendarDate.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/CalendarInterval.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Date.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/DateDefinition.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/DescribableDate.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/FoundationDate.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Gregorian/GregorianDate.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Gregorian/GregorianDay.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Gregorian/GregorianHour.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Gregorian/GregorianMinute.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Gregorian/GregorianMonth.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Gregorian/GregorianSecond.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Gregorian/GregorianWeekday.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Gregorian/GregorianWeekdayDate.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Gregorian/GregorianYear.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Hebrew/HebrewDate.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Hebrew/HebrewDay.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Hebrew/HebrewHour.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Hebrew/HebrewMonth.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Hebrew/HebrewMonthAndYear.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Hebrew/HebrewPart.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Hebrew/HebrewWeekday.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Hebrew/HebrewWeekdayDate.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Hebrew/HebrewYear.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/Hebrew/HebrewYearLength.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/RationalArithmetic.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/RelativeDate.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGCalendar/UnknownDate.swift"
)
set_target_properties("SDGCalendar" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGCalendar" PRIVATE -enable-testing)
target_link_libraries("SDGCalendar" PRIVATE
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
  "SDGCollections"
  "SDGText"
  "SDGLocalization"
  "SDGCornerstoneLocalizations"
)

add_library("SDGExternalProcess"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGExternalProcess/ExternalProcess.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGExternalProcess/ExternalProcessError.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGExternalProcess/LegacyMode.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGExternalProcess/Shell.swift"
)
set_target_properties("SDGExternalProcess" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGExternalProcess" PRIVATE -enable-testing)
target_link_libraries("SDGExternalProcess" PRIVATE
  "SDGControlFlow"
  "SDGLogic"
  "SDGText"
  "SDGPersistence"
  "SDGLocalization"
)

add_library("SDGTesting"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGTesting/PerformanceTest.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGTesting/Test.swift"
)
set_target_properties("SDGTesting" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGTesting" PRIVATE -enable-testing)
target_link_libraries("SDGTesting" PRIVATE
  "SDGControlFlow"
  "SDGMathematics"
  "SDGText"
  "SDGLocalization"
  "SDGCornerstoneLocalizations"
)

add_library("SDGLogicTestUtilities"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLogicTestUtilities/Equatable.swift"
)
set_target_properties("SDGLogicTestUtilities" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGLogicTestUtilities" PRIVATE -enable-testing)
target_link_libraries("SDGLogicTestUtilities" PRIVATE
  "SDGLogic"
  "SDGTesting"
)

add_library("SDGPersistenceTestUtilities"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGPersistenceTestUtilities/Codable.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGPersistenceTestUtilities/FileConvertible.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGPersistenceTestUtilities/Specification.swift"
)
set_target_properties("SDGPersistenceTestUtilities" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGPersistenceTestUtilities" PRIVATE -enable-testing)
target_link_libraries("SDGPersistenceTestUtilities" PRIVATE
  "SDGPersistence"
  "SDGTesting"
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
  "SDGCollections"
  "SDGText"
  "SDGLocalization"
  "SDGCalendar"
  "SDGCornerstoneLocalizations"
)

add_library("SDGLocalizationTestUtilities"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGLocalizationTestUtilities/CustomStringConvertible.swift"
)
set_target_properties("SDGLocalizationTestUtilities" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGLocalizationTestUtilities" PRIVATE -enable-testing)
target_link_libraries("SDGLocalizationTestUtilities" PRIVATE
  "SDGLocalization"
  "SDGTesting"
  "SDGText"
  "SDGPersistence"
  "SDGPersistenceTestUtilities"
)

add_library("SDGVersioning"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGVersioning/Version.swift"
)
set_target_properties("SDGVersioning" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGVersioning" PRIVATE -enable-testing)
target_link_libraries("SDGVersioning" PRIVATE
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
  "SDGCollections"
  "SDGText"
  "SDGLocalization"
  "SDGCornerstoneLocalizations"
)

add_library("SDGXCTestUtilities"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGXCTestUtilities/TestCase.swift"
  "../../../.build/SDG/Dependencies/SDGCornerstone/Sources/SDGXCTestUtilities/XCTAssert.swift"
)
set_target_properties("SDGXCTestUtilities" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGXCTestUtilities" PRIVATE -enable-testing)
target_link_libraries("SDGXCTestUtilities" PRIVATE
  "SDGTesting"
  "SDGLogic"
  "SDGMathematics"
  "SDGText"
  "SDGPersistence"
)

add_library("SDGSwiftConfiguration"
  "../../../Sources/SDGSwiftConfiguration/Configuration.swift"
  "../../../Sources/SDGSwiftConfiguration/Context.swift"
  "../../../Sources/SDGSwiftConfiguration/Export.swift"
)
set_target_properties("SDGSwiftConfiguration" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGSwiftConfiguration" PRIVATE -enable-testing)

add_library("SDGSwiftLocalizations"
  "../../../Sources/SDGSwiftLocalizations/APILocalization.swift"
  "../../../Sources/SDGSwiftLocalizations/InterfaceLocalization.swift"
)
set_target_properties("SDGSwiftLocalizations" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGSwiftLocalizations" PRIVATE -enable-testing)
target_link_libraries("SDGSwiftLocalizations" PRIVATE
  "SDGLocalization"
)

add_library("SDGSwift"
  "../../../Sources/SDGSwift/Build.swift"
  "../../../Sources/SDGSwift/Git.swift"
  "../../../Sources/SDGSwift/PackageRepository.swift"
  "../../../Sources/SDGSwift/PackageStructure.swift"
  "../../../Sources/SDGSwift/PackageStructureBuildError.swift"
  "../../../Sources/SDGSwift/PackageStructureExecutionError.swift"
  "../../../Sources/SDGSwift/SwiftCompiler.swift"
  "../../../Sources/SDGSwift/VersionedExternalProcess.swift"
  "../../../Sources/SDGSwift/VersionedExternalProcessExecutionError.swift"
  "../../../Sources/SDGSwift/VersionedExternalProcessLocationError.swift"
)
set_target_properties("SDGSwift" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGSwift" PRIVATE -enable-testing)
target_link_libraries("SDGSwift" PRIVATE
  "SDGSwiftLocalizations"
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
  "SDGCollections"
  "SDGText"
  "SDGLocalization"
  "SDGExternalProcess"
  "SDGVersioning"
)

add_library("SDGSwiftConfigurationLoading"
  "../../../Sources/SDGSwiftConfigurationLoading/Configuration.swift"
  "../../../Sources/SDGSwiftConfigurationLoading/ConfigurationError.swift"
  "../../../Sources/SDGSwiftConfigurationLoading/Resources.swift"
)
set_target_properties("SDGSwiftConfigurationLoading" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGSwiftConfigurationLoading" PRIVATE -enable-testing)
target_link_libraries("SDGSwiftConfigurationLoading" PRIVATE
  "SDGSwiftLocalizations"
  "SDGSwiftConfiguration"
  "SDGSwift"
  "SDGLogic"
  "SDGText"
  "SDGLocalization"
  "SDGVersioning"
)

add_library("SDGSwiftPackageManager"
  "../../../Sources/SDGSwiftPackageManager/CoverageRegion.swift"
  "../../../Sources/SDGSwiftPackageManager/FileTestCoverage.swift"
  "../../../Sources/SDGSwiftPackageManager/Git.swift"
  "../../../Sources/SDGSwiftPackageManager/PackageRepository.swift"
  "../../../Sources/SDGSwiftPackageManager/PackageRepositoryInitializationError.swift"
  "../../../Sources/SDGSwiftPackageManager/String.swift"
  "../../../Sources/SDGSwiftPackageManager/SwiftCompiler.swift"
  "../../../Sources/SDGSwiftPackageManager/SwiftCompilerCoverageReportingError.swift"
  "../../../Sources/SDGSwiftPackageManager/SwiftCompilerManifestLoadingError.swift"
  "../../../Sources/SDGSwiftPackageManager/TestCoverageReport.swift"
)
set_target_properties("SDGSwiftPackageManager" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGSwiftPackageManager" PRIVATE -enable-testing)
target_link_libraries("SDGSwiftPackageManager" PRIVATE
  "SDGSwift"
  "SDGSwiftLocalizations"
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
  "SDGCollections"
  "SDGText"
  "SDGLocalization"
  "SDGVersioning"
)

add_library("SDGSwiftTestUtilities"
  "../../../Tests/SDGSwiftTestUtilities/ProcessInfo.swift"
  "../../../Tests/SDGSwiftTestUtilities/Repositories.swift"
  "../../../Tests/SDGSwiftTestUtilities/TestCase.swift"
)
set_target_properties("SDGSwiftTestUtilities" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGSwiftTestUtilities" PRIVATE -enable-testing)
target_link_libraries("SDGSwiftTestUtilities" PRIVATE
  "SDGSwift"
  "SDGSwiftPackageManager"
  "SDGLogic"
  "SDGText"
  "SDGPersistence"
  "SDGExternalProcess"
  "SDGVersioning"
  "SDGXCTestUtilities"
)

add_library("SDGSwiftDocumentationExampleTests"
  "../../../Tests/SDGSwiftDocumentationExampleTests/ReadMeExampleTests.swift"
)
set_target_properties("SDGSwiftDocumentationExampleTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGSwiftDocumentationExampleTests" PRIVATE -enable-testing)
target_link_libraries("SDGSwiftDocumentationExampleTests" PRIVATE
  "SDGSwift"
  "SDGSwiftTestUtilities"
  "SDGVersioning"
  "SDGXCTestUtilities"
)

add_library("SDGSwiftPackageManagerTests"
  "../../../Tests/SDGSwiftPackageManagerTests/APITests.swift"
)
set_target_properties("SDGSwiftPackageManagerTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGSwiftPackageManagerTests" PRIVATE -enable-testing)
target_link_libraries("SDGSwiftPackageManagerTests" PRIVATE
  "SDGSwift"
  "SDGSwiftPackageManager"
  "SDGSwiftLocalizations"
  "SDGSwiftTestUtilities"
  "SDGText"
  "SDGPersistence"
  "SDGLocalization"
  "SDGLocalizationTestUtilities"
  "SDGPersistenceTestUtilities"
  "SDGXCTestUtilities"
)

add_library("SDGSwiftTests"
  "../../../Tests/SDGSwiftTests/APITests.swift"
  "../../../Tests/SDGSwiftTests/RegressionTests.swift"
)
set_target_properties("SDGSwiftTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGSwiftTests" PRIVATE -enable-testing)
target_link_libraries("SDGSwiftTests" PRIVATE
  "SDGSwiftLocalizations"
  "SDGSwift"
  "SDGSwiftTestUtilities"
  "SDGCollections"
  "SDGText"
  "SDGLocalization"
  "SDGVersioning"
  "SDGLogicTestUtilities"
  "SDGLocalizationTestUtilities"
  "SDGXCTestUtilities"
)

add_library("SDGXcode"
  "../../../Sources/SDGXcode/PackageRepository.swift"
  "../../../Sources/SDGXcode/SwiftCompiler.swift"
  "../../../Sources/SDGXcode/Xcode.swift"
  "../../../Sources/SDGXcode/XcodeCoverageReportingError.swift"
  "../../../Sources/SDGXcode/XcodeSDK.swift"
  "../../../Sources/SDGXcode/XcodeSchemeError.swift"
)
set_target_properties("SDGXcode" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGXcode" PRIVATE -enable-testing)
target_link_libraries("SDGXcode" PRIVATE
  "SDGSwift"
  "SDGSwiftPackageManager"
  "SDGSwiftLocalizations"
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
  "SDGCollections"
  "SDGText"
  "SDGLocalization"
  "SDGExternalProcess"
  "SDGVersioning"
)

add_library("SDGXcodeTests"
  "../../../Tests/SDGXcodeTests/APITests.swift"
  "../../../Tests/SDGXcodeTests/RegressionTests.swift"
)
set_target_properties("SDGXcodeTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGXcodeTests" PRIVATE -enable-testing)
target_link_libraries("SDGXcodeTests" PRIVATE
  "SDGXcode"
  "SDGSwift"
  "SDGSwiftLocalizations"
  "SDGSwiftTestUtilities"
  "SDGLogic"
  "SDGCollections"
  "SDGText"
  "SDGPersistence"
  "SDGLocalization"
  "SDGVersioning"
  "SDGPersistenceTestUtilities"
  "SDGLocalizationTestUtilities"
  "SDGXCTestUtilities"
)

add_library("SampleConfiguration"
  "../../../Sources/SampleConfiguration/SampleConfiguration.swift"
  "../../../Sources/SampleConfiguration/SampleContext.swift"
)
set_target_properties("SampleConfiguration" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SampleConfiguration" PRIVATE -enable-testing)
target_link_libraries("SampleConfiguration" PRIVATE
  "SDGSwiftConfiguration"
)

add_library("SDGSwiftConfigurationTests"
  "../../../Tests/SDGSwiftConfigurationTests/APITests.swift"
  "../../../Tests/SDGSwiftConfigurationTests/InternalTests.swift"
)
set_target_properties("SDGSwiftConfigurationTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGSwiftConfigurationTests" PRIVATE -enable-testing)
target_link_libraries("SDGSwiftConfigurationTests" PRIVATE
  "SDGSwift"
  "SDGSwiftConfiguration"
  "SDGSwiftConfigurationLoading"
  "SDGSwiftTestUtilities"
  "SampleConfiguration"
  "SDGLogic"
  "SDGCollections"
  "SDGText"
  "SDGLocalization"
  "SDGVersioning"
  "SDGPersistenceTestUtilities"
  "SDGLocalizationTestUtilities"
  "SDGXCTestUtilities"
)

add_library("SDGWebLocalizations"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGWebLocalizations/InterfaceLocalization.swift"
)
set_target_properties("SDGWebLocalizations" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGWebLocalizations" PRIVATE -enable-testing)
target_link_libraries("SDGWebLocalizations" PRIVATE
  "SDGLocalization"
)

add_library("SDGHTML"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/AnyLocalization.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Entities.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/HTML.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Localization.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Syntax/ContentSyntaxKind.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Syntax/Nodes/AttributeSyntax.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Syntax/Nodes/AttributeValueSyntax.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Syntax/Nodes/AttributesSyntax.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Syntax/Nodes/ClosingTagSyntax.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Syntax/Nodes/CommentSyntax.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Syntax/Nodes/ContentSyntax+Factories.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Syntax/Nodes/ContentSyntax.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Syntax/Nodes/DocumentSyntax+Factories.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Syntax/Nodes/DocumentSyntax.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Syntax/Nodes/ElementContinuationSyntax.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Syntax/Nodes/ElementSyntax+Factories.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Syntax/Nodes/ElementSyntax.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Syntax/Nodes/ListSyntax.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Syntax/Nodes/ListSyntaxAttributeSyntax.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Syntax/Nodes/ListSyntaxContentSyntax.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Syntax/Nodes/OpeningTagSyntax.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Syntax/Nodes/TextSyntax.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Syntax/Nodes/TokenSyntax.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Syntax/Protocols/AttributedSyntax.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Syntax/Protocols/ContainerSyntax.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Syntax/Protocols/NamedSyntax.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Syntax/Protocols/Syntax.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Syntax/SyntaxError.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Syntax/SyntaxStorage.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Syntax/SyntaxUnfolder.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Syntax/SyntaxUnfolderContext.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Syntax/SyntaxUnfolderError.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Syntax/SyntaxUnfolderProtocol.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Syntax/TokenKind.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/Syntax/UnfoldingError.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/TextDirection.swift"
  "../../../.build/SDG/Dependencies/SDGWeb/Sources/SDGHTML/UnicodeScalar.swift"
)
set_target_properties("SDGHTML" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGHTML" PRIVATE -enable-testing)
target_link_libraries("SDGHTML" PRIVATE
  "SDGWebLocalizations"
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
  "SDGCollections"
  "SDGText"
  "SDGLocalization"
)

add_library("SDGSwiftSource"
  "../../../Sources/SDGSwiftSource/API/APIElement.swift"
  "../../../Sources/SDGSwiftSource/API/ConformanceReference.swift"
  "../../../Sources/SDGSwiftSource/API/Protocols/APIElementProtocol.swift"
  "../../../Sources/SDGSwiftSource/API/Protocols/APIElementStorage.swift"
  "../../../Sources/SDGSwiftSource/API/Protocols/DeclaredAPIElement.swift"
  "../../../Sources/SDGSwiftSource/API/Protocols/NonOverloadableAPIElement.swift"
  "../../../Sources/SDGSwiftSource/API/Protocols/OverloadableAPIElement.swift"
  "../../../Sources/SDGSwiftSource/API/Protocols/SortableAPIElement.swift"
  "../../../Sources/SDGSwiftSource/API/Protocols/UndeclaredAPIElementProtocol.swift"
  "../../../Sources/SDGSwiftSource/API/Protocols/UndeclaredAPIElementStorage.swift"
  "../../../Sources/SDGSwiftSource/API/Protocols/UniquelyDeclaredAPIElement.swift"
  "../../../Sources/SDGSwiftSource/API/Protocols/UniquelyDeclaredManifestAPIElement.swift"
  "../../../Sources/SDGSwiftSource/API/Protocols/UniquelyDeclaredOverloadableAPIElement.swift"
  "../../../Sources/SDGSwiftSource/API/Protocols/UniquelyDeclaredSyntaxAPIElement.swift"
  "../../../Sources/SDGSwiftSource/API/SymbolDocumentation.swift"
  "../../../Sources/SDGSwiftSource/API/Types/CaseAPI.swift"
  "../../../Sources/SDGSwiftSource/API/Types/ConformanceAPI.swift"
  "../../../Sources/SDGSwiftSource/API/Types/ExtensionAPI.swift"
  "../../../Sources/SDGSwiftSource/API/Types/FunctionAPI.swift"
  "../../../Sources/SDGSwiftSource/API/Types/InitializerAPI.swift"
  "../../../Sources/SDGSwiftSource/API/Types/LibraryAPI.swift"
  "../../../Sources/SDGSwiftSource/API/Types/ModuleAPI.swift"
  "../../../Sources/SDGSwiftSource/API/Types/OperatorAPI.swift"
  "../../../Sources/SDGSwiftSource/API/Types/PackageAPI.swift"
  "../../../Sources/SDGSwiftSource/API/Types/PrecedenceAPI.swift"
  "../../../Sources/SDGSwiftSource/API/Types/ProtocolAPI.swift"
  "../../../Sources/SDGSwiftSource/API/Types/SubscriptAPI.swift"
  "../../../Sources/SDGSwiftSource/API/Types/TypeAPI.swift"
  "../../../Sources/SDGSwiftSource/API/Types/VariableAPI.swift"
  "../../../Sources/SDGSwiftSource/CMark/CMarkNode.swift"
  "../../../Sources/SDGSwiftSource/General Extensions/Mergeable.swift"
  "../../../Sources/SDGSwiftSource/General Extensions/NSCache.swift"
  "../../../Sources/SDGSwiftSource/General Extensions/Optional.swift"
  "../../../Sources/SDGSwiftSource/General Extensions/String.swift"
  "../../../Sources/SDGSwiftSource/Miscellaneous/Callout.swift"
  "../../../Sources/SDGSwiftSource/Miscellaneous/ParameterDocumentation.swift"
  "../../../Sources/SDGSwiftSource/Miscellaneous/TextFreedom.swift"
  "../../../Sources/SDGSwiftSource/Resources.swift"
  "../../../Sources/SDGSwiftSource/Scanners/FunctionalSyntaxScanner.swift"
  "../../../Sources/SDGSwiftSource/Scanners/SyntaxScanner.swift"
  "../../../Sources/SDGSwiftSource/Scanners/TriviaNormalizer.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Extended Syntax Nodes/BlockCommentSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Extended Syntax Nodes/BlockDeveloperCommentSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Extended Syntax Nodes/BlockDocumentationSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Extended Syntax Nodes/CalloutSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Extended Syntax Nodes/CodeFragmentSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Extended Syntax Nodes/CommentSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Extended Syntax Nodes/ExtendedSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Extended Syntax Nodes/ExtendedTokenKind.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Extended Syntax Nodes/ExtendedTokenSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Extended Syntax Nodes/FragmentSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Extended Syntax Nodes/LineCommentSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Extended Syntax Nodes/LineDeveloperCommentSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Extended Syntax Nodes/LineDocumentationSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Extended Syntax Nodes/Markdown/CodeBlockSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Extended Syntax Nodes/Markdown/DocumentationSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Extended Syntax Nodes/Markdown/FontSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Extended Syntax Nodes/Markdown/HeadingSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Extended Syntax Nodes/Markdown/ImageSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Extended Syntax Nodes/Markdown/InlineCodeSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Extended Syntax Nodes/Markdown/LineSeparatorSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Extended Syntax Nodes/Markdown/LinkSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Extended Syntax Nodes/Markdown/ListEntrySyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Extended Syntax Nodes/Markdown/ListSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Extended Syntax Nodes/Markdown/MarkdownSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Extended Syntax Nodes/Markdown/ParagraphSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Extended Syntax Nodes/Markdown/QuotationSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Extended Syntax Nodes/ParametersCalloutSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Extended Syntax Nodes/SourceHeading.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Extended Syntax Nodes/StringLiteralSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Fragmentation/ExtendedSyntaxContext.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Fragmentation/SyntaxContext.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Fragmentation/SyntaxFragment.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Fragmentation/TriviaContext.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Fragmentation/TriviaPieceContext.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Protocols/APIDeclaration.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Protocols/APISyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Protocols/AccessControlled.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Protocols/Accessor.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Protocols/Attributed.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Protocols/Constrained.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Protocols/Generic.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Protocols/Hidable.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Protocols/Inheritor.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Protocols/Member.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Protocols/OverloadableAPIDeclaration.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Protocols/OverridableDeclaration.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Protocols/PatternSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Protocols/SyntaxProtocol.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Protocols/TypeDeclaration.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Protocols/TypeSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/ArrayTypeSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/AssociatedtypeDeclSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/AttributeListSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/AttributeSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/AttributedTypeSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/AvailabilityArgumentSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/AvailabilityLabeledArgumentSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/AvailabilitySpecListSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/AvailabilityVersionRestrictionSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/ClassDeclSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/ClassRestrictionTypeSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/CompositionTypeElementListSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/CompositionTypeElementSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/CompositionTypeSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/ConformanceRequirementSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/CustomAttributeSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/DeclModifierSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/DictoinaryTypeSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/EnumCaseDeclSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/EnumCaseElementListSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/EnumCaseElementSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/EnumDeclSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/ExtensionDeclSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/FunctionCallExprSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/FunctionDeclSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/FunctionParameterListSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/FunctionParameterSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/FunctionSignatureSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/FunctionTypeSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/GenericArgumentClauseSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/GenericArgumentListSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/GenericArgumentSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/GenericParameterClauseSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/GenericParameterListSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/GenericParameterSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/GenericRequirementListSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/GenericRequirementSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/GenericWhereClauseSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/IdentifierListSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/IdentifierPatternSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/IfConfigDeclSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/ImplicitlyUnwrappedOptionalSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/InitializerClauseSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/InitializerDeclSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/MemberTypeIdentifierSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/MetatypeTypeSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/ModifierListSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/OperatorDeclSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/OperatorPrecedenceAndTypesSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/OptionalTypeSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/ParameterClauseSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/PatternBindingListSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/PatternBindingSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/PrecedenceGroupAssignmentSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/PrecedenceGroupAssociativitySyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/PrecedenceGroupAttributeListSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/PrecedenceGroupDeclSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/PrecedenceGroupNameElementSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/PrecedenceGroupNameListSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/PrecedenceGroupRelationSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/ProtocolDeclSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/ReturnClauseSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/SameTypeRequirementSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/SimpleTypeIdentifierSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/StructDeclSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/SubscriptDeclSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/TokenKind.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/TokenSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/Trivia.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/TriviaPiece.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/TupleTypeElementListSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/TupleTypeElementSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/TupleTypeSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/TypeAnnotationSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/TypeInheritanceClauseSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/TypealiasDeclSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/VariableDeclSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/Syntax Nodes/Types/VersionTupleSyntax.swift"
  "../../../Sources/SDGSwiftSource/Syntax/SyntaxFactory.swift"
  "../../../Sources/SDGSwiftSource/SyntaxHighlighter.swift"
  "../../../Sources/SDGSwiftSource/SyntaxParser.swift"
)
set_target_properties("SDGSwiftSource" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGSwiftSource" PRIVATE -enable-testing)
target_link_libraries("SDGSwiftSource" PRIVATE
  "SDGSwift"
  "SDGSwiftPackageManager"
  "SDGSwiftLocalizations"
  "SDGControlFlow"
  "SDGLogic"
  "SDGMathematics"
  "SDGCollections"
  "SDGText"
  "SDGPersistence"
  "SDGLocalization"
  "SDGHTML"
)

add_library("SDGSwiftSourceTests"
  "../../../Tests/SDGSwiftSourceTests/APITests.swift"
  "../../../Tests/SDGSwiftSourceTests/Helpers/APIElement.swift"
  "../../../Tests/SDGSwiftSourceTests/Helpers/DocumentationSyntax.swift"
  "../../../Tests/SDGSwiftSourceTests/Helpers/ExtensionAPI.swift"
  "../../../Tests/SDGSwiftSourceTests/Helpers/FunctionCallExprSyntax.swift"
  "../../../Tests/SDGSwiftSourceTests/Helpers/HTML.swift"
  "../../../Tests/SDGSwiftSourceTests/Helpers/Highlighter.swift"
  "../../../Tests/SDGSwiftSourceTests/Helpers/TextFreedomHighlighter.swift"
  "../../../Tests/SDGSwiftSourceTests/InternalTests.swift"
  "../../../Tests/SDGSwiftSourceTests/RegressionTests.swift"
  "../../../Tests/SDGSwiftSourceTests/Repository.swift"
)
set_target_properties("SDGSwiftSourceTests" PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_compile_options("SDGSwiftSourceTests" PRIVATE -enable-testing)
target_link_libraries("SDGSwiftSourceTests" PRIVATE
  "SDGSwift"
  "SDGSwiftLocalizations"
  "SDGSwiftSource"
  "SDGSwiftTestUtilities"
  "SDGLogic"
  "SDGMathematics"
  "SDGCollections"
  "SDGLogicTestUtilities"
  "SDGPersistenceTestUtilities"
  "SDGLocalizationTestUtilities"
  "SDGXCTestUtilities"
)

add_executable(WindowsMain
  WindowsMain.swift
)
target_link_libraries(WindowsMain PRIVATE
  "SDGSwiftDocumentationExampleTests"
  "SDGSwiftPackageManagerTests"
  "SDGSwiftTests"
  "SDGXcodeTests"
  "SDGSwiftConfigurationTests"
  "SDGSwiftSourceTests"
)
add_test(NAME WindowsMain COMMAND WindowsMain)
set_property(TEST WindowsMain PROPERTY ENVIRONMENT "LD_LIBRARY_PATH=${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")
