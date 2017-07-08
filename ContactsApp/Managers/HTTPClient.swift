//
//  HTTPClient.swift
//  ContactsApp
//
//  Created by One on 07/07/2017.
//  Copyright © 2017 Onedeveloper. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

// I don’t have an example to get JSON with contacts from somewhere.
// But if I had one, I’d use Alamofire framework to ease the networking process.
// And it would look like this:

let baseUrl = "http://baseServerURL/"

class HttpClient: NSObject {
    
    static let shared = HttpClient()
    private var sessionManager = Alamofire.SessionManager.default
    
    override init() {
        super.init()
        configManager()
    }
    
    func configManager() {
        
        // here can be any configuration (for example, default header with token configuration)
    
        let configuration = URLSessionConfiguration.default
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    // MARK: - Contacts
    
    func accounts(complection:@escaping([ContactFromServer]?) -> Void) {
        sessionManager.request(baseUrl + "contacts.json", method: .get, encoding: JSONEncoding.default).responseArray{
            (response:DataResponse<[ContactFromServer]>) in
            complection(response.result.value)
        }
    }
}

// MARK: - Download images

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: baseUrl + link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
