
/// A parameter list in symbol documentation.
public class DocumentationParameterList : DocumentationCallout {

    internal init(callout: DocumentationCallout, parameters: [DocumentationListElement], in source: String) {
        var parameterList: [DocumentationParameterListEntry] = []
        for parameter in parameters {
            if let parsed = DocumentationParameterListEntry(entry: parameter, in: source) {
                parameterList.append(parsed)
            }
        }
        self.parameters = parameterList
        super.init(bullet: callout.bullet, callout: callout.callout, colon: callout.colon, end: parameterList.last?.range.upperBound ?? callout.range.upperBound, in: source, knownChildren: parameterList)
    }

    // MARK: - Properties

    /// The individual parameters.
    public let parameters: [DocumentationParameterListEntry]
}
