//
//  Book.swift
//  PrettyShelf
//
//  Created by Seda Kunda on 18/01/2022.
//

import Foundation
import SwiftUI

struct Book: Codable {
    let publishers: [String]
    let subtitle: String
    let lastModified: Created
    let sourceRecords: [String]
    let title: String
    let numberOfPages: Int
    let isbn13: [String]
    let isbn10: [String]
    let weight: String
    let physicalFormat: String
    let identifiers: Identifiers
    let oclcNumbers: [String]
    let physicalDimensions: [String]
    let covers: [Int]
    let ocaid: String
    let lccn: [String]
    let created: Created
    let languages: [TypeElement]
    let fullTitle: String
    let lcClassifications: [String]
    let publishDate, key: String
    let authors: [TypeElement]
    let latestRevision: Int
    let works: [TypeElement]
    let type: TypeElement
    let subjects: [String]
    let revision: Int

    enum CodingKeys: String, CodingKey {
        case publishers, subtitle
        case lastModified = "last_modified"
        case sourceRecords = "source_records"
        case title
        case numberOfPages = "number_of_pages"
        case isbn13 = "isbn_13"
        case isbn10 = "isbn_10"
        case weight
        case physicalFormat = "physical_format"
        case identifiers
        case oclcNumbers = "oclc_numbers"
        case physicalDimensions = "physical_dimensions"
        case covers, ocaid, lccn, created, languages
        case fullTitle = "full_title"
        case lcClassifications = "lc_classifications"
        case publishDate = "publish_date"
        case key, authors
        case latestRevision = "latest_revision"
        case works, type, subjects, revision
    }
}

struct TypeElement: Codable {
    let key: String
}

struct Created: Codable {
    let type, value: String
}

struct Identifiers: Codable {
    let libraryThing, goodReads: [String]
    
    enum CodingKeys: String, CodingKey {
        case libraryThing = "library_thing"
        case goodReads = "good_reads"
    }
}

