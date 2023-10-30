//
//  StarwarsDetailsViewController.swift
//  lazyloading
//
//  Created by Chinedu Uche on 30/10/2023.
//

import UIKit

class StarwarsDetailsViewController: UIViewController {
    
    var people: Starwars!
    var peopleDetails: StarDetails!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var skinLabel: UILabel!
    @IBOutlet weak var hairLabel: UILabel!
    @IBOutlet weak var eyelabel: UILabel!
    @IBOutlet weak var genderlabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = people.name
        
        nameLabel.text = ""
        heightLabel.text = ""
        massLabel.text = ""
        skinLabel.text = ""
        hairLabel.text = ""
        eyelabel.text = ""
        genderlabel.text = ""
        
        Task {
            do{
                peopleDetails = try await StarwarsAPI_Helper.fetchStarDetails(urlString: people.url)
                nameLabel.text = String(peopleDetails.name)
                heightLabel.text = String(peopleDetails.height)
                massLabel.text = String(peopleDetails.mass)
                skinLabel.text = String(peopleDetails.skin_color)
                hairLabel.text = String(peopleDetails.hair_color)
                eyelabel.text = String(peopleDetails.eye_color)
                genderlabel.text = String(peopleDetails.gender)
                
//                var url: String?
//                if let imageURL = pokeDetails.sprites.front_default {
//                    url = imageURL
//                } else if let imageURL = pokeDetails.sprites.front_female {
//                    url = imageURL
//                }
                
//                if let url = url {
//                    var pokeImageData = try await PokeAPI_Helper.fetchPokeImage(urlSring: url)
//                    
//                    imageView.image = UIImage(data: pokeImageData)
//                }
//                
//                
                
                spinner.stopAnimating()
            } catch {
                print(error)
            }
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
