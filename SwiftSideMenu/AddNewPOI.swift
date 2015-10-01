import UIKit


// to add a new point to a plist
class AddNewPOI: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var typeText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var textArea: UITextView!
    
    var selectedImage:UIImage = UIImage();
    var didSelectImage:Bool = false;
    
    let settings = NSUserDefaults.standardUserDefaults()
    
    struct holder {
        static var typeName:String = "";
        static var pointLat:String = "";
        static var pointLong:String = "";
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
            var mpoi:addNewPoint = addNewPoint();
            var point:PointOfInterest = PointOfInterest();
            point.name = nameText.text;
            point.description = textArea.text;
            point.type = typeText.text;
            point.lat = holder.pointLat;
            point.long = holder.pointLong;
            
            
//            point.long = NSUserDefaults.standardUserDefaults().valueForKey("pointLon") as! String;
//            point.lat = NSUserDefaults.standardUserDefaults().valueForKey("pointLat") as! String;
            
            if didSelectImage{
                var fileName = "suggestedImage"+NSDate().description;
                var fileUtils:FileUtils = FileUtils(fileName: fileName);
                fileUtils.fileType = "png";
                fileUtils.createIfNotExistUnderDocs();
                println(fileUtils.docsPath());
                imgConv.writeImage(selectedImage, toFile: fileUtils.docsPath());
                // yossef - poi - save the file name instead of the file path
                point.images.addObject(fileName)
//                point.images.addObject(fileUtils.docsPath())
            }
            else {
                //if image is not set by the user the path for the default image is stored in the plist
                point.images.addObject("");
                
                
//            point.images.addObject(NSBundle.mainBundle().pathForResource("defaultPoint", ofType: "jpg")!);
//                point.images.addObject(UIImage(named: "defaultPoint")!);
            }
            mpoi.addpointii(point);
            
            println("lat: " + AddNewPOI.holder.pointLat + " long: " + AddNewPOI.holder.pointLong);
            
            AddNewPOI.holder.typeName = "";
            AddNewPOI.holder.pointLat = "";
            AddNewPOI.holder.pointLong = "";
//            settings.setValue(nil, forKey: "pointLat");
//            settings.setValue(nil, forKey: "pointLon");
            println("lat: " + AddNewPOI.holder.pointLat + " long: " + AddNewPOI.holder.pointLong);
            
            var tempCor2: AnyObject? = NSUserDefaults.standardUserDefaults().valueForKey("pointLat");
            println(tempCor2);
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
        }
        
    }
    
//    var tempCor: AnyObject? = NSUserDefaults.standardUserDefaults().valueForKey("pointLat");
//    

    
    func validateSuggestForm() -> Bool{
        
//        if let ayshy = tempCor {
//            print("We have a coordinates\(tempCor)")
//        } else {
//            
//            println("We don't have coordinates")
//            
//        }
    
//        println(tempCor);
        if nameText.text == "" || typeText.text == "" || textArea.text == ""{
            return true;
        }
        
        else{
            if holder.pointLong == "" || holder.pointLat == "" {
                return true;
            }
//            if tempCor == nil {
//                return true;
//            }
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
        
//        settings.setValue("", forKey: "coorLat");
//        settings.setValue("", forKey: "coorLng");
        // Do any additional setup after loading the view, typically from a nib.
        
        //myImageUploadRequest()
        
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
        
        
        var manage:ManagePoints = ManagePoints();
        
        
        //writing to the plist
        //manage.write(tempPoint);
        
        // to pop the page and go back to the previous screen.
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
        
        
        
        //        //Sending the new point to the server!! :
        
        
        //        let myUrl = NSURL(string: "https://example.com/imageupload.php");
        //        //let myUrl = NSURL(string: "http://www.boredwear.com/utils/postImage.php");
        //
        //        let request = NSMutableURLRequest(URL:myUrl!);
        //        request.HTTPMethod = "POST";
        //
        //        let param = [
        //            "firstName"  : "Sergey",
        //            "lastName"    : "Kargopolov",
        //            "userId"    : "9",
        //            "name"      : "\(nameText.text)",
        //            "description": "\(textArea.text)",
        //            "type" : "\(typeText.text)"
        //        ]
        //
        //        let boundary = generateBoundaryString()
        //
        //        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        //
        //
        //        let imageData = UIImageJPEGRepresentation(myImageView.image, 1)
        //
        //        if(imageData==nil)  { return; }
        //
        //        request.HTTPBody = createBodyWithParameters(param, filePathKey: "file", imageDataKey: imageData, boundary: boundary)
        //
        //
        //
        //        //myActivityIndicator.startAnimating();
        //
        //        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
        //            data, response, error in
        //
        //            if error != nil {
        //                println("error=\(error)")
        //                return
        //            }
        //
        //            // You can print out response object
        //            println("******* response = \(response)")
        //
        //            // Print out reponse body
        //            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
        //            println("****** response data = \(responseString!)")
        //
        //            var err: NSError?
        //            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &err) as? NSDictionary
        //
        //
        //
        //            dispatch_async(dispatch_get_main_queue(),{
        //                //self.myActivityIndicator.stopAnimating()
        //                self.myImageView.image = nil;
        //            });
        //
        /*
        if let parseJSON = json {
        var firstNameValue = parseJSON["firstName"] as? String
        println("firstNameValue: \(firstNameValue)")
        }
        */
        
        //        }
        //
        //        task.resume()
        //
        
    }
    
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        var body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        let filename = "user-profile.jpg"
        
        let mimetype = "image/jpg"
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.appendData(imageDataKey)
        body.appendString("\r\n")
        
        
        
        body.appendString("--\(boundary)--\r\n")
        
        return body
    }
    
    
    
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().UUIDString)"
    }
    
    //method to hide keyboard when tapping anywhere
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
        
    }

    
    
}


extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}