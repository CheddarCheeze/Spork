//
//  HomeModel.swift
//  Spork
//
//  Created by Adrian Ordorica on 9/26/16.
//  Copyright © 2016 Adrian Ordorica. All rights reserved.
//

import Foundation

protocol HomeModelProtocal: class {
    func itemsDownloaded(items: NSArray)
}


class HomeModel: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: HomeModelProtocal!
    
    var data : NSMutableData = NSMutableData()
    
    let urlPath: String = "http://cyberwizard.me/recipe_service.php"

    
    func downloadItems() {
        
        let url: URL = URL(string: urlPath)!
        //let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: url as URL)
        var session: URLSession!
        let config = URLSessionConfiguration.default
        
        session = Foundation.URLSession(configuration: config)
        
        let task = session.dataTask(with: url as URL) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                do{
                    self.data.append(data! as Data);
                    self.parseJSON()
                    //let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    
                    //print(json)
                    /*
                    if let stations = json["["] as? [[String: AnyObject]] {
                        
                        for station in stations {
                            
                            if let name = station["full_name"] as? String {
                                
                                if let year = station["email"] as? String {
                                    print(name,year)
                                }
                                
                            }
                        }
                    
                    }
                    */
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        
        task.resume()
        
    }
    
    @objc(URLSession:dataTask:didReceiveData:) func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.data.append(data as Data);
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error != nil {
            print("Failed to download data")
        }else {
            print("Data downloaded")
            self.parseJSON()
        }
        
    }
    
    func parseJSON() {
        
        var jsonResult: NSArray = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: self.data as Data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement: NSDictionary = NSDictionary()
        let recipes: NSMutableArray = NSMutableArray()
        
        for i in 0..<jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let recipe = RecipeModel()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let id = jsonElement["id"] as? String,
                let user_id = jsonElement["user_id"] as? String,
                let title = jsonElement["title"] as? String,
                //let picture = jsonElement["picture"] as? String,
                let prep_time = jsonElement["prep_time"] as? String,
                let cook_time = jsonElement["cook_time"] as? String,
                let notes = jsonElement["notes"] as? String
            {
                
                recipe.id = id
                recipe.user_id = user_id
                recipe.title = title
                recipe.prep_time = prep_time
                recipe.cook_time = cook_time
                recipe.notes = notes
                
                if let picture = jsonElement["picture"] as? String {
                    recipe.picture = picture
                }
            }
            
            recipes.add(recipe)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: recipes)
            
        })
    }
}
