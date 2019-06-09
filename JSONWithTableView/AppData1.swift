//
//  AppData1.swift
//  JSONWithTableView
//
//  Created by Arun Reddy on 09/06/19.
//  Copyright © 2019 brn. All rights reserved.
//

import Foundation

// MARK: - Results
struct Results: Codable {
    let response: [Response]
    let error: Bool
    let errorMsg, messages: JSONNull?
}

// MARK: - Response
struct Response: Codable {
    let eventID: EventID
    let eventname, location, responseDescription, image: String
    let eventDate, eventCreatedDate: String
    let eventUpdateDate: JSONNull?
    let displayHours: Int
    let listOfEventImagesDto: [ListOfEventImagesDto]
    
    enum CodingKeys: String, CodingKey {
        case eventID = "eventId"
        case eventname, location
        case responseDescription = "description"
        case image, eventDate, eventCreatedDate, eventUpdateDate, displayHours, listOfEventImagesDto
    }
}

// MARK: - EventID
struct EventID: Codable {
    let id: String
}

// MARK: - ListOfEventImagesDto
struct ListOfEventImagesDto: Codable {
    let eventStateImageID: EventID
    let images: String
    
    enum CodingKeys: String, CodingKey {
        case eventStateImageID = "eventStateImageId"
        case images
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
