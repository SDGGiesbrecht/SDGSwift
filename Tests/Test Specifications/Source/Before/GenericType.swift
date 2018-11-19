public struct Generic<Thing : RequiredConformance> : DeclaredConformanceOne, DeclaredConformanceTwo where Thing : ConformanceRequiredByWhere {

}

public struct DoubleGeneric<ThingA, ThingB> {}

public struct StandardFormGeneric<Thing> where Thing : Equatable {}
public struct DeprecatedFormGeneric<Thing : Equatable> {}
public struct DoubledDeprecatedFormGeneric<ThingA : Equatable, ThingB : Equatable> {}

public struct NestedGenericConstraint<Thing> where Thing : Collection, Thing.Element : Equatable, Thing.Associated == Thing.Generic<Int>, OtherThing == Generic<Int> {}
