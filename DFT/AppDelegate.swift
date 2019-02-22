//
// AppDelegate.swift
// DFT
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 08/02/19
//

import SAPCommon
import SAPFiori
import SAPFioriFlows
import SAPFoundation
import SAPOData
import UserNotifications
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate, OnboardingManagerDelegate, ConnectivityObserver, UNUserNotificationCenterDelegate {
    var window: UIWindow?

    private let logger = Logger.shared(named: "AppDelegateLogger")
    var getFieldTicketDetails: GetFieldTicketDetails<OnlineODataProvider>!
    private(set) var sapURLSession: SAPURLSession = OnboardingContext().sapURLSession

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Set a FUIInfoViewController as the rootViewController, since there it is none set in the Main.storyboard
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.rootViewController = FUIInfoViewController.createSplashScreenInstanceFromStoryboard()

        do {
            // Attaches a LogUploadFileHandler instance to the root of the logging system
            try SAPcpmsLogUploader.attachToRootLogger()
        } catch {
            self.logger.error("Failed to attach to root logger.", error: error)
        }

        UINavigationBar.applyFioriStyle()

        ConnectivityReceiver.registerObserver(self)
        OnboardingManager.shared.delegate = self
        OnboardingManager.shared.onboardOrRestore()

        return true
    }

    // To only support portrait orientation during onboarding
    func application(_: UIApplication, supportedInterfaceOrientationsFor _: UIWindow?) -> UIInterfaceOrientationMask {
        switch OnboardingFlowController.presentationState {
        case .onboarding, .restoring:
            return .portrait
        default:
            return .allButUpsideDown
        }
    }

    // Delegate to OnboardingManager.
    func applicationDidEnterBackground(_: UIApplication) {
        OnboardingManager.shared.applicationDidEnterBackground()
    }

    // Delegate to OnboardingManager.
    func applicationWillEnterForeground(_: UIApplication) {
        OnboardingManager.shared.applicationWillEnterForeground {
        }
    }

    func onboarded(onboardingContext: OnboardingContext, onboarding _: Bool) {
        self.sapURLSession = onboardingContext.sapURLSession
        var configurationURL = (onboardingContext.info[OnboardingInfoKey.sapcpmsSettingsParameters] as! SAPcpmsSettingsParameters).url(forDestination: "com.incture.dftxsodata")
        if configurationURL == nil {
            configurationURL = onboardingContext.info[OnboardingInfoKey.authenticationURL] as? URL
        }
        if configurationURL == nil {
            // Adjust this path so it can be called after authentication and returns an HTTP 200 code. This is used to validate the authentication was successful.
            configurationURL = URL(string: "https://mobile-hkea136m18.hana.ondemand.com/com.incture.dftxsodata")!
        }
        //Get the logged in User Details
        let urlSession = self.sapURLSession
        let url = try! "https://mobile-hkea136m18.hana.ondemand.com/com.getloggedinUser.dest/services/userapi/attributes".asURL()
        let urlRequest = try! URLRequest(url: url, method: .get)
        let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            print("got user info")
            let data = try! JSONSerialization.jsonObject(with : data!) as! JSON
            print(data)
            //Get detailed userinfo
            self.getUserDetail(id: data["name"] as! String)
            self.configureOData(onboardingContext.sapURLSession, configurationURL!)

        }
        dataTask.resume()


        self.uploadLogs(onboardingContext.sapURLSession, onboardingContext.info[.sapcpmsSettingsParameters] as! SAPcpmsSettingsParameters)
        self.registerForRemoteNotification(onboardingContext.sapURLSession, onboardingContext.info[.sapcpmsSettingsParameters] as! SAPcpmsSettingsParameters)
    }
    //Get Detailed user Info
    func getUserDetail(id : String){
        let urlSession = self.sapURLSession
        let url = try! ("https://mobile-hkea136m18.hana.ondemand.com/InctureIDPDestination/service/scim/Users/" + id).asURL()
        let urlRequest = try! URLRequest(url: url, method: .get)
        let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            let data = try! JSONSerialization.jsonObject(with : data!) as! JSON
            print("got the user detailed info")
            //Parse the User
            print(data)
            User.shared.setUserDetails(json : data)
            self.setRootViewController()
        }
        dataTask.resume()
    }
    
    private func setRootViewController() {
        DispatchQueue.main.async {
//            let splitViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MainSplitViewController") as! UISplitViewController
//            splitViewController.delegate = self
//            splitViewController.modalPresentationStyle = .currentContext
//            splitViewController.preferredDisplayMode = .allVisible
//            self.window!.rootViewController = splitViewController
            
            //Setting Custom ViewController
//            (masterViewController as! DFTHeaderTypeMasterViewController).entitySetName = "DFTHeader"
            let allTicketsViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DFTAllTicketsViewController") as! DFTAllTicketsViewController

            func fetchDFTHeader(_ completionHandler: @escaping ([DFTHeaderType]?, Error?) -> Void) {
                // Only request the first 20 values. If you want to modify the requested entities, you can do it here.
                var queryFilter : QueryFilter
                if User.shared.role == UserRole.Reviewer{
                    queryFilter = DFTHeaderType.ownerID.equal(User.shared.id ?? "")
                    allTicketsViewController.addNewTicketButton.isHidden = true
                    
                }else{
                    queryFilter = DFTHeaderType.serviceProviderID.equal(User.shared.id ?? "")
                }
                let query = DataQuery().selectAll().where(queryFilter)
                print("Query Tickets for \(User.shared.role.debugDescription)")
                do {
                    self.getFieldTicketDetails!.fetchDFTHeader(matching: query) { dFTHeader, error in
                        if error == nil {
                            completionHandler(dFTHeader, nil)
                        } else {
                            completionHandler(nil, error)
                        }
                    }
                }
            }
            allTicketsViewController.loadEntitiesBlock = fetchDFTHeader
//            let navigationController = UINavigationController(rootViewController: allTicketsViewController)
            let MainNavigationController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MainNavigationController") as! UINavigationController
            MainNavigationController.viewControllers = [allTicketsViewController]
            
            self.window!.rootViewController = MainNavigationController
            

        }
    }

    // MARK: - Split view

    func splitViewController(_: UISplitViewController, collapseSecondary _: UIViewController, onto _: UIViewController) -> Bool {
        // The first Collection will be selected automatically, so we never discard showing the secondary ViewController
        return false
    }

    // MARK: - Remote Notification handling

    private var deviceToken: Data?

    func application(_: UIApplication, willFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        UIApplication.shared.registerForRemoteNotifications()
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in
            // Enable or disable features based on authorization.
        }
        center.delegate = self
        return true
    }

    // Called to let your app know which action was selected by the user for a given notification.
    func userNotificationCenter(_: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        self.logger.info("App opened via user selecting notification: \(response.notification.request.content.body)")
        // Here is where you want to take action to handle the notification, maybe navigate the user to a given screen.
        completionHandler()
    }

    // Called when a notification is delivered to a foreground app.
    func userNotificationCenter(_: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        self.logger.info("Remote Notification arrived while app was in foreground: \(notification.request.content.body)")
        // Currently we are presenting the notification alert as the application were in the background.
        // If you have handled the notification and do not want to display an alert, call the completionHandler with empty options: completionHandler([])
        completionHandler([.alert, .sound])
    }

    func registerForRemoteNotification(_ urlSession: SAPURLSession, _ settingsParameters: SAPcpmsSettingsParameters) {
        guard let deviceToken = self.deviceToken else {
            // Device token has not been acquired
            return
        }

        let remoteNotificationClient = SAPcpmsRemoteNotificationClient(sapURLSession: urlSession, settingsParameters: settingsParameters)
        remoteNotificationClient.registerDeviceToken(deviceToken) { error in
            if let error = error {
                self.logger.error("Register DeviceToken failed", error: error)
                return
            }
            self.logger.info("Register DeviceToken succeeded")
        }
    }

    func application(_: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        self.deviceToken = deviceToken
    }

    func application(_: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        self.logger.error("Failed to register for Remote Notification", error: error)
    }

    // MARK: - Log uploading

    // This function is invoked on every application start, but you can reuse it to manually trigger the logupload.
    private func uploadLogs(_ urlSession: SAPURLSession, _ settingsParameters: SAPcpmsSettingsParameters) {
        SAPcpmsLogUploader.uploadLogs(sapURLSession: urlSession, settingsParameters: settingsParameters) { error in
            if let error = error {
                self.logger.error("Error happened during log upload.", error: error)
                return
            }
            self.logger.info("Logs have been uploaded successfully.")
        }
    }

    // MARK: - Configure OData

    private func configureOData(_ urlSession: SAPURLSession, _ serviceRoot: URL) {
        let odataProvider = OnlineODataProvider(serviceName: "GetFieldTicketDetails", serviceRoot: serviceRoot, sapURLSession: urlSession)
        // Disables version validation of the backend OData service
        // TODO: Should only be used in demo and test applications
        odataProvider.serviceOptions.checkVersion = false
        self.getFieldTicketDetails = GetFieldTicketDetails(provider: odataProvider)
        // To update entity force to use X-HTTP-Method header
        self.getFieldTicketDetails.provider.networkOptions.tunneledMethods.append("MERGE")
    }

    // MARK: - ConnectivityObserver implementation

    func connectionEstablished() {
        // connection established
    }

    func connectionChanged(_ previousReachabilityType: ReachabilityType, reachabilityType _: ReachabilityType) {
        // connection changed
        if case previousReachabilityType = ReachabilityType.offline {
            // connection established
        }
    }

    func connectionLost() {
        // connection lost
    }
}
