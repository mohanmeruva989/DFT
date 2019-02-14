// # Proxy Compiler 18.9.4-973a4d-20181128

import Foundation
import SAPOData

internal class GetFieldTicketDetailsMetadataChanges {
    static func merge(metadata: CSDLDocument) {
        metadata.hasGeneratedProxies = true
        GetFieldTicketDetailsMetadata.document = metadata
        GetFieldTicketDetailsMetadataChanges.merge1(metadata: metadata)
        try! GetFieldTicketDetailsFactory.registerAll()
    }

    private static func merge1(metadata: CSDLDocument) {
        Ignore.valueOf_any(metadata)
        if !GetFieldTicketDetailsMetadata.EntityTypes.attachmentsType.isRemoved {
            GetFieldTicketDetailsMetadata.EntityTypes.attachmentsType = metadata.entityType(withName: "DFT_XSJS.XSODATA.getFieldTicketDetails.xsodata.AttachmentsType")
        }
        if !GetFieldTicketDetailsMetadata.EntityTypes.changeLogsType.isRemoved {
            GetFieldTicketDetailsMetadata.EntityTypes.changeLogsType = metadata.entityType(withName: "DFT_XSJS.XSODATA.getFieldTicketDetails.xsodata.ChangeLogsType")
        }
        if !GetFieldTicketDetailsMetadata.EntityTypes.commentsType.isRemoved {
            GetFieldTicketDetailsMetadata.EntityTypes.commentsType = metadata.entityType(withName: "DFT_XSJS.XSODATA.getFieldTicketDetails.xsodata.CommentsType")
        }
        if !GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.isRemoved {
            GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType = metadata.entityType(withName: "DFT_XSJS.XSODATA.getFieldTicketDetails.xsodata.DFTHeaderType")
        }
        if !GetFieldTicketDetailsMetadata.EntitySets.attachments.isRemoved {
            GetFieldTicketDetailsMetadata.EntitySets.attachments = metadata.entitySet(withName: "Attachments")
        }
        if !GetFieldTicketDetailsMetadata.EntitySets.changeLogs.isRemoved {
            GetFieldTicketDetailsMetadata.EntitySets.changeLogs = metadata.entitySet(withName: "ChangeLogs")
        }
        if !GetFieldTicketDetailsMetadata.EntitySets.comments.isRemoved {
            GetFieldTicketDetailsMetadata.EntitySets.comments = metadata.entitySet(withName: "Comments")
        }
        if !GetFieldTicketDetailsMetadata.EntitySets.dftHeader.isRemoved {
            GetFieldTicketDetailsMetadata.EntitySets.dftHeader = metadata.entitySet(withName: "DFTHeader")
        }
        if !AttachmentsType.attachmentID.isRemoved {
            AttachmentsType.attachmentID = GetFieldTicketDetailsMetadata.EntityTypes.attachmentsType.property(withName: "attachmentId")
        }
        if !AttachmentsType.dftNumber.isRemoved {
            AttachmentsType.dftNumber = GetFieldTicketDetailsMetadata.EntityTypes.attachmentsType.property(withName: "dftNumber")
        }
        if !AttachmentsType.attachmentName.isRemoved {
            AttachmentsType.attachmentName = GetFieldTicketDetailsMetadata.EntityTypes.attachmentsType.property(withName: "attachmentName")
        }
        if !AttachmentsType.dftAttachmentType.isRemoved {
            AttachmentsType.dftAttachmentType = GetFieldTicketDetailsMetadata.EntityTypes.attachmentsType.property(withName: "dftAttachmentType")
        }
        if !AttachmentsType.createdByName.isRemoved {
            AttachmentsType.createdByName = GetFieldTicketDetailsMetadata.EntityTypes.attachmentsType.property(withName: "createdByName")
        }
        if !AttachmentsType.createdOn.isRemoved {
            AttachmentsType.createdOn = GetFieldTicketDetailsMetadata.EntityTypes.attachmentsType.property(withName: "createdOn")
        }
        if !AttachmentsType.updatedByName.isRemoved {
            AttachmentsType.updatedByName = GetFieldTicketDetailsMetadata.EntityTypes.attachmentsType.property(withName: "updatedByName")
        }
        if !AttachmentsType.updatedOn.isRemoved {
            AttachmentsType.updatedOn = GetFieldTicketDetailsMetadata.EntityTypes.attachmentsType.property(withName: "updatedOn")
        }
        if !AttachmentsType.attachmentUrl.isRemoved {
            AttachmentsType.attachmentUrl = GetFieldTicketDetailsMetadata.EntityTypes.attachmentsType.property(withName: "attachmentUrl")
        }
        if !ChangeLogsType.activityID.isRemoved {
            ChangeLogsType.activityID = GetFieldTicketDetailsMetadata.EntityTypes.changeLogsType.property(withName: "activityId")
        }
        if !ChangeLogsType.dftNumber.isRemoved {
            ChangeLogsType.dftNumber = GetFieldTicketDetailsMetadata.EntityTypes.changeLogsType.property(withName: "dftNumber")
        }
        if !ChangeLogsType.status.isRemoved {
            ChangeLogsType.status = GetFieldTicketDetailsMetadata.EntityTypes.changeLogsType.property(withName: "status")
        }
        if !ChangeLogsType.createdOn.isRemoved {
            ChangeLogsType.createdOn = GetFieldTicketDetailsMetadata.EntityTypes.changeLogsType.property(withName: "createdOn")
        }
        if !ChangeLogsType.createdByName.isRemoved {
            ChangeLogsType.createdByName = GetFieldTicketDetailsMetadata.EntityTypes.changeLogsType.property(withName: "createdByName")
        }
        if !CommentsType.commentID.isRemoved {
            CommentsType.commentID = GetFieldTicketDetailsMetadata.EntityTypes.commentsType.property(withName: "commentId")
        }
        if !CommentsType.dftNumber.isRemoved {
            CommentsType.dftNumber = GetFieldTicketDetailsMetadata.EntityTypes.commentsType.property(withName: "dftNumber")
        }
        if !CommentsType.commentedByName.isRemoved {
            CommentsType.commentedByName = GetFieldTicketDetailsMetadata.EntityTypes.commentsType.property(withName: "commentedByName")
        }
        if !CommentsType.commentedOn.isRemoved {
            CommentsType.commentedOn = GetFieldTicketDetailsMetadata.EntityTypes.commentsType.property(withName: "commentedOn")
        }
        if !CommentsType.comment.isRemoved {
            CommentsType.comment = GetFieldTicketDetailsMetadata.EntityTypes.commentsType.property(withName: "comment")
        }
        if !DFTHeaderType.dftNumber.isRemoved {
            DFTHeaderType.dftNumber = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "dftNumber")
        }
        if !DFTHeaderType.poNumber.isRemoved {
            DFTHeaderType.poNumber = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "poNumber")
        }
        if !DFTHeaderType.vendorAdminID.isRemoved {
            DFTHeaderType.vendorAdminID = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "vendorAdminId")
        }
        if !DFTHeaderType.vendorID.isRemoved {
            DFTHeaderType.vendorID = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "vendorId")
        }
        if !DFTHeaderType.vendorName.isRemoved {
            DFTHeaderType.vendorName = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "vendorName")
        }
        if !DFTHeaderType.vendorAddress.isRemoved {
            DFTHeaderType.vendorAddress = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "vendorAddress")
        }
        if !DFTHeaderType.aribaSesNo.isRemoved {
            DFTHeaderType.aribaSesNo = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "aribaSesNo")
        }
        if !DFTHeaderType.serviceProviderMail.isRemoved {
            DFTHeaderType.serviceProviderMail = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "serviceProviderMail")
        }
        if !DFTHeaderType.serviceProviderID.isRemoved {
            DFTHeaderType.serviceProviderID = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "serviceProviderId")
        }
        if !DFTHeaderType.serviceProviderName.isRemoved {
            DFTHeaderType.serviceProviderName = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "serviceProviderName")
        }
        if !DFTHeaderType.reviewerID.isRemoved {
            DFTHeaderType.reviewerID = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "ReviewerId")
        }
        if !DFTHeaderType.reviewerName.isRemoved {
            DFTHeaderType.reviewerName = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "ReviewerName")
        }
        if !DFTHeaderType.reviewerEmail.isRemoved {
            DFTHeaderType.reviewerEmail = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "ReviewerEmail")
        }
        if !DFTHeaderType.sesApproverName.isRemoved {
            DFTHeaderType.sesApproverName = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "sesApproverName")
        }
        if !DFTHeaderType.sesApproverEmail.isRemoved {
            DFTHeaderType.sesApproverEmail = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "sesApproverEmail")
        }
        if !DFTHeaderType.department.isRemoved {
            DFTHeaderType.department = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "department")
        }
        if !DFTHeaderType.location.isRemoved {
            DFTHeaderType.location = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "location")
        }
        if !DFTHeaderType.startDate.isRemoved {
            DFTHeaderType.startDate = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "startDate")
        }
        if !DFTHeaderType.startTime.isRemoved {
            DFTHeaderType.startTime = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "startTime")
        }
        if !DFTHeaderType.endDate.isRemoved {
            DFTHeaderType.endDate = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "endDate")
        }
        if !DFTHeaderType.endTime.isRemoved {
            DFTHeaderType.endTime = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "endTime")
        }
        if !DFTHeaderType.accountingCategory.isRemoved {
            DFTHeaderType.accountingCategory = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "accountingCategory")
        }
        if !DFTHeaderType.costCenter.isRemoved {
            DFTHeaderType.costCenter = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "costCenter")
        }
        if !DFTHeaderType.sesNumber.isRemoved {
            DFTHeaderType.sesNumber = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "sesNumber")
        }
        if !DFTHeaderType.workOrderNo.isRemoved {
            DFTHeaderType.workOrderNo = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "workOrderNo")
        }
        if !DFTHeaderType.signatureVersion.isRemoved {
            DFTHeaderType.signatureVersion = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "signatureVersion")
        }
        if !DFTHeaderType.wbsElement.isRemoved {
            DFTHeaderType.wbsElement = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "wbsElement")
        }
        if !DFTHeaderType.deviceType.isRemoved {
            DFTHeaderType.deviceType = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "deviceType")
        }
        if !DFTHeaderType.deviceID.isRemoved {
            DFTHeaderType.deviceID = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "deviceId")
        }
        if !DFTHeaderType.status.isRemoved {
            DFTHeaderType.status = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "status")
        }
        if !DFTHeaderType.createdBy.isRemoved {
            DFTHeaderType.createdBy = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "createdBy")
        }
        if !DFTHeaderType.createdOn.isRemoved {
            DFTHeaderType.createdOn = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "createdOn")
        }
        if !DFTHeaderType.updatedBy.isRemoved {
            DFTHeaderType.updatedBy = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "updatedBy")
        }
        if !DFTHeaderType.updatedOn.isRemoved {
            DFTHeaderType.updatedOn = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "updatedOn")
        }
        if !DFTHeaderType.vendorRefNumber.isRemoved {
            DFTHeaderType.vendorRefNumber = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "vendorRefNumber")
        }
        if !DFTHeaderType.reviewedOn.isRemoved {
            DFTHeaderType.reviewedOn = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "reviewedOn")
        }
        if !DFTHeaderType.reviewedBy.isRemoved {
            DFTHeaderType.reviewedBy = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "reviewedBy")
        }
        if !DFTHeaderType.completedBy.isRemoved {
            DFTHeaderType.completedBy = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "completedBy")
        }
        if !DFTHeaderType.completedOn.isRemoved {
            DFTHeaderType.completedOn = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "completedOn")
        }
        if !DFTHeaderType.well.isRemoved {
            DFTHeaderType.well = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "well")
        }
        if !DFTHeaderType.field.isRemoved {
            DFTHeaderType.field = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "field")
        }
        if !DFTHeaderType.facility.isRemoved {
            DFTHeaderType.facility = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "facility")
        }
        if !DFTHeaderType.wellPad.isRemoved {
            DFTHeaderType.wellPad = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "wellPad")
        }
        if !DFTHeaderType.ownerID.isRemoved {
            DFTHeaderType.ownerID = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "ownerId")
        }
        if !DFTHeaderType.wfInstanceID.isRemoved {
            DFTHeaderType.wfInstanceID = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "wfInstanceId")
        }
        if !DFTHeaderType.comments.isRemoved {
            DFTHeaderType.comments = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "Comments")
        }
        if !DFTHeaderType.changeLogs.isRemoved {
            DFTHeaderType.changeLogs = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "ChangeLogs")
        }
        if !DFTHeaderType.attachments.isRemoved {
            DFTHeaderType.attachments = GetFieldTicketDetailsMetadata.EntityTypes.dftHeaderType.property(withName: "Attachments")
        }
    }
}
