//
//  StarWars_Helper.swift
//  lazyloading
//
//  Created by Chinedu Uche on 30/10/2023.
//

import Foundation

enum StarwarsAPI_Errors: Error {
    case CannotConvertStringToURL
    case cannotCreateURLComponent
}

actor StarwarsAPI_Helper {
    private static let baseURL = "https://swapi.dev/api/people"
    private static let decoder = JSONDecoder()
    private static let cache: NSCache<NSString, CacheEntryObject> = NSCache()
    
    // NOTE you will need to create the codable structure "Pokemon"
    private static func fetch(urlString: String) async throws -> Data {
        // convert url string into a URL **safely**

        guard
            let url = URL(string: urlString)
        else {throw StarwarsAPI_Errors.CannotConvertStringToURL}
        
        
        if let cached = cache[url] {
            switch cached {
            case let .inProgress(task):
                return try await task.value
            case let .ready(data):
                return data
            }
        }
        
        print(urlString)

        
        let task = Task {
            // create a datatask to fetch the information from the URL
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        }
        
        cache[url] = .inProgress(task)
        do{
            let data = try await task.value
            cache[url] = .ready(data)
            return data
        } catch {
            cache[url] = nil
            throw error
        }
    }
    
    // modify method to accept offset and limit
    public static func fetchStardex(offset: Int = 0, limit: Int = 20) async throws -> Stardex {
        
        
        
        // build url string from offset and limit
        // look into URLComponents
        guard
            var urlComp = URLComponents(string: baseURL)
        else {throw StarwarsAPI_Errors.cannotCreateURLComponent}
        
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "offset", value: String(offset)))
        queryItems.append(URLQueryItem(name: "limit", value: String(limit)))

        urlComp.queryItems = queryItems
        
        do {
//            let data = try await fetch(urlString: "\(baseURL)?offset=\(offset)&limit=\(limit)")
            print("this is the url generated by urlComp: \(urlComp.string!)")
            let data = try await fetch(urlString: urlComp.string!)
            let stardex = try decoder.decode(Stardex.self, from: data)
            return stardex
        } catch {
            throw error
        }
    }
    
    public static func fetchStarDetails(urlString: String) async throws -> StarDetails {
        do {
            let data = try await fetch(urlString: urlString)
            let stardetails = try decoder.decode(StarDetails.self, from: data)
            return stardetails
        } catch {
            throw error
        }
    }
    
    public static func fetchStarImage(urlSring: String) async throws -> Data {
        do {
            let data = try await fetch(urlString: urlSring)
            return data
        } catch {
            throw error
        }
    }
    
    public static func fetchStarImages(StarDetailURL: String) async throws -> [Data] {
        let starData = try await StarwarsAPI_Helper.fetchStarDetails(urlString: StarDetailURL)
        
        var images: [Data] = []
        
        
            let img = try await StarwarsAPI_Helper.fetchStarImage(urlSring: "https://pngimg.com/d/starwars_PNG27.png")
            images.append(img)
        
        
       
//            let img = try await StarwarsAPI_Helper.fetchStarImage(urlSring: "https://pngimg.com/d/starwars_PNG27.png")
//            images.append(img)
        
        
        return images
    }
    
    /**
     create a new method to fetch images
     
     accept a urlString and return data
     */
    
}

