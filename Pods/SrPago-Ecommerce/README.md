
# SrPago-Ecommerce

[![CI Status](https://img.shields.io/travis/fbustosr@srpago.com/SrPago-Ecommerce.svg?style=flat)](https://travis-ci.org/fbustosr@srpago.com/SrPago-Ecommerce)
[![Version](https://img.shields.io/cocoapods/v/SrPago-Ecommerce.svg?style=flat)](https://cocoapods.org/pods/SrPago-Ecommerce)
[![License](https://img.shields.io/cocoapods/l/SrPago-Ecommerce.svg?style=flat)](https://cocoapods.org/pods/SrPago-Ecommerce)
[![Platform](https://img.shields.io/cocoapods/p/SrPago-Ecommerce.svg?style=flat)](https://cocoapods.org/pods/SrPago-Ecommerce)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first. In there you can find a little demo of how validate a card and get a token for this card

![dasdasd](https://github.com/LFBR-SrPago/SrPago-ecommerce/blob/main/Example/SrPago-Ecommerce/home.png?raw=true)

## Requirements

Before you start a development you must register on our platform to obtain the specific credentials for your project. You can review any questions [here](https://devcenter.srpago.com/docs/librerias/como-empezar/registro-de-una-aplicacion/)

## Installation

  
SrPago-Ecommerce is available through [CocoaPods](https://cocoapods.org). To install

it, simply add the following line to your Podfile:

```ruby

pod 'SrPago-Ecommerce'

```

Then open a terminal and install or update your podfile to download this repository

```ruby

pod install

```

After this, import SrPago.framework in your file

```swift

import SrPago

```

Create a new instance of SrPago like singleton class and setup this initialization with your current key

```swift

let srPago: SrPago = SrPago.sharedInstance()

srPago.publishableKey = <<YOUR_SRPAGO_PUBLISH_KEY>>

srPago.liveMode = false

```


To validate a credit card just neet to create a file of type SPCard()

```swift

let card = SPCard()
card.name = "Your name"
card.number = "Your credit card number"
card.expMonth = "Expiration month from 1 to 12"
card.expYear = "The last two numbers of the expiration year"
card.cvv = "The card's CVV"

srPago.token.createToken(with: card, onSuccess: { (token) in
if let token = token?.token {
   self.tokenLabel.text = "Token: \(token)"
}
}) { (error) in
   if let error = error?.message {
   self.tokenLabel.text = "Error: \(error)"
}
}

```
  
## Author

[SrPago][https://devcenter.srpago.com]

## License

SrPago-Ecommerce is available under the MIT license. See the LICENSE file for more info.
