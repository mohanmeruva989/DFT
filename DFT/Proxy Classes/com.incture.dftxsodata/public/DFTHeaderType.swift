// # Proxy Compiler 18.9.4-973a4d-20181128

import Foundation
import SAPOData

open class DFTHeaderType: EntityValue {
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    private static var dftNumber_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "dftNumber")

    private static var poNumber_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "poNumber")

    private static var vendorAdminID_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "vendorAdminId")

    private static var vendorID_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "vendorId")

    private static var vendorName_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "vendorName")

    private static var vendorAddress_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "vendorAddress")

    private static var aribaSesNo_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "aribaSesNo")

    private static var serviceProviderMail_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "serviceProviderMail")

    private static var serviceProviderID_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "serviceProviderId")

    private static var serviceProviderName_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "serviceProviderName")

    private static var reviewerID_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "ReviewerId")

    private static var reviewerName_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "ReviewerName")

    private static var reviewerEmail_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "ReviewerEmail")

    private static var sesApproverName_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "sesApproverName")

    private static var sesApproverEmail_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "sesApproverEmail")

    private static var department_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "department")

    private static var location_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "location")

    private static var startDate_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "startDate")

    private static var startTime_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "startTime")

    private static var endDate_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "endDate")

    private static var endTime_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "endTime")

    private static var accountingCategory_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "accountingCategory")

    private static var costCenter_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "costCenter")

    private static var sesNumber_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "sesNumber")

    private static var workOrderNo_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "workOrderNo")

    private static var signatureVersion_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "signatureVersion")

    private static var wbsElement_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "wbsElement")

    private static var deviceType_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "deviceType")

    private static var deviceID_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "deviceId")

    private static var status_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "status")

    private static var createdBy_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "createdBy")

    private static var createdOn_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "createdOn")

    private static var updatedBy_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "updatedBy")

    private static var updatedOn_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "updatedOn")

    private static var vendorRefNumber_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "vendorRefNumber")

    private static var reviewedOn_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "reviewedOn")

    private static var reviewedBy_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "reviewedBy")

    private static var completedBy_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "completedBy")

    private static var completedOn_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "completedOn")

    private static var well_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "well")

    private static var field_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "field")

    private static var facility_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "facility")

    private static var wellPad_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "wellPad")

    private static var ownerID_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "ownerId")

    private static var wfInstanceID_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "wfInstanceId")

    private static var comments_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "Comments")

    private static var changeLogs_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "ChangeLogs")

    private static var attachments_: Property = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "Attachments")

    public init(withDefaults: Bool = true) {
        super.init(withDefaults: withDefaults, type: GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType)
    }

    open class var accountingCategory: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.accountingCategory_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.accountingCategory_ = value
            }
        }
    }

    open var accountingCategory: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.accountingCategory))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.accountingCategory, to: StringValue.of(optional: value))
        }
    }

    open class var aribaSesNo: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.aribaSesNo_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.aribaSesNo_ = value
            }
        }
    }

    open var aribaSesNo: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.aribaSesNo))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.aribaSesNo, to: StringValue.of(optional: value))
        }
    }

    open class func array(from: EntityValueList) -> Array<DFTHeaderType> {
        return ArrayConverter.convert(from.toArray(), Array<DFTHeaderType>())
    }

    open class var attachments: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.attachments_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.attachments_ = value
            }
        }
    }

    open var attachments: Array<AttachmentsType> {
        get {
            return ArrayConverter.convert(EntityValueList.castRequired(self.requiredValue(for: DFTHeaderType.attachments)).toArray(), Array<AttachmentsType>())
        }
        set(value) {
            DFTHeaderType.attachments.setEntityList(in: self, to: EntityValueList.fromArray(ArrayConverter.convert(value, Array<EntityValue>())))
        }
    }

    open class var changeLogs: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.changeLogs_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.changeLogs_ = value
            }
        }
    }

    open var changeLogs: Array<ChangeLogsType> {
        get {
            return ArrayConverter.convert(EntityValueList.castRequired(self.requiredValue(for: DFTHeaderType.changeLogs)).toArray(), Array<ChangeLogsType>())
        }
        set(value) {
            DFTHeaderType.changeLogs.setEntityList(in: self, to: EntityValueList.fromArray(ArrayConverter.convert(value, Array<EntityValue>())))
        }
    }

    open class var comments: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.comments_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.comments_ = value
            }
        }
    }

    open var comments: Array<CommentsType> {
        get {
            return ArrayConverter.convert(EntityValueList.castRequired(self.requiredValue(for: DFTHeaderType.comments)).toArray(), Array<CommentsType>())
        }
        set(value) {
            DFTHeaderType.comments.setEntityList(in: self, to: EntityValueList.fromArray(ArrayConverter.convert(value, Array<EntityValue>())))
        }
    }

    open class var completedBy: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.completedBy_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.completedBy_ = value
            }
        }
    }

    open var completedBy: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.completedBy))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.completedBy, to: StringValue.of(optional: value))
        }
    }

    open class var completedOn: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.completedOn_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.completedOn_ = value
            }
        }
    }

    open var completedOn: LocalDateTime? {
        get {
            return LocalDateTime.castOptional(self.optionalValue(for: DFTHeaderType.completedOn))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.completedOn, to: value)
        }
    }

    open func copy() -> DFTHeaderType {
        return CastRequired<DFTHeaderType>.from(self.copyEntity())
    }

    open class var costCenter: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.costCenter_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.costCenter_ = value
            }
        }
    }

    open var costCenter: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.costCenter))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.costCenter, to: StringValue.of(optional: value))
        }
    }

    open class var createdBy: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.createdBy_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.createdBy_ = value
            }
        }
    }

    open var createdBy: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.createdBy))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.createdBy, to: StringValue.of(optional: value))
        }
    }

    open class var createdOn: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.createdOn_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.createdOn_ = value
            }
        }
    }

    open var createdOn: LocalDateTime? {
        get {
            return LocalDateTime.castOptional(self.optionalValue(for: DFTHeaderType.createdOn))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.createdOn, to: value)
        }
    }

    open class var department: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.department_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.department_ = value
            }
        }
    }

    open var department: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.department))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.department, to: StringValue.of(optional: value))
        }
    }

    open class var deviceID: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.deviceID_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.deviceID_ = value
            }
        }
    }

    open var deviceID: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.deviceID))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.deviceID, to: StringValue.of(optional: value))
        }
    }

    open class var deviceType: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.deviceType_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.deviceType_ = value
            }
        }
    }

    open var deviceType: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.deviceType))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.deviceType, to: StringValue.of(optional: value))
        }
    }

    open class var dftNumber: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.dftNumber_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.dftNumber_ = value
            }
        }
    }

    open var dftNumber: Int? {
        get {
            return IntValue.optional(self.optionalValue(for: DFTHeaderType.dftNumber))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.dftNumber, to: IntValue.of(optional: value))
        }
    }

    open class var endDate: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.endDate_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.endDate_ = value
            }
        }
    }

    open var endDate: LocalDateTime? {
        get {
            return LocalDateTime.castOptional(self.optionalValue(for: DFTHeaderType.endDate))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.endDate, to: value)
        }
    }

    open class var endTime: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.endTime_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.endTime_ = value
            }
        }
    }

    open var endTime: LocalTime? {
        get {
            return LocalTime.castOptional(self.optionalValue(for: DFTHeaderType.endTime))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.endTime, to: value)
        }
    }

    open class var facility: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.facility_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.facility_ = value
            }
        }
    }

    open var facility: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.facility))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.facility, to: StringValue.of(optional: value))
        }
    }

    open class var field: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.field_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.field_ = value
            }
        }
    }

    open var field: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.field))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.field, to: StringValue.of(optional: value))
        }
    }

    open override var isProxy: Bool {
        return true
    }

    open class func key(dftNumber: Int?) -> EntityKey {
        return EntityKey().with(name: "dftNumber", value: IntValue.of(optional: dftNumber))
    }

    open class var location: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.location_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.location_ = value
            }
        }
    }

    open var location: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.location))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.location, to: StringValue.of(optional: value))
        }
    }

    open var old: DFTHeaderType {
        return CastRequired<DFTHeaderType>.from(self.oldEntity)
    }

    open class var ownerID: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.ownerID_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.ownerID_ = value
            }
        }
    }

    open var ownerID: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.ownerID))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.ownerID, to: StringValue.of(optional: value))
        }
    }

    open class var poNumber: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.poNumber_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.poNumber_ = value
            }
        }
    }

    open var poNumber: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.poNumber))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.poNumber, to: StringValue.of(optional: value))
        }
    }

    open class var reviewedBy: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.reviewedBy_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.reviewedBy_ = value
            }
        }
    }

    open var reviewedBy: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.reviewedBy))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.reviewedBy, to: StringValue.of(optional: value))
        }
    }

    open class var reviewedOn: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.reviewedOn_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.reviewedOn_ = value
            }
        }
    }

    open var reviewedOn: LocalDateTime? {
        get {
            return LocalDateTime.castOptional(self.optionalValue(for: DFTHeaderType.reviewedOn))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.reviewedOn, to: value)
        }
    }

    open class var reviewerEmail: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.reviewerEmail_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.reviewerEmail_ = value
            }
        }
    }

    open var reviewerEmail: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.reviewerEmail))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.reviewerEmail, to: StringValue.of(optional: value))
        }
    }

    open class var reviewerID: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.reviewerID_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.reviewerID_ = value
            }
        }
    }

    open var reviewerID: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.reviewerID))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.reviewerID, to: StringValue.of(optional: value))
        }
    }

    open class var reviewerName: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.reviewerName_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.reviewerName_ = value
            }
        }
    }

    open var reviewerName: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.reviewerName))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.reviewerName, to: StringValue.of(optional: value))
        }
    }

    open class var serviceProviderID: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.serviceProviderID_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.serviceProviderID_ = value
            }
        }
    }

    open var serviceProviderID: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.serviceProviderID))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.serviceProviderID, to: StringValue.of(optional: value))
        }
    }

    open class var serviceProviderMail: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.serviceProviderMail_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.serviceProviderMail_ = value
            }
        }
    }

    open var serviceProviderMail: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.serviceProviderMail))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.serviceProviderMail, to: StringValue.of(optional: value))
        }
    }

    open class var serviceProviderName: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.serviceProviderName_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.serviceProviderName_ = value
            }
        }
    }

    open var serviceProviderName: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.serviceProviderName))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.serviceProviderName, to: StringValue.of(optional: value))
        }
    }

    open class var sesApproverEmail: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.sesApproverEmail_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.sesApproverEmail_ = value
            }
        }
    }

    open var sesApproverEmail: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.sesApproverEmail))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.sesApproverEmail, to: StringValue.of(optional: value))
        }
    }

    open class var sesApproverName: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.sesApproverName_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.sesApproverName_ = value
            }
        }
    }

    open var sesApproverName: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.sesApproverName))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.sesApproverName, to: StringValue.of(optional: value))
        }
    }

    open class var sesNumber: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.sesNumber_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.sesNumber_ = value
            }
        }
    }

    open var sesNumber: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.sesNumber))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.sesNumber, to: StringValue.of(optional: value))
        }
    }

    open class var signatureVersion: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.signatureVersion_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.signatureVersion_ = value
            }
        }
    }

    open var signatureVersion: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.signatureVersion))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.signatureVersion, to: StringValue.of(optional: value))
        }
    }

    open class var startDate: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.startDate_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.startDate_ = value
            }
        }
    }

    open var startDate: LocalDateTime? {
        get {
            return LocalDateTime.castOptional(self.optionalValue(for: DFTHeaderType.startDate))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.startDate, to: value)
        }
    }

    open class var startTime: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.startTime_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.startTime_ = value
            }
        }
    }

    open var startTime: LocalTime? {
        get {
            return LocalTime.castOptional(self.optionalValue(for: DFTHeaderType.startTime))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.startTime, to: value)
        }
    }

    open class var status: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.status_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.status_ = value
            }
        }
    }

    open var status: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.status))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.status, to: StringValue.of(optional: value))
        }
    }

    open class var updatedBy: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.updatedBy_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.updatedBy_ = value
            }
        }
    }

    open var updatedBy: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.updatedBy))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.updatedBy, to: StringValue.of(optional: value))
        }
    }

    open class var updatedOn: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.updatedOn_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.updatedOn_ = value
            }
        }
    }

    open var updatedOn: LocalDateTime? {
        get {
            return LocalDateTime.castOptional(self.optionalValue(for: DFTHeaderType.updatedOn))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.updatedOn, to: value)
        }
    }

    open class var vendorAddress: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.vendorAddress_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.vendorAddress_ = value
            }
        }
    }

    open var vendorAddress: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.vendorAddress))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.vendorAddress, to: StringValue.of(optional: value))
        }
    }

    open class var vendorAdminID: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.vendorAdminID_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.vendorAdminID_ = value
            }
        }
    }

    open var vendorAdminID: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.vendorAdminID))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.vendorAdminID, to: StringValue.of(optional: value))
        }
    }

    open class var vendorID: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.vendorID_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.vendorID_ = value
            }
        }
    }

    open var vendorID: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.vendorID))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.vendorID, to: StringValue.of(optional: value))
        }
    }

    open class var vendorName: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.vendorName_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.vendorName_ = value
            }
        }
    }

    open var vendorName: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.vendorName))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.vendorName, to: StringValue.of(optional: value))
        }
    }

    open class var vendorRefNumber: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.vendorRefNumber_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.vendorRefNumber_ = value
            }
        }
    }

    open var vendorRefNumber: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.vendorRefNumber))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.vendorRefNumber, to: StringValue.of(optional: value))
        }
    }

    open class var wbsElement: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.wbsElement_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.wbsElement_ = value
            }
        }
    }

    open var wbsElement: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.wbsElement))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.wbsElement, to: StringValue.of(optional: value))
        }
    }

    open class var well: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.well_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.well_ = value
            }
        }
    }

    open var well: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.well))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.well, to: StringValue.of(optional: value))
        }
    }

    open class var wellPad: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.wellPad_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.wellPad_ = value
            }
        }
    }

    open var wellPad: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.wellPad))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.wellPad, to: StringValue.of(optional: value))
        }
    }

    open class var wfInstanceID: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.wfInstanceID_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.wfInstanceID_ = value
            }
        }
    }

    open var wfInstanceID: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.wfInstanceID))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.wfInstanceID, to: StringValue.of(optional: value))
        }
    }

    open class var workOrderNo: Property {
        get {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                return DFTHeaderType.workOrderNo_
            }
        }
        set(value) {
            objc_sync_enter(DFTHeaderType.self)
            defer { objc_sync_exit(DFTHeaderType.self) }
            do {
                DFTHeaderType.workOrderNo_ = value
            }
        }
    }

    open var workOrderNo: String? {
        get {
            return StringValue.optional(self.optionalValue(for: DFTHeaderType.workOrderNo))
        }
        set(value) {
            self.setOptionalValue(for: DFTHeaderType.workOrderNo, to: StringValue.of(optional: value))
        }
    }
}
