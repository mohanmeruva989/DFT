// # Proxy Compiler 18.9.4-973a4d-20181128

import Foundation
import SAPOData

open class GetFieldTicketDetails<Provider: DataServiceProvider>: DataService<Provider> {
    public override init(provider: Provider) {
        super.init(provider: provider)
        self.provider.metadata = GetFieldTicketDetailsMetadata.document
    }

    @available(swift, deprecated: 4.0, renamed: "fetchAttachments")
    open func attachments(query: DataQuery = DataQuery()) throws -> Array<AttachmentsType> {
        return try self.fetchAttachments(matching: query)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchAttachments")
    open func attachments(query: DataQuery = DataQuery(), completionHandler: @escaping (Array<AttachmentsType>?, Error?) -> Void) {
        self.fetchAttachments(matching: query, headers: nil, options: nil, completionHandler: completionHandler)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchChangeLogs")
    open func changeLogs(query: DataQuery = DataQuery()) throws -> Array<ChangeLogsType> {
        return try self.fetchChangeLogs(matching: query)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchChangeLogs")
    open func changeLogs(query: DataQuery = DataQuery(), completionHandler: @escaping (Array<ChangeLogsType>?, Error?) -> Void) {
        self.fetchChangeLogs(matching: query, headers: nil, options: nil, completionHandler: completionHandler)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchComments")
    open func comments(query: DataQuery = DataQuery()) throws -> Array<CommentsType> {
        return try self.fetchComments(matching: query)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchComments")
    open func comments(query: DataQuery = DataQuery(), completionHandler: @escaping (Array<CommentsType>?, Error?) -> Void) {
        self.fetchComments(matching: query, headers: nil, options: nil, completionHandler: completionHandler)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchDFTHeader")
    open func dftHeader(query: DataQuery = DataQuery()) throws -> Array<DFTHeaderType> {
        return try self.fetchDFTHeader(matching: query)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchDFTHeader")
    open func dftHeader(query: DataQuery = DataQuery(), completionHandler: @escaping (Array<DFTHeaderType>?, Error?) -> Void) {
        self.fetchDFTHeader(matching: query, headers: nil, options: nil, completionHandler: completionHandler)
    }

    open func fetchAttachments(matching query: DataQuery? = nil, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> Array<AttachmentsType> {
        let var_query: DataQuery = DataQuery.newIfNull(query: query)
        let var_headers: HTTPHeaders = HTTPHeaders.emptyIfNull(headers: headers)
        let var_options: RequestOptions = try RequestOptions.noneIfNull(options: options)
        return try AttachmentsType.array(from: self.executeQuery(var_query.fromDefault(GetFieldTicketDetailsMetadata.EntitySets.attachments), headers: var_headers, options: var_options).entityList())
    }

    open func fetchAttachments(matching query: DataQuery = DataQuery(), headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping (Array<AttachmentsType>?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result: Array<AttachmentsType> = try self.fetchAttachments(matching: query, headers: headers, options: options)
                self.completionQueue.addOperation {
                    completionHandler(result, nil)
                }
            } catch let error {
                self.completionQueue.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func fetchAttachmentsType(matching query: DataQuery, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> AttachmentsType {
        let var_headers: HTTPHeaders = HTTPHeaders.emptyIfNull(headers: headers)
        let var_options: RequestOptions = try RequestOptions.noneIfNull(options: options)
        return try CastRequired<AttachmentsType>.from(self.executeQuery(query.fromDefault(GetFieldTicketDetailsMetadata.EntitySets.attachments), headers: var_headers, options: var_options).requiredEntity())
    }

    open func fetchAttachmentsType(matching query: DataQuery, headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping (AttachmentsType?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result: AttachmentsType = try self.fetchAttachmentsType(matching: query, headers: headers, options: options)
                self.completionQueue.addOperation {
                    completionHandler(result, nil)
                }
            } catch let error {
                self.completionQueue.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func fetchChangeLogs(matching query: DataQuery? = nil, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> Array<ChangeLogsType> {
        let var_query: DataQuery = DataQuery.newIfNull(query: query)
        let var_headers: HTTPHeaders = HTTPHeaders.emptyIfNull(headers: headers)
        let var_options: RequestOptions = try RequestOptions.noneIfNull(options: options)
        return try ChangeLogsType.array(from: self.executeQuery(var_query.fromDefault(GetFieldTicketDetailsMetadata.EntitySets.changeLogs), headers: var_headers, options: var_options).entityList())
    }

    open func fetchChangeLogs(matching query: DataQuery = DataQuery(), headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping (Array<ChangeLogsType>?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result: Array<ChangeLogsType> = try self.fetchChangeLogs(matching: query, headers: headers, options: options)
                self.completionQueue.addOperation {
                    completionHandler(result, nil)
                }
            } catch let error {
                self.completionQueue.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func fetchChangeLogsType(matching query: DataQuery, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> ChangeLogsType {
        let var_headers: HTTPHeaders = HTTPHeaders.emptyIfNull(headers: headers)
        let var_options: RequestOptions = try RequestOptions.noneIfNull(options: options)
        return try CastRequired<ChangeLogsType>.from(self.executeQuery(query.fromDefault(GetFieldTicketDetailsMetadata.EntitySets.changeLogs), headers: var_headers, options: var_options).requiredEntity())
    }

    open func fetchChangeLogsType(matching query: DataQuery, headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping (ChangeLogsType?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result: ChangeLogsType = try self.fetchChangeLogsType(matching: query, headers: headers, options: options)
                self.completionQueue.addOperation {
                    completionHandler(result, nil)
                }
            } catch let error {
                self.completionQueue.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func fetchComments(matching query: DataQuery? = nil, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> Array<CommentsType> {
        let var_query: DataQuery = DataQuery.newIfNull(query: query)
        let var_headers: HTTPHeaders = HTTPHeaders.emptyIfNull(headers: headers)
        let var_options: RequestOptions = try RequestOptions.noneIfNull(options: options)
        return try CommentsType.array(from: self.executeQuery(var_query.fromDefault(GetFieldTicketDetailsMetadata.EntitySets.comments), headers: var_headers, options: var_options).entityList())
    }

    open func fetchComments(matching query: DataQuery = DataQuery(), headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping (Array<CommentsType>?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result: Array<CommentsType> = try self.fetchComments(matching: query, headers: headers, options: options)
                self.completionQueue.addOperation {
                    completionHandler(result, nil)
                }
            } catch let error {
                self.completionQueue.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func fetchCommentsType(matching query: DataQuery, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> CommentsType {
        let var_headers: HTTPHeaders = HTTPHeaders.emptyIfNull(headers: headers)
        let var_options: RequestOptions = try RequestOptions.noneIfNull(options: options)
        return try CastRequired<CommentsType>.from(self.executeQuery(query.fromDefault(GetFieldTicketDetailsMetadata.EntitySets.comments), headers: var_headers, options: var_options).requiredEntity())
    }

    open func fetchCommentsType(matching query: DataQuery, headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping (CommentsType?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result: CommentsType = try self.fetchCommentsType(matching: query, headers: headers, options: options)
                self.completionQueue.addOperation {
                    completionHandler(result, nil)
                }
            } catch let error {
                self.completionQueue.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func fetchDFTHeader(matching query: DataQuery? = nil, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> Array<DFTHeaderType> {
        let var_query: DataQuery = DataQuery.newIfNull(query: query)
        let var_headers: HTTPHeaders = HTTPHeaders.emptyIfNull(headers: headers)
        let var_options: RequestOptions = try RequestOptions.noneIfNull(options: options)
        return try DFTHeaderType.array(from: self.executeQuery(var_query.fromDefault(GetFieldTicketDetailsMetadata.EntitySets.dftHeader), headers: var_headers, options: var_options).entityList())
    }

    open func fetchDFTHeader(matching query: DataQuery = DataQuery(), headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping (Array<DFTHeaderType>?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result: Array<DFTHeaderType> = try self.fetchDFTHeader(matching: query, headers: headers, options: options)
                self.completionQueue.addOperation {
                    completionHandler(result, nil)
                }
            } catch let error {
                self.completionQueue.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func fetchDFTHeaderType(matching query: DataQuery, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> DFTHeaderType {
        let var_headers: HTTPHeaders = HTTPHeaders.emptyIfNull(headers: headers)
        let var_options: RequestOptions = try RequestOptions.noneIfNull(options: options)
        return try CastRequired<DFTHeaderType>.from(self.executeQuery(query.fromDefault(GetFieldTicketDetailsMetadata.EntitySets.dftHeader), headers: var_headers, options: var_options).requiredEntity())
    }

    open func fetchDFTHeaderType(matching query: DataQuery, headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping (DFTHeaderType?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result: DFTHeaderType = try self.fetchDFTHeaderType(matching: query, headers: headers, options: options)
                self.completionQueue.addOperation {
                    completionHandler(result, nil)
                }
            } catch let error {
                self.completionQueue.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open override func refreshMetadata() throws {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        do {
            try ProxyInternal.refreshMetadata(service: self, fetcher: nil, options: GetFieldTicketDetailsMetadataParser.options)
            GetFieldTicketDetailsMetadataChanges.merge(metadata: self.metadata)
        }
    }
}
