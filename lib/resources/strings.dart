class AppStrings {
  static final AppStrings _appStrings = AppStrings._internal();
  factory AppStrings() {
    return _appStrings;
  }
  AppStrings._internal();

  //Splash Screen
  String get appNameSplash => "Bharathasth Kaushal";

  //login Screen
  String get phone => 'Phone Number';
  String get phoneHint => 'Enter Phone Number';
  String get loginerrormessage => 'Please Enter Phone Number.';
  String get loginvalidPhone =>'Please Enter valid Phone Number.';
  String get getOTP => 'GET OTP';
  String get welcomeBack => 'Welcome back, you\'ve been missed!';
  String get letsSignIn => "Log In or Sign Up to Continue";
  String get or => 'Or';
  String get phoneVerification => "OTP Verification";
  String get editNumber => "Edit Phone Number?";

  //Otp Verification
  String get verifyPhoneNumber => "Verify Phone Number";
  String get otpDesc => "We need to register your phone number before getting started";
  String get pleaseEnterOTP => "Please Enter OTP";
  String get reSend => 'Resend';
  String get reSendCode => 'Resend OTP in ';

  // Upload Image Drawer
  String get uploadPhoto => 'Upload Photo';
  String get viewPhotoLibrary => 'View Photo Library';
  String get takeAPhoto => 'Take a Photo';
  String get removePhoto => 'Remove Photo';

  // Upload Video Drawer
  String get uploadVideo => 'Upload Video';
  String get viewVideoLibrary => 'View Video Library';
  String get takeAVideo => 'Take a Video';
  String get removeVideo => 'Remove Video';
  String get introductoryVideo => "Introductory Video";

  //Common Screen
  String get confirmExitTitle => 'Confirm Exit...!!!';
  String get confirmExitSubtitle => "Are you sure you want to exit?";
  String get cancel => 'CANCEL';
  String get exit => 'EXIT';

  //Home Screen
  String get success => "Success!";
  String get loginSuccess => "You have successfully logged into the system";
  String get goToDashboard => "Go to Dashboard";
  String get todayOrders => "Today Orders";
  String get approvedProducts => "Approved Products";
  String get pendingOrders => "Pending Orders";
  String get needAction => "Orders Need Action";
  String get totalOrders => "Total Orders";
  String get annualSales => "Annual Sales";
  String get recentlyAddedProducts => "Recently Added Products";
  String get viewAll => "View All>";
  String get recentOrders => "Recent Orders";
  String get salesStatistics => "Sales Statistics";
  String get perPiece => "/piece";

  //Add Product Screen
  String get addProduct => "Add Product";
  String get addProductDesc => "Add a new product to your store.";
  String get previousStep => "Previous step";
  String get nextStep => "Next step";
  String get submit => "Submit";
  String get pleaseFillMandatoryFields => "Please fill all the mandatory fields!";
  String get category => "Category";
  String get selectCategory => "Select Category";
  String get subCategory => "SubCategory";
  String get selectSubCategory => "Select SubCategory";
  String get productName => "Product Name";
  String get enterProductName => "Enter your Product name";
  String get timeToMake => "Time to Make (in days)";
  String get enterTimeToMake => "Enter how long it took to make";
  String get description => "Description";
  String get enterDescription => "Enter a detailed description\neg. product history, culture, uniqueness...";
  String get productPrice => "Product Price per Piece";
  String get enterProductPrice => "Enter Product Price per Piece";
  String get quantity => "Quantity";
  String get enterQuantity => "Enter Quantity";
  String get totalPrice => "Total Price";
  String get finishTexture => "Finish/Texture";
  String get selectTexture => "Select Texture";
  String get washCare => "Wash Care";
  String get selectWashCare => "Select Wash Care";
  String get material => "Material";
  String get enterMaterial => "Enter Material Used";
  String get netWeight => "Net Weight";
  String get enterNetWeight => "Enter Net Weight";
  String get dimension => "Dimension";
  String get length => "Length";
  String get breadth => "Breadth";
  String get height => "Height";
  String get artUsed => "Art Used";
  String get enterArtUsed => "Enter Art Used";
  String get patternUsed => "Pattern Used";
  String get enterPatternUsed => "Enter Pattern Used";
  String get uploadImages => "Upload Images";
  String get uploadImagesHere => "Upload your images here";
  String get clickToBrowse => "Click to browse";
  String get uploadImagesDesc => "Upload up to 10 images to showcase your product for the auction and social sharing. Each file must be under 2 MB and in JPG, JPEG, or PNG format.";
  String get pickedFiles => "Picked Files:";

  //Build Step Circle Screen
  String get stepGeneral => "General";
  String get stepDetails => "Details";
  String get stepFiles => "Files";

  // Product Tab Screen
  String get tabApproved => "Approved";
  String get tabPending => "Pending";
  String get tabRejected => "Rejected";
  String get myProductsTitle => "MY PRODUCTS";

  //MY Product
  String get myProducts => "My Products";
  String get addNewProduct => "Add New Product";
  String get hiThere => "Hi there";
  String get addYourProduct => "Add Your Product";
  String get emptyProductDesc => "Thanks for checking out products. we hope your products can make your routine a little more enjoyable.";

  //Pending Product Screen
  String get noPendingProducts => "No Pending Products";
  String get emptyPendingProductDesc => "Thanks for checking out Pending products. we hope your products can make your routine a little more enjoyable.";

  //Cancel Product Screen
  String get noRejectedProducts => "No Rejected Products";
  String get emptyRejectedProductDesc => "Thanks for checking out your rejected products. We hope your future products can make your routine a little more enjoyable.";

  //Product Details Screen
  String get productDetailsTitle => "Product Details";
  String get productIdPrefix => "Product ID: BHKP000";
  String get inclusiveTaxes => "Inclusive of all taxes";
  String get productQuantity => "Product Quantity";
  String get productDetails => "Product Details";
  String get dimensions => "Dimensions";
  String get texture => "Texture";
  String get careInstructions => "Care Instructions";

  //Order Details
  String get orderDetailsTitle => "Order Details";
  String get acceptOrder => "Accept Order";
  String get acceptOrderSubtitle => "Are you Sure you want to accept this order?";
  String get accept => "Accept";
  String get declineOrder => "Decline Order";
  String get declineOrderSubtitle => "Are you Sure you want to decline this order?";
  String get decline => "Decline";
  String get markAsCompleted => "Mark As Completed";
  String get declined => "Declined";
  String get waitingForApproval =>'Waiting for the Approval';
  String get awaitingPickUp =>'Waiting for the Pick Up';
  String get selectAddress => "Select Address for Pick Up";
  String get orderStatus => "Order Status";
  String get timeRemaining => "Time Remaining";
  String get asap=>"As Soon As Possible";
  String get orderValue => "Order Value";
  String get orderId => "Order ID";
  String get orderIdPrefix => "ORD000";
  String get product => "Product";
  String get productId => "Product ID";
  String get orderAssigned => "Order Assigned";
  String get dueDate => "Due Date";
  String get completeSoonPossible =>"Complete as soon as possible";
  String get orderInformation => "Order Information";
  String get productDescription => "Product Description";
  String get viewDetails =>"View Details";
  String get notAvailable => "Not Available";
  String get productionRequirements => "Production Requirements";
  String get orderDescription => "Order Description";
  String get materialsRequired => "Materials Required";
  String get specialInstructions => "Special Instructions";
  String get imageForReference => "Image for Reference"; 
  String get manage =>'Manage';

  //Upload Order Image
  String get uploadCompletion => "Upload Completion";
  String get finishedProduct => "Finished Product";
  String get addPicturesCompletedOrder => "Add pictures of the completed order.";
  String get uploadImagesOrderDesc => "Upload up to 10 images of the completed product to confirm the order and for record keeping. Please ensure each file is no larger than 2 MB, and use one of the supported formats: JPG, JPEG, or PNG.";
  String get pleaseUploadImages => "Please Upload Images!";

  //Order Tab Screen
  String get tabActiveOrders => "Active Orders";
  String get tabPastOrders => "Past Orders";
  String get ordersDetailsTitle => "ORDERS DETAILS";

  //Track Order
  String get orderTrackingTitle => "Order Tracking";
  String get orderIdPrefixHash => "Order Id #";
  String get orderFulfillmentStatus => "Order Fulfillment Status";
  String get statusOrderReceived => "Order Received";
  String get statusOrderCompleted => "Order Completed";
  String get statusAwaitingPickup => "Awaiting Pickup";
  String get statusInTransit => "In Transit";
  String get statusOrderDelivered => "Order Delivered";
  String get deliveredDescription => "Your order has been Successfully Delivered";
  String get expectedPickup => "Expected Pickup on ";
  String get awaitingPickup => "Awaiting Pickup";

  // Order History Screen
  String get noOrdersFound => "No Orders Found";
  String get emptyOrderDesc => "Once an order is delivered or declined, it will appear here with complete details for your review";
  String get payment => "Payment";
  String get orderQty => "Order Qty.";
  String get delivered => "Delivered";

  // Active orders Screen
  String get noOrdersAvailable => "No Orders Available";
  String get emptyOrdersDesc => "Once an order is allocated, it will appear here with complete details for your review and action.";
  String get orderCompleteBy => "Order to be completed by";
  String get orderNeedsAction => "Order Needs Action!";
  String get orderConfirmed => "Order is Confirmed";
  String get orderapproved => "Order is Approved";
  String get orderDeclined => "Order is Declined";

  //Edit Profile Screen
  String get updateProfile => 'Update Profile';
  String get personalInformation => 'Personal Information';
  String get save => 'Save';
  String get fiveMBValidation => "Maximum file size : 5 MB*";
  String get jpgPngAccpted => "Accepted file types : jpg, png, jpeg";
  String get viewIntro => 'View Intro';
  String get uploadedtick => "Uploaded ✓";
  String get uploadIntro => 'Upload Intro';
  String get firstName => 'First Name';
  String get firstNameHint => 'Enter your First name';
  String get lastName => "Last Name";
  String get lastNameHint => 'Enter your Last name';
  String get email => 'Email';
  String get emailHint => 'Enter your Email';
  String get gstNumber => 'GST Number';
  String get gstNumberHint => 'Enter GST Number (if Organisation)';
  String get caste => 'Caste';
  String get enterCaste => 'Enter your Caste';
  String get expertise => 'Expertise';
  String get selectExpertise => 'Select Expertise';

  //main Profile Screen
  String get profileAndMore => "Profile & More";
  String get viewProfile => "View Profile";
  String get myAddress => "My Address";
  String get editAddRemoveAddress => "Edit, add or remove Address";
  String get privacyPolicyTitle => "Privacy & Policy";
  String get privacyPolicySubtitle => "Read how we protect your personal data";
  String get termsConditions => "Terms & Conditions";
  String get termsConditionsSubtitle => "Review the terms of using our services";
  String get settings => "Settings";
  String get settingsSubtitle => "Edit Profile, Manage your profile";
  String get logout => "Logout";
  String get logoutSubtitle => "Sign out from your account";
  String get userDefault => "User";

  //Setting Screen
  String get editProfile => "Edit Profile";
  String get editProfileSubtitle => "Edit, or Change your Profile";
  String get deleteAccount => "Delete Account";
  String get deleteAccountSubtitle => "Remove your account permanently";
  String get verifyAadhaar => "Verify Aadhaar";
  String get verifyAadhaarSubtitle => "Securely link your Aadhaar for verification";
  String get needAssistance => 'Need Assistance';
  String get needAssistanceSubtitle => "Get the help you need quickly and easily";

  //View Profile
  String get pleaseSetExpertise => "Please set your Expertise";

  //Aadhar Screen
  String get aadharVerificationTitle => "Aadhar Verification";
  String get aadharVerificationHeader => "Aadhaar Verification";
  String get aadharVerificationDesc => "Verify your identity securely with your Aadhaar number. Enter your 16-digit Aadhaar number to receive a One-Time Password (OTP) on your registered mobile number.";
  String get aadhaarNumber => "Aadhaar Number";
  String get enterAadhaarNumber => "Enter your 12 Digits Aadhaar Number";
  String get sendOtp => "Send OTP";
  String get aadhaarOtp => "Aadhaar OTP";
  String get verifyOtp => "Verify OTP";

  //Notification
  String get notificationsTitle => "Notifications";
  String get markAsRead => "Mark as Read";

  //address Screen
  String get manageAddress => "Manage Address";
  String get yourAddressEmpty => "Your Address is Empty";
  String get emptyAddressDescription => "No address added yet. Keeping your profile\nsafe starts with adding your address. ";
  String get addAddress => "Add Address";
  String get defaultTag => 'Default';
  String get delete => 'Delete';
  String get defaultAddressDeleted => "Default address can't be deleted";
  String get edit => 'Edit';
  String get markasDefault => 'Mark As Default';
  String get addressDetails => "Address Details";
  String get addressDetailsDescription => 'Complete Address would assists better\nconnectivity with us...';
  String get houseBuilding => "House/Flat/Building";
  String get houseBuildingHint => "Enter your house/Flat/Building";
  String get streetArea => "Street/Area/Locality";
  String get streetAreaHint => "Enter your street/Area/Locality";
  String get landMark => 'LandMark';
  String get landMarkHint => 'Enter LandMark';
  String get city => 'City';
  String get cityHint => 'Enter your State';
  String get state => 'State';
  String get stateHint => 'Enter your state';
  String get country => 'Country';
  String get countryHint => 'Enter your country';
  String get pinCode => 'PinCode';
  String get pinCodeHint => 'Enter your PinCode';
  String get addressType => 'AddressType';
  String get confirmAddress => "Confirm Address";
  String get mandatoryFields => "please fill all the mandatory fields";
  String get fetchLocation=> "Please wait while we are fetching your location...";

  // Need Assistance
  String get needHelp => 'Need Help?';
  String get issueTypeHint => 'Issue Type';
  String get selectIssue => 'Select Issue';
  String get issueDescHint => 'Issue Description';
  String get detailedDescriptionIssue => 'Detailed description of the issue';
  String get requestSubmitted => 'Request Submitted';
  String get requestSubmittedDesc => 'Your request has been submitted and an executive will reach out to you shortly.';
  String get buttonGoBackHome => 'Go Back Home';
  String get contactPhone => "(246)264 845";
  String get contactEmail => "BharathasthKaushal@gmail.com";

  //default
  String get alert => 'Alert';
  String get yourAuthExpired => 'Your authentication has expired please login again';
  String get weUnable => 'We\'re unable to process your request.\nPlease try again.';
  String get retry => 'Retry';
  String get weUnableCheckData => 'Please Check Your Internet Connection, We Unable to Check your Data';
  String get ok => 'Ok';
}

AppStrings appStrings = AppStrings();
