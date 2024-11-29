//
//  ContentView.swift
//  Carry1stCommerce
//
//  Created by Ayodeji Ayankola on 25/11/2024.
//

import SwiftUI

struct RootView: View {
	var body: some View {
		ProductListView(productViewModel: ProductViewModel(apiService: LiveAPIService()))
	}
}

#if DEBUG
struct RootView_Previews: PreviewProvider {
	static var previews: some View {
		RootView()
			.environmentObject(CartManagerViewModel(cartService: CartService()))
	}
}
#endif
