//
//  APIdataModel.swift
//  FetchRewards Exercise
//
//  Created by Dambar Bista on 11/21/20.
//

import Foundation

// This will handle the error while fetching data from API
protocol APImanagerDelegate {
    
    func didFailWithError(error: Error)
}



// MARK:- API Model

struct APIdataModel {
    
    var apiManagerDelegate: APImanagerDelegate?
    
    func fetchData(completionOn: @escaping ([APIdataItems]) -> ()) {
        
        let url         = "https://fetch-hiring.s3.amazonaws.com/hiring.json"
        let urlString   = URL(string: url)
        let session     = URLSession.shared
        let dataTask    = session.dataTask(with: urlString!) { (data, response, error) in
            
            if error != nil {
                apiManagerDelegate?.didFailWithError(error: error!)
            }
            
            if let safeData = data {
                
                do {
                    let decodedData  = try JSONDecoder().decode([APIdataItems].self, from: safeData)
                    let filteredData = decodedData.filter({$0.name != nil && $0.name != ""}) // Filtering items name
                    
                    completionOn(filteredData)
                    
                } catch {
                    apiManagerDelegate?.didFailWithError(error: error)
                }
            }
        }
        dataTask.resume()
    }
}
