//
//  SceneDelegate.swift
//  Pokedex
//
//  Created by Rachel Goldman on 11/1/20.
//  Copyright © 2020 Rachel Goldman. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    //let pokemonStore = PokemonStore()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        //Starting with iOS 13, handing is done in SceneDelegate. You should put all the method there with modifications.
        
        // Create an ItemStore from appDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let pokemonStore = appDelegate.pokemonStore
        
        // Access the ItemsViewController and set its item store
        let navController = window!.rootViewController as! UINavigationController
        let itemsController = navController.topViewController as! PokemonViewController
        itemsController.pokemonStore = pokemonStore
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        
        // Create an ItemStore from appDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let pokemonStore = appDelegate.pokemonStore
        
        //Save all items
        let success = pokemonStore.saveChanges()
        if (success) {
            print("Saved all of the Items")
        } else {
            print("Could not save any of the Items")
        }
        print("Leaving app")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Create an ItemStore from appDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let pokemonStore = appDelegate.pokemonStore
        
        //Save all items
        let success = pokemonStore.saveChanges()
        if (success) {
            print("Saved all of the Items")
        } else {
            print("Could not save any of the Items")
        }
        print("Leaving app")
        
        
    }
}

