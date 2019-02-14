// # Proxy Compiler 18.9.4-973a4d-20181128

import Foundation
import SAPOData

open class ChangeLogsType: EntityValue {
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    private static var activityID_: Property = GetFieldTicketDetailsMetadata.EntityTypes.changeLogsType.property(withName: "activityId")

    private static var dftNumber_: Property = GetFieldTicketDetailsMetadata.EntityTypes.changeLogsType.property(withName: "dftNumber")

    private static var status_: Property = GetFieldTicketDetailsMetadata.EntityTypes.changeLogsType.property(withName: "status")

    private static var createdOn_: Property = GetFieldTicketDetailsMetadata.EntityTypes.changeLogsType.property(withName: "createdOn")

    private static var createdByName_: Property = GetFieldTicketDetailsMetadata.EntityTypes.changeLogsType.property(withName: "createdByName")

    public init(withDefaults: Bool = true) {
        super.init(withDefaults: withDefaults, type: GetFieldTicketDetailsMetadata.EntityTypes.changeLogsType)
    }

    open class var activityID: Property {
        get {
            objc_sync_enter(ChangeLogsType.self)
            defer { objc_sync_exit(ChangeLogsType.self) }
            do {
                return ChangeLogsType.activityID_
            }
        }
        set(value) {
            objc_sync_enter(ChangeLogsType.self)
            defer { objc_sync_exit(ChangeLogsType.self) }
            do {
                ChangeLogsType.activityID_ = value
            }
        }
    }

    open var activityID: Int? {
        get {
            return IntValue.optional(self.optionalValue(for: ChangeLogsType.activityID))
        }
        set(value) {
            self.setOptionalValue(for: ChangeLogsType.activityID, to: IntValue.of(optional: value))
        }
    }

    open class func array(from: EntityValueList) -> Array<ChangeLogsType> {
        return ArrayConverter.convert(from.toArray(), Array<ChangeLogsType>())
    }

    open func copy() -> ChangeLogsType {
        return CastRequired<ChangeLogsType>.from(self.copyEntity())
    }

    open class var createdByName: Property {
        get {
            objc_sync_enter(ChangeLogsType.self)
            defer { objc_sync_exit(ChangeLogsType.self) }
            do {
                return ChangeLogsType.createdByName_
            }
        }
        set(value) {
            objc_sync_enter(ChangeLogsType.self)
            defer { objc_sync_exit(ChangeLogsType.self) }
            do {
                ChangeLogsType.createdByName_ = value
            }
        }
    }

    open var createdByName: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ChangeLogsType.createdByName))
        }
        set(value) {
            self.setOptionalValue(for: ChangeLogsType.createdByName, to: StringValue.of(optional: value))
        }
    }

    open class var createdOn: Property {
        get {
            objc_sync_enter(ChangeLogsType.self)
            defer { objc_sync_exit(ChangeLogsType.self) }
            do {
                return ChangeLogsType.createdOn_
            }
        }
        set(value) {
            objc_sync_enter(ChangeLogsType.self)
            defer { objc_sync_exit(ChangeLogsType.self) }
            do {
                ChangeLogsType.createdOn_ = value
            }
        }
    }

    open var createdOn: LocalDateTime? {
        get {
            return LocalDateTime.castOptional(self.optionalValue(for: ChangeLogsType.createdOn))
        }
        set(value) {
            self.setOptionalValue(for: ChangeLogsType.createdOn, to: value)
        }
    }

    open class var dftNumber: Property {
        get {
            objc_sync_enter(ChangeLogsType.self)
            defer { objc_sync_exit(ChangeLogsType.self) }
            do {
                return ChangeLogsType.dftNumber_
            }
        }
        set(value) {
            objc_sync_enter(ChangeLogsType.self)
            defer { objc_sync_exit(ChangeLogsType.self) }
            do {
                ChangeLogsType.dftNumber_ = value
            }
        }
    }

    open var dftNumber: Int? {
        get {
            return IntValue.optional(self.optionalValue(for: ChangeLogsType.dftNumber))
        }
        set(value) {
            self.setOptionalValue(for: ChangeLogsType.dftNumber, to: IntValue.of(optional: value))
        }
    }

    open override var isProxy: Bool {
        return true
    }

    open class func key(activityID: Int?) -> EntityKey {
        return EntityKey().with(name: "activityId", value: IntValue.of(optional: activityID))
    }

    open var old: ChangeLogsType {
        return CastRequired<ChangeLogsType>.from(self.oldEntity)
    }

    open class var status: Property {
        get {
            objc_sync_enter(ChangeLogsType.self)
            defer { objc_sync_exit(ChangeLogsType.self) }
            do {
                return ChangeLogsType.status_
            }
        }
        set(value) {
            objc_sync_enter(ChangeLogsType.self)
            defer { objc_sync_exit(ChangeLogsType.self) }
            do {
                ChangeLogsType.status_ = value
            }
        }
    }

    open var status: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ChangeLogsType.status))
        }
        set(value) {
            self.setOptionalValue(for: ChangeLogsType.status, to: StringValue.of(optional: value))
        }
    }
}
