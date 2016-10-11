//
//  ViewController.swift
//  Spork
//
//  Created by Adrian Ordorica on 9/25/16.
//  Copyright © 2016 Adrian Ordorica. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HomeModelProtocal   {
    
    //Properties
    
    var feedItems: NSArray = NSArray()
    var selectedRecipe : RecipeModel = RecipeModel()

    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //set delegates and initialize homeModel
        
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        let homeModel = HomeModel()
        homeModel.delegate = self
        homeModel.downloadItems()
        do{
        //let json = try JSONSerialization.jsonObject(with: homeModel.data as Data, options:.allowFragments)
        
        //print(json)
        }catch {
                print("Error with Json: \(error)")
            }
    }
    
    func itemsDownloaded(items: NSArray) {
        
        feedItems = items
        self.listTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of feed items
        return feedItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        // Retrieve cell
        let cellIdentifier: String = "BasicCell"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the recipe to be shown
        let item: RecipeModel = feedItems[indexPath.row] as! RecipeModel
        // Get references to labels of cell
        myCell.textLabel!.text = item.title
        
        return myCell
 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Set selected location to var
        selectedRecipe = feedItems[indexPath.row] as! RecipeModel
        // Manually call segue to detail view controller
        self.performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get reference to the destination view controller
        let detailVC  = segue!.destination as! DetailViewController
        // Set the property to the selected location so when the view for
        // detail view controller loads, it can access that property to get the feeditem obj
        detailVC.selectedRecipe = selectedRecipe
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

