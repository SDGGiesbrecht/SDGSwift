public struct Generic<Thing : RequiredConformance> : DeclaredConformanceOne, DeclaredConformanceTwo where Thing : ConformanceRequiredByWhere {

}

public struct DoubleGeneric<ThingA, ThingB> {}

public struct StandardFormGeneric<Thing> where Thing : Equatable {}
public struct DeprecatedFormGeneric<Thing : Equatable> {}
