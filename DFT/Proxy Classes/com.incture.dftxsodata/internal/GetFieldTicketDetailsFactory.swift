// # Proxy Compiler 18.9.4-973a4d-20181128

import Foundation
import SAPOData

internal class GetFieldTicketDetailsFactory {
    static func registerAll() throws {
        GetFieldTicketDetailsMetadata.EntityTypes.attachmentsType.registerFactory(ObjectFactory.with(create: { AttachmentsType(withDefaults: false) }, createWithDecoder: { d in try AttachmentsType(from: d) }))
        GetFieldTicketDetailsMetadata.EntityTypes.changeLogsType.registerFactory(ObjectFactory.with(create: { ChangeLogsType(withDefaults: false) }, createWithDecoder: { d in try ChangeLogsType(from: d) }))
        GetFieldTicketDetailsMetadata.EntityTypes.commentsType.registerFactory(ObjectFactory.with(create: { CommentsType(withDefaults: false) }, createWithDecoder: { d in try CommentsType(from: d) }))
        GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.registerFactory(ObjectFactory.with(create: { DFTHeaderType(withDefaults: false) }, createWithDecoder: { d in try DFTHeaderType(from: d) }))
        GetFieldTicketDetailsStaticResolver.resolve()
    }
}
