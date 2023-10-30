//
//  CacheEntry.swift
//  lazyloading
//
//  Created by Chinedu Uche on 30/10/2023.
//

import Foundation

final class CacheEntryObject {
    let entry: CacheEntry
    init(entry: CacheEntry) {
        self.entry = entry
    }
}

enum CacheEntry {
    case inProgress(Task<Data, Error>)
    case ready(Data)
}

