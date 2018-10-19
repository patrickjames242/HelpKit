# HelpKit
This is a library of various class extensions and convenience classes and functions that I have come to find useful in developing iOS applications

## Pins
Pins represent several convenience extension methods on UIView and UILayoutGuide that simplify the process of setting constraints.
For example, one can simplify this:

        view2.translatesAutoresizingMaskIntoConstraints = false
        view1.addSubview(view2)
        view2.leftAnchor.constraint(equalTo: view1.rightAnchor, constant: 10).isActive = true
        view2.topAnchor.constraint(equalTo: view1.topAnchor).isActive = true
        view2.bottomAnchor.constraint(equalTo: view1.bottomAnchor).isActive = true
        view2.widthAnchor.constraint(equalToConstant: 30).isActive = true
