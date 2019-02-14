// # Proxy Compiler 18.9.4-973a4d-20181128

import Foundation
import SAPOData

public class GetFieldTicketDetailsMetadata {
    private static var document_: CSDLDocument = GetFieldTicketDetailsMetadata.resolve()

    public static var document: CSDLDocument {
        get {
            objc_sync_enter(GetFieldTicketDetailsMetadata.self)
            defer { objc_sync_exit(GetFieldTicketDetailsMetadata.self) }
            do {
                return GetFieldTicketDetailsMetadata.document_
            }
        }
        set(value) {
            objc_sync_enter(GetFieldTicketDetailsMetadata.self)
            defer { objc_sync_exit(GetFieldTicketDetailsMetadata.self) }
            do {
                GetFieldTicketDetailsMetadata.document_ = value
            }
        }
    }

    private static func resolve() -> CSDLDocument {
        try! GetFieldTicketDetailsFactory.registerAll()
        GetFieldTicketDetailsMetadataParser.parsed.hasGeneratedProxies = true
        return GetFieldTicketDetailsMetadataParser.parsed
    }

    public class EntityTypes {
        private static var attachmentsType_: EntityType = GetFieldTicketDetailsMetadataParser.parsed.entityType(withName: "DFT_XSJS.XSODATA.getFieldTicketDetails.xsodata.AttachmentsType")

        private static var changeLogsType_: EntityType = GetFieldTicketDetailsMetadataParser.parsed.entityType(withName: "DFT_XSJS.XSODATA.getFieldTicketDetails.xsodata.ChangeLogsType")

        private static var commentsType_: EntityType = GetFieldTicketDetailsMetadataParser.parsed.entityType(withName: "DFT_XSJS.XSODATA.getFieldTicketDetails.xsodata.CommentsType")

        private static var dftHeaderType_: EntityType = GetFieldTicketDetailsMetadataParser.parsed.entityType(withName: "DFT_XSJS.XSODATA.getFieldTicketDetails.xsodata.DFTHeaderType")

        public static var attachmentsType: EntityType {
            get {
                objc_sync_enter(GetFieldTicketDetailsMetadata.EntityTypes.self)
                defer { objc_sync_exit(GetFieldTicketDetailsMetadata.EntityTypes.self) }
                do {
                    return GetFieldTicketDetailsMetadata.EntityTypes.attachmentsType_
                }
            }
            set(value) {
                objc_sync_enter(GetFieldTicketDetailsMetadata.EntityTypes.self)
                defer { objc_sync_exit(GetFieldTicketDetailsMetadata.EntityTypes.self) }
                do {
                    GetFieldTicketDetailsMetadata.EntityTypes.attachmentsType_ = value
                }
            }
        }

        public static var changeLogsType: EntityType {
            get {
                objc_sync_enter(GetFieldTicketDetailsMetadata.EntityTypes.self)
                defer { objc_sync_exit(GetFieldTicketDetailsMetadata.EntityTypes.self) }
                do {
                    return GetFieldTicketDetailsMetadata.EntityTypes.changeLogsType_
                }
            }
            set(value) {
                objc_sync_enter(GetFieldTicketDetailsMetadata.EntityTypes.self)
                defer { objc_sync_exit(GetFieldTicketDetailsMetadata.EntityTypes.self) }
                do {
                    GetFieldTicketDetailsMetadata.EntityTypes.changeLogsType_ = value
                }
            }
        }

        public static var commentsType: EntityType {
            get {
                objc_sync_enter(GetFieldTicketDetailsMetadata.EntityTypes.self)
                defer { objc_sync_exit(GetFieldTicketDetailsMetadata.EntityTypes.self) }
                do {
                    return GetFieldTicketDetailsMetadata.EntityTypes.commentsType_
                }
            }
            set(value) {
                objc_sync_enter(GetFieldTicketDetailsMetadata.EntityTypes.self)
                defer { objc_sync_exit(GetFieldTicketDetailsMetadata.EntityTypes.self) }
                do {
                    GetFieldTicketDetailsMetadata.EntityTypes.commentsType_ = value
                }
            }
        }

