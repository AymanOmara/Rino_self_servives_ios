# RINO.Self-services-IOS
in ios Rino self services our app consist of three main layers as we are following MMVM Archticture design pattern 
# Model Layer 
* Network 
Which makes all Network requests
eatch method contains: TargetType which contains (baseURL ,path,method,task , headers )
* LocalModel and its responsible for storing data locally on the mobile

# View Model layer 
* this layer is responsible for send and pass data from : To and vice verse between  model and view layers

# View
* this layer is responsible for Creating UI and get inputs from user 
 # used tools
 * Alamofire
 * Combine
 * iOSDropDown
 * SkeletonView
 * MaterialComponents
 * MaterialActivityIndicator
 * SPAlert
 * lottie-ios
 * FirebaseMessaging
 * Firebase
 * SkeletonUI
 * Introspect
 * RXSwift
 # Application Main Futures 
 * Authorization (Login , logout , reset password , chnage password )
 * Payment process (Home Page contains some data of payments requests , view all payments in specific duration ,search for specific request, rquest details , Archive movement modifications , upload attachments, request approval  )
 * HR Clearance  (Home Page contains some data of Clearance requests , view all Clearance in specific duration ,search for specific request, rquest details  , upload attachments ,request approval )
 * Top Management Alerts (Home Page contains some data of  requests , view all requests  in specific duration ,search for specific request, rquest details )
 * All Modules contains push notifications 
 
