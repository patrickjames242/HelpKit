# HelpKit
HelpKit is a library of various class extensions and convenience classes and functions that I have come to find useful in developing iOS applications. Below are just a few examples.

## Pins
Pins represent several convenience extension methods on UIView and UILayoutGuide that simplify the process of setting constraints.
For example, one can simplify this...
```swift
   view2.translatesAutoresizingMaskIntoConstraints = false
   view1.addSubview(view2)
   view2.leftAnchor.constraint(equalTo: view1.rightAnchor, constant: 10).isActive = true
   view2.topAnchor.constraint(equalTo: view1.topAnchor).isActive = true
   view2.bottomAnchor.constraint(equalTo: view1.bottomAnchor).isActive = true
   view2.widthAnchor.constraint(equalToConstant: 30).isActive = true
```
to this...

```swift
   view2.pin(addTo: view1, anchors: [.left: view1.rightAnchor, .top: view1.topAnchor, .bottom: view1.bottomAnchor], constants: [.left: 10, .width: 30])
```

## Equations

Linear and Absolute Value equations are especially helpful when constructing heavily interactive user interfaces. For this reason I have made it easy to define such equations in code and 'solve for x.' Here's how it would be used.

```swift
   let equation = LinearEquation<CGFloat>(xy(0, 4), xy(1, 5))!
   print(equation[0.5]) // prints 4.5
```

## HKNotification

NotificationCenter in Foundation is, in my opinion, a pain, and code for posting and observing notifications is often very verbose. In addition, there is no type safety with regards to accessing information stored in the notification's userInfo property. HKNotification solves these issues with concise method calls and generics, which provides type-safe information along with the notification. For example...

```swift
   // Define a global notification instance
   let UserDidSignInNotification = HKNotification<(userID: String, username: String)>()
        
   UserDidSignInNotification.post(with: ("3K32KAL-AKSD391", "patrickJhanna242"))
        
   UserDidSignInNotification.listen(sender: self) { (args) in
       print(args.userID)
       print(args.username)
   }
   
   UserDidSignInNotification.removeListener(sender: self)

```

## CoreDataListViewVM

This generic class encapsulates NSFetchedResultsController and UITableViewDataSource code and reduces boilerplait code in collectionView and tableView controllers. It automatically updates the UI based on Core Data changes by setting itself as the dataSource of the collectionView or tableView and inserting, updating, moving, or deleting cells as needed. Basically all you need to do is set up the fetch request and write code to configure the cell. You would use it like this...

```swift
class MyCustomCellType: UITableViewCell{}
class ViewController: UITableViewController{
    
    private var viewModel: CoreDataListViewVM<ViewController>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = CoreDataListViewVM(delegate: self, context: CoreData.mainContext)
    }
    
    
}

extension ViewController: CoreDataListViewVMDelegate{
    var listView: UITableView {
        return tableView
    }
    
    var fetchRequest: NSFetchRequest<User> {
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "firstName", ascending: true)]
        return fetchRequest
    }
    
    func configureCell(_ cell: MyCustomCellType, at indexPath: IndexPath, for object: User) {
        cell.textLabel?.text = object.firstName
    }
}
```




