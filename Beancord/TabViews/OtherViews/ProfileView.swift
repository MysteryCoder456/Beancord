//
//  ProfileView.swift
//  Beancord
//
//  Created by Rehatbir Singh on 06/13/2021.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage

struct ProfileView: View {
    @ObservedObject var userRepo: UserRepository
    @State var user: AppUser
    
    @State var username: String = ""
    @State var email: String = ""
    
    @State var primaryAlertMessage: String = ""
    @State var secondaryAlertMessage: String = ""
    @State var showingAlert: Bool = false
    
    @State var showingImagePicker: Bool = false
    @State var profileImage = UIImage(named: "bean")!
    @State var newProfileImage = UIImage()
    
    let sizeLimitMegaBytes: Int64 = 5
    
    init(userRepo: UserRepository, user: AppUser) {
        self.userRepo = userRepo
        self._user = .init(initialValue: user)
        
        self._username = .init(initialValue: user.username)
        self._email = .init(initialValue: user.email)
    }
    
    var body: some View {
        VStack {

            Button(action: { showingImagePicker = true }) {
                VStack {
                    
                    Image(uiImage: profileImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                    
                    Text("Upload Image")
                        .font(.footnote)
                    
                }
            }
            .padding(5)
            
            Text(user.username)
                .font(.title2)
            
            GroupBox {
                    
                HStack {
                    Text("Username:")
                        .bold()
                    
                    TextField("Change your username", text: $username)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                
                Divider()
                
                HStack {
                    Text("Email:")
                        .bold()
                    
                    TextField("Change your email", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                
                Divider()
                
                Button(action: saveDetails) {
                    Text("Save")
                }
                .alert(isPresented: $showingAlert) {
                    Alert(
                        title: Text(primaryAlertMessage),
                        message: Text(secondaryAlertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
                    
            }
            .padding(.horizontal)
                
            Spacer()
            
        }
        .navigationTitle("My Profile")
        .sheet(isPresented: $showingImagePicker, onDismiss: uploadProfileImage) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $newProfileImage)
        }
        .onAppear(perform: {
            // Retrieve user's profile image if they have one
            let storageRef = Storage.storage().reference(withPath: "profileImages/\(user.userID).jpg")
            storageRef.getData(maxSize: sizeLimitMegaBytes * 1048576 ) { data, error in
                if let error = error {
                    print("Error occurred while retrieving profile image: \(error.localizedDescription)")
                    return
                }
                
                if let data = data {
                    if let image = UIImage(data: data) {
                        profileImage = image
                    }
                }
            }
        })
        
    }
    
    func uploadProfileImage() {
        // Make sure an image was selected from image picker
        guard self.newProfileImage.size != CGSize.zero else { return }
        
        if let currentUserID = Auth.auth().currentUser?.uid {
            
            let uploadRef = Storage.storage().reference(withPath: "profileImages/\(currentUserID).jpg")
            guard let imageData = newProfileImage.jpegData(compressionQuality: 0.5) else { return }
            
            // Check if the selected image is less than the size limit
            if imageData.count > sizeLimitMegaBytes * 1048576 {
                
                self.primaryAlertMessage = "Image is too large"
                self.secondaryAlertMessage = "Image must be less than \(self.sizeLimitMegaBytes) MB"
                self.showingAlert = true
                return
                
            }
            
            let uploadMetadata = StorageMetadata()
            uploadMetadata.contentType = "image/jpeg"
            
            uploadRef.putData(imageData, metadata: uploadMetadata) { downloadMetadata, error in
                if let error = error {
                    
                    print(error)
                    self.primaryAlertMessage = "Unable to upload image"
                    self.secondaryAlertMessage = error.localizedDescription
                    self.showingAlert = true
                    
                } else {
                    
                    print("Image uploaded successfully. Metadata: \(String(describing: downloadMetadata))")
                    self.profileImage = self.newProfileImage
                    
                    // Set newProfileImage back to a blank UIImage object
                    self.newProfileImage = UIImage()
                    
                }
            }
            
        }
    }
    
    func saveDetails() {
        if let currentUser = Auth.auth().currentUser {
            currentUser.updateEmail(to: self.email) { error in
                if let error = error {
                    
                    print(error)
                    self.primaryAlertMessage = "Unable to update details"
                    self.secondaryAlertMessage = error.localizedDescription
                    self.showingAlert = true
                    
                } else {
                    
                    // TODO: Add field value checks
                    self.user.username = self.username
                    self.user.email = self.email
                    self.userRepo.updateUser(user: self.user)
                    
                    self.primaryAlertMessage = "Details updated succesfully"
                    self.secondaryAlertMessage = "Your accounts details were changed successfully."
                    self.showingAlert = true
                    
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userRepo: UserRepository(), user: previewUser)
    }
}
