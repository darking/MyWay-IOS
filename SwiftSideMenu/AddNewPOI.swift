import UIKit

class AddNewPOI: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var typeText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var textArea: UITextView!
    
    
    var selectedImage:UIImage = UIImage();
    var didSelectImage:Bool = false;
    
    struct holder {
        static var typeName:String = "";
    }
    
    var imgConv:ImageConversion = ImageConversion();
    
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
            point.long = "00.00";
            point.lat = "00.00";
            
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
                point.images.addObject(NSBundle.mainBundle().pathForResource("default", ofType: "jpg")!);
            }
            mpoi.addpointii(point);
            
            AddNewPOI.holder.typeName = "";
            
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
        }
        
    }
    
    func validateSuggestForm() -> Bool{
        if nameText.text == "" || typeText.text == "" || textArea.text == "" {
            return true;
        }
        else{
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
    
    
    
}


extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}