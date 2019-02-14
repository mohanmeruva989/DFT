// # Proxy Compiler 18.9.4-973a4d-20181128

import Foundation
import SAPOData

open class AttachmentsType: EntityValue {
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    private static var attachmentID_: Property = GetFieldTicketDetailsMetadata.EntityTypes.attachmentsType.property(withName: "attachmentId")

    private static var dftNumber_: Property = GetFieldTicketDetailsMetadata.EntityTypes.attachmentsType.property(withName: "dftNumber")

    private static var attachmentName_: Property = GetFieldTicketDetailsMetadata.EntityTypes.attachmentsType.property(withName: "attachmentName")

    private static var dftAttachmentType_: Property = GetFieldTicketDetailsMetadata.EntityTypes.attachmentsType.property(withName: "dftAttachmentType")

    private static var createdByName_: Property = GetFieldTicketDetailsMetadata.EntityTypes.attachmentsType.property(withName: "createdByName")

    private static var createdOn_: Property = GetFieldTicketDetailsMetadata.EntityTypes.attachmentsType.property(withName: "createdOn")

    private static var updatedByName_: Property = GetFieldTicketDetailsMetadata.EntityTypes.attachmentsType.property(withName: "updatedByName")

    private static var updatedOn_: Property = GetFieldTicketDetailsMetadata.EntityTypes.attachmentsType.property(withName: "updatedOn")

    private static var attachmentUrl_: Property = GetFieldTicketDetailsMetadata.EntityTypes.attachmentsType.property(withName: "attachmentUrl")

    public init(withDefaults: Bool = true) {
        super.init(withDefaults: withDefaults, type: GetFieldTicketDetailsMetadata.EntityTypes.attachmentsType)
    }

    open class func array(from: EntityValueList) -> Array<AttachmentsType> {
        return ArrayConverter.convert(from.toArray(), Array<AttachmentsType>())
    }

    open class var attachmentID: Property {
        get {
            objc_sync_enter(AttachmentsType.self)
            defer { objc_sync_exit(AttachmentsType.self) }
            do {
                return AttachmentsType.attachmentID_
            }
        }
        set(value) {
            objc_sync_enter(AttachmentsType.self)
            defer { objc_sync_exit(AttachmentsType.self) }
            do {
                AttachmentsType.attachmentID_ = value
            }
        }
    }

    open var attachmentID: Int? {
        get {
            return IntValue.optional(self.optionalValue(for: AttachmentsType.attachmentID))
        }
        set(value) {
            self.setOptionalValue(for: AttachmentsType.attachmentID, to: IntValue.of(optional: value))
        }
    }

    open class var attachmentName: Property {
        get {
            objc_sync_enter(AttachmentsType.self)
            defer { objc_sync_exit(AttachmentsType.self) }
            do {
                return AttachmentsType.attachmentName_
            }
        }
        set(value) {
            objc_sync_enter(AttachmentsType.self)
            defer { objc_sync_exit(AttachmentsType.self) }
            do {
                AttachmentsType.attachmentName_ = value
            }
        }
    }

    open var attachmentName: String? {
        get {
            return StringValue.optional(self.optionalValue(for: AttachmentsType.attachmentName))
        }
        set(value) {
            self.setOptionalValue(for: AttachmentsType.attachmentName, to: StringValue.of(optional: value))
        }
    }

    open class var attachmentUrl: Property {
        get {
            objc_sync_enter(AttachmentsType.self)
            defer { objc_sync_exit(AttachmentsType.self) }
            do {
                return AttachmentsType.attachmentUrl_
            }
        }
        set(value) {
            objc_sync_enter(AttachmentsType.self)
            defer { objc_sync_exit(AttachmentsType.self) }
            do {
                AttachmentsType.attachmentUrl_ = value
            }
        }
    }

    open var attachmentUrl: String? {
        get {
            return StringValue.optional(self.optionalValue(for: AttachmentsType.attachmentUrl))
        }
        set(value) {
            self.setOptionalValue(for: AttachmentsType.attachmentUrl, to: StringValue.of(optional: value))
        }
    }

    open func copy() -> AttachmentsType {
        return CastRequired<AttachmentsType>.from(self.copyEntity())
    }

    open class var createdByName: Property {
        get {
            objc_sync_enter(AttachmentsType.self)
            defer { objc_sync_exit(AttachmentsType.self) }
            do {
                return AttachmentsType.createdByName_
            }
        }
        set(value) {
            objc_sync_enter(AttachmentsType.self)
            defer { objc_sync_exit(AttachmentsType.self) }
            do {
                AttachmentsType.createdByName_ = value
            }
        }
    }

