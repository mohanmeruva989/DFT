// # Proxy Compiler 18.9.4-973a4d-20181128

import Foundation
import SAPOData

internal class GetFieldTicketDetailsMetadataParser {
    internal static let options: Int = (CSDLOption.allowCaseConflicts | CSDLOption.disableFacetWarnings | CSDLOption.disableNameValidation | CSDLOption.processMixedVersions | CSDLOption.retainOriginalText | CSDLOption.ignoreUndefinedTerms)

    internal static let parsed: CSDLDocument = GetFieldTicketDetailsMetadataParser.parse()

    static func parse() -> CSDLDocument {
        let parser: CSDLParser = CSDLParser()
        parser.logWarnings = false
        parser.csdlOptions = GetFieldTicketDetailsMetadataParser.options
        let metadata: CSDLDocument = parser.parseInProxy(GetFieldTicketDetailsMetadataText.xml, url: "DFT_XSJS.XSODATA.getFieldTicketDetails.xsodata")
        metadata.proxyVersion = "18.9.4-973a4d-20181128"
        return metadata
    }
}
