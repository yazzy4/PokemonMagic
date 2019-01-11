//
//  PokemonDetailViewController.swift
//  dexkz
//
//  Created by Pritesh Nadiadhara on 1/9/19.
//  Copyright © 2019 Pritesh Nadiadhara. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var pokemonButton: UIButton!
    @IBOutlet weak var pokemonDetailedImage: UIImageView!
    
    
    @IBOutlet weak var detailedPokemonCollectionView: UICollectionView!
    
    
    
    private var pokeDetailImage = [PokemonInfo](){
        didSet{
            DispatchQueue.main.async {
                self.detailedPokemonCollectionView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPokemonDetailCards()
        
    }
    
    
    func getPokemonDetailCards() {
        PokemonAPI.searchPokemon { (error, cards) in
            if let error = error{
                print(error)
            } else if let cards = cards {
                DispatchQueue.main.async {
                    self.pokeDetailImage = cards
                }
            }
        }
    }
    
    
    
}
