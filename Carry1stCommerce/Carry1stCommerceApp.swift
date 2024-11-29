//
//  Carry1stCommerceApp.swift
//  Carry1stCommerce
//
//  Created by Ayodeji Ayankola on 25/11/2024.
//

import SwiftUI

@main
struct Carry1stCommerceApp: App {
	@StateObject private var cartManager = CartManagerViewModel(cartService: CartService())
	
	var body: some Scene {
		WindowGroup {
			RootView()
				.environmentObject(cartManager)
		}
	}
}
