// # Proxy Compiler 18.9.4-973a4d-20181128

import Foundation
import SAPOData

open class CommentsType: EntityValue {
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    private static var commentID_: Property = GetFieldTicketDetailsMetadata.EntityTypes.commentsType.property(withName: "commentId")

    private static var dftNumber_: Property = GetFieldTicketDetailsMetadata.EntityTypes.commentsType.property(withName: "dftNumber")

    private static var commentedByName_: Property = GetFieldTicketDetailsMetadata.EntityTypes.commentsType.property(withName: "commentedByName")

    private static var commentedOn_: Property = GetFieldTicketDetailsMetadata.EntityTypes.commentsType.property(withName: "commentedOn")

    private static var comment_: Property = GetFieldTicketDetailsMetadata.EntityTypes.commentsType.property(withName: "comment")

    public init(withDefaults: Bool = true) {
        super.init(withDefaults: withDefaults, type: GetFieldTicketDetailsMetadata.EntityTypes.commentsType)
    }

    open class func array(from: EntityValueList) -> Array<CommentsType> {
        return ArrayConverter.convert(from.toArray(), Array<CommentsType>())
    }

    open class var comment: Property {
        get {
            objc_sync_enter(CommentsType.self)
            defer { objc_sync_exit(CommentsType.self) }
            do {
                return CommentsType.comment_
            }
        }
        set(value) {
            objc_sync_enter(CommentsType.self)
            defer { objc_sync_exit(CommentsType.self) }
            do {
                CommentsType.comment_ = value
            }
        }
    }

    open var comment: String? {
        get {
            return StringValue.optional(self.optionalValue(for: CommentsType.comment))
        }
        set(value) {
            self.setOptionalValue(for: CommentsType.comment, to: StringValue.of(optional: value))
        }
    }

    open class var commentID: Property {
        get {
            objc_sync_enter(CommentsType.self)
            defer { objc_sync_exit(CommentsType.self) }
            do {
                return CommentsType.commentID_
            }
        }
        set(value) {
            objc_sync_enter(CommentsType.self)
            defer { objc_sync_exit(CommentsType.self) }
            do {
                CommentsType.commentID_ = value
            }
        }
    }

    open var commentID: Int? {
        get {
            return IntValue.optional(self.optionalValue(for: CommentsType.commentID))
        }
        set(value) {
            self.setOptionalValue(for: CommentsType.commentID, to: IntValue.of(optional: value))
        }
    }

    open class var commentedByName: Property {
        get {
            objc_sync_enter(CommentsType.self)
            defer { objc_sync_exit(CommentsType.self) }
            do {
                return CommentsType.commentedByName_
            }
        }
        set(value) {
            objc_sync_enter(CommentsType.self)
            defer { objc_sync_exit(CommentsType.self) }
            do {
                CommentsType.commentedByName_ = value
            }
        }
    }

    open var commentedByName: String? {
        get {
            return StringValue.optional(self.optionalValue(for: CommentsType.commentedByName))
        }
        set(value) {
            self.setOptionalValue(for: CommentsType.commentedByName, to: StringValue.of(optional: value))
        }
    }

    open class var commentedOn: Property {
        get {
            objc_sync_enter(CommentsType.self)
            defer { objc_sync_exit(CommentsType.self) }
            do {
                return CommentsType.commentedOn_
            }
        }
        set(value) {
            objc_sync_enter(CommentsType.self)
            defer { objc_sync_exit(CommentsType.self) }
            do {
                CommentsType.commentedOn_ = value
            }
        }
    }

    open var commentedOn: LocalDateTime? {
        get {
            return LocalDateTime.castOptional(self.optionalValue(for: CommentsType.commentedOn))
        }
        set(value) {
            self.setOptionalValue(for: CommentsType.commentedOn, to: value)
        }
    }

    open func copy() -> CommentsType {
        return CastRequired<CommentsType>.from(self.copyEntity())
    }

    open class var dftNumber: Property {
        get {
            objc_sync_enter(CommentsType.self)
            defer { objc_sync_exit(CommentsType.self) }
            do {
                return CommentsType.dftNumber_
            }
        }
        set(value) {
            objc_sync_enter(CommentsType.self)
            defer { objc_sync_exit(CommentsType.self) }
            do {
                CommentsType.dftNumber_ = value
            }
        }
    }

    open var dftNumber: Int? {
        get {
            return IntValue.optional(self.optionalValue(for: CommentsType.dftNumber))
        }
        set(value) {
            self.setOptionalValue(for: CommentsType.dftNumber, to: IntValue.of(optional: value))
        }
    }

    open override var isProxy: Bool {
        return true
    }

    open class func key(commentID: Int?) -> EntityKey {
        return EntityKey().with(name: "commentId", value: IntValue.of(optional: commentID))
    }

    open var old: CommentsType {
        return CastRequired<CommentsType>.from(self.oldEntity)
    }
}
