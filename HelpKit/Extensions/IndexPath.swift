//
//  Indexpath.swift
//  HelpKit
//
//  Created by Patrick Hanna on 9/8/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//

import UIKit

extension IndexPath{
    
    
    public func isLastInSection(for collectionView: UICollectionView) -> Bool{
        return self == IndexPath(row: collectionView.numberOfItems(inSection: section) - 1, section: section)
    }
    
    
    
    public func isLastInSection(for tableView: UITableView) -> Bool{
        return self == IndexPath(row: tableView.numberOfRows(inSection: section) - 1, section: section)
    }
    
    public func isFirstInSection() -> Bool{
        return self.row == 0
    }
    
}

