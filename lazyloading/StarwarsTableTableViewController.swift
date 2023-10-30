//
//  StarwarsTableTableViewController.swift
//  lazyloading
//
//  Created by Chinedu Uche on 30/10/2023.
//

import UIKit

class StarwarsTableTableViewController: UITableViewController {
    
    var  peopleList = [Starwars]()
    var currentOffset: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        Task{
            do{
                let stardex = try await StarwarsAPI_Helper.fetchStardex()
                peopleList = stardex.results
                currentOffset += 20
                tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return peopleList.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath) as! StarwarsTableViewCell

        // Configure the cell...
        let people = peopleList[indexPath.row]
//        cell.textLabel!.text = pokemon.name
        cell.nameLabel.text = people.name
        
        
        /**
         create a task to fetch poke details
        create a task to fetch poke image
         set pokeimage as pokeImageView.image
         */
        
        let cellTask = Task {
            do{
                let peopleDetails = try await StarwarsAPI_Helper.fetchStarDetails(urlString: people.url)
                let peopleImageData = try await StarwarsAPI_Helper.fetchStarImage(urlSring: peopleDetails.sprites.front_default!)
                
                cell.starImageView.image = UIImage(data: peopleImageData)
            } catch {
                print(error)
            }
        }
        
        cell.task = cellTask
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row + 1 == peopleList.count - 10 {
            // fetch more pokemone
            print("fetch more pokemon")
            Task {
                do {
                    let peopledex = try await StarwarsAPI_Helper.fetchStardex(offset: currentOffset)
                    peopleList.append(contentsOf: peopledex.results)
                    currentOffset += 20
                    tableView.reloadData()
                } catch {
                    print(error)
                }
            }
        }
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
