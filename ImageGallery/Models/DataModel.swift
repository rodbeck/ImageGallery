//
//  DataModel.swift
//  ImageGallery
//
//  Created by Rodolphe Beck on 23/06/2024.
//

import Foundation
import SwiftData

@Observable
class DataModel {
    var items: [Item] = []
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        let urls = fetchImageFiles()
        for url in urls {
            let item = Item(url: url)
            items.append(item)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func fetchImageFiles() -> [URL] {
        let fileManager = FileManager.default
        let documentsURL = getDocumentsDirectory()
        
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil).filter({ $0.isImage })
            return fileURLs
        } catch {
            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
            return []
        }
    }
    
    func addItem(_ item: Item) {
        items.insert(item, at: 0)
    }
    
    func removeItem(_ item: Item) {
        let fileManager = FileManager.default
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
            do {
                try fileManager.removeItem(at: item.url)
            } catch {
                print("Error while deleting file \(item.url): \(error.localizedDescription)")
            }
        }
    }
    
}

extension URL {
    /// Indicates whether the URL has a file extension corresponding to a common image format.
    var isImage: Bool {
        let imageExtensions = ["jpg", "jpeg", "png", "gif", "heic"]
        return imageExtensions.contains(self.pathExtension)
    }
}
