import SwiftUI

struct ContentView: View {
    
    // Initalize Variable Total Amount
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
    
    // Total Amount
    func calculateTotal() {
        guard
            let initialInvestment_Amount = Double(initialInvestment_Amount),
            let interestRate_Amount = Double(interestRate_Amount),
            let yearsInvested_Amount = Double(yearsInvested_Amount)
        else {
            return
        }
        
        let interestDecimal_Amount = interestRate_Amount / 100
        let totalAmount_Amount = initialInvestment_Amount * pow(1 + interestDecimal_Amount, yearsInvested_Amount)
        self.totalAmount_Amount = totalAmount_Amount
    }
    
    // Interest Rate
    func calculateRate(){
        guard
            let totalAmount_Rate = Double(self.totalAmount_Rate),
            let initialInvestment_Rate = Double(self.initialInvestment_Rate),
            let yearsInvested_Rate = Double(self.yearsInvested_Rate) else {
            return
        }
        
        let interestRate_Rate =  ((totalAmount_Rate / initialInvestment_Rate - 1) / yearsInvested_Rate) * 100
        self.interestRate_Rate = interestRate_Rate
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Picker(selection: $selectedPicker, label: Text("picker")) {
                        ForEach(0..<picker.count) { index in
                            Text(picker[index])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .navigationTitle("Investment Calculator")
                    
                    switch selectedPicker {
                    case 0:
                        VStack {
                            HStack {
                                Image(systemName: "dollarsign.circle") .foregroundStyle(.white)
                                Text("Initial Investment")
                                    .fontDesign(.monospaced)
                                    .font(.headline)
                                Spacer()
                            }
                            
                            TextField("Amount", text: $initialInvestment_Amount)
                                .keyboardType(.decimalPad)
                                .textFieldStyle(.roundedBorder)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.white, lineWidth: 2)
                                )
                        }
                        .padding(.bottom)
                        
                        VStack {
                            HStack {
                                Image(systemName: "percent")
                                    .foregroundStyle(.white)
                                Text("Interest Rate")
                                    .fontDesign(.monospaced)
                                    .font(.headline)
                                Spacer()
                            }
                            
                            TextField("Percent", text: $interestRate_Amount)
                                .keyboardType(.decimalPad)
                                .textFieldStyle(.roundedBorder)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.white, lineWidth: 2)
                                )
                        }
                        .padding(.bottom)
                        
                        VStack {
                            HStack{
                                Image(systemName: "calendar.badge.clock")
                                    .foregroundStyle(.white)
                                Text("Years Invested")
                                    .fontDesign(.monospaced)
                                    .font(.headline)
                                Spacer()
                            }
                            
                            TextField("Years", text: $yearsInvested_Amount)
                                .keyboardType(.decimalPad)
                                .textFieldStyle(.roundedBorder)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.white, lineWidth: 2)
                                )
                        }
                        .padding(.bottom)
                        
                        VStack{
                            Text("Total Amount")
                                .font(.title3)
                                .fontWeight(.heavy)
                                .fontDesign(.monospaced)
                            Spacer()
                            Text("$ \(totalAmount_Amount, specifier: "%.2f")")
                                .font(.title3)
                            
                            Button(action: calculateTotal) {
                                Text("Calculate")
                            }
                            .buttonStyle(.bordered)
                            
                            .disabled(initialInvestment_Amount.isEmpty || interestRate_Amount.isEmpty || yearsInvested_Amount.isEmpty)
                        }
                        
                    case 1:
                        VStack {
                            HStack {
                                Image(systemName: "dollarsign.circle") .foregroundStyle(.white)
                                Text("Initial Investment")
                                    .fontDesign(.monospaced)
                                    .font(.headline)
                                Spacer()
                            }
                            
                            TextField("Amount", text: $initialInvestment_Rate)
                                .keyboardType(.decimalPad)
                                .textFieldStyle(.roundedBorder)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.white, lineWidth: 2)
                                )
                        }
                        .padding(.bottom)
                        
                        VStack {
                            HStack {
                                Image(systemName: "equal.square") .foregroundStyle(.white)
                                Text("Total Amount")
                                    .fontDesign(.monospaced)
                                    .font(.headline)
                                Spacer()
                            }
                            
                            TextField("Total", text: $totalAmount_Rate)
                                .keyboardType(.decimalPad)
                                .textFieldStyle(.roundedBorder)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.white, lineWidth: 2)
                                )
                        }
                        .padding(.bottom)
                        
                        VStack {
                            HStack{
                                Image(systemName: "calendar.badge.clock")
                                    .foregroundStyle(.white)
                                Text("Years Invested")
                                    .fontDesign(.monospaced)
                                    .font(.headline)
                                Spacer()
                            }
                            
                            TextField("Years", text: $yearsInvested_Rate)
                                .keyboardType(.decimalPad)
                                .textFieldStyle(.roundedBorder)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.white, lineWidth: 2)
                                )
                        }
                        .padding(.bottom)
                        
                        VStack{
                            Text("Interest Rate")
                                .font(.title3)
                                .fontWeight(.heavy)
                                .fontDesign(.monospaced)
                            Spacer()
                            Text(" \(interestRate_Rate, specifier: "%.2f") %")
                                .font(.title3)
                            
                            
                            Button(action: calculateRate) {
                                Text("Calculate")
                            }
                            .buttonStyle(.bordered)
                            
                            .disabled(initialInvestment_Rate.isEmpty || totalAmount_Rate.isEmpty || yearsInvested_Rate.isEmpty)
                        }
                        
                    default:
                        Text("Error.")
                    }
                }
                .padding()
            }
            .preferredColorScheme(.dark)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
