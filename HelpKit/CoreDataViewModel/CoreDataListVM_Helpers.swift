//
//  CoreDataListVM_Helpers.swift
//  CamChat
//
//  Created by Patrick Hanna on 9/8/18.
//  Copyright © 2018 Patrick Hanna. All rights reserved.
//







public protocol CelledListView: class {
    

    associatedtype CellBaseType: UIView
    
    
    func register(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: String)
    func insertCell(at index: IndexPath)
    func deleteCell(at index: IndexPath)
    func moveCell(from index: IndexPath, to newIndex: IndexPath)
    func reloadCell(at index: IndexPath)
    func reloadData()
    func performBatchUpdates(_ updates: (() -> Void)?, completion: ((Bool) -> Void)?)
    func cellForItem(at index: IndexPath) -> CellBaseType?
    
}

extension UITableView: CelledListView{
    
    public typealias CellBaseType = UITableViewCell
    
    public func cellForItem(at index: IndexPath) -> UITableViewCell? {
        return cellForRow(at: index)
    }
    
    public func insertCell(at index: IndexPath) {
        insertRows(at: [index], with: .fade)
    }
    
    public func deleteCell(at index: IndexPath) {
        deleteRows(at: [index], with: .fade)
    }
    
    public func moveCell(from index: IndexPath, to newIndex: IndexPath) {
        moveRow(at: index, to: newIndex)
    }
    
    public func reloadCell(at index: IndexPath) {
        reloadRows(at: [index], with: .fade)
    }
    
    
}

extension UICollectionView: CelledListView{
    
    
    
    
    public typealias CellBaseType = UICollectionViewCell
    
    
    
    public func register(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: String) {
        register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    public func insertCell(at index: IndexPath) {
        insertItems(at: [index])
    }
    public func deleteCell(at index: IndexPath) {
        deleteItems(at: [index])
    }
    
    public func moveCell(from index: IndexPath, to newIndex: IndexPath) {
        moveItem(at: index, to: newIndex)
    }
    
    public func reloadCell(at index: IndexPath) {
        reloadItems(at: [index])
    }
    
}



