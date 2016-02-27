//
//  ViewController.swift
//  testSearch
//
//  Created by Chris Augg on 2/26/16.
//  Copyright © 2016 Auggie Doggie iOSware. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRectMake(0, 0, 0, 0))
    
    @IBOutlet weak var tableView: UITableView!    
    @IBOutlet weak var weatherViews: UIScrollView!
    
    var width: CGFloat = 0
    var height: CGFloat = 0
    var count: CGFloat = 1
    
    // use model instead - just an example.
    let data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
        "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
        "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
        "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
        "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]
    
    var filteredData = [String]()
    
    let logo = UIImage(named: "search.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let size: CGSize = self.view.bounds.size
        
        width = size.width;
        height = size.height;
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        
        searchBar.delegate = self
        searchBar.placeholder = "Enter a City"
        setImg()
        
        let tap = UITapGestureRecognizer(target: self, action: "tap")
        navigationController?.view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
       
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let city = filteredData[indexPath.row]
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("CityCell") as? CityCell {
            cell.configureCell(city)
            return cell
        } else {
            
            let cell = CityCell()
            cell.configureCell(city)
            return cell
        }
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }

    
    func tap() {
        
        self.navigationItem.titleView = searchBar
        self.tableView.hidden = false
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
            return dataString.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
        })
        
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        addCityView(filteredData[indexPath.row])
        setImg()
        self.tableView.hidden = true
        
    }
    
    func setImg() {
        
        let imageView = UIImageView(image:logo)
        imageView.frame = CGRectMake(0,0, 40, 40)
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.navigationItem.titleView = imageView
    }
    
    func addCityView(city: String) {
        
        let newView = UIView(frame: CGRectMake(-width + (width * CGFloat(count)), -65, width, height))
        newView.backgroundColor = UIColor.blackColor()
        
        let newLbl = UILabel(frame: CGRectMake(20, 20, width - 40, 50))
        newLbl.text = city
        newLbl.textAlignment = .Center
        newLbl.backgroundColor = UIColor.grayColor()
        newLbl.textColor = UIColor(colorLiteralRed: 255/255.0, green: 193/255.0, blue: 7/255.0, alpha: 1.0)
        
        newView.addSubview(newLbl)
        
        weatherViews.addSubview(newView)
        
        let scrollSize = CGSizeMake(weatherViews.frame.size.width * count, width)
        weatherViews.contentSize = scrollSize
        
        count++
        
    }
    

}