    open var createdByName: String? {
        get {
            return StringValue.optional(self.optionalValue(for: AttachmentsType.createdByName))
        }
        set(value) {
            self.setOptionalValue(for: AttachmentsType.createdByName, to: StringValue.of(optional: value))
        }
    }

    open class var createdOn: Property {
        get {
            objc_sync_enter(AttachmentsType.self)
            defer { objc_sync_exit(AttachmentsType.self) }
            do {
                return AttachmentsType.createdOn_
            }
        }
        set(value) {
            objc_sync_enter(AttachmentsType.self)
            defer { objc_sync_exit(AttachmentsType.self) }
            do {
                AttachmentsType.createdOn_ = value
            }
        }
    }

    open var createdOn: LocalDateTime? {
        get {
            return LocalDateTime.castOptional(self.optionalValue(for: AttachmentsType.createdOn))
        }
        set(value) {
            self.setOptionalValue(for: AttachmentsType.createdOn, to: value)
        }
    }

    open class var dftAttachmentType: Property {
        get {
            objc_sync_enter(AttachmentsType.self)
            defer { objc_sync_exit(AttachmentsType.self) }
            do {
                return AttachmentsType.dftAttachmentType_
            }
        }
        set(value) {
            objc_sync_enter(AttachmentsType.self)
            defer { objc_sync_exit(AttachmentsType.self) }
            do {
                AttachmentsType.dftAttachmentType_ = value
            }
        }
    }

    open var dftAttachmentType: String? {
        get {
            return StringValue.optional(self.optionalValue(for: AttachmentsType.dftAttachmentType))
        }
        set(value) {
            self.setOptionalValue(for: AttachmentsType.dftAttachmentType, to: StringValue.of(optional: value))
        }
    }

    open class var dftNumber: Property {
        get {
            objc_sync_enter(AttachmentsType.self)
            defer { objc_sync_exit(AttachmentsType.self) }
            do {
                return AttachmentsType.dftNumber_
            }
        }
        set(value) {
            objc_sync_enter(AttachmentsType.self)
            defer { objc_sync_exit(AttachmentsType.self) }
            do {
                AttachmentsType.dftNumber_ = value
            }
        }
    }

    open var dftNumber: Int? {
        get {
            return IntValue.optional(self.optionalValue(for: AttachmentsType.dftNumber))
        }
        set(value) {
            self.setOptionalValue(for: AttachmentsType.dftNumber, to: IntValue.of(optional: value))
        }
    }

    open override var isProxy: Bool {
        return true
    }

    open class func key(attachmentID: Int?) -> EntityKey {
        return EntityKey().with(name: "attachmentId", value: IntValue.of(optional: attachmentID))
    }

    open var old: AttachmentsType {
        return CastRequired<AttachmentsType>.from(self.oldEntity)
    }

    open class var updatedByName: Property {
        get {
            objc_sync_enter(AttachmentsType.self)
            defer { objc_sync_exit(AttachmentsType.self) }
            do {
                return AttachmentsType.updatedByName_
            }
        }
        set(value) {
            objc_sync_enter(AttachmentsType.self)
            defer { objc_sync_exit(AttachmentsType.self) }
            do {
                AttachmentsType.updatedByName_ = value
            }
        }
    }

    open var updatedByName: String? {
        get {
            return StringValue.optional(self.optionalValue(for: AttachmentsType.updatedByName))
        }
        set(value) {
            self.setOptionalValue(for: AttachmentsType.updatedByName, to: StringValue.of(optional: value))
        }
    }

    open class var updatedOn: Property {
        get {
            objc_sync_enter(AttachmentsType.self)
            defer { objc_sync_exit(AttachmentsType.self) }
            do {
                return AttachmentsType.updatedOn_
            }
        }
        set(value) {
            objc_sync_enter(AttachmentsType.self)
            defer { objc_sync_exit(AttachmentsType.self) }
            do {
                AttachmentsType.updatedOn_ = value
            }
        }
    }

    open var updatedOn: LocalDateTime? {
        get {
            return LocalDateTime.castOptional(self.optionalValue(for: AttachmentsType.updatedOn))
        }
        set(value) {
            self.setOptionalValue(for: AttachmentsType.updatedOn, to: value)
        }
    }
}
