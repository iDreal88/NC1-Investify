import SwiftUI

struct InvestmentCalculator: View {
    
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
    
    // Amount
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
    
    // Rate
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
            VStack {
                Picker(selection: $selectedPicker, label: Text("picker")) {
                    ForEach(0..<picker.count) { index in
                        Text(picker[index])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .navigationTitle("Investment Calculator")
            }
            
            
            switch selectedPicker {
            case 0:
                Form {
                    Section(header: Text("Initial Investment")) {
                        HStack{
                            Image(systemName: "dollarsign")
                                .foregroundStyle(.tertiary)
                            TextField("Amount", text: $initialInvestment_Amount)
                                .keyboardType(.decimalPad)
                        }
                    }
                    
                    Section(header: Text("Interest Rate")) {
                        HStack{
                            Image(systemName: "percent")
                                .foregroundStyle(.tertiary)
                            TextField("Percent", text: $interestRate_Amount)
                                .keyboardType(.decimalPad)
                        }
                    }
                    
                    Section(header: Text("Years Invested")) {
                        HStack{
                            Image(systemName: "calendar.badge.clock")
                                .foregroundStyle(.tertiary)
                            TextField("Years", text: $yearsInvested_Amount)
                                .keyboardType(.decimalPad)
                        }
                    }
                    
                    Section(header: Text("Total Amount")) {
                        Text("$ \(totalAmount_Amount, specifier: "%.2f")")
                    }
                    
                    Button(action: calculateTotal) {
                        Text("Calculate")
                    }
                    .frame(maxWidth: .infinity)
                }
                
            case 1:
                Form {
                    Section(header: Text("Initial Investment")) {
                        HStack{
                            Image(systemName: "dollarsign")
                                .foregroundStyle(.tertiary)
                            TextField("Amount", text: $initialInvestment_Rate)
                                .keyboardType(.decimalPad)
                        }
                    }
                    
                    Section(header: Text("Total Amount")) {
                        HStack{
                            Image(systemName: "equal.square")
                                .foregroundStyle(.tertiary)
                            TextField("Total", text: $totalAmount_Rate)
                                .keyboardType(.decimalPad)
                        }
                    }
                    
                    Section(header: Text("Years Invested")) {
                        HStack{
                            Image(systemName: "calendar.badge.clock")
                                .foregroundStyle(.tertiary)
                            TextField("Years", text: $yearsInvested_Rate)
                                .keyboardType(.decimalPad)
                        }
                    }
                    
                    Section(header: Text("Interest Rate")) {
                        Text(" \(interestRate_Rate, specifier: "%.2f") %")
                    }
                    
                    Section {
                        Button {
                            calculateRate()
                        }
                    label: {
                        Text("Calculate")
                            .frame(maxWidth: .infinity)
                    }
                    }
                }
            default:
                Text("Error.")
            }
        }
        .preferredColorScheme(.dark)
        }
    }

struct InvestmentCalculator_Previews: PreviewProvider {
    static var previews: some View {
        InvestmentCalculator()
    }
}
