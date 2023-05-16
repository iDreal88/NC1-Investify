import SwiftUI

struct ContentView: View {
    // Initialize Variable Total Amount
    @State private var initialInvestment_Amount = ""
    @State private var interestRate_Amount = ""
    @State private var yearsInvested_Amount = ""
    @State private var totalAmount_Amount = 0.0
    
    // Initialize Variable Interest Rate
    @State private var initialInvestment_Rate = ""
    @State private var interestRate_Rate: Double = 0.0
    @State private var yearsInvested_Rate = ""
    @State private var totalAmount_Rate = ""
    
    @State private var selectedPicker = 0
    let picker = ["Total Amount", "Interest Rate"]
    
    // Function Calculate Total Amount
    func calculateTotal() {
        guard let initialInvestment_Amount = Double(initialInvestment_Amount),
              let interestRate_Amount = Double(interestRate_Amount),
              let yearsInvested_Amount = Double(yearsInvested_Amount)
        else {
            return
        }
        
        let interestDecimal_Amount = interestRate_Amount / 100
        let totalAmount_Amount = initialInvestment_Amount * pow(1 + interestDecimal_Amount, yearsInvested_Amount)
        self.totalAmount_Amount = totalAmount_Amount
    }
    
    // Function Calculate Interest Rate
    func calculateRate() {
        guard let totalAmount_Rate = Double(self.totalAmount_Rate),
              let initialInvestment_Rate = Double(self.initialInvestment_Rate),
              let yearsInvested_Rate = Double(self.yearsInvested_Rate)
        else {
            return
        }
        
        let interestRate_Rate = ((totalAmount_Rate / initialInvestment_Rate - 1) / yearsInvested_Rate) * 100
        self.interestRate_Rate = interestRate_Rate
    }
    
    // Function Clear Input Fields Total Amount
    func clearInputFieldsTotalAmount() {
        initialInvestment_Amount = ""
        interestRate_Amount = ""
        yearsInvested_Amount = ""
        totalAmount_Amount = 0.0
    }
    
    // Function Clear Input Fields Interest Rate
    func clearInputFieldsInterestRate() {
        initialInvestment_Rate = ""
        totalAmount_Rate = ""
        yearsInvested_Rate = ""
        interestRate_Rate = 0.0
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Picker(selection: $selectedPicker, label: Text("picker")) {
                        ForEach(0..<picker.count) { index in
                            Text(picker[index])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    .navigationTitle("Calculation")
                }
                
                VStack {
                    switch selectedPicker {
                        
                    // Total Amount
                    case 0:
                        VStack {
                            VStack {
                                HStack {
                                    Image(systemName: "dollarsign.circle")
                                    Text("Initial Investment")
                                        .font(.headline)
                                    Spacer()
                                }
                                
                                TextField("Amount", text: $initialInvestment_Amount)
                                    .keyboardType(.decimalPad)
                                    .textFieldStyle(.roundedBorder)
                            }
                            .padding(.bottom)
                            
                            VStack {
                                HStack {
                                    Image(systemName: "percent")
                                    Text("Interest Rate")
                                        .font(.headline)
                                    Spacer()
                                }
                                
                                TextField("Percent", text: $interestRate_Amount)
                                    .keyboardType(.decimalPad)
                                    .textFieldStyle(.roundedBorder)
                            }
                            .padding(.bottom)
                            
                            VStack {
                                HStack {
                                    Image(systemName: "calendar.badge.clock")
                                    Text("Years Invested")
                                        .font(.headline)
                                    Spacer()
                                }
                                
                                TextField("Years", text: $yearsInvested_Amount)
                                    .keyboardType(.decimalPad)
                                    .textFieldStyle(.roundedBorder)
                            }
                            .padding(.bottom)
                            
                            // If Field is Empty -> Button Disabled
                            if initialInvestment_Amount.isEmpty || interestRate_Amount.isEmpty || yearsInvested_Amount.isEmpty {
                                Button(action: calculateTotal) {
                                    Text("Calculate")
                                        .padding()
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .background(.secondary)
                                        .cornerRadius(10)
                                }
                                .disabled(true)
                                
                            // Else -> Button Changed to Primary
                            } else {
                                Button(action: calculateTotal) {
                                    Text("Calculate")
                                        .padding()
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .background(.primary)
                                        .cornerRadius(10)
                                }
                            }
                            
                            // Clear All Field Button
                            Button(action: clearInputFieldsTotalAmount) {
                                Text("Clear All")
                                    .padding()
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .background(.red)
                                    .cornerRadius(10)
                            }
                        }
                        
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        .shadow(radius: 1)
                        .padding()
                        
                        VStack {
                            Text("Total Amount")
                                .font(.title3)
                                .fontWeight(.bold)
                            Spacer()
                            Text("$ \(totalAmount_Amount, specifier: "%.2f")")
                                .font(.title3)
                        }
                        
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        .shadow(radius: 1)
                        .padding(.horizontal)
                        
                    // Interest Rate
                    case 1:
                        VStack {
                            VStack {
                                HStack {
                                    Image(systemName: "dollarsign.circle")
                                    Text("Initial Investment")
                                        .font(.headline)
                                    Spacer()
                                }
                                
                                TextField("Amount", text: $initialInvestment_Rate)
                                    .keyboardType(.decimalPad)
                                    .textFieldStyle(.roundedBorder)
                            }
                            .padding(.bottom)
                            
                            VStack {
                                HStack {
                                    Image(systemName: "equal.square")
                                    Text("Total Amount")
                                        .font(.headline)
                                    Spacer()
                                }
                                
                                TextField("Total", text: $totalAmount_Rate)
                                    .keyboardType(.decimalPad)
                                    .textFieldStyle(.roundedBorder)
                            }
                            .padding(.bottom)
                            
                            VStack {
                                HStack {
                                    Image(systemName: "calendar.badge.clock")
                                    Text("Years Invested")
                                        .font(.headline)
                                    Spacer()
                                }
                                
                                TextField("Years", text: $yearsInvested_Rate)
                                    .keyboardType(.decimalPad)
                                    .textFieldStyle(.roundedBorder)
                            }
                            .padding(.bottom)
                            
                            // If Field is Empty -> Button Disabled
                            if initialInvestment_Rate.isEmpty || totalAmount_Rate.isEmpty || yearsInvested_Rate.isEmpty {
                                Button(action: calculateRate) {
                                    Text("Calculate")
                                        .padding()
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .background(.secondary)
                                        .cornerRadius(10)
                                }
                                .disabled(true)
                                
                            // Else -> Button Changed to Primary
                            } else {
                                Button(action: calculateRate) {
                                    Text("Calculate")
                                        .padding()
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .background(.primary)
                                        .cornerRadius(10)
                                }
                            }
                            
                            // Clear All Field Button
                            Button(action: clearInputFieldsInterestRate) {
                                Text("Clear All")
                                    .padding()
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .background(.red)
                                    .cornerRadius(10)
                            }
                        }
                        
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        .shadow(radius: 1)
                        .padding()
                        
                        VStack {
                            Text("Interest Rate")
                                .font(.title3)
                                .fontWeight(.bold)
                            Spacer()
                            Text(" \(interestRate_Rate, specifier: "%.2f") %")
                                .font(.title3)
                        }
                        
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        .shadow(radius: 1)
                        .padding(.horizontal)
                        
                    default:
                        Text("Error.")
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
