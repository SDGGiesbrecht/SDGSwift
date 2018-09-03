public struct Generic<Thing : RequiredConformance> : DeclaredConformanceOne, DeclaredConformanceTwo where Thing : ConformanceRequiredByWhere {

}

public struct DoubleGeneric<ThingA, ThingB> {}
