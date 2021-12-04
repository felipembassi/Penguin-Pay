//
//  RecipientCountryCollectionViewManager.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import Foundation
import UIKit

class RecipientCountryCollectionViewManager: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private var viewModel: RecipientCountrySelectionViewModelProtocol
    private let sizeFactor: CGFloat = 2
    
    init(viewModel: RecipientCountrySelectionViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipientCountryCollectionViewCell.className, for: indexPath) as? RecipientCountryCollectionViewCell {
            cell.set(viewModel: viewModel.getCellModel(for: indexPath))
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectCounty(viewModel.countries.value[indexPath.row])
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.frame.width/CGFloat(viewModel.numberOfRows) + (.spacing(.medium) * CGFloat(viewModel.numberOfRows))), height: collectionView.frame.height/sizeFactor)
    }
    
}
