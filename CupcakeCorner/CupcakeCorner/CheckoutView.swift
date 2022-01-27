import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    @State private var alertMessage = ""
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    func placeOrder() async {
        // Convert our current order object into some JSON data that can be sent.
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        // Tell Swift how to send that data over a network call.
        let url = URL(string: "https://reqres.in/api/cupcakes")!  // fake website that echos what we send
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        // Run that request and process the response.
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            alertMessage = "Thank You!"
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            alertMessage = "Checkout failed."
            confirmationMessage = "Please check your internet connection and try again"
            showingConfirmation = true
            
        }
    }


    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                        image
                            .resizable()
                            .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)

                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)

                Button("Place Order") { Task { await placeOrder()} }
                    .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert(alertMessage, isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
