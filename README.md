# HelpKit
This is a library of various class extensions and convenience classes and functions that I have come to find useful in developing iOS applications

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

   let UserDidSignInNotification = HKNotification<(userID: String, username: String)>()
        
   UserDidSignInNotification.post(with: ("3K32KAL-AKSD391", "patrickJhanna242"))
        
   UserDidSignInNotification.listen(sender: self) { (args) in
       print(args.userID)
       print(args.username)
   }

```




