import UIKit


// to add a new point to a plist
class AddNewPOI: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, NSURLConnectionDataDelegate, NSURLConnectionDelegate{
    
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var typeText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var textArea: UITextView!
    
    var selectedImage:UIImage = UIImage();
    var didSelectImage:Bool = false;
    lazy var data = NSMutableData()
    var submitted: String = "1";
    var point:PointOfInterest = PointOfInterest();
    
    let settings = NSUserDefaults.standardUserDefaults()
    
    struct holder {
        static var typeName:String = "";
        static var pointLat:String = "";
        static var pointLong:String = "";
        static var startDate:String = "";
        static var endDate:String = "";
    }
    
    var imgConv:ImageConversion = ImageConversion();
    
    
    @IBAction func setLocationButton(sender: AnyObject) {
        
        
        var getLocation:GetLocationVC = UIStoryboard(name: "GetLocation", bundle: nil).instantiateViewControllerWithIdentifier("GetLocationVC") as! GetLocationVC;
        //
        //        NSUserDefaults.standardUserDefaults().setValue("0.0", forKey: "pointLat");
        //        NSUserDefaults.standardUserDefaults().setValue("0.0", forKey: "pointLon");
        //        getLocation.latKey = "pointLat";
        //        getLocation.lngKey = "pointLon";
        self.presentViewController(getLocation, animated: true, completion: {});
        
    }
    
    
    
    @IBAction func uploadButtonTapped(sender: AnyObject) {
        
        //myImageUploadRequest()
        if (validateSuggestForm()){
            var alert : UIAlertView = UIAlertView(title: "ALERT!!", message: "Cannot leave mandatory fields empty.",
                delegate: nil, cancelButtonTitle: "OK");
            alert.show();
        }
        else{
//            var mpoi:addNewPoint = addNewPoint();
            var mpoi:addNewPoint = addNewPoint();
            
            point = PointOfInterest();
            point.name = nameText.text;
            point.description = textArea.text;
            point.type = typeText.text;
            point.lat = holder.pointLat;
            point.long = holder.pointLong;
            point.startDate = holder.startDate;
            point.endDate = holder.endDate;
            
            
            if didSelectImage{
//                var fileName = "suggestedImage"+NSDate().description;
//                var fileUtils:FileUtils = FileUtils(fileName: fileName);
//                fileUtils.fileType = "png";
//                fileUtils.createIfNotExistUnderDocs();
//                println(fileUtils.docsPath());
//                imgConv.writeImage(selectedImage, toFile: fileUtils.docsPath());
                var imageData = UIImagePNGRepresentation(selectedImage);
                let base64String = imageData.base64EncodedStringWithOptions(.allZeros)
                
                // yossef - poi - save the file name instead of the file path
                point.images.addObject(base64String);
                //                point.images.addObject(fileUtils.docsPath())
            }
            else {
                //if image is not set by the user the path for the default image is stored in the plist
                point.images.addObject("");
                
            }
            
            //send the request to web service
            startConnection();
            
            
            
            
            println(submitted);
        }
    
    
    }
    
    
    func validateSuggestForm() -> Bool{
        
        
        if nameText.text == "" || typeText.text == "" || textArea.text == ""{
            return true;
        }
            
        else{
            if holder.pointLong == "" || holder.pointLat == "" {
                return true;
            }
            
            return false;
        }
        
    }
    
    @IBAction func selectPhotoButtonTapped(sender: AnyObject) {
        
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(myPickerController, animated: true, completion: nil)
        
    }
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
        
    {
        myImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage!;
        self.dismissViewControllerAnimated(true, completion: nil)
        didSelectImage = true;
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        didSelectImage = false;
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        typeText.text = AddNewPOI.holder.typeName;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func myImageUploadRequest()
    {
        
        var fileUtils:FileUtils = FileUtils(fileName: "suggestedImage");
        fileUtils.fileType = "png";
        fileUtils.createIfNotExistUnderDocs();
        imgConv.writeImage(selectedImage, toFile: fileUtils.docsPath());
        println(fileUtils.docsPath());
        
        //to send to server
        //        var tempPoint:[String:String] = ["Name":nameText.text,"Type":typeText.text , "Description":textArea.text, "image":fileUtils.docsPath()];
        
        //to write directly in placeDetails
        
        // yossef - poi - save the file name instead of the file path
        var tempPoint = ["image":[fileUtils.fileName], "description":textArea.text, "lat":00.00, "long":00.00];
        
        
        //        var manage:ManagePoints = ManagePoints();

        //writing to the plist
        //manage.write(tempPoint);
        
        // to pop the page and go back to the previous screen.
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
       
    }
    
   
    //method to hide keyboard when tapping anywhere
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
        
    }
    
    
    func startConnection(){
        //let urlPath: String = "http://mobile.comxa.com/events/all_events.jsp"
        let urlPath: String = "http://172.16.8.105:8080/MyWayWeb/requestEvent"
        var url: NSURL = NSURL(string: urlPath)!
        var request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST";
        
        var username = NSUserDefaults.standardUserDefaults().stringForKey("username")!;
        //var bodyData = "username=\(username)&category=\(point.type)&name=\(point.name)&latitude=\(point.lat)&longitude=\(point.long)&description=\(point.description)&image=\(point.images)&startDate=\(point.startDate)&endDate=\(point.endDate)";
        var bodyData = "username=ahmed&category=\(point.type)&name=\(point.name)&latitude=\(point.lat)&longitude=\(point.long)&description=\(point.description)&image=\(point.images)&startDate=\(point.startDate)&endDate=\(point.endDate)";
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
        println(bodyData);
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)!
        data = NSMutableData()//re-initialize the data so it wouldn't be an invalid JSON after i append to it the newer JSON
        connection.start()
    }
    
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        self.data.appendData(data)
        
    }
    
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        var err: NSError
        // throwing an error on the line below (can't figure out where the error message is)
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
        // To check if the request was successful
       var tempNumber = jsonResult.valueForKey("result_code") as! NSNumber;
       submitted = "\(tempNumber)";
        
        if submitted == "1" {
            var alert : UIAlertView = UIAlertView(title: "Could Not Send", message: "Try again later.",
                delegate: nil, cancelButtonTitle: "OK");
            alert.show();
        } else {
            println("lat: " + AddNewPOI.holder.pointLat + " long: " + AddNewPOI.holder.pointLong);
            
            AddNewPOI.holder.typeName = "";
            AddNewPOI.holder.pointLat = "";
            AddNewPOI.holder.pointLong = "";
            
            //emptying the favs static holder
            AddNewFavoriteVC.holder.favLat = "";
            AddNewFavoriteVC.holder.favLong = "";
            
            println("lat: " + AddNewPOI.holder.pointLat + " long: " + AddNewPOI.holder.pointLong);
            
            var tempCor2: AnyObject? = NSUserDefaults.standardUserDefaults().valueForKey("pointLat");
            println(tempCor2);
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
            
        }
        println(submitted);
        
    }
    
    
    
 }



extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}