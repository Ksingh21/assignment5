//
//  LocationViewController.swift
//  assignment4
//
//  Created by Student on 2018-02-28.
//  Copyright © 2018 Khushwant. All rights reserved.
//

import UIKit
import CoreLocation

class LocationViewController: UITableViewController {

        let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBOutlet weak var LocationTextField: UITextField!
    
    @IBOutlet weak var LatitudeTextField: UITextField!
    
    @IBOutlet weak var LongitudeTextField: UITextField!
    

    @IBAction func ForwardGeocoding(_ sender: Any) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(LocationTextField.text!, completionHandler: {
            placemarks, error in
            print("Found the location: \(String(describing: placemarks))")
            if let placemark = placemarks?.last {
                if  let latitude = placemark.location?.coordinate.latitude,
                    let longitude = placemark.location?.coordinate.longitude {
                    self.LatitudeTextField.text = String (latitude)
                    self.LongitudeTextField.text = String (longitude)
                    let alert = UIAlertController(title: "Forward Geocoding Result:", message:
                    "Latitude: \(self.LatitudeTextField.text!) Longitude: \(self.LongitudeTextField.text)" ,     preferredStyle: .alert)
                    let popup = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(popup)
                    self.present(alert, animated: true, completion: nil)
            }
            }
        })

    }
    
    @IBAction func ReverseGeocoding(_ sender: Any) {
        let geocoder = CLGeocoder();
        let location = CLLocation(latitude: Double (LatitudeTextField.text!)!, longitude: Double (LongitudeTextField.text!)!)
        geocoder.reverseGeocodeLocation(location, completionHandler: {
            placemarks, error in
            print("Found the location: \(String(describing: placemarks))")
            if let placemark = placemarks?.last!{
                var address = ""
                if let street1 = placemark.subThoroughfare {
                    address = address + street1 + " "
                }
                if let street2 = placemark.thoroughfare {
                    address = address + street2 + " "
                }
                if let city = placemark.locality {
                    address = address + city + " "
                }
                if let prov = placemark.administrativeArea {
                    address = address + prov + " "
                }
                if let postcode = placemark.postalCode{
                    address = address + postcode + " "
                }
                self.LocationTextField.text = address
                let alert = UIAlertController(title: "Reverse Geocoding Result:", message:
                    "Location: \(address)"  ,     preferredStyle: .alert)
                let popup = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(popup)
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
