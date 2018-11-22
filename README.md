# Quiz Application using Clean architecture and RxSwift

### Installing and build

Dependencies in this project are provided via Cocoapods. Please install all dependecies with

`
pod install
`
Build sequence: Domain > NetworkPlatform > Application 

## High level overview
![](Architecture/Modules.png)

#### Domain 

The `Domain` is basically what is your App about and what it can do (Entities, UseCase etc.) **It does not depend on UIKit or any persistence framework**, and it doesn't have implementations apart from entities

#### Platform

The `Platform` is a concrete implementation of the `Domain` in a specific platform like iOS. It does hide all implementation details.

#### Application
`Application` is responsible for delivering information to the user and handling user input. It can be implemented with any delivery pattern e.g (MVVM, MVC, MVP). This is the place for your `UIView`s and `UIViewController`s. As you will see from the example app, `ViewControllers` are completely independent of the `Platform`.  The only responsibility of a view controller is to "bind" the UI to the Domain to make things happen.

### Refrences
* [RxSwift](https://github.com/ReactiveX/RxSwift)
* [RxSwift Book](https://store.raywenderlich.com/products/rxswift)
* [Robert C Martin - Clean Architecture and Design](https://www.youtube.com/watch?v=Nsjsiz2A9mg)
* [Cycle.js](https://cycle.js.org)
* [ViewModel](https://medium.com/@SergDort/viewmodel-in-rxswift-world-13d39faa2cf5#.qse37r6jw) in Rx world

### Contact me

* feel free to contact by [Email](mailto://behrad.kzm@gmail.com)