        public static var dftHeaderType: EntityType {
            get {
                objc_sync_enter(GetFieldTicketDetailsMetadata.EntityTypes.self)
                defer { objc_sync_exit(GetFieldTicketDetailsMetadata.EntityTypes.self) }
                do {
                    return GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType_
                }
            }
            set(value) {
                objc_sync_enter(GetFieldTicketDetailsMetadata.EntityTypes.self)
                defer { objc_sync_exit(GetFieldTicketDetailsMetadata.EntityTypes.self) }
                do {
                    GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType_ = value
                }
            }
        }
    }

    public class EntitySets {
        private static var attachments_: EntitySet = GetFieldTicketDetailsMetadataParser.parsed.entitySet(withName: "Attachments")

        private static var changeLogs_: EntitySet = GetFieldTicketDetailsMetadataParser.parsed.entitySet(withName: "ChangeLogs")

        private static var comments_: EntitySet = GetFieldTicketDetailsMetadataParser.parsed.entitySet(withName: "Comments")

        private static var dftHeader_: EntitySet = GetFieldTicketDetailsMetadataParser.parsed.entitySet(withName: "DFTHeader")

        public static var attachments: EntitySet {
            get {
                objc_sync_enter(GetFieldTicketDetailsMetadata.EntitySets.self)
                defer { objc_sync_exit(GetFieldTicketDetailsMetadata.EntitySets.self) }
                do {
                    return GetFieldTicketDetailsMetadata.EntitySets.attachments_
                }
            }
            set(value) {
                objc_sync_enter(GetFieldTicketDetailsMetadata.EntitySets.self)
                defer { objc_sync_exit(GetFieldTicketDetailsMetadata.EntitySets.self) }
                do {
                    GetFieldTicketDetailsMetadata.EntitySets.attachments_ = value
                }
            }
        }

        public static var changeLogs: EntitySet {
            get {
                objc_sync_enter(GetFieldTicketDetailsMetadata.EntitySets.self)
                defer { objc_sync_exit(GetFieldTicketDetailsMetadata.EntitySets.self) }
                do {
                    return GetFieldTicketDetailsMetadata.EntitySets.changeLogs_
                }
            }
            set(value) {
                objc_sync_enter(GetFieldTicketDetailsMetadata.EntitySets.self)
                defer { objc_sync_exit(GetFieldTicketDetailsMetadata.EntitySets.self) }
                do {
                    GetFieldTicketDetailsMetadata.EntitySets.changeLogs_ = value
                }
            }
        }

        public static var comments: EntitySet {
            get {
                objc_sync_enter(GetFieldTicketDetailsMetadata.EntitySets.self)
                defer { objc_sync_exit(GetFieldTicketDetailsMetadata.EntitySets.self) }
                do {
                    return GetFieldTicketDetailsMetadata.EntitySets.comments_
                }
            }
            set(value) {
                objc_sync_enter(GetFieldTicketDetailsMetadata.EntitySets.self)
                defer { objc_sync_exit(GetFieldTicketDetailsMetadata.EntitySets.self) }
                do {
                    GetFieldTicketDetailsMetadata.EntitySets.comments_ = value
                }
            }
        }

        public static var dftHeader: EntitySet {
            get {
                objc_sync_enter(GetFieldTicketDetailsMetadata.EntitySets.self)
                defer { objc_sync_exit(GetFieldTicketDetailsMetadata.EntitySets.self) }
                do {
                    return GetFieldTicketDetailsMetadata.EntitySets.dftHeader_
                }
            }
            set(value) {
                objc_sync_enter(GetFieldTicketDetailsMetadata.EntitySets.self)
                defer { objc_sync_exit(GetFieldTicketDetailsMetadata.EntitySets.self) }
                do {
                    GetFieldTicketDetailsMetadata.EntitySets.dftHeader_ = value
                }
            }
        }
    }
}
