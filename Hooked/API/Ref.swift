//
//  Ref.swift
//  Hooked
//
//  Created by Michael Roundcount on 3/6/20.
//  Copyright © 2020 Michael Roundcount. All rights reserved.
//

import Foundation
import Firebase

//All of our firebase related references. We'll assign one for every node. This was we do not have to hardcode elsewhere
let REF_USER = "users"
let REF_MESSAGE = "messages"


//Artist heiarchy
let REF_AUDIO = "audio"
let REF_AUDIO_FILE = "audioFiles"


let URL_STORAGE_ROOT = "gs://hooked-217d3.appspot.com"
let STORAGE_PROFILE = "profile"
let PROFILE_IMAGE_URL = "profileImageUrl"
let UID = "uid"
let EMAIL = "email"
let USERNAME = "username"
let STATUS = "status"

//let ERROR_EMPTY_PHOTO = "Please choose your profile image"
let ERROR_EMPTY_EMAIL = "Please enter an email address"
let ERROR_EMPTY_USERNAME = "Please enter a username"
let ERROR_EMPTY_PASSWORD = "Please enter a password"
let ERROR_EMPTY_EMAIL_RESET = "Please enter an email address to reset your password"

let SUCCESS_EMAIL_RESET = "We have just resent you a password reset email. Please check your inbox"

let IDENTIFIER_TABBAR = "TabBarVC"
let IDENTIFIER_WELCOME = "WelcomeVC"
let IDENTIFIER_CHAT = "ChatViewController"

let IDENTIFIER_USER_AROUND = "UsersAroundViewController"
let IDENTIFIER_CELL_USERS = "UserTableViewCell"
let IDENTIFIER_PEOPLE = "PeopleTableViewController"
let IDENTIFIER_EDIT_PROFILE = "ProfileTableViewController"
let IDENTIFIER_UPLOAD = "UploadTableViewController"
let IDENTIFIER_PREFERENCES = "PreferenceTableViewController"

let REF_GEO = "Geolocs"

let IDENTIFIER_DETAIL = "DetailViewController"

let IDENTIFIER_RADAR = "RadarViewController"
let IDENTIFIER_AUDIO_RADAR = "AudioRadarViewController"


let IDENTIFIER_NEW_MATCH = "NewMatchTableViewController"
let IDENTIFIER_LIKES = "LikesTableViewController"


let REF_ACTION = "action"

let REF_AUDIO_ACTION = "audioAction"

let REF_LIKES = "likes"
let REF_LIKE_COUNT = "likesCount"

//New preferecnes database
let REF_PREFERENCES = "preferences"


class Ref {
    let databaseRoot: DatabaseReference = Database.database().reference()
    //store the child node in a global variable
    
    var databaseUsers: DatabaseReference {
        return databaseRoot.child(REF_USER)
    }
    //method for taking a user id as a parameter to get the reference node
    func databaseSpecificUser(uid: String) -> DatabaseReference {
        return databaseUsers.child(uid)
    }
    
    //Adding as a reference to sign in with a username
    func databaseSpecificUsername(username: String) -> DatabaseReference {
        return databaseUsers.child(username)
    }
    
    
    //StorageRoot that is stored in a global variable
    let storageRoot = Storage.storage().reference(forURL: URL_STORAGE_ROOT)
    //the child class in the firebase url
    
    var storageProfile: StorageReference {
        return storageRoot.child(STORAGE_PROFILE)
    }
    //getting access to the user profile reference
    func storageSpecificProfile(uid: String) -> StorageReference {
        //naigiating to the specific user usering uid
        return storageProfile.child(uid)
    }
    
    
    
    
    //Not currently using
    var databaseGeo: DatabaseReference {
        return databaseRoot.child(REF_GEO)
    }
    
    
    
    //For the user based likes
    //This is referring to the "action" node that I am not using
    var databaseAction: DatabaseReference {
        return databaseRoot.child(REF_ACTION)
    }
    func databaseActionForUser(uid: String) -> DatabaseReference {
        return databaseAction.child(uid)
    }
    


    //adding in the new tables for just likes
    var databaseLikes: DatabaseReference {
         return databaseRoot.child(REF_LIKES)
     }
     //adding in the new tables for just likes
     func databaseLikesForUser(uid: String) -> DatabaseReference {
           return databaseLikes.child(uid)
    }
    
    
    //adding in the new tables for just the ability to count likes
    var databaseLikesCount: DatabaseReference {
         return databaseRoot.child(REF_LIKE_COUNT)
     }
     //adding in the new tables for counting likes
     func databaseLikesCount(id: String) -> DatabaseReference {
           return databaseLikesCount.child(id)
    }
    
    
    
    //Uploading audio in preferences heiarchy
    var databasePreferences: DatabaseReference {
        return databaseRoot.child(REF_PREFERENCES)
    }
    
    func databasePreferencesUser(user: String) -> DatabaseReference {
        return databasePreferences.child(user)
    }


    
    
    
    
    
    //Uploading audio in artist heiarchy
    var databaseAudio: DatabaseReference {
        return databaseRoot.child(REF_AUDIO)
    }
    
    func databaseAudioArtist(artist: String) -> DatabaseReference {
        return databaseAudio.child(artist)
    }
    
    //Uploading JUST audio files
    func databaseAudioFileOnly() -> DatabaseReference {
        return databaseRoot.child(REF_AUDIO_FILE)
    }
    
    
    //In an attempt to remove records from audioFile
    var databaseAudioFile: DatabaseReference {
        return databaseRoot.child(REF_AUDIO_FILE)
    }
    //In an attempt to remove records from audioFile
    func databaseAudioFileRef(artist: String) -> DatabaseReference {
        return databaseAudio.child(artist)
    }
  
    
    
    
    //Need this for both
    var storageAudio: StorageReference {
        return storageRoot.child(REF_AUDIO)
    }
    
    func storageSpecificAudio(id: String) -> StorageReference {
        print("from final audio")
        return storageAudio.child(id)
    }
    
    //Used to return audio IDs from the liked database
    func databaseSpecificAudio(id: String) -> DatabaseReference {
        return databaseAudioFileOnly().child(id)
     }
    
    
    

    
    
    //These are for training. I do not actually use these in the MVP
    var databaseMessage: DatabaseReference {
        return databaseRoot.child(REF_MESSAGE)
    }
    
    func databaseMessageSendTo(from: String /*,to: String*/) -> DatabaseReference {
        return databaseMessage.child(from)/*.child(to)*/
    }
    
    var storageMessage: StorageReference {
        return storageRoot.child(REF_MESSAGE)
    }
    
    
    func storageSpecificImageMessage(id: String) -> StorageReference {
        return storageMessage.child("photo").child(id)
    }
    
    func storageSpecificVideoMessage(id: String) -> StorageReference {
        return storageMessage.child("video").child(id)
    }
    
    func storageSpecificAudioMessage(id: String) -> StorageReference {
        return storageMessage.child("audio").child(id)
    }
}


/*
let storageRef = Storage.storage().reference(forURL: "gs://hooked-217d3.appspot.com")
 download the profile image url
let storageProfileRef = storageRef.child("profile").child(authData.user.uid)
*/
