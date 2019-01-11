//
//  ViewController.swift
//  dexkz
//
//  Created by Pritesh Nadiadhara on 1/9/19.
//  Copyright © 2019 Pritesh Nadiadhara. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    @IBOutlet weak var pokemonCollectionView: UICollectionView!
    
    private var pokeImageCollection = [PokemonInfo](){
        didSet {
            DispatchQueue.main.async {
                self.pokemonCollectionView.reloadData()
            }
        }
    }
    var pokemen = [PokemonInfo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonCollectionView.dataSource = self
        pokemonCollectionView.delegate = self
        getPokemonCards()
        
        
        
    }
    
    func getPokemonCards() {
        PokemonAPI.searchPokemon { (error, cards) in
            if let error = error{
                print(error)
            } else if let cards = cards {
                DispatchQueue.main.async {
                    self.pokeImageCollection = cards
                }
            }
        }
    }
    
    
}

extension PokemonViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokeImageCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = pokemonCollectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath) as? PokemonViewCell else { fatalError("Poke cell not found")}
        let card = pokeImageCollection[indexPath.row]
        ImageHelper.shared.fetchImage(urlString: card.imageUrl) { (error, image) in
            if let error = error {
                print(error)
            } else if let image = image {
                DispatchQueue.main.async {
                    cell.pokemonImage.image = image
                }
            }
        }
        return cell
    }
    
    
}

extension PokemonViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 125, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let mainStoryboard = UIStoryboard.init(name:"Main", bundle: nil)
        
        guard let detailVC = mainStoryboard.instantiateViewController(withIdentifier: "PokemonDetailViewController") as? PokemonDetailViewController else {return}
        
        detailVC.modalPresentationStyle = .overCurrentContext
        
        present(detailVC, animated: true, completion: nil)
    }
}



